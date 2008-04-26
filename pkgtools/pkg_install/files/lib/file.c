/*	$NetBSD: file.c,v 1.24 2008/04/26 14:56:34 joerg Exp $	*/

#if HAVE_CONFIG_H
#include "config.h"
#endif
#include <nbcompat.h>
#if HAVE_SYS_CDEFS_H
#include <sys/cdefs.h>
#endif
#if HAVE_SYS_PARAM_H
#include <sys/param.h>
#endif
#if HAVE_SYS_QUEUE_H
#include <sys/queue.h>
#endif
#ifndef lint
#if 0
static const char *rcsid = "from FreeBSD Id: file.c,v 1.29 1997/10/08 07:47:54 charnier Exp";
#else
__RCSID("$NetBSD: file.c,v 1.24 2008/04/26 14:56:34 joerg Exp $");
#endif
#endif

/*
 * FreeBSD install - a package for the installation and maintainance
 * of non-core utilities.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * Jordan K. Hubbard
 * 18 July 1993
 *
 * Miscellaneous file access utilities.
 *
 */

#include "lib.h"

#if HAVE_SYS_WAIT_H
#include <sys/wait.h>
#endif

#if HAVE_ASSERT_H
#include <assert.h>
#endif
#if HAVE_ERR_H
#include <err.h>
#endif
#if HAVE_GLOB_H
#include <glob.h>
#endif
#if HAVE_NETDB_H
#include <netdb.h>
#endif
#if HAVE_PWD_H
#include <pwd.h>
#endif
#if HAVE_TIME_H
#include <time.h>
#endif
#if HAVE_FCNTL_H
#include <fcntl.h>
#endif


/*
 * Quick check to see if a file (or dir ...) exists
 */
Boolean
fexists(const char *fname)
{
	struct stat dummy;
	if (!lstat(fname, &dummy))
		return TRUE;
	return FALSE;
}

/*
 * Quick check to see if something is a directory
 */
Boolean
isdir(const char *fname)
{
	struct stat sb;

	if (lstat(fname, &sb) != FAIL && S_ISDIR(sb.st_mode))
		return TRUE;
	else
		return FALSE;
}

/*
 * Check if something is a link to a directory
 */
Boolean
islinktodir(const char *fname)
{
	struct stat sb;

	if (lstat(fname, &sb) != FAIL && S_ISLNK(sb.st_mode)) {
		if (stat(fname, &sb) != FAIL && S_ISDIR(sb.st_mode))
			return TRUE;	/* link to dir! */
		else
			return FALSE;	/* link to non-dir */
	} else
		return FALSE;	/* non-link */
}

/*
 * Check if something is a link that points to nonexistant target.
 */
Boolean
isbrokenlink(const char *fname)
{
	struct stat sb;

	if (lstat(fname, &sb) != FAIL && S_ISLNK(sb.st_mode)) {
		if (stat(fname, &sb) != FAIL)
			return FALSE;	/* link target exists! */
		else
			return TRUE;	/* link target missing*/
	} else
		return FALSE;	/* non-link */
}

/*
 * Check to see if file is a dir, and is empty
 */
Boolean
isemptydir(const char *fname)
{
	if (isdir(fname) || islinktodir(fname)) {
		DIR    *dirp;
		struct dirent *dp;

		dirp = opendir(fname);
		if (!dirp)
			return FALSE;	/* no perms, leave it alone */
		for (dp = readdir(dirp); dp != NULL; dp = readdir(dirp)) {
			if (strcmp(dp->d_name, ".") && strcmp(dp->d_name, "..")) {
				closedir(dirp);
				return FALSE;
			}
		}
		(void) closedir(dirp);
		return TRUE;
	}
	return FALSE;
}

/*
 * Check if something is a regular file
 */
Boolean
isfile(const char *fname)
{
	struct stat sb;
	if (stat(fname, &sb) != FAIL && S_ISREG(sb.st_mode))
		return TRUE;
	return FALSE;
}

/*
 * Check to see if file is a file and is empty. If nonexistent or not
 * a file, say "it's empty", otherwise return TRUE if zero sized.
 */
Boolean
isemptyfile(const char *fname)
{
	struct stat sb;
	if (stat(fname, &sb) != FAIL && S_ISREG(sb.st_mode)) {
		if (sb.st_size != 0)
			return FALSE;
	}
	return TRUE;
}

/* This struct defines the leading part of a valid URL name */
typedef struct url_t {
	char   *u_s;		/* the leading part of the URL */
	int     u_len;		/* its length */
}       url_t;

/* A table of valid leading strings for URLs */
static const url_t urls[] = {
	{"ftp://", 6},
	{"http://", 7},
	{NULL}
};

/*
 * Returns length of leading part of any URL from urls table, or -1
 */
int
URLlength(const char *fname)
{
	const url_t *up;
	int     i;

	if (fname != (char *) NULL) {
		for (i = 0; isspace((unsigned char) *fname); i++) {
			fname++;
		}
		for (up = urls; up->u_s; up++) {
			if (strncmp(fname, up->u_s, up->u_len) == 0) {
				return i + up->u_len;    /* ... + sizeof(up->u_s);  - HF */
			}
		}
	}
	return -1;
}

/*
 * Takes a filename and package name, returning (in "try") the canonical
 * "preserve" name for it.
 */
Boolean
make_preserve_name(char *try, size_t max, char *name, char *file)
{
	int     len, i;

	if ((len = strlen(file)) == 0)
		return FALSE;
	else
		i = len - 1;
	strncpy(try, file, max);
	if (try[i] == '/')	/* Catch trailing slash early and save checking in the loop */
		--i;
	for (; i; i--) {
		if (try[i] == '/') {
			try[i + 1] = '.';
			strncpy(&try[i + 2], &file[i + 1], max - i - 2);
			break;
		}
	}
	if (!i) {
		try[0] = '.';
		strncpy(try + 1, file, max - 1);
	}
	/* I should probably be called rude names for these inline assignments */
	strncat(try, ".", max -= strlen(try));
	strncat(try, name, max -= strlen(name));
	strncat(try, ".", max--);
	strncat(try, "backup", max -= 6);
	return TRUE;
}

void
remove_files(const char *path, const char *pattern)
{
	char	fpath[MaxPathSize];
	glob_t	globbed;
	int	i;

	(void) snprintf(fpath, sizeof(fpath), "%s/%s", path, pattern);
	if ((i=glob(fpath, GLOB_NOSORT, NULL, &globbed)) != 0) {
		switch(i) {
		case GLOB_NOMATCH:
			warn("no files matching ``%s'' found", fpath);
			break;
		case GLOB_ABORTED:
			warn("globbing aborted");
			break;
		case GLOB_NOSPACE:
			warn("out-of-memory during globbing");
			break;
		default:
			warn("unknown error during globbing");
			break;
		}
		return;
	}

	/* deleting globbed files */
	for (i=0; i<globbed.gl_pathc; i++)
		if (unlink(globbed.gl_pathv[i]) < 0)
			warn("can't delete ``%s''", globbed.gl_pathv[i]);

	return;
}

/*
 * Using fmt, replace all instances of:
 *
 * %F	With the parameter "name"
 * %D	With the parameter "dir"
 * %B	Return the directory part ("base") of %D/%F
 * %f	Return the filename part of %D/%F
 *
 * Check that no overflows can occur.
 */
int
format_cmd(char *buf, size_t size, const char *fmt, const char *dir, const char *name)
{
	char    scratch[MaxPathSize * 2];
	char   *bufp;
	char   *cp;

	for (bufp = buf; (int) (bufp - buf) < size && *fmt;) {
		if (*fmt == '%') {
			if (*++fmt != 'D' && name == NULL) {
				warnx("no last file available for '%s' command", buf);
				return -1;
			}
			switch (*fmt) {
			case 'F':
				strlcpy(bufp, name, size - (int) (bufp - buf));
				bufp += strlen(bufp);
				break;

			case 'D':
				strlcpy(bufp, dir, size - (int) (bufp - buf));
				bufp += strlen(bufp);
				break;

			case 'B':
				(void) snprintf(scratch, sizeof(scratch), "%s/%s", dir, name);
				if ((cp = strrchr(scratch, '/')) == (char *) NULL) {
					cp = scratch;
				}
				*cp = '\0';
				strlcpy(bufp, scratch, size - (int) (bufp - buf));
				bufp += strlen(bufp);
				break;

			case 'f':
				(void) snprintf(scratch, sizeof(scratch), "%s/%s", dir, name);
				if ((cp = strrchr(scratch, '/')) == (char *) NULL) {
					cp = scratch;
				} else {
					cp++;
				}
				strlcpy(bufp, cp, size - (int) (bufp - buf));
				bufp += strlen(bufp);
				break;

			default:
				*bufp++ = '%';
				*bufp++ = *fmt;
				break;
			}
			++fmt;
		} else {
			*bufp++ = *fmt++;
		}
	}
	*bufp = '\0';
	return 0;
}

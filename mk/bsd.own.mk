#	$NetBSD: bsd.own.mk,v 1.4 1998/05/29 13:57:09 agc Exp $

.if !defined(_BSD_OWN_MK_)
_BSD_OWN_MK_=1

.if defined(MAKECONF) && exists(${MAKECONF})
.include "${MAKECONF}"
.elif exists(/etc/mk.conf)
.include "/etc/mk.conf"
.endif

# Defining `SKEY' causes support for S/key authentication to be compiled in.
SKEY=		yes
# Defining `KERBEROS' causes support for Kerberos authentication to be
# compiled in.
#KERBEROS=	yes
# Defining 'KERBEROS5' causes support for Kerberos5 authentication to be
# compiled in.
#KERBEROS5=	yes

# where the system object and source trees are kept; can be configurable
# by the user in case they want them in ~/foosrc and ~/fooobj, for example
BSDSRCDIR?=	/usr/src
BSDOBJDIR?=	/usr/obj

BINGRP?=	wheel
BINOWN?=	root
BINMODE?=	555
NONBINMODE?=	444

# Define MANZ to have the man pages compressed (gzip)
#MANZ=		1

MANDIR?=	/usr/share/man
MANGRP?=	wheel
MANOWN?=	root
MANMODE?=	${NONBINMODE}
MANINSTALL?=	maninstall catinstall

LIBDIR?=	/usr/lib
LINTLIBDIR?=	/usr/libdata/lint
LIBGRP?=	${BINGRP}
LIBOWN?=	${BINOWN}
LIBMODE?=	${NONBINMODE}

DOCDIR?=        /usr/share/doc
DOCGRP?=	wheel
DOCOWN?=	root
DOCMODE?=       ${NONBINMODE}

NLSDIR?=	/usr/share/nls
NLSGRP?=	wheel
NLSOWN?=	root
NLSMODE?=	${NONBINMODE}

KMODDIR?=	/usr/lkm
KMODGRP?=	wheel
KMODOWN?=	root
KMODMODE?=	${NONBINMODE}

COPY?=		-c
STRIPFLAG?=	-s

# Define SYS_INCLUDE to indicate whether you want symbolic links to the system
# source (``symlinks''), or a separate copy (``copies''); (latter useful
# in environments where it's not possible to keep /sys publicly readable)
#SYS_INCLUDE= 	symlinks

# XXX The next two are temporary until the transition to UVM is complete.


# The NETBSD_CURRENT checks are to make sure that UVM is defined only
# if the user is running a NetBSD-current, as well as the right platform
# I'm told that 1.3C was the first version with UVM	XXX - agc
.if !defined(UVM)
NETBSD_CURRENT!= /usr/bin/uname -r | /usr/bin/sed -e 's|^1\.3[C-Z]$$|yes|'

.if (${NETBSD_CURRENT} == "yes")
# Systems on which UVM is the standard VM system.
.if	(${MACHINE} == "alpha") || \
	(${MACHINE} == "hp300") || \
	(${MACHINE} == "mac68k") || \
	(${MACHINE} == "mvme68k") || \
	(${MACHINE} == "sparc")
UVM?=		yes
.endif

# Systems that use UVM's new pmap interface.
.if	(${MACHINE} == "alpha")
PMAP_NEW?=	yes
.endif

.endif # NetBSD-current

.endif # !UVM


# don't try to generate PIC versions of libraries on machines
# which don't support PIC.
.if  (${MACHINE_ARCH} == "vax") || \
    ((${MACHINE_ARCH} == "mips") && defined(STATIC_TOOLCHAIN)) || \
    (${MACHINE_ARCH} == "powerpc")
NOPIC=
.endif

# Data-driven table using make variables to control how 
# toolchain-dependent targets and shared libraries are built
# for different platforms and object formats.
# OBJECT_FMT:		currently either "ELF" or "a.out".
# SHLIB_TYPE:		"ELF" or "a.out" or "" to force static libraries.
#
.if (${MACHINE_ARCH} == "alpha") || \
    (${MACHINE_ARCH} == "mips") || \
    (${MACHINE_ARCH} == "powerpc")
OBJECT_FMT?=ELF
.else
OBJECT_FMT?=a.out
.endif

# No lint, for now.

# all machines on which we are okay should be added here until we can
# get rid of the whole "NOLINT by default" thing.
.if (${MACHINE} == "i386") || \
    (${MACHINE} == "sparc")
NONOLINT=1
.endif

.if !defined(NONOLINT)
NOLINT=
.endif

# Profiling and shared libraries don't work on PowerPC yet.
.if (${MACHINE_ARCH} == "powerpc")
NOPROFILE=
NOSHLIB=
.endif

# GNU sources and packages sometimes see architecture names differently.
# This table maps an architecture name to its GNU counterpart.
# Use as so:  ${GNU_ARCH.${TARGET_ARCH}} or ${MACHINE_GNU_ARCH}
GNU_ARCH.alpha=alpha
GNU_ARCH.arm32=arm
GNU_ARCH.i386=i386
GNU_ARCH.m68k=m68k
GNU_ARCH.mips=mips
GNU_ARCH.ns32k=ns32k
GNU_ARCH.powerpc=powerpc
GNU_ARCH.sparc=sparc
GNU_ARCH.vax=vax
MACHINE_GNU_ARCH=${GNU_ARCH.${MACHINE_ARCH}}

TARGETS+=	all clean cleandir depend includes install lint obj regress \
		tags
.PHONY:		all clean cleandir depend includes install lint obj regress \
		tags beforedepend afterdepend beforeinstall afterinstall \
		realinstall

# set NEED_OWN_INSTALL_TARGET, if it's not already set, to yes
# this is used by bsd.port.mk to stop "install" being defined
NEED_OWN_INSTALL_TARGET?=	yes

.if (${NEED_OWN_INSTALL_TARGET} == "yes")
.if !target(install)
install:	.NOTMAIN beforeinstall subdir-install realinstall afterinstall
beforeinstall:	.NOTMAIN
subdir-install:	.NOTMAIN beforeinstall
realinstall:	.NOTMAIN beforeinstall
afterinstall:	.NOTMAIN subdir-install realinstall
.endif
.endif

.endif		# _BSD_OWN_MK_

$NetBSD: patch-ipc_chromium_src_chrome_common_ipc__channel__posix.cc,v 1.1 2012/08/28 12:42:01 ryoon Exp $

--- ipc/chromium/src/chrome/common/ipc_channel_posix.cc.orig	2012-08-08 20:20:07.000000000 +0000
+++ ipc/chromium/src/chrome/common/ipc_channel_posix.cc
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stddef.h>
+#include <unistd.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/stat.h>

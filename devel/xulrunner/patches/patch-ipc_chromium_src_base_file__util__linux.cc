$NetBSD: patch-ipc_chromium_src_base_file__util__linux.cc,v 1.1 2012/08/28 12:42:01 ryoon Exp $

--- ipc/chromium/src/base/file_util_linux.cc.orig	2012-08-08 20:20:07.000000000 +0000
+++ ipc/chromium/src/base/file_util_linux.cc
@@ -28,7 +28,7 @@ bool GetTempDir(FilePath* path) {
 }
 
 bool GetShmemTempDir(FilePath* path) {
-#ifdef ANDROID
+#if defined(ANDROID) || defined(OS_BSD)
   return GetTempDir(path);
 #else
   *path = FilePath("/dev/shm");

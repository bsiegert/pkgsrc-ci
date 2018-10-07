$NetBSD: patch-src_util_futex.h,v 1.1 2018/10/07 23:49:31 ryoon Exp $

Implement futex_wake() and futex_wait() via _umtx_op()

FreeBSD Bugzilla - Bug 225415: graphics/mesa-dri: update to 18.0.0
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=225415

--- src/util/futex.h.orig	2018-02-09 02:18:00.000000000 +0000
+++ src/util/futex.h
@@ -29,10 +29,35 @@
 #include <limits.h>
 #include <stdint.h>
 #include <unistd.h>
+#if defined(__FreeBSD__)
+#include <errno.h>
+# if __FreeBSD__ < 11
+#  include <machine/atomic.h>
+# endif
+#include <sys/umtx.h>
+#else
 #include <linux/futex.h>
 #include <sys/syscall.h>
+#endif
 #include <sys/time.h>
 
+#if defined(__FreeBSD__)
+static inline int futex_wake(uint32_t *addr, int count)
+{
+   return _umtx_op(addr, UMTX_OP_WAKE, (uint32_t)count, NULL, NULL) == -1 ? errno : 0;
+}
+
+static inline int futex_wait(uint32_t *addr, int32_t value, struct timespec *timeout)
+{
+   void *uaddr = NULL, *uaddr2 = NULL;
+   if (timeout != NULL) {
+      const struct _umtx_time tmo = { ._timeout = *timeout, ._flags = UMTX_ABSTIME, ._clockid = CLOCK_MONOTONIC };
+      uaddr = (void *)(uintptr_t)sizeof(tmo);
+      uaddr2 = (void *)&tmo;
+   }
+   return _umtx_op(addr, UMTX_OP_WAIT_UINT, (uint32_t)value, uaddr, uaddr2) == -1 ? errno : 0;
+}
+#else
 static inline long sys_futex(void *addr1, int op, int val1, const struct timespec *timeout, void *addr2, int val3)
 {
    return syscall(SYS_futex, addr1, op, val1, timeout, addr2, val3);
@@ -50,6 +75,7 @@ static inline int futex_wait(uint32_t *a
    return sys_futex(addr, FUTEX_WAIT_BITSET, value, timeout, NULL,
                     FUTEX_BITSET_MATCH_ANY);
 }
+#endif
 
 #endif
 

$NetBSD: patch-vio_viosslfactories.c,v 1.1 2015/07/14 12:09:24 manu Exp $

Backport from upstream to mysql 5.6.x:
https://github.com/mysql/mysql-server/commit/866b988a76e8e7e217017a7883a52a12ec5024b9

From 866b988a76e8e7e217017a7883a52a12ec5024b9 Mon Sep 17 00:00:00 2001
From: Marek Szymczak <marek.szymczak@oracle.com>
Date: Thu, 9 Oct 2014 16:39:43 +0200
Subject: [PATCH] Bug#18367167 DH KEY LENGTH OF 1024 BITS TO MEET MINIMUM REQ
 OF FIPS 140-2

Perfect Forward Secrecy (PFS) requires Diffie-Hellman (DH) parameters to be set.
 Current implementation uses DH key of 512 bit.

--- vio/viosslfactories.c.orig	2015-05-05 13:05:53.000000000 +0200
+++ vio/viosslfactories.c	2015-07-14 05:22:11.000000000 +0200
@@ -19,29 +19,58 @@
 
 static my_bool     ssl_algorithms_added    = FALSE;
 static my_bool     ssl_error_strings_loaded= FALSE;
 
-static unsigned char dh512_p[]=
-{
-  0xDA,0x58,0x3C,0x16,0xD9,0x85,0x22,0x89,0xD0,0xE4,0xAF,0x75,
-  0x6F,0x4C,0xCA,0x92,0xDD,0x4B,0xE5,0x33,0xB8,0x04,0xFB,0x0F,
-  0xED,0x94,0xEF,0x9C,0x8A,0x44,0x03,0xED,0x57,0x46,0x50,0xD3,
-  0x69,0x99,0xDB,0x29,0xD7,0x76,0x27,0x6B,0xA2,0xD3,0xD4,0x12,
-  0xE2,0x18,0xF4,0xDD,0x1E,0x08,0x4C,0xF6,0xD8,0x00,0x3E,0x7C,
-  0x47,0x74,0xE8,0x33,
+/*
+  Diffie-Hellman key.
+  Generated using: >openssl dhparam -5 -C 2048
+ 
+  -----BEGIN DH PARAMETERS-----
+  MIIBCAKCAQEAil36wGZ2TmH6ysA3V1xtP4MKofXx5n88xq/aiybmGnReZMviCPEJ
+  46+7VCktl/RZ5iaDH1XNG1dVQmznt9pu2G3usU+k1/VB4bQL4ZgW4u0Wzxh9PyXD
+  glm99I9Xyj4Z5PVE4MyAsxCRGA1kWQpD9/zKAegUBPLNqSo886Uqg9hmn8ksyU9E
+  BV5eAEciCuawh6V0O+Sj/C3cSfLhgA0GcXp3OqlmcDu6jS5gWjn3LdP1U0duVxMB
+  h/neTSCSvtce4CAMYMjKNVh9P1nu+2d9ZH2Od2xhRIqMTfAS1KTqF3VmSWzPFCjG
+  mjxx/bg6bOOjpgZapvB6ABWlWmRmAAWFtwIBBQ==
+  -----END DH PARAMETERS-----
+ */
+static unsigned char dh2048_p[]=
+{
+  0x8A, 0x5D, 0xFA, 0xC0, 0x66, 0x76, 0x4E, 0x61, 0xFA, 0xCA, 0xC0, 0x37,
+  0x57, 0x5C, 0x6D, 0x3F, 0x83, 0x0A, 0xA1, 0xF5, 0xF1, 0xE6, 0x7F, 0x3C,
+  0xC6, 0xAF, 0xDA, 0x8B, 0x26, 0xE6, 0x1A, 0x74, 0x5E, 0x64, 0xCB, 0xE2,
+  0x08, 0xF1, 0x09, 0xE3, 0xAF, 0xBB, 0x54, 0x29, 0x2D, 0x97, 0xF4, 0x59,
+  0xE6, 0x26, 0x83, 0x1F, 0x55, 0xCD, 0x1B, 0x57, 0x55, 0x42, 0x6C, 0xE7,
+  0xB7, 0xDA, 0x6E, 0xD8, 0x6D, 0xEE, 0xB1, 0x4F, 0xA4, 0xD7, 0xF5, 0x41,
+  0xE1, 0xB4, 0x0B, 0xE1, 0x98, 0x16, 0xE2, 0xED, 0x16, 0xCF, 0x18, 0x7D,
+  0x3F, 0x25, 0xC3, 0x82, 0x59, 0xBD, 0xF4, 0x8F, 0x57, 0xCA, 0x3E, 0x19,
+  0xE4, 0xF5, 0x44, 0xE0, 0xCC, 0x80, 0xB3, 0x10, 0x91, 0x18, 0x0D, 0x64,
+  0x59, 0x0A, 0x43, 0xF7, 0xFC, 0xCA, 0x01, 0xE8, 0x14, 0x04, 0xF2, 0xCD,
+  0xA9, 0x2A, 0x3C, 0xF3, 0xA5, 0x2A, 0x83, 0xD8, 0x66, 0x9F, 0xC9, 0x2C,
+  0xC9, 0x4F, 0x44, 0x05, 0x5E, 0x5E, 0x00, 0x47, 0x22, 0x0A, 0xE6, 0xB0,
+  0x87, 0xA5, 0x74, 0x3B, 0xE4, 0xA3, 0xFC, 0x2D, 0xDC, 0x49, 0xF2, 0xE1,
+  0x80, 0x0D, 0x06, 0x71, 0x7A, 0x77, 0x3A, 0xA9, 0x66, 0x70, 0x3B, 0xBA,
+  0x8D, 0x2E, 0x60, 0x5A, 0x39, 0xF7, 0x2D, 0xD3, 0xF5, 0x53, 0x47, 0x6E,
+  0x57, 0x13, 0x01, 0x87, 0xF9, 0xDE, 0x4D, 0x20, 0x92, 0xBE, 0xD7, 0x1E,
+  0xE0, 0x20, 0x0C, 0x60, 0xC8, 0xCA, 0x35, 0x58, 0x7D, 0x3F, 0x59, 0xEE,
+  0xFB, 0x67, 0x7D, 0x64, 0x7D, 0x8E, 0x77, 0x6C, 0x61, 0x44, 0x8A, 0x8C,
+  0x4D, 0xF0, 0x12, 0xD4, 0xA4, 0xEA, 0x17, 0x75, 0x66, 0x49, 0x6C, 0xCF,
+  0x14, 0x28, 0xC6, 0x9A, 0x3C, 0x71, 0xFD, 0xB8, 0x3A, 0x6C, 0xE3, 0xA3,
+  0xA6, 0x06, 0x5A, 0xA6, 0xF0, 0x7A, 0x00, 0x15, 0xA5, 0x5A, 0x64, 0x66,
+  0x00, 0x05, 0x85, 0xB7,
 };
 
-static unsigned char dh512_g[]={
-  0x02,
+static unsigned char dh2048_g[]={
+  0x05,
 };
 
-static DH *get_dh512(void)
+static DH *get_dh2048(void)
 {
   DH *dh;
   if ((dh=DH_new()))
   {
-    dh->p=BN_bin2bn(dh512_p,sizeof(dh512_p),NULL);
-    dh->g=BN_bin2bn(dh512_g,sizeof(dh512_g),NULL);
+    dh->p=BN_bin2bn(dh2048_p,sizeof(dh2048_p),NULL);
+    dh->g=BN_bin2bn(dh2048_g,sizeof(dh2048_g),NULL);
     if (! dh->p || ! dh->g)
     {
       DH_free(dh);
       dh=0;
@@ -80,9 +109,11 @@
   "Unable to get private key",
   "Private key does not match the certificate public key",
   "SSL_CTX_set_default_verify_paths failed",
   "Failed to set ciphers to use",
-  "SSL_CTX_new failed"
+  "SSL_CTX_new failed",
+  "SSL context is not usable without certificate and private key",
+  "SSL_CTX_set_tmp_dh failed"
 };
 
 const char*
 sslGetErrString(enum enum_ssl_init_error e)
@@ -284,10 +315,19 @@
     DBUG_RETURN(0);
   }
 
   /* DH stuff */
-  dh=get_dh512();
-  SSL_CTX_set_tmp_dh(ssl_fd->ssl_context, dh);
+  dh= get_dh2048();
+  if (SSL_CTX_set_tmp_dh(ssl_fd->ssl_context, dh) == 0)
+  {
+    *error= SSL_INITERR_DHFAIL;
+    DBUG_PRINT("error", ("%s", sslGetErrString(*error)));
+    report_errors();
+    DH_free(dh);
+    SSL_CTX_free(ssl_fd->ssl_context);
+    my_free(ssl_fd);
+    DBUG_RETURN(0);
+  }
   DH_free(dh);
 
   DBUG_PRINT("exit", ("OK 1"));
 

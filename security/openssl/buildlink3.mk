# $NetBSD: buildlink3.mk,v 1.19 2004/08/05 04:20:28 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
OPENSSL_BUILDLINK3_MK:=	${OPENSSL_BUILDLINK3_MK}+

.include "../../mk/bsd.prefs.mk"

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	openssl
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nopenssl}
BUILDLINK_PACKAGES+=	openssl

.if !empty(OPENSSL_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.openssl+=	openssl>=0.9.6m
BUILDLINK_PKGSRCDIR.openssl?=	../../security/openssl

# Ensure that -lcrypt comes before -lcrypto when linking so that the
# system crypt() routine is used.
#
BUILDLINK_TRANSFORM+=	reorder:l:crypt:crypto

SSLBASE=	${BUILDLINK_PREFIX.openssl}
BUILD_DEFS+=	SSLBASE
.endif	# OPENSSL_BUILDLINK3_MK

PKG_OPTIONS.openssl?=	${PKG_DEFAULT_OPTIONS}

.if !empty(PKG_OPTIONS.openssl:Mrsaref)
.  include "../../security/rsaref/buildlink3.mk"
.endif

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}

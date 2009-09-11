# $NetBSD: buildlink3.mk,v 1.12 2009/09/11 21:48:01 joerg Exp $

BUILDLINK_TREE+=	eet

.if !defined(EET_BUILDLINK3_MK)
EET_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.eet+=	eet>=1.0.1
BUILDLINK_ABI_DEPENDS.eet?=	eet>=1.2.2nb1
BUILDLINK_PKGSRCDIR.eet?=	../../devel/eet

.include "../../devel/eina/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../graphics/jpeg/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.endif # EET_BUILDLINK3_MK

BUILDLINK_TREE+=	-eet

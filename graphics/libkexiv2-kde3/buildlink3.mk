# $NetBSD: buildlink3.mk,v 1.16 2014/06/07 12:11:23 wiz Exp $

BUILDLINK_TREE+=	libkexiv2

.if !defined(LIBKEXIV2_BUILDLINK3_MK)
LIBKEXIV2_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.libkexiv2+=	libkexiv2>=0.1.1<4.0
BUILDLINK_ABI_DEPENDS.libkexiv2+=	libkexiv2>=0.1.9nb20
BUILDLINK_PKGSRCDIR.libkexiv2?=	../../graphics/libkexiv2-kde3

.include "../../graphics/exiv2/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../x11/kdelibs3/buildlink3.mk"
.endif # LIBKEXIV2_BUILDLINK3_MK

BUILDLINK_TREE+=	-libkexiv2

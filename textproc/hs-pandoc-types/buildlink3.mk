# $NetBSD: buildlink3.mk,v 1.4 2014/11/23 12:52:33 szptvlfn Exp $

BUILDLINK_TREE+=	hs-pandoc-types

.if !defined(HS_PANDOC_TYPES_BUILDLINK3_MK)
HS_PANDOC_TYPES_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-pandoc-types+=	hs-pandoc-types>=1.12.4
BUILDLINK_ABI_DEPENDS.hs-pandoc-types+=	hs-pandoc-types>=1.12.4.1nb3
BUILDLINK_PKGSRCDIR.hs-pandoc-types?=	../../textproc/hs-pandoc-types

.include "../../converters/hs-aeson/buildlink3.mk"
.include "../../devel/hs-deepseq-generics/buildlink3.mk"
.include "../../devel/hs-syb/buildlink3.mk"
.endif	# HS_PANDOC_TYPES_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-pandoc-types

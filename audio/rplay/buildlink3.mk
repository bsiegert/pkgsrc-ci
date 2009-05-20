# $NetBSD: buildlink3.mk,v 1.11 2009/05/20 00:58:06 wiz Exp $

BUILDLINK_TREE+=	rplay

.if !defined(RPLAY_BUILDLINK3_MK)
RPLAY_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.rplay+=	rplay>=3.3.2nb1
BUILDLINK_ABI_DEPENDS.rplay+=	rplay>=3.3.2nb7
BUILDLINK_PKGSRCDIR.rplay?=	../../audio/rplay

.include "../../audio/gsm/buildlink3.mk"
.include "../../devel/readline/buildlink3.mk"
.include "../../devel/rx/buildlink3.mk"
.endif # RPLAY_BUILDLINK3_MK

BUILDLINK_TREE+=	-rplay

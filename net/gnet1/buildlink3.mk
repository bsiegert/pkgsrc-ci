# $NetBSD: buildlink3.mk,v 1.3 2004/03/18 09:12:14 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GNET1_BUILDLINK3_MK:=	${GNET1_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	gnet1
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngnet1}
BUILDLINK_PACKAGES+=	gnet1

.if !empty(GNET1_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.gnet1+=	gnet1>=1.1.8nb2
BUILDLINK_PKGSRCDIR.gnet1?=	../../net/gnet1
.endif	# GNET1_BUILDLINK3_MK

.include "../../devel/glib2/buildlink3.mk"

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}

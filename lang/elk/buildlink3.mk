# $NetBSD: buildlink3.mk,v 1.1 2005/03/30 19:44:44 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
ELK_BUILDLINK3_MK:=	${ELK_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	elk
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nelk}
BUILDLINK_PACKAGES+=	elk

.if !empty(ELK_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.elk+=	elk>=3.0.3nb1
BUILDLINK_PKGSRCDIR.elk?=	../../lang/elk
.endif	# ELK_BUILDLINK3_MK

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}

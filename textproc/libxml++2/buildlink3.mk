# $NetBSD: buildlink3.mk,v 1.2 2005/11/15 18:54:08 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBXML++2_BUILDLINK3_MK:=	${LIBXML++2_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libxml++2
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibxml++2}
BUILDLINK_PACKAGES+=	libxml++2

.if !empty(LIBXML++2_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.libxml++2+=	libxml++2>=2.10.0
BUILDLINK_PKGSRCDIR.libxml++2?=	../../textproc/libxml++2
.endif	# LIBXML++2_BUILDLINK3_MK

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}

# $NetBSD: buildlink3.mk,v 1.6 2004/03/18 09:12:11 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
POPT_BUILDLINK3_MK:=	${POPT_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	popt
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Npopt}
BUILDLINK_PACKAGES+=	popt

.if !empty(POPT_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.popt+=	popt>=1.7nb3
BUILDLINK_PKGSRCDIR.popt?=	../../devel/popt
.endif	# POPT_BUILDLINK3_MK

.include "../../devel/gettext-lib/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}

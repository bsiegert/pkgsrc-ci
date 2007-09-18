# $NetBSD: buildlink3.mk,v 1.6 2007/09/18 20:15:58 drochner Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
MPFR_BUILDLINK3_MK:=	${MPFR_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	mpfr
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nmpfr}
BUILDLINK_PACKAGES+=	mpfr
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}mpfr

.if !empty(MPFR_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.mpfr+=	mpfr>=2.0.3
BUILDLINK_PKGSRCDIR.mpfr?=	../../math/mpfr
.endif	# MPFR_BUILDLINK3_MK

.include "../../devel/gmp/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}

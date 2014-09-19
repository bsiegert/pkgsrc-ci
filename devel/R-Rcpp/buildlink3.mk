# $NetBSD: buildlink3.mk,v 1.1 2014/09/19 20:12:51 brook Exp $

BUILDLINK_TREE+=	R-Rcpp

.if !defined(R_RCPP_BUILDLINK3_MK)
R_RCPP_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.R-Rcpp+=	R-Rcpp>=0.11.2
BUILDLINK_PKGSRCDIR.R-Rcpp?=	../../devel/R-Rcpp
.endif	# R_RCPP_BUILDLINK3_MK

BUILDLINK_TREE+=	-R-Rcpp

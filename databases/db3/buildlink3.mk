# $NetBSD: buildlink3.mk,v 1.7 2004/03/18 09:12:09 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
DB3_BUILDLINK3_MK:=	${DB3_BUILDLINK3_MK}+

.include "../../mk/bsd.prefs.mk"

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	db3
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ndb3}
BUILDLINK_PACKAGES+=	db3

.if !empty(DB3_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.db3+=		db3>=2.9.2
BUILDLINK_PKGSRCDIR.db3?=	../../databases/db3
.  if defined(USE_DB185)
BUILDLINK_INCDIRS.db3?=		include/db3
BUILDLINK_TRANSFORM+=		l:db:db3
.  endif
.endif	# DB3_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}

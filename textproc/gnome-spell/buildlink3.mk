# $NetBSD: buildlink3.mk,v 1.4 2004/03/18 09:12:15 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
GNOME_SPELL_BUILDLINK3_MK:=	${GNOME_SPELL_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	gnome-spell
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngnome-spell}
BUILDLINK_PACKAGES+=	gnome-spell

.if !empty(GNOME_SPELL_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.gnome-spell+=		gnome-spell>=1.0.5
BUILDLINK_PKGSRCDIR.gnome-spell?=	../../textproc/gnome-spell
.endif	# GNOME_SPELL_BUILDLINK3_MK

.include "../../devel/libbonobo/buildlink3.mk"
.include "../../devel/libbonoboui/buildlink3.mk"
.include "../../devel/libglade2/buildlink3.mk"
.include "../../devel/libgnomeui/buildlink3.mk"
.include "../../net/ORBit2/buildlink3.mk"
.include "../../textproc/aspell/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}

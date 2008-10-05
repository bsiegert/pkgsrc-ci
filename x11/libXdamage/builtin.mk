# $NetBSD: builtin.mk,v 1.2 2008/10/05 21:36:33 cube Exp $

BUILTIN_PKG:=	libXdamage
PKGCONFIG_FILE.libXdamage=	${X11BASE}/lib/pkgconfig/xdamage.pc \
				${X11BASE}/lib/libXdamage.so

.include "../../mk/buildlink3/pkgconfig-builtin.mk"
.include "../../mk/x11.builtin.mk"

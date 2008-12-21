# $NetBSD: options.mk,v 1.3 2008/12/21 12:09:42 obache Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.dbus
PKG_SUPPORTED_OPTIONS+=	debug kqueue x11
PKG_SUGGESTED_OPTIONS=	x11

.if (${OPSYS} == "NetBSD"  ||	\
     ${OPSYS} == "FreeBSD" ||	\
     ${OPSYS} == "OpenBSD")
PKG_SUGGESTED_OPTIONS+=	kqueue
.endif

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mdebug)
CONFIGURE_ARGS.enable+=	asserts tests verbose-mode
.else
CONFIGURE_ARGS.disable+= asserts tests verbose-mode
.endif

.if !empty(PKG_OPTIONS:Mkqueue)
CONFIGURE_ARGS.enable+= 	kqueue
.else
CONFIGURE_ARGS.disable+=	kqueue
.endif

.if !empty(PKG_OPTIONS:Mx11)
CONFIGURE_ARGS.with+=	x
.  include "../../x11/libX11/buildlink3.mk"
BUILDLINK_DEPMETHOD.libXt=	build
.  include "../../x11/libXt/buildlink3.mk"
.else
CONFIGURE_ARGS.without=	x
.endif

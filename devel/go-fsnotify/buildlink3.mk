# $NetBSD: buildlink3.mk,v 1.1 2017/08/17 01:24:45 gavan Exp $

BUILDLINK_TREE+=	go-fsnotify

.if !defined(GO_FSNOTIFY_BUILDLINK3_MK)
GO_FSNOTIFY_BUILDLINK3_MK:=

BUILDLINK_CONTENTS_FILTER.go-fsnotify=	${EGREP} gopkg/
BUILDLINK_DEPMETHOD.go-fsnotify?=	build

BUILDLINK_API_DEPENDS.go-fsnotify+=	go-fsnotify>=1.3.0
BUILDLINK_PKGSRCDIR.go-fsnotify?=	../../devel/go-fsnotify

.endif  # GO_FSNOTIFY_BUILDLINK3_MK

BUILDLINK_TREE+=	-go-fsnotify


# $NetBSD: buildlink2.mk,v 1.2 2004/01/25 10:04:21 cube Exp $

.if !defined(LIBID3TAG_BUILDLINK2_MK)
LIBID3TAG_BUILDLINK2_MK=	# defined

BUILDLINK_PACKAGES+=		libid3tag
BUILDLINK_DEPENDS.libid3tag?=	libid3tag>=0.15.0b
BUILDLINK_PKGSRCDIR.libid3tag?=	../../audio/libid3tag

EVAL_PREFIX+=			BUILDLINK_PREFIX.libid3tag=libid3tag
BUILDLINK_PREFIX.libid3tag_DEFAULT=${LOCALBASE}
BUILDLINK_FILES.libid3tag+=	include/id3tag.h
BUILDLINK_FILES.libid3tag+=	lib/libid3tag.*

.include "../../devel/zlib/buildlink2.mk"

BUILDLINK_TARGETS+=		libid3tag-buildlink

libid3tag-buildlink: _BUILDLINK_USE

.endif	# LIBID3TAG_BUILDLINK2_MK

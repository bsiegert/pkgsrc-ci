$NetBSD: patch-res_res__format__attr__siren7.c,v 1.1 2024/04/08 03:20:10 jnemeth Exp $

--- res/res_format_attr_siren7.c.orig	2022-04-14 22:16:42.000000000 +0000
+++ res/res_format_attr_siren7.c
@@ -55,7 +55,7 @@ static struct ast_format *siren7_parse_s
 
 	/* lower-case everything, so we are case-insensitive */
 	for (attrib = attribs; *attrib; ++attrib) {
-		*attrib = tolower(*attrib);
+		*attrib = tolower((unsigned char)*attrib);
 	} /* based on channels/chan_sip.c:process_a_sdp_image() */
 
 	if (sscanf(attribs, "bitrate=%30u", &val) == 1) {

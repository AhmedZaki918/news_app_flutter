import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'hive_manager.dart';

var box = Hive.box('newsBox');

void shareContent(String url) {
  SharePlus.instance.share(ShareParams(text: url));
}

void openUrlLink(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}

IconData displaySaveIcon(String key) {
  if (isArticleSaved(key)) {
    return Icons.bookmark;
  } else {
    return Icons.bookmark_border;
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

bool isImageNull(String? image) {
  if (image == null || image == '') {
    return true;
  } else {
    return false;
  }
}

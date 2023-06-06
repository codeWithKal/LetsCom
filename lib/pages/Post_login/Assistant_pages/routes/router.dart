import 'package:flutter/material.dart';
import 'package:lets_com/pages/Post_login/Assistant_pages/screens/HI_detail.dart';
import 'package:lets_com/pages/Post_login/Assistant_pages/screens/home.dart';


Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => AHome(),
  '/detail': (context) => SliverAssistantDetail(),
};

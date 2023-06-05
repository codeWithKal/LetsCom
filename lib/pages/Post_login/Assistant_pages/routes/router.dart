import 'package:flutter/material.dart';
import 'package:lets_com/pages/Post_login/Assistant_pages/screens/assistant_detail.dart';
import 'package:lets_com/pages/Post_login/Assistant_pages/screens/home.dart';


Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => Home(),
  '/detail': (context) => SliverAssistantDetail(),
};

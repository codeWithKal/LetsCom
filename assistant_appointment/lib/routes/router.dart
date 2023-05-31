import 'package:flutter/material.dart';
import 'package:LetsCom/screens/assistant_detail.dart';
import 'package:LetsCom/screens/home.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => Home(),
  '/detail': (context) => SliverAssistantDetail(),
};

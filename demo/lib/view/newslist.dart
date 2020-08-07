
import 'package:demo/model/newsfeed.dart';

import 'package:demo/view/newstile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class newsList extends StatefulWidget {
  @override
  _newsListState createState() => _newsListState();
}

class _newsListState extends State<newsList> {
  @override
  Widget build(BuildContext context) {

    final listnews = Provider.of<List<news>>(context) ?? [];

    return ListView.builder(
      itemCount: listnews.length,
      itemBuilder: (context, index) {
        return newstile(cmpl1: listnews[index]);
      },
    );
  }
}
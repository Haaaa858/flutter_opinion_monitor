import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class SinglePostPage extends StatelessWidget {
  var postId;

  SinglePostPage({Key? key,  @PathParam() required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.postId),
    );
  }
}

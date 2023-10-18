import 'package:flutter/material.dart';
import 'package:flutter_blog/data/models/post.dart';
import 'package:flutter_blog/ui/pages/post/update_page/widgets/post_update_body.dart';

class PostUpdatePage extends StatelessWidget {
  final Post post;

  const PostUpdatePage(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PostUpdateBody(post),
    );
  }
}
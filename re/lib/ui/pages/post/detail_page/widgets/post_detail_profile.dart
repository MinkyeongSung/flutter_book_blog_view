import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/data/models/post.dart';

class PostDetailProfile extends StatelessWidget {
  final Post post;

  const PostDetailProfile(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(post.user.username),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset('assets/default_profile.png'),
        ),
        subtitle: Row(
          children: [
            Text(post.user.email),
            const SizedBox(width: mediumGap),
            const Text("·"),
            const SizedBox(width: mediumGap),
            const Text("Written on "),
            Text(post.getUpdated()),
          ],
        )
    );
  }
}
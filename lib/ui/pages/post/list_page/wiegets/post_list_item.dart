import 'package:flutter/material.dart';
import 'package:flutter_blog/data/models/post.dart';

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        post.content,
        style: const TextStyle(color: Colors.black45),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset('assets/default_profile.png'),
      ),
    );
  }
}

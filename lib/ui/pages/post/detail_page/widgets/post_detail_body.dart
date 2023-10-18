import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/data/models/post.dart';
import 'package:flutter_blog/data/providers/session_provider.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_view_model.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_buttons.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_content.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_profile.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailBody extends ConsumerWidget {
  final int postId;

  const PostDetailBody(this.postId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostDetailPageModel? model = ref.watch(postDetailPageProvider(postId));
    SessionUser sessionUser = ref.read(sessionProvider);
    if(model == null){
      return const Center(child: CircularProgressIndicator());
    } else {
      Post post = model.post;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            PostDetailTitle(post.title),
            const SizedBox(height: largeGap),
            PostDetailProfile(post),
            if (sessionUser.user!.id == post.user.id)
              PostDetailButtons(post),
            const Divider(),
            const SizedBox(height: largeGap),
            Expanded(child: PostDetailContent(post.content)),
          ],
        ),
      );
    }
  }
}
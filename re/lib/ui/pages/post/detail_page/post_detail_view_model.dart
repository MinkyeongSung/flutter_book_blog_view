import 'package:flutter/material.dart';
import 'package:flutter_blog/data/dtos/post_request.dart';
import 'package:flutter_blog/data/dtos/response_dto.dart';
import 'package:flutter_blog/data/models/post.dart';
import 'package:flutter_blog/data/providers/session_provider.dart';
import 'package:flutter_blog/data/repositories/post_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final postDetailPageProvider = StateNotifierProvider.family.autoDispose<PostDetailPageViewModel, PostDetailPageModel?, int>((ref, postId) {
  return PostDetailPageViewModel(ref, null)..notifyInit(postId);
});

// 창고 데이터
class PostDetailPageModel {
  Post post;
  PostDetailPageModel({required this.post});
}

// 창고
class PostDetailPageViewModel extends StateNotifier<PostDetailPageModel?> {
  final mContext = navigatorKey.currentContext;
  final Ref ref;

  PostDetailPageViewModel(this.ref, super.state);

  Future<void> notifyInit(int id) async {
    Logger().d("notifyInit");

    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().fetchPost(sessionUser.jwt!, id);

    state = PostDetailPageModel(post: responseDTO.data);
  }

  Future<void> notifyUpdate(int postId, PostUpdateReqDTO reqDTO) async {
    Logger().d("notifyUpdate");

    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().updatePost(sessionUser.jwt!, postId, reqDTO);
    if (responseDTO.code != 1) {
      ScaffoldMessenger.of(mContext!).showSnackBar(SnackBar(content: Text("게시물 수정 실패 : ${responseDTO.msg}")));
    } else {
      await ref.read(postListPageProvider.notifier).notifyUpdate(responseDTO.data);

      state = PostDetailPageModel(post: responseDTO.data);
      Navigator.pop(mContext!);
    }
  }
}

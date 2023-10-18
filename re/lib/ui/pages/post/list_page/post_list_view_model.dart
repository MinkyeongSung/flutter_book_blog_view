import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/data/dtos/post_request.dart';
import 'package:flutter_blog/data/dtos/response_dto.dart';
import 'package:flutter_blog/data/models/post.dart';
import 'package:flutter_blog/data/providers/session_provider.dart';
import 'package:flutter_blog/data/repositories/post_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final postListPageProvider = StateNotifierProvider<PostListPageViewModel, PostListPageModel?>((ref) {
  return PostListPageViewModel(ref, null)..notifyInit();
});

// 창고 데이터
class PostListPageModel {
  List<Post> posts;
  PostListPageModel({required this.posts});
}

// 창고
class PostListPageViewModel extends StateNotifier<PostListPageModel?> {
  final mContext = navigatorKey.currentContext;
  final Ref ref;

  PostListPageViewModel(this.ref, super.state);

  Future<void> notifyInit() async {
    Logger().d("notifyInit");
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().fetchPostList(sessionUser.jwt!);
    state = PostListPageModel(posts: responseDTO.data);
  }

  Future<void> notifyAdd(PostSaveReqDTO reqDTO) async {
    Logger().d("notifyAdd");

    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().savePost(sessionUser.jwt!, reqDTO);

    if (responseDTO.code != 1) {
      ScaffoldMessenger.of(mContext!).showSnackBar(SnackBar(content: Text("게시물 작성 실패 : ${responseDTO.msg}")));
    } else {
      Post newPost = responseDTO.data;

      List<Post> posts = state!.posts;
      List<Post> newPosts = [newPost, ...posts];

      state = PostListPageModel(posts: newPosts);
      Navigator.pop(mContext!, Move.postListPage);
    }
  }

  Future<void> notifyUpdate(Post post) async {
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.map((e) => e.id == post.id ? post : e).toList();

    state = PostListPageModel(posts: newPosts);
  }

  Future<void> notifyRemove(int id) async {
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().fetchDelete(sessionUser.jwt!, id);

    if (responseDTO.code != 1) {
      ScaffoldMessenger.of(mContext!).showSnackBar(SnackBar(content: Text("게시물 삭제 실패 : ${responseDTO.msg}")));
    } else {
      List<Post> posts = state!.posts;
      List<Post> newPosts = posts.where((e) => e.id != id).toList();

      state = PostListPageModel(posts: newPosts);
      Navigator.pop(mContext!);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dtos/post_request.dart';
import 'package:flutter_blog/data/dtos/response_dto.dart';
import 'package:flutter_blog/data/models/post.dart';
import 'package:logger/logger.dart';

class PostRepository {
  static final PostRepository _instance = PostRepository._single(); // (1) _instance

  factory PostRepository() {
    // (2) PostRepository
    return _instance;
  }

  PostRepository._single(); // (3) PostRepository._single()

  // 목적 : 통신 + 파싱
  Future<ResponseDTO> fetchPostList(String jwt) async {
    Logger().d("fetchPostList");
    try {
      // 통신
      Response response = await dio.get("/post", options: Options(headers: {"Authorization": "$jwt"}));

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      // 전달받은 데이터의 값을 mapList라는 변수에 List<dynamic> 타입으로 저장합니다.
      List<dynamic> mapList = responseDTO.data as List<dynamic>;
      // mapList의 각 아이템을 Post 객체로 변환하여 postList 변수에 할당합니다.
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();
      // 그리고 변환된 데이터를 다시 공통DTO에 덮어씌웁니다.
      responseDTO.data = postList;

      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> fetchPost(String jwt, int id) async {
    try {
      // 통신
      Response response = await dio.get("/post/$id", options: Options(headers: {"Authorization": "$jwt"}));

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);

      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> savePost(String jwt, PostSaveReqDTO postSaveReqDTO) async {
    try {
      // 통신
      Response response = await dio.post("/post", options: Options(headers: {"Authorization": "$jwt"}), data: postSaveReqDTO.toJson());
      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);

      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> updatePost(String jwt, int id, PostUpdateReqDTO postUpdateReqDTO) async {
    try {
      // 통신
      Response response = await dio.put(
        "/post/$id",
        options: Options(headers: {"Authorization": "$jwt"}),
        data: postUpdateReqDTO.toJson(),
      );

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);

      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> fetchDelete(String jwt, int id) async {
    try {
      // 통신
      Response response = await dio.delete("/post/$id", options: Options(headers: {"Authorization": "$jwt"}));
      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }
}

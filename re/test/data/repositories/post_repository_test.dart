import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dtos/post_request.dart';
import 'package:flutter_blog/data/dtos/response_dto.dart';
import 'package:flutter_blog/data/models/post.dart';
import 'package:logger/logger.dart';

void main() async {
  await deletePost_test();
}

Future<void> fetchPostList_test() async {
  // given
  // JWT 토큰은 만료될 수 있기 때문에, PostMan으로 요청한 뒤 Authorization 응답 헤더값을 사용하세요.
  String jwt =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjb3PthqDtgbAiLCJpZCI6MSwiZXhwIjoxNjg5ODY2MDY1fQ.tvmkZeCUToHiTOZQjKUBN6d-00L4GvmpplJirwCp_XB2jsaLIp9UTbJrwfWHPWqTqU0iRnvMxp30S4PDhDUI_A';

  try {
    // 통신
    Response response = await dio.get("/post", options: Options(headers: {"Authorization": "$jwt"}));

    // 응답 받은 데이터 파싱
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    List<dynamic> mapList = responseDTO.data as List<dynamic>;
    List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();
    responseDTO.data = postList;

    // then
    Logger().d(responseDTO.code);
    Logger().d(responseDTO.msg);
  } catch (e) {
    Logger().d("통신 실패");
  }
}

Future<void> fetchPost_test() async {
  // given
  // JWT 토큰은 만료될 수 있기 때문에, PostMan으로 요청한 뒤 Authorization 응답 헤더값을 사용하세요.
  String jwt =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjb3PthqDtgbAiLCJpZCI6MSwiZXhwIjoxNjg5ODY2MDY1fQ.tvmkZeCUToHiTOZQjKUBN6d-00L4GvmpplJirwCp_XB2jsaLIp9UTbJrwfWHPWqTqU0iRnvMxp30S4PDhDUI_A';
  int id = 1;

  // when
  try {
    // 통신
    Response response = await dio.get("/post/$id", options: Options(headers: {"Authorization": "$jwt"}));

    // 응답 받은 데이터 파싱
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    responseDTO.data = Post.fromJson(responseDTO.data);

    Logger().d(responseDTO.code);
    Logger().d(responseDTO.msg);
  } catch (e) {
    Logger().d("통신 실패");
  }
}

Future<void> savePost_test() async {
  // JWT 토큰은 만료될 수 있기 때문에, PostMan으로 요청한 뒤 Authorization 응답 헤더값을 사용하세요.
  String jwt =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjb3PthqDtgbAiLCJpZCI6MSwiZXhwIjoxNjg5ODY2MDY1fQ.tvmkZeCUToHiTOZQjKUBN6d-00L4GvmpplJirwCp_XB2jsaLIp9UTbJrwfWHPWqTqU0iRnvMxp30S4PDhDUI_A';
  PostSaveReqDTO postSaveReqDTO = PostSaveReqDTO(title: "제목", content: "내용");

  try {
    // 통신
    Response response = await dio.post("/post", options: Options(headers: {"Authorization": "$jwt"}), data: postSaveReqDTO.toJson());
    // 응답 받은 데이터 파싱
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    responseDTO.data = Post.fromJson(responseDTO.data);

    Logger().d(responseDTO.code);
    Logger().d(responseDTO.msg);
  } catch (e) {
    Logger().d("통신 실패");
  }
}

Future<void> updatePost_test() async {
  // JWT 토큰은 만료될 수 있기 때문에, PostMan으로 요청한 뒤 Authorization 응답 헤더값을 사용하세요.
  String jwt =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjb3PthqDtgbAiLCJpZCI6MSwiZXhwIjoxNjg5ODgwNzEzfQ.wRMLsbl1lBjFjNmUPDo5MWtAZ4ukzVDQy1B5A-qhwk54vSycgy3EhzvXgb4WtZImxV_YcwddLDS5iFPBZuk2iA';
  int id = 1;
  PostUpdateReqDTO requestDTO = PostUpdateReqDTO(title: "수정제목", content: "수정내용");

  try {
    // 통신
    Response response = await dio.put(
      "/post/$id",
      options: Options(headers: {"Authorization": "$jwt"}),
      data: requestDTO.toJson(),
    );

    // 응답 받은 데이터 파싱
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    responseDTO.data = Post.fromJson(responseDTO.data);

    Logger().d(responseDTO.code);
    Logger().d(responseDTO.msg);
  } catch (e) {
    Logger().d("통신 실패");
  }
}

Future<void> deletePost_test() async {
  // JWT 토큰은 만료될 수 있기 때문에, PostMan으로 요청한 뒤 Authorization 응답 헤더값을 사용하세요.
  String jwt =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjb3PthqDtgbAiLCJpZCI6MSwiZXhwIjoxNjg5ODgxMDU2fQ.Vd0SepViCFoVaEv_Zv73AI1M2Z87t0TZSO--FYYUJqqffWS4rgti_2ebcnJtmhCdJQLdaRBLhoqvbuVDqu8iZA';
  int id = 2;

  try {
    // 통신
    Response response = await dio.delete("/post/$id", options: Options(headers: {"Authorization": "$jwt"}));
    // 응답 받은 데이터 파싱
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

    Logger().d(responseDTO.code);
    Logger().d(responseDTO.msg);
  } catch (e) {
    Logger().d("통신 실패");
  }
}

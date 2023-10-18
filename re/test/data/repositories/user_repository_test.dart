import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dtos/response_dto.dart';
import 'package:flutter_blog/data/dtos/user_request.dart';
import 'package:flutter_blog/data/models/user.dart';
import 'package:logger/logger.dart';

void main() async {
  await fetchLogin_test();
}

Future<void> fetchJoin_test() async {
  // given
  JoinReqDTO requestDTO = JoinReqDTO(username: "meta", password: "1234", email: "meta@nate.com");

  // when
  try {
    Response response = await dio.post("/join", data: requestDTO.toJson());
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    responseDTO.data = User.fromJson(responseDTO.data);

    // then
    Logger().d(responseDTO.code);
    Logger().d(responseDTO.msg);
  } catch (e) {
    Logger().d("통신 실패");
  }
}

Future<void> fetchLogin_test() async {
  // given
  LoginReqDTO requestDTO = LoginReqDTO(username: "ssar", password: "1234");

  // when
  try {
    // 1. 통신 시작
    Response response = await dio.post("/login", data: requestDTO.toJson());

    // 2. DTO 파싱
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    responseDTO.data = User.fromJson(responseDTO.data);

    // 3. 토큰 받기
    final authorization = response.headers["authorization"];
    if (authorization != null) {
      responseDTO.token = authorization.first;
    }

    // then
    Logger().d(responseDTO.code);
    Logger().d(responseDTO.msg);
    Logger().d(responseDTO.token);
  } catch (e) {
    Logger().d("통신 실패");
  }
}

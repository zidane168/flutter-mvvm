

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mvvm/data/ApiResponse.dart';
import 'package:mvvm/data/models/get_user.dart';
import 'package:mvvm/data/models/update_user.dart';
import 'package:mvvm/data/models/user.dart';

class UserService {
  final Dio dio;
  var logger = Logger();

  UserService({required this.dio});


/*

  Future<List<User>> getUsers() async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/users');
      print (response);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList.map((json) => User.fromJson(json)).toList();

      } else {
        throw Exception('API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An Error occurred: $e');
    }
  }*/


  String convertLanguage(String language) {
    if (language == "en") { language = "en_US"; }
    else if (language == "vi") { language = "vi_VN"; }

    return language;
  }

  Future<GetUser> getOneUser(String id, String language) async {
    try  {
      String language_api = convertLanguage(language);
      final options = Options(
        headers: {
          'Authorization': 'Bearer <token>',
          'Content-type': 'application/json',
          'Language': language_api
        }
      );

      final response = await dio.get('http://localhost:8888/flutter-demo-fake-server-api/api/v1/members/getMember.json',
        queryParameters: {
          "id": id,
        },
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['params'];

        if (response.data['status'] == 200) {
          Get.snackbar("App", response.data['message'], snackPosition: SnackPosition.BOTTOM);

          final getUser = GetUser(
            id: response.data['params']['id'] ?? '',
            email: response.data['params']['email'] ?? '',
            name: response.data['params']['name'] ?? '',
          );

          return getUser;
        } else {
          throw Exception(response.data['message']);
        }
      }

      throw Exception('Unexpected response: ${response.statusCode}');
    } catch (e) {
      throw Exception('An Error occurred: $e');
    }
  }

  Future<List<User>> getFullListUsers(String page, String limit, String language) async {
    try {

      var logger = Logger();
      language = convertLanguage(language);

      final options = Options(
        headers: {
          'Authorization': 'Bearer <token>',
          'Content-type': 'application/json',
          "Language": language,
        },
      );

      final response = await dio.get('http://localhost:8888/flutter-demo-fake-server-api/api/v1/members/listMembers.json',
        queryParameters: {
          "page": page,
          "limit": limit,
        },
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['params'];

        if (response.data['status'] == 200) {
          Get.snackbar("App", response.data['message'], snackPosition: SnackPosition.BOTTOM);
          return jsonList.map<User>((json) => User.fromJson(json)).toList();
        } else {
          throw Exception(response.data['message']);
        }

      } else {
        throw Exception('API failed with status code: ${response.statusCode}');
      }

    } catch (e) {
      throw Exception('An Error occurred: $e');
    }
  }

  Future<ApiResponse> createUser(UpdateUser user, String language)  async {
    try {

      String language_api = convertLanguage(language);

      final formData = {    // post - body (from-data)
        'id': user.id,
        'email': user.email,
        'name_vi': user.name_vi,
        'name_en': user.name_en,
      };

      final options = Options(
        headers: {
          'Authorization': 'Bearer <token>',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Language': language_api,
        }
      );

      final response = await dio.post('http://localhost:8888/flutter-demo-fake-server-api/api/v1/members/createMembers.json',
            data: formData,
            options: options,
      );

      if (response.statusCode == 200) {

        final int status =   response.data['status'];
        final String message = response.data['message'];
        final dynamic params = response.data['params'];

        return ApiResponse(status: status, message: message, params: params);
    
      } else {
        throw Exception('API failed with status code: ${response.statusCode}');
      }

    } catch (e) {
      throw Exception('An Error occurred: $e');
    }
  }

  Future<UpdateUser> updateUser(UpdateUser user) async {
    try {
      logger.d(user.toJson());
      final response = await dio.put('http://localhost:8888/flutter-demo-fake-server-api/api/v1/members/createMembers.json', data: user.toJson());


      return UpdateUser.fromJson(response.data);
    } catch (e) {
      throw Exception('An Error occurred: $e');
    }
  }

  Future<ApiResponse> deleteUser(String userId, String language) async {
    try {
      String language_api = convertLanguage(language);
      final formData = {    // post - body (from-data)
        'id': userId,
      };

      final options = Options(
          headers: {
            'Authorization': 'Bearer <token>',
            'Content-Type': 'application/x-www-form-urlencoded',
            'Language': language_api,
          }
      );

      final response = await dio.post('http://localhost:8888/flutter-demo-fake-server-api/api/v1/members/deleteMembers.json',
          data: formData,
          options: options,
      );

      if (response.statusCode == 200) {

        final int status =   response.data['status'];
        final String message = response.data['message'];
        final dynamic params = response.data['params'];

        return ApiResponse(status: status, message: message, params: params);

      } else {
        throw Exception('API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An Error occurred: $e');
    }
  }
}
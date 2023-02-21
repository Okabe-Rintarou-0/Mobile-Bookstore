import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:mobile_bookstore/model/book_snapshot.dart';
import 'package:mobile_bookstore/model/response.dart' as model;
import 'package:path_provider/path_provider.dart';

import '../constants.dart';
import '../model/book_details.dart';

class Api {
  static CookieJar? cookieJar;
  static final Dio dio = Dio();

  static Future init() async {
    Directory tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;
    cookieJar =
        PersistCookieJar(ignoreExpires: true, storage: FileStorage(tempPath));
    dio.interceptors.add(CookieManager(cookieJar!));
  }

  static Future<BookDetails?> getBookDetailsById(int id) async {
    try {
      print("$bookDetailsUrl/$id");
      final response = await dio.get("$bookDetailsUrl/$id");
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.toString());
        var payload = data["payload"];
        return BookDetails.fromJson(payload);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<BookSnapshot?> getBookSnapshotById(int id) async {
    try {
      print("$bookSnapshotUrl/$id");
      final response = await dio.get("$bookSnapshotUrl/$id");
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.toString());
        var payload = data["payload"];
        return BookSnapshot.fromJson(payload);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List<BookSnapshot>> getRangedBookSnapshots(
      int startIdx, int endIdx) async {
    List<BookSnapshot> books = [];
    try {
      print("$bookRangedSnapshotsUrl?start=$startIdx&end=$endIdx");
      final response =
          await dio.get("$bookRangedSnapshotsUrl?start=$startIdx&end=$endIdx");
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.toString());
        List<dynamic> payload = data["payload"];
        for (var bookJson in payload) {
          books.add(BookSnapshot.fromJson(bookJson));
        }
        return books;
      }
    } catch (e) {
      print(e);
    }
    return books;
  }

  static Future<bool> checkSession() async {
    try {
      if (cookieJar == null) {
        await init();
      }
      final response = await dio.get(checkSessionUrl);
      if (response.statusCode == HttpStatus.ok) {
        print(response);
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        return res.success;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> register(String username, String password, String email, String nickname) async {
    try {
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
        'email': email,
        'nickname': nickname
      });
      final response = await dio.post(registerUrl, data: formData);
      if (response.statusCode == HttpStatus.ok) {
        print(response);
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        return res.success;
      }
    } catch (e) {
      print("err $e");
    }
    return false;
  }

  static Future<bool> login(String username, String password) async {
    try {
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });
      final response = await dio.post(loginUrl, data: formData);
      if (response.statusCode == HttpStatus.ok) {
        print(response);
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        return res.success;
      }
    } catch (e) {
      print("err $e");
    }
    return false;
  }

  static Future<bool> logout() async {
    try {
      final response = await dio.get(logoutUrl);
      if (response.statusCode == HttpStatus.ok) {
        print(response);
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        return res.success;
      }
    } catch (e) {
      print("err $e");
    }
    return false;
  }
}

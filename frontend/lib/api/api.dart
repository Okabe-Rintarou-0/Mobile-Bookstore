import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:mobile_bookstore/model/address.dart';
import 'package:mobile_bookstore/model/book_snapshot.dart';
import 'package:mobile_bookstore/model/cart_item.dart';
import 'package:mobile_bookstore/model/comment.dart';
import 'package:mobile_bookstore/model/response.dart' as model;
import 'package:mobile_bookstore/model/user.dart';
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

  static Future<model.Response?> postResponse(String url) async {
    try {
      final response = await dio.post(url);
      if (response.statusCode == HttpStatus.ok) {
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        return res;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<model.Response?> getResponse(String url) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == HttpStatus.ok) {
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        return res;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<model.Response?> putResponse(String url, {Object? data}) async {
    try {
      final response = await dio.put(url, data: data);
      if (response.statusCode == HttpStatus.ok) {
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        return res;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<model.Response?> deleteResponse(String url) async {
    try {
      final response = await dio.delete(url);
      if (response.statusCode == HttpStatus.ok) {
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        return res;
      }
    } catch (e) {
      print(e);
    }
    return null;
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
      final url = "$bookRangedSnapshotsUrl?start=$startIdx&end=$endIdx";
      final response = await dio.get(url);
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

  static Future<model.Response?> addToCart(int bookId) async {
    final url = "$apiPrefix/books/$bookId/cart";
    return postResponse(url);
  }

  static Future<model.Response?> removeCartItem(int cartItemId) async {
    final url = "$apiPrefix/cart/$cartItemId";
    return deleteResponse(url);
  }

  static Future<model.Response?> updateCartNumber(
      int cartItemId, int number) async {
    final url = "$apiPrefix/cart/$cartItemId/number/$number";
    return putResponse(url);
  }

  static Future<List<CartItem>> getCartItems() async {
    List<CartItem> items = [];
    try {
      const url = cartUrl;
      print(url);
      final response = await dio.get(url);
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.toString());
        if (data["payload"] == null) {
          return items;
        }
        List<dynamic> payload = data["payload"];
        for (var itemJson in payload) {
          items.add(CartItem.fromJson(itemJson));
        }
        return items;
      }
    } catch (e) {
      print(e);
    }
    return items;
  }

  static Future<List<BookSnapshot>> searchBook(
      String keyword, int startIdx, int endIdx) async {
    List<BookSnapshot> books = [];
    try {
      final url =
          "$bookSearchUrl?keyword=$keyword&startIdx=$startIdx&endIdx=$endIdx";
      print(url);
      final response = await dio.get(url);
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.toString());
        if (data["payload"] == null) {
          return books;
        }
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

  static Future<bool> register(
      String username, String password, String email, String nickname) async {
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

  static Future<bool> uploadComment(int bookId, String comment) async {
    try {
      final String url = "$apiPrefix/books/$bookId/comments";
      print(url);
      final response = await dio.post(url, data: comment);
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

  static Future<UserProfile?> getUserProfile() async {
    try {
      final response = await dio.get(userProfileUrl);
      if (response.statusCode == HttpStatus.ok) {
        print(response);
        var data = jsonDecode(response.toString());
        var payload = data["payload"];
        return UserProfile.fromJson(payload);
      }
    } catch (e) {
      print("err $e");
    }
    return null;
  }

  static Future<bool> uploadImage(String url) async {
    try {
      FormData formData =
          FormData.fromMap({"file": await MultipartFile.fromFile(url)});
      final response = await dio.post(uploadImageUrl, data: formData);
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

  static Future<BookCommentsSnapshot?> getBookCommentsSnapshot(
      int bookId) async {
    try {
      print("$apiPrefix/books/$bookId/comments/snapshot");
      final response =
          await dio.get("$apiPrefix/books/$bookId/comments/snapshot");
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.toString());
        var payload = data["payload"];
        var s = BookCommentsSnapshot.fromJson(payload);
        return s;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<bool> likeOrCancelLike(String commentId, bool isLiked) async {
    try {
      print("$commentsUrl/$commentId/like");
      final response = await dio.get("$commentsUrl/$commentId/like");
      if (response.statusCode == HttpStatus.ok) {
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        if (!res.success) {
          return isLiked;
        }
        return res.payload as bool;
      }
    } catch (e) {
      print(e);
    }
    return isLiked;
  }

  static Future<bool> getIsLiked(String commentId) async {
    try {
      print("$commentsUrl/$commentId/liked");
      final response = await dio.get("$commentsUrl/$commentId/liked");
      if (response.statusCode == HttpStatus.ok) {
        var parsedJson = jsonDecode(response.toString());
        model.Response res = model.Response.fromJson(parsedJson);
        if (!res.success) {
          return false;
        }
        return res.payload as bool;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<List<AddressInfo>> getAddresses() async {
    List<AddressInfo> addresses = [];
    try {
      final response = await dio.get(userAddressesUrl);
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.toString());
        List<dynamic> payload = data["payload"];
        for (var addrJson in payload) {
          addresses.add(AddressInfo.fromJson(addrJson));
        }
        return addresses;
      }
    } catch (e) {
      print(e);
    }
    return addresses;
  }

  static Future<model.Response?> changeDefaultAddress(
      int oldId, int newId) async {
    return putResponse(userDefaultAddressUrl,
        data: json.encode({"oldId": oldId, "newId": newId}));
  }

  static Future<model.Response?> deleteAddress(int addrId) async {
    return deleteResponse("$userAddressesUrl/$addrId");
  }
}

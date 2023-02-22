import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageUtils {
  static Future<bool> saveNetworkImage(String imgUrl, String name) async {
    var response = await Dio()
        .get(imgUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: name);
    print(result);
    return true;
  }
}

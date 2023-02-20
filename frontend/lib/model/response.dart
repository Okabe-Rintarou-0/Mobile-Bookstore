import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    required this.success,
    required this.message,
    required this.err,
    required this.payload,
  });

  bool success;
  String message;
  String err;
  dynamic payload;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        success: json["success"],
        message: json["message"],
        err: json["err"],
        payload: json["payload"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "err": err,
        "payload": payload,
      };
}

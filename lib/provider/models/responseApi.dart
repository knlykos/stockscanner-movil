// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

class ResponseApi {
    List<dynamic> data;
    String message;
    String error;

    ResponseApi({
        this.data,
        this.message,
        this.error,
    });

    factory ResponseApi.fromRawJson(String str) => ResponseApi.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResponseApi.fromJson(Map<String, dynamic> json) => ResponseApi(
        data: json["data"] == null ? null : List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"] == null ? null : json["message"],
        error: json["error"] == null ? null : json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
        "message": message == null ? null : message,
        "error": error == null ? null : error,
    };
}

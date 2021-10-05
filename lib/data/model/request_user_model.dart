import 'package:meta/meta.dart';
import 'dart:convert';

RequestUserModel requestUserModelFromJson(String str) =>
    RequestUserModel.fromJson(json.decode(str));

String requestUserModelToJson(RequestUserModel data) =>
    json.encode(data.toJson());

class RequestUserModel {
  RequestUserModel({
    @required this.id,
    @required this.createdAt,
  });

  final String? id;
  final DateTime? createdAt;

  factory RequestUserModel.fromJson(Map<String, dynamic> json) =>
      RequestUserModel(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
      };
}

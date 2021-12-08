// To parse this JSON data, do
//
//     final responseVideo = responseVideoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResponseVideo responseVideoFromJson(String str) =>
    ResponseVideo.fromJson(json.decode(str));

String responseVideoToJson(ResponseVideo data) => json.encode(data.toJson());

class ResponseVideo {
  ResponseVideo({
    required this.status,
    required this.message,
    required this.videos,
  });

  final String status;
  final String message;
  final List<Video> videos;

  factory ResponseVideo.fromJson(Map<String, dynamic> json) => ResponseVideo(
        status: json["status"],
        message: json["message"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class Video {
  Video({
    required this.id,
    required this.name,
    required this.description,
    required this.youtubeLink,
    required this.showOnUser,
    required this.showOnDriver,
    required this.videoCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final int id;
  final String name;
  final String description;
  final String youtubeLink;
  final int showOnUser;
  final int showOnDriver;
  final int videoCategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        youtubeLink: json["youtube_link"],
        showOnUser: json["show_on_user"],
        showOnDriver: json["show_on_driver"],
        videoCategoryId: json["video_category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "youtube_link": youtubeLink,
        "show_on_user": showOnUser,
        "show_on_driver": showOnDriver,
        "video_category_id": videoCategoryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

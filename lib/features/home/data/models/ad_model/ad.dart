import 'package:flutter/material.dart';

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class Ad extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final Uint8List? image;
  final int? isExpired;
  final dynamic stageId;
  final dynamic yearId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Ad({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.image,
    this.isExpired,
    this.stageId,
    this.yearId,
    this.createdAt,
    this.updatedAt,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        imageUrl: json['image_url'] as String?,
        isExpired: json['isExpired'] as int?,
        stageId: json['stage_id'] as dynamic,
        yearId: json['year_id'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image_url': imageUrl,
        // 'image': image,
        'isExpired': isExpired,
        'stage_id': stageId,
        'year_id': yearId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
  Map<String, dynamic> toUploadJson() => {
        'title': title,
        'description': description,
        'image': MultipartFile.fromBytes(image!.toList(), filename: title),
      };
  Map<String, dynamic> toUpdateJson() {
    if (image == null) {
      return {
        'ad_id': id,
        'title': title,
        'description': description,
      };
    }
    return {
      'ad_id': id,
      'title': title,
      'description': description,
      'image': MultipartFile.fromBytes(image!.toList(), filename: title),
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      imageUrl,
      image,
      isExpired,
      stageId,
      yearId,
      createdAt,
      updatedAt,
    ];
  }

  Ad copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? title,
    ValueGetter<String?>? description,
    ValueGetter<String?>? imageUrl,
    ValueGetter<Uint8List?>? image,
    ValueGetter<int?>? isExpired,
    dynamic stageId,
    dynamic yearId,
    ValueGetter<DateTime?>? createdAt,
    ValueGetter<DateTime?>? updatedAt,
  }) {
    return Ad(
      id: id != null ? id() : this.id,
      title: title != null ? title() : this.title,
      description: description != null ? description() : this.description,
      imageUrl: imageUrl != null ? imageUrl() : this.imageUrl,
      image: image != null ? image() : this.image,
      isExpired: isExpired != null ? isExpired() : this.isExpired,
      stageId: stageId ?? this.stageId,
      yearId: yearId ?? this.yearId,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt() : this.updatedAt,
    );
  }
}

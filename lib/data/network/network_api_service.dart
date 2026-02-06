import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluxwalls/data/network/base_api_service.dart';
import 'package:fluxwalls/model/photos_collection_model/Photos_Collection_Model.dart';
import 'package:fluxwalls/resources/api_urls/api_urls.dart';
import 'package:path_provider/path_provider.dart';

import '../../resources/envconfig/env_config.dart';
import '../../utils/app_exceptions.dart';

class NetworkApiService extends BaseApiService {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Client-ID ${EnvConfig.accessKey}",
        'Accept-Version': 'v1',
      },
    ),
  );

  @override
  Future<PhotosCollectionModel> getPhotosCollection(int page) async {
    try {
      final response = await dio.get(
        "${ApiUrls.baseUrl}/search/photos",
        queryParameters: {
          "query": "wallpaper",
          "page": page,
          "per_page": 30,
          "orientation": "portrait",
        },
      );
      return PhotosCollectionModel.fromJson(_returnData(response));
    } on SocketException {
      throw InternetException("No Internet Connection");
    } on TimeoutException {
      throw TimeoutException("Request Timeout");
    } catch (e) {
      throw Exception(e);
    }
  }

  dynamic _returnData(Response response) {
    log(response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw ServerException("Invalid Url Exception");
      case 401:
        throw UnauthorizedException("Unauthorized");
      default:
        throw Exception("Unknown error: ${response.statusCode}");
    }
  }

  @override
  Future<String> downloadSpecificPhoto(
    String photoUrl, {
    Function(double progress)? onProgress,
  }) async {
    try {
      final dir =
          await getDownloadsDirectory(); // Or use getApplicationDocumentsDirectory() if you want the file to persist longer
      final filePath =
          "${dir?.path}/${DateTime.now().millisecondsSinceEpoch}/FluxWalls.jpg";
      final file = File(filePath);
      await dio.download(
        photoUrl,
        file.path,
        onReceiveProgress: (received, total) {
          if (total != -1 && onProgress != null) {
            onProgress(received / total); // convert to 0.0 - 1.0 double
          }
        },
      );
      return file.path;
    } on SocketException {
      throw InternetException("No Internet Connection");
    } on TimeoutException {
      throw TimeoutException("Download Timeout");
    } catch (e) {
      throw Exception("Download failed: $e");
    }
  }

  @override
  Future<dynamic> getSpecificPhoto(String photoId) async {}

  @override
  Future<PhotosCollectionModel> getSearchQuery(String query, int page) async {
    try {
      final response = await dio.get(
        "${ApiUrls.baseUrl}/search/photos",
        queryParameters: {
          "query": query,
          "per_page": 30,
          "page": page,
          "orientation": "portrait",
        },
      );
      return PhotosCollectionModel.fromJson(_returnData(response));
    } on SocketException {
      throw InternetException("No Internet Connection");
    } on TimeoutException {
      throw TimeoutException("Request Timeout");
    } catch (e) {
      throw Exception(e);
    }
  }
}

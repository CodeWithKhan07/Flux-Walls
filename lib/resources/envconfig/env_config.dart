import 'package:flutter_dotenv/flutter_dotenv.dart';
class EnvConfig {
  static  String appId=dotenv.env['APPLICATION_ID'] ?? '';
  static  String accessKey=dotenv.env['ACCESS_KEY'] ?? '';
  static  String secretKey=dotenv.env['SECRET_KEY'] ?? '';
}
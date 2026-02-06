class AppExceptions  implements Exception{
  final messege;
  final _prefix;
  @override
  String toString() {
    return "$_prefix$messege";
  }
  AppExceptions([ this.messege, this._prefix]);
}
class InternetException extends AppExceptions{
  InternetException([String? messege]): super(messege,"");
}
class RequestTimeout extends AppExceptions{
  RequestTimeout([String? messege]): super(messege,"");
}
class ServerException extends AppExceptions{
  ServerException([String? messege]): super(messege,"");
}
class InvalidUrl extends AppExceptions{
  InvalidUrl([String? messege]): super(messege,"");
}
class FetchDataException extends AppExceptions{
  FetchDataException([String? messege]): super(messege,"");
}
class UnauthorizedException extends AppExceptions{
  UnauthorizedException([String? messege]): super(messege,"");
}

import 'dart:convert';

import 'package:core_package/core_package.dart';
import 'package:dio/dio.dart';

class CurlLogIntercepter extends InterceptorsWrapper {
  final bool? printOnSuccess;
  final bool convertFormData;

  final logger = AppLogger();

  CurlLogIntercepter({this.printOnSuccess, this.convertFormData = true});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _renderCurlRepresentation(err.requestOptions);

    return handler.next(err); //continue
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (printOnSuccess != null && printOnSuccess == true) {
      _renderCurlRepresentation(response.requestOptions);
    }

    return handler.next(response); //continue
  }

  void _renderCurlRepresentation(RequestOptions requestOptions) {
    // add a breakpoint here so all errors can break
    try {
      logger.w(_cURLRepresentation(requestOptions));
    } catch (err) {
      logger.w('unable to create a CURL representation of the requestOptions');
    }
  }

  String _cURLRepresentation(RequestOptions options) {
    String cmd = "curl";
    String header = options.headers
        .map((key, value) {
          if (key == "content-type" &&
              value.toString().contains("multipart/form-data")) {
            value = "multipart/form-data;";
          }
          return MapEntry(key, "-H '$key: $value'");
        })
        .values
        .join(" ");
    String url = "${options.baseUrl}${options.path}";
    if (options.queryParameters.isNotEmpty) {
      String query = options.queryParameters
          .map((key, value) {
            return MapEntry(key, "$key=$value");
          })
          .values
          .join("&");

      url += (url.contains("?")) ? query : "?$query";
    }
    if (options.method == "GET") {
      cmd += " $header '$url'";
    } else {
      Map<String, dynamic> files = {};
      String postData = "-d ''";
      if (options.data != null) {
        if (options.data is FormData) {
          FormData fdata = options.data as FormData;
          for (var element in fdata.files) {
            MultipartFile file = element.value;
            files[element.key] = "@${file.filename}";
          }
          for (var element in fdata.fields) {
            files[element.key] = element.value;
          }
          if (files.isNotEmpty) {
            postData = files
                .map((key, value) => MapEntry(key, "-F '$key=$value'"))
                .values
                .join(" ");
          }
        } else if (options.data is Map<String, dynamic>) {
          files.addAll(options.data);

          if (files.isNotEmpty) {
            postData = "-d '${json.encode(files).toString()}'";
          }
        }
      }

      String method = options.method.toString();
      cmd += " -X $method $postData $header '$url'";
    }

    return cmd;
  }
}

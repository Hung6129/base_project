import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse<T> {
  @JsonKey(name: 'statusCode', defaultValue: 200)
  int statusCode;
  @JsonKey(name: 'error')
  ErrorBean? error;
  @JsonKey(name: 'data')
  T? data;

  BaseResponse({required this.statusCode, this.data, this.error});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);

  bool get isSuccess => statusCode >= 200 && statusCode <= 299;
}

@JsonSerializable()
class ErrorBean {
  @JsonKey(name: 'code', defaultValue: '')
  String code;
  @JsonKey(name: 'message', defaultValue: '')
  String message;

  ErrorBean({required this.code, required this.message});

  factory ErrorBean.fromJson(Map<String, dynamic> json) =>
      _$ErrorBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorBeanToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => BaseResponse<T>(
  statusCode: (json['statusCode'] as num?)?.toInt() ?? 200,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  error: json['error'] == null
      ? null
      : ErrorBean.fromJson(json['error'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'error': instance.error,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

ErrorBean _$ErrorBeanFromJson(Map<String, dynamic> json) => ErrorBean(
  code: json['code'] as String? ?? '',
  message: json['message'] as String? ?? '',
);

Map<String, dynamic> _$ErrorBeanToJson(ErrorBean instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
};

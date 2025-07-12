// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_page_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePageListResponse<T> _$BasePageListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => BasePageListResponse<T>(
  statusCode: (json['statusCode'] as num?)?.toInt() ?? 200,
  data: PageListDataBean<T>.fromJson(
    json['data'] as Map<String, dynamic>,
    (value) => fromJsonT(value),
  ),
  error: json['error'] == null
      ? null
      : ErrorBean.fromJson(json['error'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BasePageListResponseToJson<T>(
  BasePageListResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'error': instance.error,
  'data': instance.data.toJson((value) => toJsonT(value)),
};

PageListDataBean<T> _$PageListDataBeanFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PageListDataBean<T>(
  items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
  meta: MetaDataBean.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PageListDataBeanToJson<T>(
  PageListDataBean<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'meta': instance.meta,
};

MetaDataBean _$MetaDataBeanFromJson(Map<String, dynamic> json) => MetaDataBean(
  page: (json['page'] as num?)?.toInt() ?? 1,
  take: (json['take'] as num?)?.toInt() ?? 10,
  itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
  pageCount: (json['pageCount'] as num?)?.toInt() ?? 1,
  hasNextPage: json['hasNextPage'] as bool? ?? false,
);

Map<String, dynamic> _$MetaDataBeanToJson(MetaDataBean instance) =>
    <String, dynamic>{
      'page': instance.page,
      'take': instance.take,
      'itemCount': instance.itemCount,
      'pageCount': instance.pageCount,
      'hasNextPage': instance.hasNextPage,
    };

ErrorBean _$ErrorBeanFromJson(Map<String, dynamic> json) => ErrorBean(
  code: json['code'] as String? ?? '',
  message: json['message'] as String? ?? '',
);

Map<String, dynamic> _$ErrorBeanToJson(ErrorBean instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
};

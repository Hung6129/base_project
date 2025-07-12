import 'package:json_annotation/json_annotation.dart';

part 'base_page_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BasePageListResponse<T> {
  @JsonKey(name: 'statusCode', defaultValue: 200)
  int statusCode;
  @JsonKey(name: 'error')
  ErrorBean? error;
  @JsonKey(name: 'data')
  PageListDataBean<T> data;

  BasePageListResponse({
    required this.statusCode,
    required this.data,
    this.error,
  });

  factory BasePageListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BasePageListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BasePageListResponseToJson(this, toJsonT);

  bool get isSuccess => statusCode >= 200 && statusCode <= 299;
}

@JsonSerializable(genericArgumentFactories: true)
class PageListDataBean<T> {
  @JsonKey(name: 'items', defaultValue: [])
  List<T> items;
  @JsonKey(name: 'meta')
  MetaDataBean meta;

  PageListDataBean({required this.items, required this.meta});

  factory PageListDataBean.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PageListDataBeanFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PageListDataBeanToJson(this, toJsonT);
}

@JsonSerializable()
class MetaDataBean {
  @JsonKey(name: 'page', defaultValue: 1)
  int page;
  @JsonKey(name: 'take', defaultValue: 10)
  int take;
  @JsonKey(name: 'itemCount', defaultValue: 0)
  int itemCount;
  @JsonKey(name: 'pageCount', defaultValue: 1)
  int pageCount;
  @JsonKey(name: 'hasNextPage', defaultValue: false)
  bool hasNextPage;

  MetaDataBean({
    required this.page,
    required this.take,
    required this.itemCount,
    required this.pageCount,
    required this.hasNextPage,
  });

  factory MetaDataBean.fromJson(Map<String, dynamic> json) =>
      _$MetaDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataBeanToJson(this);
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

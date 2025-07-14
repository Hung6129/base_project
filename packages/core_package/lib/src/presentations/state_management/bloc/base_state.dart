part of 'base_bloc.dart';

enum BaseStateEnums { init, loading, refreshing, success, empty, error, processing, loadMore }

class BaseBlocState<T> extends Equatable {
  final BaseStateEnums status;
  final T data;
  final Object? error;
  final String? message;

  const BaseBlocState({this.status = BaseStateEnums.init, required this.data, this.error, this.message});

  @override
  String toString() => '$runtimeType ($props)';

  @override
  List get props => [status, data, error, message];

  bool get isInit => status == BaseStateEnums.init;

  bool get isLoading => status == BaseStateEnums.loading;

  bool get isProcessing => status == BaseStateEnums.processing;

  bool get isRefreshing => status == BaseStateEnums.refreshing;

  bool get isSuccess => status == BaseStateEnums.success;

  bool get isEmpty => status == BaseStateEnums.empty;

  bool get isError => status == BaseStateEnums.error;

  bool get isLoadMore => status == BaseStateEnums.loadMore;
}

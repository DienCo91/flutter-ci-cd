// Class bọc State (Y hệt lúc nãy)
import 'package:equatable/equatable.dart';

class PaginationState<T> extends Equatable {
  final List<T> data;
  final int page;
  final bool hasNextPage;
  final bool isLoadingMore;

  const PaginationState({
    required this.data,
    required this.page,
    required this.hasNextPage,
    this.isLoadingMore = false,
  });

  PaginationState<T> copyWith({List<T>? data, int? page, bool? hasNextPage, bool? isLoadingMore}) {
    return PaginationState<T>(
      data: data ?? this.data,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [data, page, hasNextPage, isLoadingMore];
}

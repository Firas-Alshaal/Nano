// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:nano/model/product/product.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

// get post

class GetProductsInProgress extends HomeState {}

class GetProductsSuccess extends HomeState {
  List<Product> products;

  GetProductsSuccess({required this.products});

  @override
  List<Object> get props => [];
}

class GetProductsFailure extends HomeState {
  String? message;

  GetProductsFailure({this.message});
}

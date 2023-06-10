// ignore_for_file: override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:nano/model/product/product.dart';
import 'package:nano/repository/homeRepo/home_api.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeApi homeApi;

  HomeBloc({required this.homeApi}) : super(HomeInitial()) {
    on<GetProductsRequested>((event, emit) async {
      await _getProducts(event, emit);
    });
  }

  Future<void> _getProducts(
      GetProductsRequested event, Emitter<HomeState> emit) async {
    emit(GetProductsInProgress());
    try {
      Response res = await homeApi.getProducts();
      if (res.statusCode == 200) {
        List<Product> products = List.from(jsonDecode(res.body))
            .map((e) => Product.fromJson(e))
            .toList();
        emit(GetProductsSuccess(products: products));
      } else {
        emit(GetProductsFailure(message: 'Please try again'));
      }
    } catch (e) {
      emit(GetProductsFailure(message: (e.toString())));
    }
  }
}

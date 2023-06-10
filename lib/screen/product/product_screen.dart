import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nano/bloc/home/home_bloc.dart';
import 'package:nano/bloc/home/home_event.dart';
import 'package:nano/bloc/home/home_state.dart';
import 'package:nano/model/product/product.dart';
import 'package:nano/repository/homeRepo/home_api.dart';
import 'package:nano/utils/theme_color.dart';
import 'package:nano/widget/material/appbar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:nano/widget/product/product_item.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late HomeBloc homeBloc;
  HomeApi homeApi = HomeApi(httpClient: http.Client());
  late List<Product> products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = HomeBloc(homeApi: homeApi);
    homeBloc.add(GetProductsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'All Products'),
      body: BlocBuilder(
          bloc: homeBloc,
          builder: (context, state) {
            if (state is GetProductsInProgress) {
              return Center(
                  child: CircularProgressIndicator(
                      color: ColorsFave.primaryColor));
            } else if (state is GetProductsSuccess) {
              products = state.products;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: products
                        .map((product) => ProductItem(product: product))
                        .toList(),
                  ),
                ),
              );
            } else if (state is GetProductsFailure) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sorry, something went wrong, you can try again',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          color: ColorsFave.navyBlue,
                          fontSize: 28,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsFave.primaryColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(43)),
                        ),
                        onPressed: () {
                          homeBloc.add(GetProductsRequested());
                        },
                        child: FittedBox(
                          child: Text('Try Again',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          }),
    );
  }
}

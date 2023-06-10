import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nano/model/product/product.dart';
import 'package:nano/utils/images.dart';
import 'package:nano/utils/theme_color.dart';
import 'package:nano/widget/material/bottom_sheet_widget.dart';
import 'package:nano/widget/product/product_details_widget.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class ProductDetailsScreen extends StatelessWidget {
  Product product;
  SolidController controllerBottomSheet = SolidController();

  ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#D8D8D8'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 1],
                colors: [
                  HexColor('#000000').withOpacity(0.6),
                  HexColor('#000000').withOpacity(0.1),
                ],
              )),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const ProductDetailsIconWidget(
                                iconData: Icons.arrow_back)),
                        const ProductDetailsIconWidget(
                          iconData: Icons.more_vert,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          'Details',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 28),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (controllerBottomSheet.isOpened) {
                  controllerBottomSheet.hide();
                }
              },
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: imageProvider,
                        ),
                      ),
                    )),
                imageUrl: product.image!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorsFave.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(Images.logo)),
                          ),
                        )),
                errorWidget: (context, url, error) => AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorsFave.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                        image: const DecorationImage(
                            fit: BoxFit.fill, image: AssetImage(Images.logo)),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '${product.price!} AED',
                style: GoogleFonts.openSans(
                    color: ColorsFave.priceColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheetWidget(
          product: product, controllerBottomSheet: controllerBottomSheet),
    );
  }
}

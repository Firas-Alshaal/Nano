import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nano/model/product/product.dart';
import 'package:nano/utils/images.dart';
import 'package:nano/utils/theme_color.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class BottomSheetWidget extends StatelessWidget {
  Product product;
  SolidController controllerBottomSheet;

  BottomSheetWidget(
      {Key? key, required this.product, required this.controllerBottomSheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SolidBottomSheet(
      controller: controllerBottomSheet,
      maxHeight: MediaQuery.of(context).size.height * 0.3,
      headerBar: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 15,
                  color: HexColor('#6b7f99').withOpacity(0.25),
                ),
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SvgPicture.asset(Images.arrowDown)],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            blurRadius: 15,
                            color: HexColor('#6b7f99').withOpacity(0.25),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Center(child: SvgPicture.asset(Images.share)),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsFave.primaryColor,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(43)),
                      ),
                      onPressed: () {},
                      child: FittedBox(
                        child: Text('Order Now',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                'Description',
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: ColorsFave.titleProductColor),
              ),
              const SizedBox(height: 7),
              Text(
                product.description!,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: ColorsFave.descriptionColor),
              ),
              const SizedBox(height: 7),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: HexColor('#F1F1F1'),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reviews (${product.rating.count!})',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: ColorsFave.titleProductColor),
                    ),
                    const SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.rating.rate!,
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w600, fontSize: 32),
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: double.parse(product.rating.rate!),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => SvgPicture.asset(
                              Images.star,
                              color: ColorsFave.starColor,
                            ),
                            unratedColor: HexColor('#E4E4E4'),
                            onRatingUpdate: (rating) {},
                            itemSize: 22,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );
  }
}

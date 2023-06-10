import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nano/model/product/product.dart';
import 'package:nano/screen/product/product_details_screen.dart';
import 'package:nano/utils/images.dart';
import 'package:nano/utils/theme_color.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ProductItem extends StatelessWidget {
  Product product;

  ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ProductDetailsScreen(product: product),
          withNavBar: false,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: ColorsFave.backgroundPages,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageBuilder: (context, imageProvider) => AspectRatio(
                  aspectRatio: 2 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: imageProvider,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                '${product.price!} AED',
                                style: GoogleFonts.openSans(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.25),
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
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
                              ignoreGestures: true,
                            ),
                          ]),
                    ),
                  )),
              imageUrl: product.image!,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  AspectRatio(
                      aspectRatio: 2 / 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsFave.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              fit: BoxFit.fill, image: AssetImage(Images.logo)),
                        ),
                      )),
              errorWidget: (context, url, error) => AspectRatio(
                  aspectRatio: 2 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsFave.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          fit: BoxFit.fill, image: AssetImage(Images.logo)),
                    ),
                  )),
            ),
            const SizedBox(height: 10),
            Text(
              product.title!,
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                  color: ColorsFave.titleProductColor),
            ),
            const SizedBox(height: 6),
            Text(
              product.description!,
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  height: 1.5,
                  letterSpacing: 0.17,
                  color: ColorsFave.navyBlue),
            ),
            Divider(
              height: 60,
              color: HexColor('#D8D8D8'),
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}

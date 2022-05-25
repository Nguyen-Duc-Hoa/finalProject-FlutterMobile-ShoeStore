import 'package:finalprojectmobile/models/Cart.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/models/voucher.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finalprojectmobile/components/default_button.dart';
import 'package:get/get.dart';
import 'package:finalprojectmobile/screens/payment/checkout.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:finalprojectmobile/common.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  Common _common = new Common();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Users>(context);
    CartController _cartController = Get.find();

    if (user == null) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Text(
                    "Voucher",
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Text(AppLocalizations.of(context)!.voucherCode),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              GetBuilder<CartController>(
                builder: (s) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context)!.totalPayment + '\n',
                        children: [
                          TextSpan(
                            text: _common.formatCurrency(_cartController
                                .totalCart(_cartController.listOrder)),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(190),
                      child: DefaultButton(
                        text: AppLocalizations.of(context)!.purchase(_cartController.listOrder.length),
                        disable: _cartController.listOrder.isNotEmpty? false : true,
                        press: () {
                          if (_cartController.listOrder.isNotEmpty) {
                            _cartController.setVoucher(Voucher());
                            Get.to(const Checkout());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

import 'package:finalprojectmobile/models/Cart.dart';
import 'package:finalprojectmobile/models/user.dart';
import 'package:finalprojectmobile/models/voucher.dart';
import 'package:finalprojectmobile/screens/cart/CartController.dart';
import 'package:finalprojectmobile/screens/voucher/voucher.dart';
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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  final Common _common = Common();
  Voucher voucher = Voucher();
  int score = 0;

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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.15),
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
                    padding: const EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Text(
                    voucher.voucherId != null
                        ? 'Mã giảm giá: ' + voucher.voucherId.toString()
                        : "Voucher",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        if (_cartController.listOrder.isNotEmpty) {
                          await FirebaseFirestore.instance
                              .collection('ranking')
                              .where('userId', isEqualTo: user.uid)
                              .get()
                              .then((value) {
                            score = value.docs[0].get('score');
                          });
                          Voucher _voucher = await Get.to(VoucherScreen(
                            score: score,
                          ));
                          if (_voucher != null) {
                            setState(() {
                              voucher = _voucher;
                              _cartController.setVoucher(_voucher);
                            });
                          }
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.voucherCode)),
                  const SizedBox(width: 10),
                  const Icon(
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
                            text: _common.formatCurrency(
                                _cartController.totalFinalOrder(
                                    _cartController.listOrder, voucher.obs, 0)),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(190),
                      child: DefaultButton(
                        text: AppLocalizations.of(context)!
                            .purchase(_cartController.listOrder.length),
                        disable:
                            _cartController.listOrder.isNotEmpty ? false : true,
                        press: () {
                          if (_cartController.listOrder.isNotEmpty) {
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

import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:final_project_mobile/constants.dart';
import 'package:final_project_mobile/models/voucher.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:get/get.dart';

class Coupon extends StatelessWidget {
  const Coupon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0x5BF3E0CB);
    const Color secondaryColor = Color(0xff368f8b);
    List<Voucher> vouchers=[
      Voucher(voucherId: 'ANBCDE', voucherName: 'Miễn phí vận chuyển', voucherValue: 10000, startDate: DateTime.now(), endDate:DateTime.now()),
      Voucher(voucherId: 'KHJIWO', voucherName: 'Miễn phí vận chuyển', voucherValue: 20000, startDate: DateTime.now(), endDate:DateTime.now()),
    ];
    return Column(
      children:
        List.generate(vouchers.length, (index) {
          return Card(
            child: InkWell(
              onTap: () =>Get.back(result: vouchers[index]),
              child:  CouponCard(
                height: 150,
                backgroundColor: primaryColor,
                curveAxis: Axis.vertical,
                firstChild: Container(
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'SALE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'OFF',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.white54, height: 0),
                      Expanded(
                        child: Center(
                          child: Text(
                            'SHOP SHOES',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                secondChild: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${NumberFormat.currency(locale: 'vi').format(vouchers[index].voucherValue)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${vouchers[index].voucherName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${vouchers[index].startDate.toString().substring(0, vouchers[0].startDate.toString().lastIndexOf(":"))} - ${vouchers[index].endDate.toString().substring(0, vouchers[0].endDate.toString().lastIndexOf(":"))}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
          );
        }
        )

    );

  }
}

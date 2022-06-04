import 'package:finalprojectmobile/common.dart';
import 'package:finalprojectmobile/components/default_button.dart';
import 'package:finalprojectmobile/constants.dart';
import 'package:finalprojectmobile/size_config.dart';
import 'package:flutter/material.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  // List<dynamic> defaultPrice = [{'name':'100.000', 'value':100000 }, 200000, 300000, 500000, 1000000, 2000000];
  List<dynamic> defaultPrice = [
    {'name': '100.000', 'value': 100000},
    {'name': '200.000', 'value': 200000},
    {'name': '300.000', 'value': 300000},
    {'name': '500.000', 'value': 500000},
    {'name': '1.000.000', 'value': 1000000},
    {'name': '2.000.000', 'value': 2000000}
  ];

  final TextEditingController _controller = TextEditingController();

  final Common _common = Common();
  int selectedColor = 1;

  @override
  Widget build(BuildContext context) {
    _controller.text = defaultPrice[selectedColor]['value'].toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Nap tiền'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: const Text(
                  "Số tiền nạp (đ)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              height: 300,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenWidth(10)),
                child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: defaultPrice.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = index;
                            _controller.text = defaultPrice[selectedColor]['value'].toString();
                          });
                        },
                        child: AnimatedContainer(
                          duration: defaultDuration,
                          margin: EdgeInsets.only(right: 2),
                          padding:
                          EdgeInsets.all(getProportionateScreenWidth(7)),
                          height: getProportionateScreenWidth(20),
                          width: getProportionateScreenWidth(0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: index == selectedColor
                                      ? kPrimaryColor
                                      : Colors.black),
                            ),
                            child: Center(
                                child: Text(
                                  defaultPrice[index]['name'],
                                  style: TextStyle(
                                      color: index == selectedColor
                                          ? kPrimaryColor
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                )),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Text("Nhập số tiền (VND)"),
            TextFormField(
              onChanged: (text) async {
                print('a');
              },
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(5),
          horizontal: getProportionateScreenWidth(10),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.5),
            )
          ],
        ),
        child: SizedBox(
          width: getProportionateScreenWidth(220),
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.03,
              right: SizeConfig.screenWidth * 0.03,
              bottom: getProportionateScreenWidth(10),
              top: getProportionateScreenWidth(10),
            ),
            child: DefaultButton(text: "Thanh toán ngay", press: () {}),
          ),
        ),
      ),
    );
  }
}

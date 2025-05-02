import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/GetTransactionModel.dart';
import '../auth/custumScreen.dart';

class PaymentTransaction extends StatefulWidget {
  PaymentTransaction({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentTransaction> createState() => _PaymentTransactionState();
}

class _PaymentTransactionState extends State<PaymentTransaction> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaymentTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            customdecorationFORScr(context, "Payment"),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.14),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // const Divider(
                    //   color: AppColors.tabtextColor,
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // const Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     Text(
                    //       "Transaction History",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w500,
                    //           color: AppColors.blackTemp,
                    //           fontSize: 20),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    !isLoading
                        ? paymentList!.isEmpty
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.6,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                  child: Text('Payment History Not Found'),
                                ),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, bottom: 15),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: paymentList?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 7),
                                        child: Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              border: Border.all(
                                                  color: AppColors.primary,
                                                  width: 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Booking Id",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .tabtextColor,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Text(
                                                              paymentList?[
                                                                          index]
                                                                      .bookingId ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColors
                                                                      .tabtextColor,
                                                                  fontSize: 15),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Payment Id",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .tabtextColor,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Text(
                                                              paymentList?[
                                                                          index]
                                                                      .transactionId ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColors
                                                                      .tabtextColor,
                                                                  fontSize: 15),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Payment Type",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .tabtextColor,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Text(
                                                              paymentList?[
                                                                          index]
                                                                      .paymentMode ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColors
                                                                      .tabtextColor,
                                                                  fontSize: 15),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Amount",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .tabtextColor,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Text(
                                                              "${paymentList?[index].amount ?? ""} /-",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColors
                                                                      .tabtextColor,
                                                                  fontSize: 15),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Date",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .tabtextColor,
                                                            fontSize: 15),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Text(
                                                              paymentList?[
                                                                          index]
                                                                      .createdAt ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColors
                                                                      .tabtextColor,
                                                                  fontSize: 15),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                        : Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(
                              child: LoadingWidget2(context),
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isLoading = false;
  var userId;
  var balance;

  List<TransactionData>? paymentList;

  Future<void> getPaymentTransaction() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    var param = {
      'user_id': userId.toString(),
    };
    print("akdjaksjakj $param");
    apiBaseHelper.postAPICall(paymneturl, param).then((getDta) {
      if (getDta['status'] == true) {
        final transactionModel = GetTransactionModel.fromJson(getDta);
        setState(() {
          paymentList = transactionModel.data ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          paymentList = [];
          isLoading = false;
        });
      }
    }).catchError((error) {
      // Handle error
      setState(() {
        paymentList = [];
        isLoading = false;
      });
    });
  }
}

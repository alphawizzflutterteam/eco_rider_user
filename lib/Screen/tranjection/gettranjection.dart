import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/getTranjectionModel.dart';
import '../auth/custumScreen.dart';

class Tranjection extends StatefulWidget {
  String? walletBalance;
  Tranjection({Key? key, this.walletBalance}) : super(key: key);

  @override
  State<Tranjection> createState() => _TranjectionState();
}

class _TranjectionState extends State<Tranjection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTranjection();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            customdecorationFORScr(context, "Wallet"),
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
                    const SizedBox(
                      height: 20,
                    ),
                    // const Text(
                    //   "Wallet Balance",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       color: AppColors.blackTemp,
                    //       fontSize: 20),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   "\u{20B9} ${widget.walletBalance ?? '0'} /-",
                    //   style: const TextStyle(color: Colors.green, fontSize: 18),
                    // ),
                    Column(
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
                            ? tranjectionList.isEmpty
                                ? Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.6,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(
                                      child: Text('Payment History Not Found'),
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15, bottom: 15),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: tranjectionList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 7),
                                            child: Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  border: Border.all(
                                                      color: AppColors.primary,
                                                      width: 1)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Transaction Type",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Text(
                                                                  tranjectionList[
                                                                              index]
                                                                          .gatewayName ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: AppColors
                                                                          .tabtextColor,
                                                                      fontSize:
                                                                          15),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Payment Type",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Text(
                                                                  tranjectionList[
                                                                              index]
                                                                          .gatewayName ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: AppColors
                                                                          .tabtextColor,
                                                                      fontSize:
                                                                          15),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Transaction Amount",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Text(
                                                                  "${tranjectionList[index].balance ?? ""} /-",
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: AppColors
                                                                          .tabtextColor,
                                                                      fontSize:
                                                                          15),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Transaction Date",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Text(
                                                                  tranjectionList[
                                                                              index]
                                                                          .txnDate ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: AppColors
                                                                          .tabtextColor,
                                                                      fontSize:
                                                                          15),
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
  List<TranjectionHistoryModel> tranjectionList = [];
  Future<void> getTranjection() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    var param = {
      'user_id': userId.toString(),
    };
    apiBaseHelper.postAPICall(getTranjectionHistory, param).then(
      (getDta) {
        if (getDta['status'] == true) {
          setState(() {
            // balance = getDta['total'];
            tranjectionList = TranjectionHistory.fromJson(getDta).data ?? [];
            setState(() {
              isLoading = false;
            });
          });
        } else {
          tranjectionList.clear();
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }
}

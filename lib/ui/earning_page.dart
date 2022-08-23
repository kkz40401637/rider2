import 'package:apitestinglogin/models/earning/earning_model.dart';
import 'package:apitestinglogin/models/response_model.dart';
import 'package:apitestinglogin/ui/widgets/list_view_behavior.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:apitestinglogin/utils/stream_ext.dart';
import '../services/bloc/get_earn/get_earn_bloc.dart';

class EarningPage extends StatefulWidget {
  const EarningPage({Key? key}) : super(key: key);

  @override
  State<EarningPage> createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  final _bloc = GetEarnBLoc();
  String? startDate;
  String? endDate;

  @override
  void initState() {
    getDate();
    _bloc.getEarning(startDate: startDate!, endDate: endDate!);
    super.initState();
  }

  getDate() {
    endDate = DateTime.now().toString().split(" ")[0];
    startDate = DateTime.now()
        .subtract(const Duration(days: 30))
        .toString()
        .split(" ")[0];
    setState(() {});
  }

  changeDTRange(DateTimeRange? value) {
    if (value != null) {
      startDate = value.start.toString().split(" ")[0];
      endDate = value.end.toString().split(" ")[0];
      setState(() {});
      _bloc.getEarning(startDate: startDate!, endDate: endDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _bloc.earnStream().streamWidget(
          successWidget: (ResponseModel responseModel) {
            EarningModel earningModel = responseModel.data;
            return Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 42,
                                width: width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0x33000000)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "$startDate  to  $endDate",
                                      // "${startDate!.splitMapJoin("-").replaceAllMapped("-", (match) => "/")}    -  ${endDate!.splitMapJoin("-").replaceAllMapped("-", (match) => "/")}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Color(0xA6000000),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDateRangePicker(
                                            initialEntryMode:
                                            DatePickerEntryMode
                                                .calendarOnly,
                                            context: context,
                                            firstDate: DateTime(2021),
                                            lastDate: DateTime.now())
                                            .then((value) =>
                                            changeDTRange(value));
                                      },
                                      icon: const Icon(
                                        Icons.calendar_today,
                                        color: Color(0x33000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      //Overview
                      Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f2f7),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr('Overview'),
                              style: const TextStyle(
                                color: Color(0xA6000000),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OverviewContent(
                                      title: tr('TOTAL EARNING'),
                                      titleContent:
                                      earningModel.totalEarnings.toString(),
                                    ),
                                    const SizedBox(height: 20),
                                    OverviewContent(
                                      title: tr('DELIVERIES'),
                                      titleContent:
                                      earningModel.orderCount.toString(),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 50),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OverviewContent(
                                      title: tr('TIPS'),
                                      titleContent: '1,000 MMK',
                                    ),
                                    const SizedBox(height: 20),
                                    OverviewContent(
                                      title: tr('REWARDS'),
                                      titleContent: '0',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Earning and Withdraw
                SizedBox(
                  height: 50,
                  child: AppBar(
                    backgroundColor: Colors.white,
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          text: tr('EARNING'),
                        ),
                        Tab(
                          text: tr('WITHDRAW'),
                        ),
                      ],
                      labelColor: const Color(0xffF55F01),
                      indicatorColor: Color(0xffF55F01),
                      unselectedLabelColor: Color(0xBD000000),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TabBarView(
                      children: [
                        ScrollConfiguration(
                          behavior: ListViewBehavior(),
                          child: earningModel.riderDetail!.isEmpty
                              ? const Center(
                            child: Text("No Data Record"),
                          )
                              : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: earningModel.riderDetail!.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30, 5, 30, 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide.none,
                                    right: BorderSide.none,
                                    left: BorderSide.none,
                                    bottom: BorderSide(
                                      color: Color(0x33000000),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          DateFormat(
                                            'yyyy/MM/dd',
                                          ).format(DateTime.parse(
                                              earningModel
                                                  .riderDetail![index]
                                                  .orderedDate!)) +
                                              " . " +
                                              DateFormat(
                                                'hh:mm a',
                                              ).format(DateTime.parse(
                                                  earningModel
                                                      .riderDetail![index]
                                                      .orderedDate!)),
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0x80000000),
                                          ),
                                        ),
                                        Text(
                                          earningModel.riderDetail![index]
                                              .orderId!
                                              .split("-")[0],
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0x80000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      earningModel
                                          .riderDetail![index].deliveryFee
                                          .toString(),
                                      style: const TextStyle(
                                        color: Color(0xA6000000),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const Text("hi"),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          tryAgain: () {
            _bloc.getEarning(startDate: startDate!, endDate: endDate!);
          },
        ),
      ),
    );
  }
}

class OverviewContent extends StatelessWidget {
  const OverviewContent({
    Key? key,
    required this.title,
    required this.titleContent,
  }) : super(key: key);

  final String title;
  final String titleContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0x80000000),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          titleContent,
          style: const TextStyle(
            color: Color(0xB2000000),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
import 'package:apitestinglogin/ui/earning_page.dart';
import 'package:apitestinglogin/ui/history_page.dart';
import 'package:apitestinglogin/ui/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'delivery_page.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int pageIndex = 0;
  List pageLists = [
    const DeliveryPage(),
    const HistoryPage(),
    const EarningPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.delivery_dining,
              ),
              label: tr('Delivery')),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.history,
              ),
              label: tr('History')),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.account_balance,
              ),
              label: tr('Earning')),
          BottomNavigationBarItem(

              icon: const Icon(
                Icons.account_circle_outlined,
              ),
              label: tr('Profile')),

        ],
        selectedItemColor: const Color(0xFFF55F01),
        unselectedItemColor: const Color(0xFFF55F01),
        showUnselectedLabels: true,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      ),
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 219, 212, 212)),
        backgroundColor: const Color(0xFFF55F01),
        title: Text(
          textTileChange(pageIndex),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.headset_mic),
            onPressed: () {},
          )
        ],
      ),
      extendBody: true,
      body: pageLists[pageIndex],

    );
  }

  String textTileChange(int pageIndex) {
    if (pageIndex == 0) {
      return 'Delivery';
    } else if (pageIndex == 1) {
      return 'History';
    } else if (pageIndex == 2) {
      return 'Earning';
    } else {
      return 'Account';
    }
  }
}

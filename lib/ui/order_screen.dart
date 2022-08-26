import 'package:apitestinglogin/ui/earning_page.dart';
import 'package:apitestinglogin/ui/history_page.dart';
import 'package:apitestinglogin/ui/profile_page.dart';
import 'package:flutter/material.dart';

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

  Color selectedColor = const Color(0xFFFFFFFF);
  Color unSelectedColor = const Color(0xA6FFFFFF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFFF55F01),
        ),
        child: BottomNavigationBar(
          currentIndex: pageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.delivery_dining,
                ),
                label: 'Delivery'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                ),
                label: 'History'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_balance,
                ),
                label: 'Earning'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                ),
                label: 'Profile'),
          ],
          selectedItemColor: const Color(0xFFFFFFFF),
          unselectedItemColor: const Color(0xA6FFFFFF),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
        ),
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

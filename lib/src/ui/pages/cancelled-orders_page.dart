import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/constants.dart';
import 'package:medicine_customer_app/src/ui/views/admin-cancelled_view.dart';
import 'package:medicine_customer_app/src/ui/views/user-cancelled_view.dart';

class CancelledOrdersPage extends StatefulWidget {
  @override
  _CancelledOrderState createState() => _CancelledOrderState();
}

class _CancelledOrderState extends State<CancelledOrdersPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex;
  List<Widget> _list = [
    Tab(
      child: Text('Admin', style: TextStyle(color: kMainColor)),
    ),
    Tab(
      child: Text('User', style: TextStyle(color: kMainColor)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _list.length, vsync: this);
    _tabController.addListener(() {
      _selectedIndex = _tabController.index;
      print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cancelled Orders',
          style: TextStyle(color: kMainColor),
        ),
        bottom: TabBar(
          // isScrollable: true,
          indicatorColor: kMainColor,
          controller: _tabController,
          tabs: _list,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AdminCancelledView(),
          UserCancelledView(),
        ],
      ),
    );
  }
}

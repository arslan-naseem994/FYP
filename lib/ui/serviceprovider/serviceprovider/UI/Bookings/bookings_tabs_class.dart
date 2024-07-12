import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/cancel.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/completed.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/confirm.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/inprogress.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/pendingbookings.dart';

class OrderTabs extends StatefulWidget {
  @override
  _OrderTabsState createState() => _OrderTabsState();
}

class _OrderTabsState extends State<OrderTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5, // Number of tabs
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                labelPadding: EdgeInsets.symmetric(horizontal: 25),
                isScrollable: true,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 14),
                indicatorWeight: 5,
                // Customize the TabBar appearance
                indicatorColor: Color(0xff9749ff), // Color of the tab indicator
                labelColor: Colors.black, // Selected tab text color
                unselectedLabelColor: Colors.grey, // Unselected tab text color
                labelStyle: TextStyle(
                  fontWeight: FontWeight
                      .bold, // Customize the font style for selected tab
                ),
                tabs: [
                  Tab(text: 'Pending'),
                  Tab(text: 'Confirm'),
                  Tab(text: 'Canceled'),
                  Tab(text: 'Completed'),
                  Tab(text: 'InProgress'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OrdersScreen(showAppBar: false),
                    ConfirmScreen(showAppBar: false),
                    CancelTab(showAppBar: false),
                    CompletedScreen(showAppBar: false),
                    InProgressScreen(showAppBar: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class OrderTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Order Tab',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }





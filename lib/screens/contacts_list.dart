import 'package:contacts_watchlist/widgets/contact_list_view.dart';
import 'package:contacts_watchlist/widgets/second_group.dart';
import 'package:contacts_watchlist/widgets/third_group.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'Contacts List',
              style: TextStyle(color: Colors.black),
            ),
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), 
            unselectedLabelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
            indicatorColor: Colors.blue,
            labelColor: Colors.black,

            tabs: [
              Tab(

                text: 'Group 1',

              ),
              Tab(
                text: 'Group 2',
              ),
              Tab(
                text: 'Group 3',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
                height: double.infinity,
                padding: const EdgeInsets.only(top: 15.0),
                child: const ContactListView()),
            const SecondGroup(),
            const ThirdGroup(),
          ],
        ),
      ),
    );
  }
}

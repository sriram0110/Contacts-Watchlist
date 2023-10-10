import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_bloc.dart';

class ContactListView extends StatefulWidget   {
  const ContactListView({super.key});

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(children: [
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // BlocProvider.of<ContactBloc>(context).add(SortById());
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Id',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Icon(Icons.arrow_upward_rounded)
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // sortByName(true);
                BlocProvider.of<ContactBloc>(context).add(SortByName());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  BlocBuilder<ContactBloc, ContactState>(
                    buildWhen: (previous, current) => current is SortedByName  ,
                    builder: (context, state) {
                      if (state is SortedByName) {
                        return state.sortNameAscending
                            ? const Icon(Icons.arrow_upward_rounded)
                            : const Icon(Icons.arrow_downward_rounded);
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10.0,
      ),
      BlocBuilder<ContactBloc, ContactState>(
        // buildWhen: (context, state) =>
        //     state is ContactLoading ||
        //     state is ContactLoaded ||
        //     state is ContactError,
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          } else if (state is ContactLoaded) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.contacts[index].name),
                      subtitle: Text(state.contacts[index].contacts),
                      // leading: CircleAvatar(
                      //   // backgroundImage: NetworkImage(state.contacts[index].url),
                      // ),
                    ),
                  );
                },
              ),
            );
          } else if (state is ContactError) {
            return const Center(
              child: Text('Failed to load contacts'),
            );
          }
          return Container();
        },
      ),
    ]);
  }
  
  @override
  bool get wantKeepAlive => true;

  @override
  void updateKeepAlive() {
    super.updateKeepAlive();
  }
}

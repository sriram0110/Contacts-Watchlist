import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_bloc.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({super.key});

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(FetchContacts());
    BlocProvider.of<ContactBloc>(context).add(InitialIDSortingEvent());
    BlocProvider.of<ContactBloc>(context).add(InitialNameSortingEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(children: [
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<ContactBloc>(context).add(SortById());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ID',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 106, 107, 107),
                    ),
                  ),
                  BlocBuilder<ContactBloc, ContactState>(
                    buildWhen: (previous, current) => current is SortedById,
                    builder: (context, state) {
                      if (state is SortedById) {
                        return state.sortIdAscending
                            ? const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color.fromARGB(255, 114, 120, 127),
                              )
                            : const Icon(
                                Icons.keyboard_arrow_up_rounded,
                                color: Color.fromARGB(255, 114, 120, 127),
                              );
                      }
                      return Container();
                    },
                  ),
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
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 106, 107, 107),
                    ),
                  ),
                  BlocBuilder<ContactBloc, ContactState>(
                    buildWhen: (previous, current) => current is SortedByName,
                    builder: (context, state) {
                      if (state is SortedByName) {
                        return state.sortNameAscending
                            ? const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color.fromARGB(255, 114, 120, 127),
                              )
                            : const Icon(
                                Icons.keyboard_arrow_up_rounded,
                                color: Color.fromARGB(255, 114, 120, 127),
                              );
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
      BlocBuilder<ContactBloc, ContactState>(
        buildWhen: (context, state) =>
            state is ContactLoading ||
            state is ContactLoaded ||
            state is ContactError,
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (state is ContactLoaded) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: state.contacts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          state.contacts[index].name,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          state.contacts[index].contacts,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        // leading: CircleAvatar(
                        //   // backgroundImage: NetworkImage(state.contacts[index].url),
                        // ),
                      ),
                    );
                  },
                ),
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
}

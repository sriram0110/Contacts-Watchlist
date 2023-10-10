import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../utils/services/contact_service.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService contactService;
  bool isSortById = true; //current state
  bool isSortByName = true;
  List<Contact> _contacts = [];

  ContactBloc(this.contactService) : super(ContactInitial()) {

    on<InitialSortingEvent>((event, emit) {
      // emit(SortedById(isSortById));
      emit(SortedByName(isSortByName));

    });


    on<FetchContacts>(
      (event, emit) async {
      
        emit(ContactLoading());
        try {
           _contacts = await contactService.getContacts();
          emit(
            ContactLoaded(_contacts),
          );
        } catch (_) {
          emit(
            ContactError(),
          );
        }
      },
    );

    // on<SortById>((event, emit) {

      
    //   isSortById = false;
    //     final List<dynamic> contactsById = List.from(_contacts);
    //     // final String id = contactsById['id'] as ;
    //   contactsById.sort((a,b)
    //   {
    //     return isSortById ? b['id'].compareTo(a['id']) : a['id'].compareTo(b['id']);
    //   });
    //  emit(ContactLoaded(contactsById as List<Contact>));
    //  isSortById = !isSortById;
    //  emit(SortedById(isSortById));

       

    // });

    on<SortByName>((event, emit) {

     emit(SortedByName(!isSortByName));
     isSortByName = !isSortByName;
  
      final contactsSortedByName = List<Contact>.from(_contacts);
      contactsSortedByName.sort((a,b)
      {
        return isSortByName ? a.name.compareTo(b.name) : b.name.compareTo(a.name);
      });
     emit(ContactLoaded(contactsSortedByName));
     isSortByName = !isSortByName;

    });
  }
}

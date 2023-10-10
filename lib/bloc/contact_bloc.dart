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
      emit(SortedById(isSortById));
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

    on<SortById>((event, emit) {
      isSortById = !isSortById;

      emit(SortedById(isSortById));

      final  contactsSortedById = List<Contact>.from(_contacts);
      // final String id = contactsById['id'] as ;
      // contactsSortedById.map((contact) => int.parse(contact.id)).toList(growable: false).sort();
      // List<Contact> result = isSortById ? contactsSortedById : _contacts;
      contactsSortedById.sort((a, b) {
        int numberA = int.parse(a.id);
        int numberB = int.parse(b.id);
        return isSortById ? numberB.compareTo(numberA) : numberA.compareTo(numberB);
      });
      emit(ContactLoaded( contactsSortedById));
      // isSortById = !isSortById;
    });

    on<SortByName>((event, emit) {
      isSortByName = !isSortByName;

      emit(SortedByName(isSortByName));

      final contactsSortedByName = List<Contact>.from(_contacts);
      contactsSortedByName.sort((a, b) {
        return isSortByName
            ? b.name.compareTo(a.name)
            : a.name.compareTo(b.name);
      });
      emit(ContactLoaded(contactsSortedByName));
      // isSortByName = !isSortByName;
    });
  }
}

// import 'dart:convert';
// import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/contact.dart';
import '../utils/services/contact_service.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService contactService;
  bool isSortById = true; //current state
  bool isSortByName = true;
  List<Contact> _contacts = [];

     List<Contact> contactsSortedById(List<Contact> finalContacts )
      {
         finalContacts.sort((a, b) {
        int numberA = int.parse(a.id);
        int numberB = int.parse(b.id);
        return isSortById
            ? numberB.compareTo(numberA)
            : numberA.compareTo(numberB);
      });
      return finalContacts;
      }

      List<Contact> contactsSortedByName(List<Contact> resultContacts)
      {
          resultContacts.sort((a, b) {
        return isSortByName
            ? b.name.compareTo(a.name)
            : a.name.compareTo(b.name);
      });
      return resultContacts;
      }



  ContactBloc(this.contactService) : super(ContactInitial()) {
    on<InitialIDSortingEvent>((event, emit) {
      emit(SortedById(isSortById)); 
    });

    on<InitialNameSortingEvent>(
      (event, emit) {
        emit(SortedByName(isSortByName));
      },
    );

    on<FetchContacts>(
      (event, emit) async {
        emit(ContactLoading());
        try {
          // _contacts = await contactService.getContacts();
          final response = await contactService.getContacts(Client());
            final List<Contact> contacts = contactFromJson(response);
            _contacts = contacts;
          // final data = json.decode(response); //string to object
          // _contacts = data.map((json) => Contact.fromJson(json)).toList();  //json object to dart model

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
      isSortById = !isSortById; //true - false

      emit(SortedById(isSortById)); //false

      final finalContacts = List<Contact>.from(_contacts);

      List<Contact> sortedContactsById =  contactsSortedById(finalContacts);

      
     
      emit(ContactLoaded(sortedContactsById));
      // isSortById = !isSortById;
    });

   


    on<SortByName>((event, emit) {
      isSortByName = !isSortByName;

      emit(SortedByName(isSortByName));

      final resultContacts = List<Contact>.from(_contacts);
      List<Contact> sortedContactsByName =  contactsSortedByName(resultContacts);

      
      emit(ContactLoaded(sortedContactsByName));
      // isSortByName = !isSortByName;
    });
  }
}

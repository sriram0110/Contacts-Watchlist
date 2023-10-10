part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchContacts extends ContactEvent {}

class InitialSortingEvent extends ContactEvent {}

class SortById extends ContactEvent {}

class SortByName extends ContactEvent {}

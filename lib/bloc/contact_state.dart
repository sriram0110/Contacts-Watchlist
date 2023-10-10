part of 'contact_bloc.dart';

@immutable
class ContactState extends Equatable {
  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {} //indicates the bloc just created

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<Contact> contacts;

  ContactLoaded(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class ContactError extends ContactState {}

class SortedByName extends ContactState {
  final bool sortNameAscending;
 
  SortedByName(this.sortNameAscending);

  @override
  List<Object> get props => [sortNameAscending];
}

class SortedById extends ContactState {
  final bool sortIdAscending;

  SortedById(this.sortIdAscending);

  @override
  List<Object> get props => [sortIdAscending];
}

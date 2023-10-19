import 'package:contacts_watchlist/bloc/contact_bloc.dart';
import 'package:contacts_watchlist/models/contact.dart';
import 'package:contacts_watchlist/utils/services/contact_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockContactService extends Mock implements ContactService {}

void main() {
  group('ContactBloc Sorting Logic', () {
    late MockContactService mockContactService;
    late ContactBloc contactBloc;
    final unsortedContacts = [
      Contact('3', 'John Doe', '123', 'example.com'),
      Contact('1', 'Jane Doe', '456', 'example.com'),
      Contact('2', 'Alice Smith', '789', 'example.com'),
    ];

    setUpAll(() {
      mockContactService = MockContactService();
      contactBloc = ContactBloc(mockContactService);
    });
    test('Sorting by ID in ascending order', () {
      // Arrange

      //Act

      contactBloc.isSortById = false;
      final contactsIdAscending =
          contactBloc.contactsSortedById(unsortedContacts);

      // Assert

      final expectedSortedContacts = [
        Contact('1', 'Jane Doe', '456', 'example.com'),
        Contact('2', 'Alice Smith', '789', 'example.com'),
        Contact('3', 'John Doe', '123', 'example.com'),
      ];
      for (int i = 0; i < contactsIdAscending.length; i++) {
        expect(contactsIdAscending[i].id, expectedSortedContacts[i].id);
      }
    });

    test('Sorting by ID in descending order', () {
      //Act

      contactBloc.isSortById = true;
      final contactsIdDescending =
          contactBloc.contactsSortedById(unsortedContacts);

      // Assert

      final expectedSortedContacts = [
        Contact('3', 'John Doe', '123', 'example.com'),
        Contact('2', 'Alice Smith', '789', 'example.com'),
        Contact('1', 'Jane Doe', '456', 'example.com'),
      ];
      for (int i = 0; i < contactsIdDescending.length; i++) {
        expect(contactsIdDescending[i].id, expectedSortedContacts[i].id);
      }
    });

    test('sorting contacts by name in ascending order', () {
      contactBloc.isSortByName = false;
      final contactsNameAscending =
          contactBloc.contactsSortedByName(unsortedContacts);

      final expectedSortedContacts = [
        Contact('2', 'Alice Smith', '789', 'example.com'),
        Contact('1', 'Jane Doe', '456', 'example.com'),
        Contact('3', 'John Doe', '123', 'example.com'),
      ];
      for (int i = 0; i < contactsNameAscending.length; i++) {
        expect(contactsNameAscending[i].name, expectedSortedContacts[i].name);
      }
    });

    test('sorting contacts by name in descending order', () {
      contactBloc.isSortByName = true;
      final contactsNameDescending =
          contactBloc.contactsSortedByName(unsortedContacts);

      final expectedSortedContacts = [
        Contact('3', 'John Doe', '123', 'example.com'),
        Contact('1', 'Jane Doe', '456', 'example.com'),
        Contact('2', 'Alice Smith', '789', 'example.com'),
      ];
      for (int i = 0; i < contactsNameDescending.length; i++) {
        expect(contactsNameDescending[i].name, expectedSortedContacts[i].name);
      }
    });
  });
}

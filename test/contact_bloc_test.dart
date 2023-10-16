import 'package:contacts_watchlist/bloc/contact_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SortedByName Test', () {
    test('SortNameAscending is true', () {
      final sortedByName = SortedByName(true);

      expect(sortedByName.sortNameAscending, true);
    });

    test('SortNameAscending is false', () {
      final sortedByName = SortedByName(false);

      expect(sortedByName.sortNameAscending, false);
    });

    test('SortIdAscending is true', () {
      final sortedById = SortedById(true);

      expect(sortedById.sortIdAscending, true);
    });

    test('SortIdAscending is false', () {
      final sortedById = SortedById(false);

      expect(sortedById.sortIdAscending, false);
    });
  });
}

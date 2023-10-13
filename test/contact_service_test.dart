import 'package:contacts_watchlist/utils/services/contact_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'contact_service_test.mocks.dart';

// class MockClient extends Mock implements http.Client {}
@GenerateMocks([http.Client])
void main() {
  group('API Calls', () {
    late MockClient mockClient;
    late ContactService contactService;

    setUpAll(() {
      mockClient = MockClient();
      contactService = ContactService();
    });

    test('fetching getContacts() for successful response', () async {
      when(mockClient.get(Uri.parse(
              'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts')))
          .thenAnswer((_) async => Future.value(
              http.Response('[{"id": "1", "name": "name 1"}]', 200)));
      expect(await contactService.getContacts(mockClient),
          '[{"id": "1", "name": "name 1"}]');
    });

    test('throws an exception', () async {
      when(mockClient.get(Uri.parse(
              'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts')))
          .thenAnswer((_) async => (http.Response('Not Found', 404)));
      // expect( await contactService.getContacts(mockClient), throwsException);
      try {
        await contactService.getContacts(mockClient);
        fail('Exception not thrown'); 
      } catch (e) {
        expect(e, isException); 
      }
    });
  });
}
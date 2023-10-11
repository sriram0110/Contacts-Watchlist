import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/contact.dart';

class ContactService {
  Future<List<Contact>> getContacts() async {
    final response = await http.get(Uri.parse('http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body); 
      List<Contact> contacts = data.map((json) => Contact.fromJson(json)).toList();
      return contacts;
    } else {
      throw Exception('Failed to load contacts');
    }
  }
}

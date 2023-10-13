// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import '../../models/contact.dart';

 class ContactService {

  Future<dynamic> getContacts(http.Client client) async {
    try {
      final response = await client.get(Uri.parse(
          'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts'));

      if (response.statusCode == 200) {
        // log(response.statusCode);
        // var data = json.decode(response.body);
        // List<Contact> contacts = data.map((json) => Contact.fromJson(json)).toList();
        return Future.value(response.body); 
      } else {
        throw Exception('Failed to load contacts');
      }
    } catch (error) {
      // print('Error fetching contacts: $error');
      throw Exception(error);
      // return Future.value(null);
    }
  }
}

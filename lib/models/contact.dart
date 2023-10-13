import 'dart:convert';

List<Contact> contactFromJson(String str) =>
    List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
  final String id;
  final String name;
  final String contacts;
  final String url;

  Contact(this.id, this.name, this.contacts, this.url,);

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(json['id'], json['name'], json['Contacts'], json['url']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Contacts": contacts,
        "url": url,
      };
}

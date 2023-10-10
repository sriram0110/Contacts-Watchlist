class Contact {   
  final String id;
  final String name;
  final String contacts;
  final String url;

  Contact(this.id, this.name, this.contacts, this.url);

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(json['id'], json['name'], json['Contacts'], json['url']);
  }
  
}

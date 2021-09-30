import 'Card.dart';

class Customer {
  int? id;
  int? tc;
  String? mail;
  String? name;
  String? surname;
  int? age;
  Card? card;
  bool? active;

  Customer(
      { this.id,
        required this.tc,
        required this.mail,
        required this.name,
        required this.surname,
        required this.age,
        this.card,
        this.active});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tc = json['tc'];
    mail = json['mail'];
    name = json['name'];
    surname = json['surname'];
    age = json['age'];
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tc'] = this.tc;
    data['mail'] = this.mail;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['age'] = this.age;
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    data['active'] = this.active;
    return data;
  }
}
import 'package:client/model/Transaction.dart';

class Card {
  bool? active;
  int? balance;
  String? code;
  int? id;
  List<Transaction>? transactions;

  Card(
      { this.active,
        this.balance,
        required this.code,
        this.id,
        this.transactions});

  Card.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    balance = json['balance'];
    code = json['code'];
    id = json['id'];
    if (json['transactions'] != null) {
      transactions = <Transaction>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['balance'] = this.balance;
    data['code'] = this.code;
    data['id'] = this.id;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
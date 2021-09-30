import 'dart:ffi';

import 'package:client/constants.dart';
import 'package:client/model/Card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CardApi{

  Future<Card> fetchCard(String code) async{
    final response = await http
        .get(Uri.parse('$host/card/getCard/$code'));

    if (response.statusCode == 200) {
      return Card.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Card> createCard(String code, int customerId) async{

    final _response = await http.post(
        Uri.parse("$host/card/create"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, dynamic>{
          'code':'$code',
          'customerId':customerId
        }));

    if (_response.statusCode == 200){
      var responseJson = jsonDecode(_response.body);
      return Card.fromJson(responseJson);
    }
    else throw Exception("gelmedi");
  }

  Future<Card> updateCardBalance(String code, int balance) async {
    final _response = await http.put(
        Uri.parse("$host/card/uploadBalance"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'balance': balance,
        'code' : code
      })

    );

    if (_response.statusCode == 200){
      var responseJson = jsonDecode(_response.body);
      return Card.fromJson(responseJson);
    }
    else throw Exception("gelmedi");
  }

  Future<Card> getPayment(String code, int amount) async {
    final _response = await http.put(
      Uri.parse("$host/card/getPayment"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'amount' : amount,
        'code': "$code"
      }),
    );

    if (_response.statusCode == 200){
      var responseJson = jsonDecode(_response.body);
      return Card.fromJson(responseJson);
    }
    else throw Exception("gelmedi");
  }

}
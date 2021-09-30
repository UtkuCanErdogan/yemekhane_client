import 'dart:convert';
import 'package:client/constants.dart';
import 'package:http/http.dart' as http;
import 'package:client/model/Customer.dart';

class CustomerApi {

  Future<Customer> fetchCustomers(int id) async{
    final response = await http
        .get(Uri.parse('$host/customer/$id'));

    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Customer> getCustomerByMail(String mail) async{
    final response = await http
        .get(Uri.parse('$host/customer/mail/$mail'));

    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Customer>> fetchListCustomer() async{
    final response = await http.get(
          Uri.parse("$host/customer/getActiveCustomers"));

    if(response.statusCode == 200){
      var responseJson = jsonDecode(response.body);
      return (responseJson as List).map((c) => Customer.fromJson(c)).toList();
    }
    else {
      throw Exception('Gelmedi.');
    }
  }

  Future<Customer> createCustomer(int tc,String mail, String name, String surname,
      int age ) async{
    final _customer = new Customer(
        tc: tc,
        mail: mail,
        name: name,
        surname: surname,
        age: age);

    final response = await http.post(
        Uri.parse("$host/customer/create"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(_customer.toJson()));

    if (response.statusCode == 200){
      var responseJson = jsonDecode(response.body);
      return Customer.fromJson(responseJson);
    }
    else throw Exception("gelmedi");
  }

  Future<bool> updateCustomer(int tc,String mail, String name, String surname,
      int age, int id) async{
    final _customer = new Customer(
        tc: tc,
        mail: mail,
        name: name,
        surname: surname,
        age: age);

    final response = await http.post(
        Uri.parse("$host/customer/update"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(_customer.toJson()));

    if (response.statusCode == 200){
      return true;
    }
    else return false;
  }

  Future<void> deActiveCustomer(int id) async {
    await http.patch(
        Uri.parse("$host/customer/activateCustomer/$id"));
  }

  Future<void> toActivateCustomer(int id) async {
    await http.patch(
        Uri.parse("http://192.168.1.115:8080/customer/activateCustomer/$id"));
  }

  Future<Customer> getCustomerByCode(String code) async{
    final response = await http
        .get(Uri.parse('$host/customer/code/$code'));

    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Customer> changeCustomerCard(int id, String code ) async{

    final _response = await http.put(
      Uri.parse("$host/customer/updateCustomerCard"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'code':'$code',
        'id':id
      }),
    );

    if (_response.statusCode == 200){
      var responseJson = jsonDecode(_response.body);
      return Customer.fromJson(responseJson);
    }
    else throw Exception("gelmedi");
  }
}
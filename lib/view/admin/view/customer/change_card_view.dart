
import 'package:client/view/admin/view/card/view/create_card.dart';
import 'package:client/view/admin/view/customer/api/customer_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class ChangeCardView extends StatefulWidget {
  const ChangeCardView({
    Key? key,
    required this.id}) : super(key: key);

  final int id;

  @override
  _ChangeCardViewState createState() => _ChangeCardViewState();
}

class _ChangeCardViewState extends State<ChangeCardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _futureBuilder(context, widget.id),
      ),
    );
  }
}

FutureBuilder _futureBuilder(BuildContext context, int? customerId){
  return FutureBuilder<NFCTag>(
      future: FlutterNfcKit.poll(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return FutureBuilder<dynamic>(
              future: CustomerApi().changeCustomerCard(customerId!, snapshot.data!.id.toString()),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return getDialog(context);
                }
                else{
                  return CircularProgressIndicator();
                }
              });
        }
        else{
          return Center(child : Text("Kartınızı Okutunuz."));
        }
      });
}


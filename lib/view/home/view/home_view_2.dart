import 'package:client/model/Customer.dart';
import 'package:client/view/admin/view/card/api/card_api.dart';
import 'package:client/view/admin/view/customer/api/customer_api.dart';
import 'package:client/view/home/components/clock.dart';
import 'package:client/view/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

import '../../../constants.dart';

class HomeView2 extends StatefulWidget {
  const HomeView2({Key? key}) : super(key: key);

  @override
  _HomeView2State createState() => _HomeView2State();
}

class _HomeView2State extends State<HomeView2> {
  late Form _form;
  bool check = false;


  @override
  void initState() {
    super.initState();
  }

  Future<bool> future() async {
    NFCTag tag = await FlutterNfcKit.poll();
    getCustomer(tag.id);
    return true;
  }

  Future<void> getCustomer(String code) async{
    var customer = await CustomerApi().getCustomerByCode(code);
    setState(() {
      _form = _formBuilder(customer, customer.card!.code.toString());
      check = true;
    });
    Future.delayed(Duration(seconds: 7), (){
      setState(() {
       check = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Center(
        child: FutureBuilder(
          future: future(),
          builder: (context, snapshot){
            if(snapshot.hasData && check){
              return _form;
            }
            else{
              return _column();
            }
          },
        )),
    );
  }
}

AppBar _appbar(BuildContext context){
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text("YemekHane Sistemi"),
    backgroundColor: Colors.red,
    actions: <Widget>[
      IconButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)
          =>LoginView()));
        },
        icon: Icon(Icons.person), color: Colors.white,)
    ],
  );
}


Column _column(){
  return Column(
    children: [
      Expanded(child: Clock()),
      Expanded(child: Text("Kartınızı Okutunuz."),),
    ],
  );
}

Form _formBuilder(Customer customer, String code){
  return Form(
      child : SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.red,),
                hintText: customer.name.toString(),
              ),
              readOnly: true,
            ),
            sizedBox,
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.red,),
                hintText: customer.surname.toString(),
              ),
              readOnly: true,
            ),
            sizedBox,
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.red,),
                hintText: (customer.card!.balance! - amount).toString(),
              ),
              readOnly: true,
            ),
            sizedBox,
            FutureBuilder(
                future:CardApi().getPayment(code, amount),
                builder: (context,snap){
                  if(snap.hasData){
                    return Icon(Icons.check, color: Colors.green, size: 48,);
                  }
                  else if(snap.hasError){
                    return Icon(Icons.error, color: Colors.red, size: 24,);
                  }
                  else{
                    return CircularProgressIndicator();
                  }
                })
          ],
        ),
      )
  );
}

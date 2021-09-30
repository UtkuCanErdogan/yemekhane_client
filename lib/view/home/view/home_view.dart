import 'package:client/constants.dart';
import 'package:client/model/Customer.dart';
import 'package:client/view/admin/view/card/api/card_api.dart';
import 'package:client/view/admin/view/customer/api/customer_api.dart';
import 'package:client/view/home/components/clock.dart';
import 'package:client/view/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();

}

class _HomeViewState extends State<HomeView> {
  late Future<Customer> future;
  bool isFakeKart=false;
  static String name = "Utku Can";
  static String surname = "Erdoğan";
  static String balance = "30";
  Widget? child;
  String label = "Kartınızı Okutunuz.";

  refresh(AsyncSnapshot snapshot){
   setState(() {
     label = snapshot.data!.id + " " + DateTime.now().toString();
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Center(
        child: FutureBuilder<NFCTag>(
          future: FlutterNfcKit.poll(),
          builder: (context, snapshot){
            if(snapshot.hasData){
             return refresh(snapshot);
            }
            else{
              if(isFakeKart){
                return staticForm(name, surname, balance,(){
                  setState(() {
                    isFakeKart = false;
                  });
                });
              }
              else
                return Column(
                  children: [
                    ElevatedButton(onPressed: (){
                      setState(() {
                        isFakeKart=true;
                      });

                    }, child: Text("Fake")),
                    Expanded(child: Clock()),
                    Expanded(child: Text(label),),
                    ElevatedButton(
                        onPressed: (){
                          setState(() {
                            isFakeKart=true;
                          });
                        },
                        child: Text("Click"))

                  ],
                );
            }
          },
        ),
      ),
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

FutureBuilder _builder(BuildContext context, AsyncSnapshot snapshot,bool fakeKartMi){
  return FutureBuilder(
      future: fakeKartMi==false? CustomerApi().getCustomerByCode(snapshot.data!.id.toString()):CustomerApi().getCustomerByCode("123"),
      builder: (context, card){
        if(card.hasData){
          return FutureBuilder(
              future: Future.delayed(Duration(seconds: 3)),
              builder: (context, s) => s.connectionState == ConnectionState.done ?
              Text("123"): _form(card, snapshot.data!.id)
          );
        }
        else{
          return CircularProgressIndicator();
        }
      });
}


Form _form(AsyncSnapshot card, String code){
  return Form(
      child : SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled : true,
                icon: Icon(Icons.person, color: Colors.red,),
                hintText: card.data!.name.toString(),
              ),
              readOnly: true,
            ),
            sizedBox,
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled : true,
                icon: Icon(Icons.person, color: Colors.red,),
                hintText: card.data!.surname.toString(),
              ),
              readOnly: true,
            ),
            sizedBox,
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled : true,
                icon: Icon(Icons.person, color: Colors.red,),
                hintText: (card.data!.card!.balance - amount).toString(),
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

reload(BuildContext context, void refresh) async{
  Future.delayed(Duration.zero, () => refresh);
}

Form staticForm(String name, String surname, String balance, VoidCallback press){
  return Form(
      child : SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled : true,
                icon: Icon(Icons.person, color: Colors.red,),
                hintText: name,
              ),
              readOnly: true,
            ),
            sizedBox,
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled : true,
                icon: Icon(Icons.person, color: Colors.red,),
                hintText: surname,
              ),
              readOnly: true,
            ),
            sizedBox,
            ElevatedButton(
                onPressed:press,
                child: Text("Bas")),
            sizedBox,
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled : true,
                icon: Icon(Icons.person, color: Colors.red,),
                hintText: balance,
              ),
              readOnly: true,
            ),
            sizedBox,
            Icon(Icons.check, color: Colors.green, size: 48,)
          ],
        ),
      )
  );
}



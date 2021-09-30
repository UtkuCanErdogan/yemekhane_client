import 'package:client/view/admin/view/card/view/card_view.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter/material.dart';


class CardOperationsView extends StatelessWidget {
  const CardOperationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context, "Kart İşlemleri"),
        body: Container(
          child: Center(
            child: _futureBuilder(context),
          ),
        )
    );
  }
}

AppBar appbar(BuildContext context, String text){
  return AppBar(
    title: Text(text),
    backgroundColor: Colors.red,
  );
}

FutureBuilder _futureBuilder(BuildContext context){
  return FutureBuilder(
      future: _future(context),
      builder: (context, snapshot){
        bool check = false;
        if(snapshot.hasData && check ) {
          return SizedBox();
        }
        else{
          return Center(child: Text("Kartı Okutunuz."),);
        }
      });
}

navigate(BuildContext context, String id) async{
  Future.delayed(Duration.zero, () => Navigator.push(context, MaterialPageRoute(
      builder: (context) => CardView(code: id,)
  ))
  );

}

Future<bool> _future(BuildContext context) async {
  NFCTag tag = await FlutterNfcKit.poll();
  Future.delayed(Duration.zero, () => Navigator.push(context, MaterialPageRoute(
      builder: (context) => CardView(code: tag.id,)
  ))
  );
  return true;
}

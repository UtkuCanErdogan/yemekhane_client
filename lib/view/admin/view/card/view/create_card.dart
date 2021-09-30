import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client/view/admin/view/admin_view.dart';
import 'package:client/view/admin/view/card/api/card_api.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class CreateCardView extends StatefulWidget {
  const CreateCardView({
    Key? key,
    required this.id,}) : super(key: key);

  final int id;

  @override
  _CreateCardViewState createState() => _CreateCardViewState();
}

class _CreateCardViewState extends State<CreateCardView> {
  Future<Card>? _future;
  int? id;


  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Kart Oluştur"),
        body: Container(
          child: _futureBuilder(context, _future, id),
          ),
        );
  }
}

FutureBuilder _futureBuilder(BuildContext context, Future<Card>? future, int? customerId){
  return FutureBuilder<NFCTag>(
      future: FlutterNfcKit.poll(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return FutureBuilder<dynamic>(
              future: CardApi().createCard(snapshot.data!.id, customerId!),
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

createDialog(BuildContext context) async{
  await Future.delayed(Duration(microseconds: 1));
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Kullanıcı Oluşturuldu"),
          content: Text("şkgşdfg"),
          actions: [
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Tamam"))
          ],
        );
  });
}

getDialog(BuildContext context){
  Future.delayed(Duration.zero, () => AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    borderSide: BorderSide(color: Colors.green, width: 2),
    width: 280,
    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Başarılı',
    desc: 'Kullanıcı Oluşturma İşlemi Başarılı',
    showCloseIcon: true,
    btnOkOnPress: () {
      Navigator.pop(context);
    },
  )..show());
}

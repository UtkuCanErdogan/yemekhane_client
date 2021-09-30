import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client/view/admin/view/card/api/card_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';


class UpdateCardBalanceView extends StatefulWidget {
  const UpdateCardBalanceView({
    Key? key,
    required this.code}) : super(key: key);

    final String code;

  @override
  _UpdateCardBalanceViewState createState() => _UpdateCardBalanceViewState();
}

class _UpdateCardBalanceViewState extends State<UpdateCardBalanceView> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:uploadAppbar(context),
      body: Container(
        child: Center(
          child: Center(
            child: _columnBuilder(context,controller, widget.code),
          ),
        ),
      ),
    );
  }
}

AppBar uploadAppbar(BuildContext context){
  return AppBar(
    title: Text("Bakiye Yükle"),
    backgroundColor: Colors.red,
  );
}

Column _columnBuilder(BuildContext context, TextEditingController controller, String code){
          return Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: InputDecoration(
                  filled : true,
                  icon: Icon(Icons.credit_card, color: Colors.red,),
                  hintText: "Miktar Giriniz*"
                ),
                readOnly: false,
              ),
              ElevatedButton(onPressed: (){
                FutureBuilder(
                  future: CardApi().updateCardBalance(code,
                      int.parse(controller.text)),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return getDialog(context);
                    }
                    else{
                      return CircularProgressIndicator();
                    }
                  },
                );
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.SUCCES,
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  width: 280,
                  buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                  headerAnimationLoop: false,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Başarılı',
                  desc: 'Bakiye Güncelleme İşlemi Başarılı',
                  showCloseIcon: true,
                  btnOkOnPress: () {
                    Navigator.pop(context, controller.text);
                  },
                )..show();
              }, child: Text("Yükle"),
              style:  ElevatedButton.styleFrom(
              primary: Colors.red,)
              )
            ],
          );
        }
getDialog(BuildContext context) async{
  await Future.delayed(const Duration(milliseconds: 50));
}
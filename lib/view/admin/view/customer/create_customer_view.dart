import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client/model/Customer.dart';
import 'package:client/view/admin/view/customer/api/customer_api.dart';
import 'package:flutter/material.dart';

class CreateCustomerView extends StatefulWidget {
  const CreateCustomerView({Key? key}) : super(key: key);

  @override
  _CreateCustomerViewState createState() => _CreateCustomerViewState();
}

class _CreateCustomerViewState extends State<CreateCustomerView> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _tcController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child:Form(
              key: _formKey,
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buildColumn(context, _tcController, _mailController,
                      _nameController, _surnameController, _ageController, height, width,
                          (){
                        setState(() {
                          CustomerApi().createCustomer(
                              int.parse(_tcController.text),
                              _mailController.text,
                              _nameController.text,
                              _surnameController.text,
                              int.parse(_ageController.text));
                          AwesomeDialog(
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
                            btnOkOnPress: () async {
                              Customer customer = await CustomerApi().getCustomerByMail(_mailController.text);
                              Navigator.pop(context, customer);
                            },
                          )..show();

                        });
                      }),
              ),
                ),
              ),)
        );
  }
}

AppBar _appBar(BuildContext context){
  return AppBar(
    title: Text("Kullanıcı Oluştur"),
    backgroundColor: Colors.red,
  );
}

Column buildColumn(BuildContext context,TextEditingController tcContoller, TextEditingController mailController,
TextEditingController nameController, TextEditingController surnameController, TextEditingController ageController,
    double height, double width, VoidCallback press){
  const sizedBox = SizedBox(height: 24,);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      sizedBox,
      Image.asset("assets/images/gsb_image.jpg",height: height * 0.15,),
      sizedBox,
      TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: tcContoller,
        decoration: InputDecoration(
          icon: Icon(Icons.person,color: Colors.red,),
          hintText: "TC*",
        ),
      ),
      sizedBox,
      TextFormField(
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        controller: mailController,
        decoration: InputDecoration(
          icon: Icon(Icons.mail,color: Colors.red),
          hintText: "E-Posta*",
        ),
      ),
      sizedBox,
      TextFormField(
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        controller: nameController,
        decoration: InputDecoration(
          icon: Icon(Icons.person,color: Colors.red),
          hintText: "İsim*",
        ),
      ),
      sizedBox,
      TextFormField(
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        controller: surnameController,
        decoration: InputDecoration(
          icon: Icon(Icons.person,color: Colors.red),
          hintText: "Soyisim*",
           ),
      ),
      sizedBox,
      TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: ageController,
        decoration: InputDecoration(
          icon: Icon(Icons.person,color: Colors.red),
          hintText: "Yaş*",
        ),
      ),
      sizedBox,
      Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,),
            onPressed: press,
            child: Text("Kaydet")),
      ),
    ],
  );
}



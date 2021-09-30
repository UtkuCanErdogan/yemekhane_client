import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client/constants.dart';
import 'package:client/model/Customer.dart';
import 'package:client/view/admin/view/admin_view.dart';
import 'package:client/view/admin/view/customer/api/customer_api.dart';
import 'package:client/view/admin/view/customer/create_customer_view.dart';
import 'package:flutter/material.dart';

class CustomerUpdateView extends StatefulWidget {
  const CustomerUpdateView({
    Key? key,
    required this.id,
    required this.tc,
    required this.age,
    required this.name,
    required this.surname,
    required this.mail,
    required this.active
}) : super(key: key);

  final int id;
  final int tc;
  final int age;
  final String name;
  final String surname;
  final String mail;
  final bool active;

  @override
  _CustomerUpdateViewState createState() => _CustomerUpdateViewState();
}

class _CustomerUpdateViewState extends State<CustomerUpdateView> {

  @override
  void initState() {
    super.initState();
    getCustomer = CustomerApi().fetchCustomers(widget.id);
    _tcController = TextEditingController(text: widget.tc.toString());
    _nameController = TextEditingController(text: widget.name);
    _surnameController = TextEditingController(text: widget.surname);
    _ageController = TextEditingController(text: widget.age.toString());
    _mailController = TextEditingController(text: widget.mail);

  }

  late Future<Customer> getCustomer;
  late Future<bool> updateCustomer;
  late String name;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  late final TextEditingController _tcController;
  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _ageController;
  late final TextEditingController _mailController;
  bool isChecked = true;




  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30),
          child: FutureBuilder<Customer>(
            future: getCustomer,
            builder: (context, snapshot){
              return Form(
                  key: _formKey,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: buildColumn(context, width, height, snapshot, () {
                        setState(() {
                          updateCustomer = CustomerApi().updateCustomer(
                              int.parse(_tcController.text),
                              _mailController.text,
                              _nameController.text,
                              _surnameController.text,
                              int.parse(_ageController.text),
                              int.parse(snapshot.data!.id.toString()));

                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            borderSide: BorderSide(color: Colors.green, width: 2),
                            width: 280,
                            buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                            headerAnimationLoop: false,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Başarılı',
                            desc: 'Kullanıcı Güncelleme İşlemi Başarılı',
                            showCloseIcon: true,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          )..show();
                        });
                        isChecked = snapshot.data!.active!;
                      },
                          _tcController,_mailController,_nameController, _surnameController,
                          _ageController, isChecked),
                    ),
                  )
              );
            },
          )
        ),
      );
  }
}

Column buildColumn(BuildContext context, double width, double height,
    AsyncSnapshot snapshot, VoidCallback press, tcController, mailController, nameController,
    surnameController, ageController, bool isChecked){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(height:30),
      Image.asset("assets/images/gsb_image.jpg",height: height * 0.1,),
      sizedBox,
      TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: tcController,
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Colors.red,),
          hintText: snapshot.data!.tc.toString(),
          labelText: "TC"
        ),
      ),
      sizedBox,
      TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        controller: mailController,
        decoration: InputDecoration(
          icon: Icon(Icons.mail, color: Colors.red),
          hintText: snapshot.data!.mail.toString(),
          labelText: "E-Posta"
        ),
      ),
      sizedBox,
      TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        controller: nameController,
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Colors.red),
          hintText: snapshot.data!.name.toString(),
          labelText: "İsim"
        ),
      ),
      sizedBox,
      TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        controller: surnameController,
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Colors.red),
          hintText: snapshot.data!.surname.toString(),
          labelText: "Soyisim"
        ),
      ),
      sizedBox,
      TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: ageController,
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Colors.red),
          hintText: snapshot.data!.age.toString(),
          labelText: "Yaş"
        ),
      ),
      sizedBox,
      Row(
        children: [
          AutoSizeText("Aktiflik :", style: TextStyle(fontSize: 16),),
          Checkbox(
              activeColor: Colors.white,
              checkColor: Colors.green,
              value: isChecked,
              onChanged: (value) async => isChecked = value!),
        ],
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


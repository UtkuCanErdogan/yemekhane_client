import 'package:client/view/admin/view/card/view/card_operations_view.dart';
import 'package:client/view/admin/view/customer/customer_operations_view.dart';
import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "İşlemler"),
      body: ListView(
        children:  <Widget>[
              propertyCard(context, "Kullanıcı İşlemleri", (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> CustomerOperationsView()));
              }),
           propertyCard(context, "Kart İşlemleri", (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> CardOperationsView()));
            },
          )
        ],
      ),
    );
  }
}

Card propertyCard(BuildContext context, String text, VoidCallback onPress){
  return Card(
    child: ListTile(
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_outlined),
      onTap: onPress,
    ),
  );
}

AppBar appBar(BuildContext context, String text){
  return AppBar(
    title: Text(text),
    backgroundColor: Colors.red,
  );
}

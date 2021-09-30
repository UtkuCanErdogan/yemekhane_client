import 'package:auto_size_text/auto_size_text.dart';
import 'package:client/constants.dart';
import 'package:client/model/Customer.dart';
import 'package:client/model/Transaction.dart';
import 'package:client/view/admin/view/admin_view.dart';
import 'package:client/view/admin/view/card/view/create_card.dart';
import 'package:client/view/admin/view/customer/api/customer_api.dart';
import 'package:client/view/admin/view/customer/change_card_view.dart';
import 'package:client/view/admin/view/customer/update_customer_view.dart';
import 'package:flutter/material.dart';

class CustomerView extends StatefulWidget {

  const CustomerView({
    Key? key,
    required this.id}
    ) : super(key: key);

  final int id;

  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {

  late final Future<Customer> futureCustomer;
  final _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontSize: 20);

  @override
  void initState() {
    super.initState();
    futureCustomer = CustomerApi().fetchCustomers(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Kullanıcı"),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: FutureBuilder<Customer>(
          future: futureCustomer,
          builder: (context, snapshot){
            if (snapshot.hasData){
              return Scrollbar(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        buildColumn(context, snapshot),
                        sizedBox,
                        snapshot.data!.card?.transactions != null ?
                        _table(context, snapshot.data!.card!.transactions!.toList())
                            : SizedBox()
                      ],
                    ),
                  ));
            }
            else return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}

DataTable _table (BuildContext context, List<Transaction> transactions){
  return DataTable(
      columns: [
        DataColumn(
            label: Text("İşlem",style: TextStyle(fontStyle: FontStyle.italic))
        ),
        DataColumn(
            label: Text("Tarih",style: TextStyle(fontStyle: FontStyle.italic))
        ),
      ],
      rows: transactions.map((t) =>
          DataRow(cells: [
            DataCell(
              Text(t.type.toString())
            ),
            DataCell(
              Text(t.creationDate.toString())
            )
          ]
          )
      ).toList());
}

Column buildColumn(BuildContext context, AsyncSnapshot snapshot){
  return Column(
    children: [
      TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled : true,
          icon: Icon(Icons.person, color: Colors.red,),
          hintText: snapshot.data!.tc.toString(),
          labelText: "TC"
        ),
        readOnly: true,
      ),
      sizedBox,
      TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled : true,
          icon: Icon(Icons.mail, color: Colors.red),
          hintText: snapshot.data!.mail.toString(),
        ),
        readOnly: true,
      ),
      sizedBox,
      TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled : true,
          icon: Icon(Icons.person, color: Colors.red),
          hintText: snapshot.data!.name.toString(),
        ),
        readOnly: true,
      ),
      sizedBox,
      TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled : true,
          icon: Icon(Icons.person, color: Colors.red),
          hintText: snapshot.data!.surname.toString(),
        ),
        readOnly: true,
      ),
      sizedBox,
      TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled : true,
          icon: Icon(Icons.person, color: Colors.red),
          hintText: snapshot.data!.age.toString(),
        ),
        readOnly: true,
      ),
      sizedBox,
      Row(
        children: [
          AutoSizeText("Aktiflik :", style: TextStyle(fontSize: 16),),
          Checkbox(
              activeColor: Colors.white,
              checkColor: Colors.green,
              value: snapshot.data!.active,
              onChanged: null),
        ],
      ),
      sizedBox,
      snapshot.data!.card == null || !snapshot.data!.card.active ? SizedBox() :
      TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled : true,
          icon: Icon(Icons.credit_card, color: Colors.red),
          hintText: snapshot.data!.card!.code.toString(),
        ),
        readOnly: true,
      ),
      sizedBox,
      Center(
        child: snapshot.data.card != null /*|| snapshot.data.card.active*/ ? TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
               ChangeCardView(id: snapshot.data!.id.toInt(),)));
            },
            child: Text("Kart Değiştir", style: TextStyle(color: Colors.red),)
        ) : SizedBox(),
      ),
      sizedBox,
      Center(child: snapshot.data!.card != null ? SizedBox()
          :TextButton(
          onPressed:(){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => CreateCardView(
                  id:snapshot.data.id.toInt(),)
            ));
          },
          child : Text("Kart Ekle", style: TextStyle(color: Colors.red),))
      ),
      sizedBox,
      Center(
        child: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
            CustomerUpdateView(
                id: snapshot.data!.id.toInt(),
                tc: snapshot.data!.tc.toInt(),
                age: snapshot.data.age.toInt(),
                name: snapshot.data.name,
                surname: snapshot.data.surname,
                mail: snapshot.data.mail,
                active: snapshot.data.active,)));
          },
          icon: Icon(Icons.edit, color: Colors.red,),
        ),
      )
    ],
  );
}


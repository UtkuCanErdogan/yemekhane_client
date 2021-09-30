import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:client/model/Customer.dart';
import 'package:client/view/admin/view/customer/api/customer_api.dart';
import 'package:client/view/admin/view/customer/customer_view.dart';
import 'package:flutter/material.dart';

import 'create_customer_view.dart';

class CustomerOperationsView extends StatefulWidget {
  const CustomerOperationsView({Key? key}) : super(key: key);

  @override
  _CustomerOperationsViewState createState() => _CustomerOperationsViewState();
}

class _CustomerOperationsViewState extends State<CustomerOperationsView> {
  late Future<List<Customer>> futureCustomer;
  List<Customer>? customers;


  @override
  void initState() {
    super.initState();
    futureCustomer = CustomerApi().fetchListCustomer();
  }


  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        backgroundColor: Colors.red,
        onPressed: ()   {
          Navigator.of(context).push( new MaterialPageRoute(
              builder: (context) => CreateCustomerView()), )
             .then((value)async{
               var list = await CustomerApi().fetchListCustomer();
               setState((){
                 customers!.add(value);
               });
         });
        },
      ),
      appBar: appbar(context),
      body: Container(
          child: FutureBuilder<List<Customer>>(
            future: futureCustomer,
            builder: (context, snapshot){
              if(snapshot.hasData){
                customers = snapshot.data!;
                customers!.sort((a, b) => a.name!.compareTo(b.name!));
                return ListView.builder(
                        itemCount: customers!.length,
                        itemBuilder: (context, index){
                          return Container(
                              child: Card(
                                child: buildInkwell(context, index, customers, size
                                ),
                              )
                          );
                        });
              }
              else return Center(child: CircularProgressIndicator(),);
            },
          )
      ),
    );
  }
}

AppBar appbar(BuildContext context){
  return AppBar(
    title: Text("Kullanıcı İşlemleri"),
    backgroundColor: Colors.red,
    actions: <Widget>[
      IconButton(onPressed: (){}, icon: Icon(Icons.search))
    ],
  );
}

InkWell buildInkwell(BuildContext context, int index, List<Customer>? list, double size){
  return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              CustomerView(id: list!.elementAt(index).id!.toInt()))),
      child: Container(
        height: size*0.08,
        child:  Row(
          children: [
            Expanded(
                child: Text(list!.elementAt(index).tc.toString())
            ),
            Expanded(
                child: Text(
                    list.elementAt(index).name.toString() + " "
                    + list.elementAt(index).surname.toString())
            ),
            Expanded(
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                    CustomerApi().deActiveCustomer(list.elementAt(index).id!);
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      width: 280,
                      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                      headerAnimationLoop: false,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Başarılı',
                      desc: 'Kullanıcı Silme İşlemi Başarılı',
                      showCloseIcon: true,
                      btnOkOnPress: () {
                      },
                    )..show();
                  },
                ))
          ],
        ),
      )
  );
}
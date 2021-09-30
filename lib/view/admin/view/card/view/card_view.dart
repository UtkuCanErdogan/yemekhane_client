
import 'package:client/constants.dart';
import 'package:client/model/Customer.dart';
import 'package:client/view/admin/view/card/view/update_card_balance.dart';
import 'package:client/view/admin/view/customer/api/customer_api.dart';
import 'package:flutter/material.dart';

class CardView extends StatefulWidget {
  const CardView({
    Key? key,
    required this.code}) : super(key: key);

  final String code;

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  Future<Customer>? _futureCustomer;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  int? balance;

  @override
  void initState() {
    super.initState();
    _futureCustomer = CustomerApi().getCustomerByCode(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        backgroundColor: Colors.red,
        onPressed: () {
           Navigator.of(context).push( new MaterialPageRoute(
              builder: (context) => UpdateCardBalanceView(code: widget.code)), )
              .then((value){
            setState(() {
              value = int.parse(value);
              balance = (balance! + value) as int?;
            });
          });
        },
      ),
      appBar: cardAppBar(context),
      body: Container(
        child: FutureBuilder<Customer>(
            future : _futureCustomer,
            builder: (context, snapshot){
              if(snapshot.hasData){
                balance = snapshot.data!.card!.balance;
                return Container(
                  child: Form(
                    key: _formKey,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            sizedBox,
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                filled : true,
                                icon: Icon(Icons.person, color: Colors.red,),
                                hintText: snapshot.data!.name.toString(),
                              ),
                              readOnly: true,
                            ),
                            sizedBox,
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                filled : true,
                                icon: Icon(Icons.person, color: Colors.red,),
                                hintText: snapshot.data!.surname.toString(),
                              ),
                              readOnly: true,
                            ),
                            sizedBox,
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled : true,
                                icon: Icon(Icons.monetization_on, color: Colors.red),
                                hintText:balance.toString(),
                              ),
                              readOnly: true,
                            ),
                            sizedBox,
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled : true,
                                icon: Icon(Icons.credit_card, color: Colors.red,),
                                hintText: snapshot.data!.card!.code.toString(),
                              ),
                              readOnly: true,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                );
              }
              else{
                return CircularProgressIndicator();
              }
            })
      ),
    );
  }
}


AppBar cardAppBar(BuildContext context){
  return AppBar(
    title: Text("Kart İşlemleri"),
    backgroundColor: Colors.red,
    actions: <Widget>[
      IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
    ],
  );
}



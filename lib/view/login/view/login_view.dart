import 'package:client/view/admin/view/admin_view.dart';
import 'package:client/view/login/viewmodel/login_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return BlocProvider(create: (context) => LoginCubit(
        _formKey,
        _passwordController,
        _emailController),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
        },
        builder: (context, state){
          return buildScaffold(
              context,
              state,
              _formKey,
              _emailController,
              _passwordController,
              _width,
              _height);
        },
      ),
    );
  }
}

Scaffold buildScaffold(BuildContext context, LoginState state, key,
    email, password, width, height){
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child:Form(
      autovalidateMode: state is LoginValidateState ?
      (state.isValidate ? AutovalidateMode.always : AutovalidateMode.disabled )
          : AutovalidateMode.disabled,
      key: key,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/gsb_image.jpg"),
            SizedBox(height: MediaQuery.of(context).size.height*0.06,),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.red),
              ),
              validator: (value) => value!.endsWith("@gsb.gov.tr") ? null :
              "Doğru bir mail adresi değil!",
              controller: email,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Şifre",
                labelStyle: TextStyle(color: Colors.red),
              ),
              validator: (value) => value!.length < 8 ? null
                  : "Şifre En Az 8 harfli olmalı",
              controller: password,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,minimumSize: Size(width*0.5, height*0.07)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AdminView()));
                  //context.read<LoginCubit>().postUserModel();
                },
                child: Text("Giriş Yap"))
          ],
        ),
      )
    ),)
  );
}

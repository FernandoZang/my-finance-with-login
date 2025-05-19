
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_finances/main.dart';
import 'package:my_finances/widget/form_text_form_field.dart';

class Auth extends StatefulWidget {

  const Auth({super.key});

  @override
  _AuthState createState() => _AuthState();

}


class _AuthState extends State {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
   var _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _doLogin() async {
    final user = await GoogleSignIn().signIn();

    GoogleSignInAuthentication userAuth = await user!.authentication;

    var credential = await GoogleAuthProvider.credential(idToken: userAuth.idToken, accessToken: userAuth.accessToken);

    FirebaseAuth.instance.signInWithCredential(credential)
      .then(
        (it) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'Minhas Finanças'))) 
    );
  }

    void _doLoginWithGoogle() async {
    final user = await GoogleSignIn().signIn();

    GoogleSignInAuthentication userAuth = await user!.authentication;

    var credential = await GoogleAuthProvider.credential(idToken: userAuth.idToken, accessToken: userAuth.accessToken);

    FirebaseAuth.instance.signInWithCredential(credential)
      .then(
        (it) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'Minhas Finanças'))) 
    );

  }

  
  @override
  Widget build(BuildContext context) {
   

    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color.fromARGB(255, 206, 55, 198),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  FormTextFormField(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'Informe E-mail',
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 10),

                  FormTextFormField(
                    controller: _passwordController,
                    label: 'Senha',
                    hintText: 'Informe a Senha',
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    keyboardType: TextInputType.text,            
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(onPressed: _doLogin, child: Text('Login')),

                  SizedBox(height: 20),

                  ElevatedButton(onPressed: _doLoginWithGoogle, child: Text('Login com Google')),

                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: _doLogin, child: Text('Cadastrar')),
                      ElevatedButton(onPressed: _doLogin, child: Text('Esqueci minha senha'))
                    ],
                  )
                ],
              )
            )
          ]
        )
      )
    );
          
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}
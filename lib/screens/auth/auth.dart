
import 'package:flutter/material.dart';
import 'package:my_finances/widget/login_text_form_field.dart';

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

  bool _doLogin() {
    setState(() {
      //
    });
    return true;
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

                LoginTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'Informe E-mail',
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 10),

                LoginTextFormField(
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
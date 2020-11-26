import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // Torna senha visível
  bool _isObscure = true;
  void _swichObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: _isObscure
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: _swichObscure,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    child: Text('ENTRAR'),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text('Criar um nova conta?'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

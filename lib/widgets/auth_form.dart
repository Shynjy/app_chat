import 'package:flutter/material.dart';

// tipos
import '../models/auth_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

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

  final AuthData _authData = new AuthData();

  // Chave da válidação do formulário
  final GlobalKey<FormState> _formKey = GlobalKey();

  _submit() {
    bool isValid = _formKey.currentState.validate();
    // Fecha o teclado
    FocusScope.of(context).unfocus();

    if (isValid) {
      widget.onSubmit(_authData);
    }
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
              key: _formKey, //vinculação da chave de válidação.
              child: Column(
                children: <Widget>[
                  if (_authData.isSignup)
                    TextFormField(
                      key: ValueKey('name'),
                      // Faz permanecer o nome já adicionado.
                      initialValue: _authData.name,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return 'Nome deve ter no mínimo 4 caracteres.';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Forneça um e-mail válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: _isObscure
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: _swichObscure,
                      ),
                    ),
                    obscureText: _isObscure,
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Senha deve ter no mínimo 7 caracteres.';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => _submit
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    child: Text(_authData.islogin ? 'ENTRAR' : 'CADASTRAR'),
                    onPressed: _submit,
                  ),
                  FlatButton(
                    child: Text(_authData.islogin
                        ? 'Criar um nova conta?'
                        : 'Já possui uma conta?'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
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

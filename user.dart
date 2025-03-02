// Define a classe User, que representa um usuário no sistema.
import 'package:flutter/material.dart';

class User {
  // Atributo que armazena o nome do usuário.
  String name;
  // Atributo que armazena o e-mail do usuário.
  String email;
  // Atributo que armazena a senha do usuário.
  String login;

  String perfil;

  String empresa;

  String sistema;

  String expira;

  // Construtor da classe User, exigindo que todos os atributos sejam obrigatórios.
  User({
    required this.name,   // Define o nome do usuário.
    required this.email,  // Define o e-mail do usuário.
    required this.login, // Define a senha do usuário.
    required this.perfil,
    required this.empresa,
    required this.sistema,
    required this.expira,
  });

  //String? get login => null;
}

//Esse código define um modelo de usuário com nome, e-mail e senha, que pode ser utilizado em toda a aplicação. 🚀
// Importa o arquivo 'user_form.dart', que provavelmente contém a tela de criação/edição de usuários.
import 'package:crud_teste1/user_form.dart';
// Importa o arquivo 'user_list.dart', que deve conter a tela com a lista de usuários.
import 'package:crud_teste1/user_list.dart';
// Importa o arquivo 'user_provider.dart', que provavelmente gerencia o estado dos usuários.
import 'package:crud_teste1/user_provider.dart';
// Importa o arquivo 'user_view.dart', que deve conter a tela de visualização de um usuário específico.
import 'package:crud_teste1/user_view.dart';
// Importa o pacote Flutter Material, que fornece widgets e temas para a aplicação.
import 'package:flutter/material.dart';

// Função principal que inicia a aplicação Flutter.
void main() {
  runApp(const MyApp()); // Executa o aplicativo chamando a classe MyApp.
}

// Declaração da classe MyApp, que representa o widget raiz da aplicação.
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Construtor da classe, utilizando um key opcional.

  @override
  Widget build(BuildContext context) {
    return UserProvider( // Envolve o aplicativo com UserProvider, garantindo o gerenciamento do estado dos usuários.
      child: MaterialApp( // Define a estrutura principal do aplicativo usando MaterialApp.
        title: 'CRUD TESTE 1', // Define o título do aplicativo.
        home: UserForm(), // Define a tela inicial como UserForm (provavelmente a tela de criação de usuários).
        routes: { // Define as rotas nomeadas da aplicação.
          "/create": (_) => UserForm(), // Rota para a criação de usuários.
          "/list": (_) => UserList(), // Rota para exibir a lista de usuários.
          "/view": (_) => UserView(), // Rota para visualizar detalhes de um usuário.
        },
      ),
    );
  }
}
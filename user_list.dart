// Importa o arquivo 'container_all.dart', que contém um layout reutilizável para a interface.
//import 'package:crud_teste1/container_all.dart';
// Importa o arquivo 'user.dart', que define a classe User.
import 'package:crud_teste1/user.dart';
// Importa o arquivo 'user_provider.dart', que gerencia o estado da lista de usuários.
import 'package:crud_teste1/user_provider.dart';
// Importa os pacotes necessários do Flutter para a construção da interface.
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';

// Define a classe UserList como um StatelessWidget, pois seu estado não muda após a construção.
class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém a instância do UserProvider para acessar a lista de usuários.
    UserProvider userProvider = UserProvider.of(context) as UserProvider; 

    // Obtém a lista de usuários do UserProvider.
    List<User> users = userProvider.users;

    // Obtém o número total de usuários na lista.
    int usersLength = users.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de usuários'),
        backgroundColor: const Color.fromARGB(255, 27, 27, 27), // Define a cor de fundo do AppBar.
        foregroundColor: Colors.white,
        leading: BackButton( // Adiciona um botão de voltar.
          onPressed: () {
            userProvider.indexUser = null; // Reseta o índice do usuário selecionado.
            Navigator.popAndPushNamed(context, "/create"); // Redireciona para a tela de criação de usuário.
          },
        ),
      ),
      body: Center( // Usa o layout reutilizável definido no ContainerAll.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: usersLength, // Define o número de itens na lista.
                itemBuilder: (BuildContext contextBuilder, indexBuilder) => 
                  Container(
                    child: ListTile(
                      title: Text(users[indexBuilder].name), // Exibe o nome do usuário na lista.
                      trailing: Row( // Adiciona os ícones de ações ao lado do nome.
                        mainAxisSize: MainAxisSize.min, // Garante que os ícones ocupem apenas o espaço necessário.
                        children: [
                          // Botão para editar o usuário.
                          IconButton(
                            onPressed: () {
                              userProvider.userSelected = users[indexBuilder]; // Define o usuário selecionado.
                              userProvider.indexUser = indexBuilder; // Define o índice do usuário.
                              Navigator.popAndPushNamed(context, "/create"); // Redireciona para a tela de edição.
                            }, 
                            icon: Icon(Icons.edit)
                          ),
                          // Botão para visualizar os detalhes do usuário.
                          IconButton(
                            onPressed: () {
                              userProvider.userSelected = users[indexBuilder]; // Define o usuário selecionado.
                              userProvider.indexUser = indexBuilder; // Define o índice do usuário.
                              Navigator.popAndPushNamed(context, "/view"); // Redireciona para a tela de visualização.
                            }, 
                            icon: Icon(Icons.visibility, color: Colors.blue)
                          ),
                          // Botão para excluir o usuário.
                          IconButton(
                            onPressed: () {
                              userProvider.indexUser = null; // Reseta o índice do usuário selecionado.
                              userProvider.users.removeAt(indexBuilder); // Remove o usuário da lista.
                              Navigator.popAndPushNamed(context, "/create"); // Redireciona para a tela de criação de usuário.
                            }, 
                            icon: Icon(Icons.delete, color: Colors.red)
                          ),
                        ],
                      )
                    ),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.4)) // Adiciona uma borda inferior para separar os itens.
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

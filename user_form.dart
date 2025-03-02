// Importa o arquivo 'container_all.dart', que provavelmente contém um layout de container reutilizável.
import 'package:crud_teste1/container_all.dart';
// Importa o arquivo 'field_form.dart', que deve conter a estrutura para os campos do formulário.
import 'package:crud_teste1/field_form.dart';
// Importa o pacote Flutter Material, que fornece widgets essenciais para o design da aplicação.
import 'package:flutter/material.dart';

// Importa o arquivo 'user.dart', que deve definir a classe User.
import 'user.dart';
// Importa o arquivo 'user_provider.dart', que gerencia o estado dos usuários.
import 'user_provider.dart';

// Define a classe UserForm como um StatefulWidget, permitindo mudanças de estado dinâmicas.
class UserForm extends StatefulWidget {
  const UserForm({super.key}); // Construtor da classe.

  @override
  State<UserForm> createState() => _UserFormState(); // Cria o estado para o formulário do usuário.
}

// Classe que gerencia o estado do formulário do usuário.
class _UserFormState extends State<UserForm> {

  // Define o título inicial da página como "Create User".
  String title = "Criar usuário";

  // Controladores para os campos de entrada do formulário.
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerLogin = TextEditingController();
  TextEditingController controllerPerfil = TextEditingController();
  TextEditingController controllerEmpresa = TextEditingController();
  TextEditingController controllerSistema = TextEditingController();
  TextEditingController controllerExpira = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // Obtém a instância do UserProvider para gerenciar os dados do usuário.
    UserProvider userProvider = UserProvider.of(context) as UserProvider;

    int? index; // Índice do usuário selecionado, se houver.

    // Verifica se há um usuário selecionado para edição.
    if (userProvider.indexUser != null) {
      index = userProvider.indexUser;

      // Preenche os campos com os dados do usuário existente.
      controllerName.text = userProvider.userSelected!.name;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerLogin.text = userProvider.userSelected!.login;
      controllerPerfil.text = userProvider.userSelected!.perfil;
      controllerEmpresa.text = userProvider.userSelected!.empresa;
      controllerSistema.text = userProvider.userSelected!.sistema;
      controllerExpira.text = userProvider.userSelected!.expira;

      // Atualiza o título da página para "Edit User".
      setState(() {
        this.title = "Editar usuário";
      });
    }

    // Cria uma chave global para o formulário.
    GlobalKey<FormState> _key = GlobalKey();
    
    // Função para salvar os dados do formulário.
    void save() {
      // Valida o formulário antes de salvar.
      final isValidate = _key.currentState?.validate();

      // Se a validação falhar, interrompe o processo de salvamento.
      if (isValidate == false) {
        return;
      }

      // Salva os dados do formulário.
      _key.currentState?.save();

      // Cria um novo usuário com os dados inseridos no formulário.
      User user = User(
        name: controllerName.text, 
        email: controllerEmail.text, 
        login: controllerLogin.text,
        perfil: controllerPerfil.text,
        empresa: controllerEmpresa.text,
        sistema: controllerSistema.text,
        expira: controllerExpira.text,
      );

      if (index != null) {
        // Se estiver editando, substitui o usuário na lista.
        userProvider.users[index] = user;
      } else {
        // Obtém o tamanho atual da lista de usuários.
        int usersLength = userProvider.users.length;

        // Adiciona um novo usuário à lista.
        userProvider.users.insert(usersLength, user);
      }

      // Navega para a lista de usuários após salvar.
      Navigator.popAndPushNamed(context, "/list");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title), // Define o título da página.
        backgroundColor: const Color.fromARGB(255, 27, 27, 27), // Define a cor de fundo do AppBar.
        foregroundColor: Colors.white,
        actions: [
          // Botão para navegar até a lista de usuários.
          Container( 
            child: TextButton(
              style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Colors.black)),
              child: Text('Lista de usuários'), // Texto do botão.
              onPressed: () {
                Navigator.popAndPushNamed(context, "/list"); // Redireciona para a lista de usuários.
              }, 
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255), // Define a cor de fundo do botão.
              borderRadius: BorderRadius.all(Radius.circular(8)) // Adiciona bordas arredondadas.
            ),
            margin: EdgeInsets.all(8), // Adiciona espaçamento ao redor do botão.
          )
        ],
      ),
      body: Center( // Usa um layout de container reutilizável.
        child: ContainerAll(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _key, // Define a chave do formulário.
                child: Column(
                  children: [
                    // Campo de entrada para a senha do usuário.
                    FieldForm(
                      label: 'Login', 
                      //isPassword: false, 
                      controller: controllerLogin,
                      isEmail: false,
                    ),
                    // Campo de entrada para o nome do usuário.
                    FieldForm(
                      label: 'Nome', 
                      //isPassword: false, 
                      controller: controllerName,
                      isEmail: false,
                    ),
                    // Campo de entrada para o e-mail do usuário.
                    FieldForm(
                      label: 'Email', 
                      //isPassword: false, 
                      controller: controllerEmail,
                      isEmail: true,
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            value: controllerPerfil.text.isEmpty ? null: controllerPerfil.text,
                            decoration: InputDecoration(
                              labelText: 'Perfil',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: 'Admin',
                                child: Text('Admin'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Usuário',
                                child: Text('Usuário'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Gerente',
                                child: Text('Gerente'),
                              ),
                            ],
                            onChanged: (String? newValue){
                              setState(() {
                                controllerPerfil.text = newValue ?? '';
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                        SizedBox(width: 10), // Espaço entre os campos
                        Expanded(
                          child: DropdownButtonFormField(
                            value: controllerEmpresa.text.isEmpty ? null: controllerEmpresa.text,
                            decoration: InputDecoration(
                              labelText: 'Empresa',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: 'Skymed',
                                child: Text('Skymed'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Nelógica',
                                child: Text('Nelógica'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Gerdau',
                                child: Text('Gerdau'),
                              ),
                            ],
                            onChanged: (String? newValue){
                              setState(() {
                                controllerEmpresa.text = newValue ?? '';
                              });
                            },
                            isExpanded: true,
                          ),
                        ),                      
                      ],
                    ),// <-- Fechando corretamente o Row
                    
                    SizedBox(height: 10),
                     
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            value: controllerSistema.text.isEmpty ? null: controllerSistema.text,
                            decoration: InputDecoration(
                              labelText: 'Sistema',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: 'Visual Studio Code',
                                child: Text('Visual Studio Code'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Anesthesia SX',
                                child: Text('Anesthesia SX'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'SAP',
                                child: Text('SAP'),
                              ),
                            ],
                            onChanged: (String? newValue){
                              setState(() {
                                controllerSistema.text = newValue ?? '';
                              });
                            },
                            isExpanded: true,
                          )
                        ),
                        SizedBox(width: 10), // Espaço entre os campos
                        Expanded(
                          child: FieldForm(
                            label: 'Expiração da Senha', 
                            controller: controllerExpira,
                            isEmail: false,
                            inputType: TextInputType.datetime, // Tipo de teclado para data
                            placeholder: 'dd/mm/yyyy', // Placeholder que mostra o formato de data
                          ),
                        ),
                      ],
                    ), 
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextButton(
                          onPressed: save,
                          child: Text('Salvar'),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 27, 27, 27)),
                            foregroundColor: WidgetStateProperty.all(Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ], // Fechando corretamente a lista de children
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
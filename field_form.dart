// Importa o pacote Flutter Cupertino, que fornece widgets com estilo do iOS.
import 'package:flutter/cupertino.dart';
// Importa o pacote Flutter Material, que fornece widgets essenciais para a aplicação.
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

// Define a classe FieldForm como um StatelessWidget, pois seu estado não muda após a construção.
// Define a classe FieldForm como um StatelessWidget, pois seu estado não muda após a construção.
class FieldForm extends StatelessWidget {
  // Rótulo do campo de entrada.
  String label;
  // Define se o campo será do tipo senha (oculto).
  bool? isPassword;
  // Controlador para gerenciar o valor do campo de entrada.
  TextEditingController controller;
  // Define se o campo está habilitado ou desabilitado.
  bool? isForm = true;
  // Define se o campo será validado como um e-mail.
  bool isEmail = false;

  TextInputType inputType;
  String? placeholder;

  // Construtor da classe, exigindo alguns parâmetros obrigatórios e permitindo outros opcionais.
  FieldForm({
    required this.label,
    //required this.isPassword,
    required this.controller,
    this.isForm,
    required this.isEmail,
    this.inputType = TextInputType.text,
    this.placeholder,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: this.isForm, // Define se o campo está habilitado ou desabilitado.
      controller: controller, // Controlador do campo para capturar o valor digitado.
      keyboardType: inputType,
      decoration: InputDecoration(
        filled: true, // Preenche o fundo do campo de entrada.
        fillColor: const Color.fromARGB(255, 255, 255, 255), // Define a cor de fundo do campo.
        labelText: label, // Define o rótulo do campo.
        hintText: placeholder, 
      ),
      validator: (value) { // Função de validação do campo.
        if (label == 'Expiração de senha') {
          // Valida a data (Formato: dd/MM/yyyy)
          try {
            // Tentamos analisar a data
            final date = DateFormat('dd/MM/yyyy').parseStrict(value!);

            // Verifica se a data é inválida, como "0/0/0"
            if (date.year < 1 || date.month < 1 || date.month > 12 || date.day < 1 || date.day > 31) {
              return 'Digite uma data válida (dd/MM/yyyy)';
            }

            // Verificação adicional para dias específicos em meses e ano bissexto
            final daysInMonth = DateTime(date.year, date.month + 1, 0).day;
            if (date.day > daysInMonth) {
              return 'O dia ${date.day} não existe no mês ${date.month}';
            }

            return null; // Data válida
            } catch (e) {
              return 'Digite uma data válida (dd/MM/yyyy)';
            }
        }
        
        // Validação para outros campos
        if (value!.length < 5) { // Verifica se o valor tem pelo menos 5 caracteres.
          return 'Digite pelo menos 5 caracteres';
        }
        if (this.isEmail && !value.contains("@")) { // Validação extra para campos de e-mail.
          return 'Digite o email corretamente';
        }
        return null;
      }
    );
  }
}
// Importa o pacote Flutter Material, que fornece widgets essenciais para a aplicação.
import 'package:flutter/material.dart';

// Define a classe ContainerAll como um StatelessWidget, pois seu estado não muda após a construção.
class ContainerAll extends StatelessWidget {
  // Declara um widget filho que será exibido dentro do container.
  Widget child;

  // Construtor da classe, exigindo um widget filho como parâmetro obrigatório.
  ContainerAll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      //child: this.child, // Exibe o widget filho dentro do container.
      margin: EdgeInsets.all(15), // Define uma margem externa de 15 pixels em todos os lados.
      padding: EdgeInsets.all(15), // Define um espaçamento interno de 15 pixels em todos os lados.
      decoration: BoxDecoration(
        color: Color.fromRGBO(189, 188, 188, 0.494), // Define a cor de fundo do container com transparência.
        borderRadius: BorderRadius.circular(20), // Adiciona bordas arredondadas com raio de 20 pixels.
      ),
      child: child,
    );
  }
}

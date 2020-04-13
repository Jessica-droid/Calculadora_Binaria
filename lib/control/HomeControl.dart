import 'package:binariocalc/dialog/dlg_resultado.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeControl {
  HomeControl({@required this.context});

  static const int SOMA = 0;
  static const int SUBTRACAO = 1;
  static const int MULTIPLICACAO = 2;
  static const int DIVISAO = 3;
  static const int RESTO = 4;

  final BuildContext context;

  //Como hà um limite de caracteres pré definido posso utilizar uma tabela com valores estáticos para realizar os cauculos
  List<int> valorCasa = [256, 128, 64, 32, 16, 8, 4, 2, 1];

  void validarCalcular(GlobalKey<FormState> formKey, int operacao,
      String valor1, String valor2) {
    //Validar campos antes de acionar uma operacao
    if (_formValidado(formKey)) {
      //Valores definidos, calcular
      _calcular(operacao, valor1, valor2);
    }
  }

  void _calcular(int operacao, String valor1, String valor2) {
    //Definir operacao
    switch (operacao) {
      case SOMA:
        _somar(valor1, valor2);

        break;
      case SUBTRACAO:
        _subtrair(valor1, valor2);

        break;

      case MULTIPLICACAO:
        _multiplicar(valor1, valor2);
        break;

      case DIVISAO:
        _dividir(valor1, valor2);
        break;

      case RESTO:
        _resto(valor1, valor2);
        break;
    }
  }

  void _somar(String entrada1, String entrada2) {
    //Converter os valores em numeros inteiros
    int inteiro1 = _tornarInteiro(entrada1);
    int inteiro2 = _tornarInteiro(entrada2);

    int resultado = inteiro1 + inteiro2;

    //Exibir Resultado
    _exibirResultado(_tornarBinario(resultado));
  }

  void _subtrair(String entrada1, String entrada2) {
    //Converter os valores em numeros inteiros
    int inteiro1 = _tornarInteiro(entrada1);
    int inteiro2 = _tornarInteiro(entrada2);

    int resultado = inteiro1 - inteiro2;

    //Exibir Resultado
    _exibirResultado(_tornarBinario(resultado));
  }

  void _multiplicar(String entrada1, String entrada2) {
    //Converter os valores em numeros inteiros
    int inteiro1 = _tornarInteiro(entrada1);
    int inteiro2 = _tornarInteiro(entrada2);

    int resultado = inteiro1 * inteiro2;

    //Exibir Resultado
    _exibirResultado(_tornarBinario(resultado));
  }

  void _dividir(String entrada1, String entrada2) {
    //Converter os valores em numeros inteiros
    int inteiro1 = _tornarInteiro(entrada1);
    int inteiro2 = _tornarInteiro(entrada2);

    int resultado = inteiro1 ~/ inteiro2;

    //Exibir Resultado
    _exibirResultado(_tornarBinario(resultado));
  }

  void _resto(String entrada1, String entrada2) {
    //Converter os valores em numeros inteiros
    int inteiro1 = _tornarInteiro(entrada1);
    int inteiro2 = _tornarInteiro(entrada2);

    int resultado = inteiro1 % inteiro2;

    //Exibir Resultado
    _exibirResultado(_tornarBinario(resultado));
  }

  bool _formValidado(GlobalKey<FormState> formKey) {
    return formKey.currentState.validate();
  }

  int _tornarInteiro(String valorBinario) {
    /*
    Uma vez que sei quantas casas são, posso descobrir seu valor de acordo com a tabela pré definida
    entao posso tranformar essa String em um array de valores por casa
     */

    List<int> valorPorCasa = List();
    List<String> valorBinarioParticionado = List();

    //Transformando a String que tem o valor binário em um List de Strings, cada indice com um valor de casa
    valorBinarioParticionado = valorBinario.split('');

    int tabelaValoresIndex = valorCasa.length - 1;

    //Agora que tenho o numero binario dividido em casas posso verificar seus valores
    for (int position = valorBinarioParticionado.length;
        position > 0;
        position--) {
      //Verificando o valor de cada casa para definir o valor numeral dela

      if (valorBinarioParticionado[position - 1] == "1") {
        //Recuperar o valor numeral da tabela referente a esta posicao
        valorPorCasa.add(valorCasa[tabelaValoresIndex]);
        tabelaValoresIndex--;
      } else {
        //Tornar campo 0
        valorPorCasa.add(0);
        tabelaValoresIndex--;
      }
    }

    //Agora que tenho os valores de cada casa, é só somar eles
    int valorInteiro = 0;
    valorPorCasa.forEach((valorCampo) {
      valorInteiro += valorCampo;
    });

    //Retornar valor inteiro
    return valorInteiro;
  }

  String _tornarBinario(int valorInteiro) {
    List<int> resto = List();

    int resultado = _retornaResultado(valorInteiro);
    int restante = _retornaResto(valorInteiro);

    //Armazenando o resto da primeira divisao, as demais virao no loop
    resto.add(restante);

    /*
   para tornar um numero inteiro em um binario, devo dividi-lo por 2 e aramazenar os restos
    */

    while (resultado > 1) {
      int restoNovo = _retornaResto(resultado);

      //Armazenando resto da divisao do novo resultado
      resto.add(restoNovo);

      resultado = _retornaResultado(resultado);
    }

    //ao sair do laço, inserir o ultimo resultado na lista
    resto.add(resultado);

    //Agora temos o valor em binário, mas ele está invertido, vamos desenverter e torná-lo uma String para exibição
    String resultadoCerto = "";

    for (int position = resto.length - 1; position >= 0; position--) {
      resultadoCerto = "$resultadoCerto${resto[position]}";
    }

    return resultadoCerto;
  }

  int _retornaResultado(int dividendo) {
    return dividendo ~/ 2;
  }

  int _retornaResto(int dividendo) {
    return dividendo % 2;
  }

  void _exibirResultado(String resultado) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DlgResultado(resultado: resultado);
        });
  }
}

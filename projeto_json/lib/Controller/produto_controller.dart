import 'dart:convert';
import 'dart:io';

import '../Model/produtos_model.dart';

class ProdutoController {
  //atributo
  List<Produto> _produtos = []; //privado

  //método get
  List<Produto> get produtos {
    return _produtos;
  }
  //método set
  set produtos(List<Produto> produtos) {
    _produtos = produtos;
  }

  //Salvar produtos no Json
  Future<void> salvarJson() async {
    final file = File('produtos.json');
    final jsonList = produtos.map((produto) => produto.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  //Carregar produtos do Json
  Future<List<Produto>> carregarJson() async {
    try {
      final file = File('produtos.json');
      final jsonList = jsonDecode(await file.readAsString());
      produtos = jsonList.map<Produto>((json) => Produto.fromJson(json)).toList();
    } catch (e) {
      // Caso o arquivo não exista ou ocorra um erro na leitura, não faz nada
      produtos = [];
    }
    return produtos;
  }
}

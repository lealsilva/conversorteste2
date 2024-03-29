import 'package:flutter/material.dart';

Widget customDropDown(
    List<String> currencies, String? value, void Function(String?) onChange) {
  // remoção de valores duplicados
  List<String> uniqueItems = currencies.toSet().toList();

  // verificar se o valor é válido
  String? validValue = uniqueItems.contains(value) ? value : uniqueItems.first;

  return Container(
    width: 115, // Defina a largura do Container
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 18),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Currency', // Adiciona um rótulo
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        // Personaliza o estilo do texto do rótulo
        labelStyle: TextStyle(color: Colors.black),
      ),
      value: validValue,
      onChanged: onChange,
      items: uniqueItems.map<DropdownMenuItem<String>>((String val) {
        return DropdownMenuItem<String>(
          child: Text(val),
          value: val,
        );
      }).toList(),
      // estilo do botão suspenso
      icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
      // estilo do texto selecionado
      selectedItemBuilder: (BuildContext context) {
        return uniqueItems.map<Widget>((String item) {
          return Text(
            item,
            style: TextStyle(color: Colors.blue),
          );
        }).toList();
      },
      //texto dos itens suspensos
      style: TextStyle(color: Colors.black),
    ),
  );
}

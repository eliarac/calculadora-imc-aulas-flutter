import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pessoa{
  double peso;
  double altura;
  String genero;
  String _result;
  

  pessoa({
    this.altura,
    this.peso,
    this.genero
  });
  
  void calculateImc(double peso , double altura , String genero) {
   
    double imc = peso / (altura * peso);
    classificarImc(imc);

  }

  void classificarImc(double imc){
    
    _result = "IMC = ${imc.toStringAsPrecision(2)}\n";
      if (genero == ('Feminino')){
      if (imc < 19.1)
        Text(_result += "Abaixo do peso", style: TextStyle(color: Colors.blue),);
      else if (imc < 25.8)
        _result += "Peso ideal";
      else if (imc < 27.3)
        _result += "Levemente acima do peso";
      else if (imc < 32.3)
        _result += "Acima do peso";
      else if (imc >= 32.4)
        _result += "Obesidade";
    } else if (genero == ('Masculino')){
      if (imc < 20.70)
        _result += "Abaixo do peso";
      else if (imc < 26.4)
        _result += "Peso ideal";
      else if (imc < 27.8)
        _result += "Levemente acima do peso";
      else if (imc < 31.1)
        _result += "Acima do peso";
      else if (imc >= 31.2)
        _result += "Obesidade";
    }
  }
}

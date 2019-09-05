import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
enum SingingCharacter { feminino, masculino }
class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _result;
  int selectedRadioTile;
  //SingingCharacter _character = SingingCharacter.feminino;
  //SingingCharacter _character2 = SingingCharacter.masculino;

  
  @override
  void initState() {
    super.initState();
    resetFields();
    selectedRadioTile = 0;

 
  }
  setselectedRadioTile(int val){
    setState(() {
      selectedRadioTile = val; 
    });
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _result = 'Informe seus dados';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          buildRadioListTile(),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  void calculateImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100.0;
    double imc = weight / (height * height);

    setState(() {
      _result = "IMC = ${imc.toStringAsPrecision(2)}\n";
      if (selectedRadioTile == 1){
      if (imc < 19.1)
        _result += "Abaixo do peso";
      else if (imc < 25.8)
        _result += "Peso ideal";
      else if (imc < 27.3)
        _result += "Levemente acima do peso";
      else if (imc < 32.3)
        _result += "Acima do peso";
      else if (imc >= 32.4)
        _result += "Obesidade";

    } else if (selectedRadioTile == 2){
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
    );
  }

  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculateImc();
          }
        },
        child: Text('CALCULAR', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0) , 
      
      ),
    );
  }

  Widget buildRadioListTile(){
    return Center(
        
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
               child: Text("Sexo:", textAlign: TextAlign.center, 
                            style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 25.0),
            ),),
            
            RadioListTile(
              value: 1,
              groupValue: selectedRadioTile,
              title: const Text('Feminino'),
              onChanged: (val){
                setselectedRadioTile(val);
              },
              selected: true,
            ),
            RadioListTile(
              value: 2,
              groupValue: selectedRadioTile,
              title: const Text('Masculino'),
              onChanged: (val){
                setselectedRadioTile(val);
              },
              selected: false,
            ),
    ],),);
     
              
  }
  Widget buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}

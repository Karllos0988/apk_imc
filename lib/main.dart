import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home>{

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); //criar uma chave para o form


  String _infoText = "Informe seus dados!";

  void _resetField(){
    _formKey.currentState?.reset(); //resetar a mensagem de erro
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
    
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.5){ 
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})"; 
      } 
      else if (imc >= 18.5 && imc < 24.9){ 
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})"; 
      } 
      else if (imc >= 25.0 && imc < 29.9){ 
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})"; 
      }
      else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      }
      else if(imc >= 40){ 
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})"; 
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(onPressed: _resetField, icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey, //iniciando a chave
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Icon(Icons.person, size: 120.0, color: Colors.green,),

              TextFormField(

                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (KG)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value){  //verificação para ver se o form está preenchido
                  if(value == null || value.isEmpty){
                      return "Insira sua altura!";
                    }
                    return null;
                },

              ),

              TextFormField(

                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (CM)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value){
                    if(value == null || value.isEmpty){ //verificação para ver se o form está preenchido
                      return "Insira sua altura!";
                    }
                    return null;
        
                },

              ),
              Padding(

                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  children: [ Container(

                      height: 50.0 ,
                      width: double.infinity, //fazer o botão cobrir a largura disponivel
                      child: ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState?.validate() ?? false){ //verificação para ver se o form está preenchido
                          _calculate(); 
                        }
                      },
                      child: Text('Calcular', style: 
                        TextStyle(
                          color: Colors.white, 
                          fontSize: 25.0),
                        ),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),              
                      ),
                      
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    Text(_infoText,
                        textAlign: TextAlign.center,                   
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                    ),
                  ]
                ),
              ),
            ],
          ),
        ), 
      )
    );
  }
}


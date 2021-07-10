import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
     ));
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final heightController = TextEditingController();            // controls  height text field

  final weightController = TextEditingController();             // controls  weight text field

   double bmi=0;
   String message = '';

  void _calculate() {

    final double? height = double.tryParse(heightController.value.text);
    final double? weight = double.tryParse(weightController.value.text);

    //checking valid input
    //<= or >= can't be unconditionally invoked because receiver can be null so mull check(!) added
    if (height!<= 0 || weight! <= 0) {
      setState(() {
        message = ' Enter positive height and weight';
      });
      return;
    }

    //calculating result and corresponding case
    setState(() {
      bmi = weight / (height * height);
      if (bmi < 18.5) {
        message = ' (Underweight)';
      } else if (bmi < 24.9) {
        message = ' (Perfect)';
      } else if (bmi < 29.9) {
        message = ' (Overweight)';
      } else {
        message = ' (Obese)';
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: true,                   //during input scaffold resizes to adjust accordingly
        backgroundColor: Color(0xFF005493),
        appBar: AppBar(
          automaticallyImplyLeading: false,                 //to get rid of back arrow
          backgroundColor: Colors.deepPurple[400],
          centerTitle: true,
          title: Text(
            'BMI Calculator',
              style: TextStyle(
              fontSize: 30.0,
              color: Colors.tealAccent
               ),
             )
          ),

          body: SingleChildScrollView(
            //to avoid pixel overflows
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15,),

                  ClipRRect(
                      borderRadius: BorderRadius.circular(55.0),
                      child: Image(image:AssetImage('assets/splash.jpg'))),

                  SizedBox(height: 10,),

              Container(
                alignment: AlignmentDirectional.bottomEnd,
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      //Minimize the amount of free space along the main axis, subject to the incoming layout constraints
                      children: [
                        TextField(
                          keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(labelText: 'Enter Height in m'),
                          style: TextStyle(fontSize: 22.0),
                          controller: heightController,                  //connecting height text editing controller to height text field
                           ),
                         ],
                       ),
                     ),
                  ),
                ),

                    Container(
                      alignment: AlignmentDirectional.bottomEnd,
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        //Card class to show data
                        color: Colors.white,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(labelText: 'Enter Weight in kg'),
                                style: TextStyle(fontSize: 22.0),
                                controller: weightController,                   //connecting weight text editing controller to weight text field
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 10),

                  ElevatedButton(onPressed: _calculate,
                    child: Text(
                       'Calculate',
                      style: TextStyle(
                          fontSize: 20.0,
                          color:Colors.tealAccent
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    child:
                      Text(
                        bmi == null ? 'No Result' : bmi.toStringAsFixed(2) + message,             //storing calculated value and message and displaying
                         //in 2 digits only
                        //Returns a string representation of this double value
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                  ),
                ],
             ),
          ),
    );
  }
}
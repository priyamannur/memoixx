import 'package:flutter/material.dart';
import 'package:memoixx/pages/pagesSection2/options_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage(this.title,{super.key});

  final String title;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = 100;
    if (screenWidth > 900) {
      paddingValue = 400.0;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: Text(title, style: const TextStyle(color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 25.0),),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset('assets/images/ex1.png'),
            ),
          ),   
             Container(
                  margin: const EdgeInsets.only(top:30.0),
                      child:const Center(
                        child: Text(
                          'Welcome to Memoix!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),),

                
                    const Text(
                        'Set your daily reminders so that you never forget an important event again',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500),
                      ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 30.0),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingValue),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context){
                              return const OptionPage();
                            })
                          );
                        },
                        tooltip: 'Get Started',
                        backgroundColor: Colors.indigo.shade900,
                        child:const Text('Get Started'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ], // <-- Correct placement of closing bracket
      ), // This trailing comma makes auto-formatting nicer for build methods
    );
  }
}

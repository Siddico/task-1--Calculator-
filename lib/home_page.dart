import 'package:calc/components/components.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> symbols = [
    'AC',
    'Del',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '.',
    '0',
    'Ans',
    '='
  ];
  String input = '';
  String output = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, //6F9395
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).themeMode ==
                          ThemeMode.light
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: ToggleButtons(
                      borderRadius: BorderRadius.circular(50),
                      children: [
                        Container(
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color:
                                Provider.of<ThemeProvider>(context).themeMode ==
                                        ThemeMode.light
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).secondaryHeaderColor,
                          ),
                          height: 40,
                          width: 60,
                          child: Icon(
                            Icons.light_mode,
                            color:
                                Provider.of<ThemeProvider>(context).themeMode ==
                                        ThemeMode.light
                                    ? Theme.of(context).secondaryHeaderColor
                                    : Theme.of(context).primaryColor,
                            size: 24,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color:
                                Provider.of<ThemeProvider>(context).themeMode ==
                                        ThemeMode.light
                                    ? Theme.of(context).secondaryHeaderColor
                                    : Theme.of(context).primaryColor,
                          ),
                          height: 40,
                          width: 60,
                          child: Icon(
                            Icons.dark_mode,
                            size: 24,
                            color:
                                Provider.of<ThemeProvider>(context).themeMode ==
                                        ThemeMode.light
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      ],
                      isSelected: [
                        Provider.of<ThemeProvider>(context).themeMode ==
                            ThemeMode.light,
                        Provider.of<ThemeProvider>(context).themeMode ==
                            ThemeData.dark(),
                      ],
                      onPressed: (index) {
                        setState(() {
                          if (index == 0) {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .setLightMode();
                          } else {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .setDarkMode();
                          }
                        });
                      }),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Container(
                  width: double.infinity,
                  child: Text(
                    input,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.left,
                  )),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Container(
                  width: double.infinity,
                  child: Text(
                    output,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.right,
                  )),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
                color: Provider.of<ThemeProvider>(context).themeMode ==
                        ThemeMode.light
                    ? Color(0xffF0EFEF)
                    : Color(0xff3D6063),
              ), //6F9395
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 4, right: 4),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        if (symbols[index] == 'AC') {
                          setState(() {
                            input = '';
                            output = '';
                          });
                        } else if (symbols[index] == 'Del') {
                          setState(() {
                            input = input.substring(0, input.length - 1);
                          });
                        } else if (symbols[index] == 'Ans') {
                          setState(() {
                            input = output;
                            output = '';
                          });
                        } else if (symbols[index] == '=') {
                          Expression expression = Parser().parse(input);
                          double result = expression.evaluate(
                              EvaluationType.REAL, ContextModel());
                          setState(() {
                            if (result == result.toInt().toDouble()) {
                              output = result.toInt().toString();
                            } else {
                              output = result.toStringAsFixed(6);
                            }
                            //input = output;
                            //output = '';
                          });
                        } else if (symbols[index] == '%' ||
                            symbols[index] == '/' ||
                            symbols[index] == '*' ||
                            symbols[index] == '-' ||
                            symbols[index] == '+') {
                          if (input.endsWith('%') ||
                              input.endsWith('/') ||
                              input.endsWith('*') ||
                              input.endsWith('-') ||
                              input.endsWith('+')) {
                            null;
                          } else {
                            setState(() {
                              input += symbols[index];
                            });
                          }
                        } else {
                          setState(() {
                            input += symbols[index];
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              color: myBackGroundColor(symbols[index])),
                          alignment: Alignment.center,
                          child: Text(
                            symbols[index],
                            style: TextStyle(
                                color: textColor(symbols[index]),
                                fontSize: 32,
                                fontFamily: 'GT_Sectra',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    );
                  }),
                  itemCount: symbols.length,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color myBackGroundColor(String x) {
    if (x == 'AC' || x == 'Del' || x == '%') {
      return Color(0xff353535); //teal
    } else if (x == '/' ||
        x == '*' ||
        x == '-' ||
        x == '+' ||
        x == '%' ||
        x == '=') {
      return Color(0xff3C6E71);
    } else if (x == 'Ans') {
      return Colors.green;
    } else {
      return Colors.white; //const Color.fromARGB(255, 218, 218, 218);
    }
  }

  Color textColor(String x) {
    if (x == 'AC' ||
        x == '/' ||
        x == '*' ||
        x == '-' ||
        x == '+' ||
        x == '%' ||
        x == 'Del' ||
        x == '=' ||
        x == 'Ans') {
      return Colors.white;
    } else {
      return Color(0xff353535);
    }
  }
}

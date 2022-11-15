import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suhu_2/widgets/Suhu.dart';
import 'package:suhu_2/widgets/ConvertButton.dart';
import 'package:suhu_2/widgets/InputUser.dart';
import 'package:suhu_2/widgets/HistoryUser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController input_user = TextEditingController();
  double kelvin = 0, reamur = 0, input = 0;
  double hasil = 0;

  String selctDropdown = "Reamur";
  List<String> NamaSuhu = ["Kelvin", "Reamur", "Fahrenheit"];
  List<String> History = [];

  void onDropChange(Object? value) {
    return setState(() {
      selctDropdown = value.toString();
      input_user.text.isNotEmpty;
    });
  }

  void Konversi() {
    return setState(() {
      if (input_user.text.isNotEmpty) {
        switch (selctDropdown) {
          case "Kelvin":
            hasil = int.parse(input_user.text) + 273;
            break;

          case "Reamur":
            hasil = int.parse(input_user.text) * 4 / 5;
            break;

          case "Fahrenheit":
            hasil = int.parse(input_user.text) * 9 / 5 + 32;
            break;
          default:
        }
        History.add(input_user.text +
            " Celcius ke " +
            selctDropdown +
            " : " +
            hasil.toString());
      }
    });
  }

  double currentSuhu = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Konverter Suhu')),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Text('Celcius'),
              Slider(
                  value: currentSuhu,
                  max: 100,
                  divisions: 100,
                  label: currentSuhu.round().toString(),
                  onChangeEnd: (value) {
                    setState(() {
                      currentSuhu = value;
                      input_user.text = currentSuhu.toString();
                      Konversi();
                    });
                  },
                  onChanged: (double value) {
                    setState(() {
                      currentSuhu = value;
                      input_user.text = currentSuhu.toString();
                    });
                  }),
              Suhu(
                selctDropdown: selctDropdown,
                NamaSuhu: NamaSuhu,
                onDropChange: onDropChange,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hasil',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "$hasil",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 30,
              ),
              ConvertButton(
                konversi: Konversi,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Riwayat Konversi ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              HistoryUser(history: History)
            ],
          ),
        ),
      ),
    );
  }
}

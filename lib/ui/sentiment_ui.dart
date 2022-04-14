import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SentimentAnalyzer extends StatefulWidget {
  const SentimentAnalyzer({Key? key}) : super(key: key);

  @override
  State<SentimentAnalyzer> createState() => _SentimentAnalyzerState();
}

class _SentimentAnalyzerState extends State<SentimentAnalyzer> {
  final TextEditingController _textController = TextEditingController();
  String _sentiment = "";
  String _result_image = "assets/logo_maua.jpg";
  String _current_language = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentiment Analyzer'),
        backgroundColor: const Color(0xff004586),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/logo_maua.jpg',
              height: 40,
              width: 40,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.medium,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Digite o texto a ser analisado',
              ),
              style: const TextStyle(fontSize: 24),
              controller: _textController,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      color: const Color(0xff004586),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      if (_current_language == 'en') {
                        _current_language = 'pt';
                      } else {
                        _current_language = 'en';
                      }
                      setState(() {});
                    },
                    child: Text(_current_language),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      color: const Color(0xff004586),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 24),
                    ),
                    onPressed: () async {
                      var dio = Dio();
                      var response = await dio.post(
                        "https://flutter-service.cognitiveservices.azure.com/text/analytics/v3.2-preview.1/sentiment?opinionMining=true",
                        data: {
                          "documents": [
                            {
                              "language": _current_language,
                              "id": "1",
                              "text": _textController.text,
                            },
                          ],
                        },
                        options: Options(
                          headers: {
                            "Ocp-Apim-Subscription-Key": "<chave aqui>",
                          },
                        ),
                      );
                      setState(
                        () {
                          _sentiment =
                              response.data["documents"][0]["sentiment"];
                          if (_sentiment == "positive") {
                            _result_image = "assets/happy.jpg";
                          } else if (_sentiment == "neutral") {
                            _result_image = "assets/neutral.png";
                          } else if (_sentiment == "negative") {
                            _result_image = "assets/sad.webp";
                          }
                        },
                      );
                    },
                    child: const Text('Analizar'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Resultado: $_sentiment",
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Image.asset(
            _result_image,
            height: 40,
            width: 40,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
          ),
        ],
      ),
    );
  }
}

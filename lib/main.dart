import 'package:flutter/material.dart';
import 'package:proyecto_quizzapp/quiz_brain.dart';

// Crear un objeto de QuizBarin
QuizzBrain quiz = QuizzBrain();

List<Widget> scoreKeeper = [];
int puntaje = 0;

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quiz.getQuestionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              child: Text(
                'Verdadero',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                bool correctAnswer = quiz.getQuestionAnswer;
                  if (correctAnswer == true) {
                    if (!quiz.lastQuestion()) {
                      scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
                      puntaje++;
                    }
                  } else {
                    if (!quiz.lastQuestion()) {
                      scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
                    }
                  }
                  setState(() {
                    quiz.nextQuestion();
                    if (quiz.lastQuestion()) {
                      _showAlertDialog(puntaje.toString());
                    }
                  });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: Text(
                'Falso',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                bool correctAnswer = quiz.getQuestionAnswer;
                //The user picked false.
                if (!correctAnswer) {
                  if (!quiz.lastQuestion()) {
                    scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
                    puntaje++;
                  }
                } else {
                  if (!quiz.lastQuestion()) {
                    scoreKeeper.add(Icon(Icons.close, color: Colors.green,));
                  }
                }
                setState(() {
                  quiz.nextQuestion();
                  if (quiz.lastQuestion()) {
                    _showAlertDialog(puntaje.toString());
                  }
                });
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper

      ],
    );
  }

  Future<void> _showAlertDialog(String correctAnswers) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Todas las preguntas respondidas",
              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 4, 31, 154))),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Tuviste un puntaje de $correctAnswers sobre ${scoreKeeper.length} preguntas.',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Restart',
                  style: TextStyle(
                    fontSize: 24,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  scoreKeeper = [];
                  quiz.restartQuestions();
                  puntaje = 0;
                });
              },
            ),
          ],
        );
      },
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

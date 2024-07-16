import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'package:quiz_app/provider/provider.dart';
import 'package:quiz_app/screens/quiz_options.dart';

class QuizScreen extends StatefulWidget {
  final String topic;
  const QuizScreen({super.key, required this.topic});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false)
          .initialize(widget.topic, quizData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (quizProvider.topicQuestions.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text('${widget.topic} Quiz'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final currentQuestion =
            quizProvider.topicQuestions[quizProvider.currentQuestionIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text('${widget.topic} Quiz'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${quizProvider.currentQuestionIndex + 1}/${quizProvider.topicQuestions.length}',
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      currentQuestion['question'],
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),
                    ...currentQuestion['options'].entries.map((entry) {
                      return ListTile(
                        title: Text(entry.value),
                        leading: Radio<String>(
                          value: entry.key,
                          groupValue: quizProvider.selectedOption,
                          onChanged: (String? value) {
                            quizProvider.selectOption(value!);
                          },
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: quizProvider.selectedOption.isEmpty
                          ? null
                          : () {
                              bool hasMoreQuestions =
                                  quizProvider.nextQuestion();
                              if (!hasMoreQuestions) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _showResult(context, quizProvider);
                                });
                              }
                            },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: quizProvider.resetQuiz,
            child: const Icon(Icons.refresh),
          ),
        );
      },
    );
  }

  void _showResult(BuildContext context, QuizProvider quizProvider) {
    int totalQuestions = quizProvider.topicQuestions.length;
    int score = (quizProvider.correctAnswers * 5);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Completed'),
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (score == 25)
                  Stack(
                    children: [
                      ConfettiWidget(
                        confettiController: quizProvider.confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: false,
                      ),
                      Center(
                        child: Image.asset(
                          'images/trophy.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                Text(
                  'Total Questions: $totalQuestions\n'
                  'Correct Answers: ${quizProvider.correctAnswers}\n'
                  'Incorrect Answers: ${quizProvider.incorrectAnswers}\n'
                  'Your Score: $score',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Navigate back to home screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

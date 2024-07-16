import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class QuizProvider with ChangeNotifier {
  int _currentQuestionIndex = 0;
  String _selectedOption = '';
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;
  List<Map<String, dynamic>> _topicQuestions = [];
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));

  int get currentQuestionIndex => _currentQuestionIndex;
  String get selectedOption => _selectedOption;
  int get correctAnswers => _correctAnswers;
  int get incorrectAnswers => _incorrectAnswers;
  List<Map<String, dynamic>> get topicQuestions => _topicQuestions;
  ConfettiController get confettiController => _confettiController;

  void initialize(String topic, List<Map<String, dynamic>> quizData) {
    _topicQuestions = quizData.where((q) => q['topic'] == topic).toList();
    notifyListeners();
  }

  void selectOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  bool nextQuestion() {
    if (_selectedOption == _topicQuestions[_currentQuestionIndex]['answer']) {
      _correctAnswers++;
    } else {
      _incorrectAnswers++;
    }

    if (_currentQuestionIndex < _topicQuestions.length - 1) {
      _currentQuestionIndex++;
      _selectedOption = '';
      notifyListeners();
      return true; // Indicates that there are more questions
    } else {
      _confettiController.play();
      notifyListeners();
      return false; // Indicates that the quiz is complete
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _selectedOption = '';
    _correctAnswers = 0;
    _incorrectAnswers = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}

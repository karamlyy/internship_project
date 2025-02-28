import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  int _chances = 3;
  int _correctAnswerCount = 0;
  bool _isAddedToMaster = false;
  bool _isRemovedFromMaster = false;
  bool _isCorrectAnswerSelected = false;
  bool _isAnswerSelected = false;
  bool _showAddToMaster = false;
  String? _selectedAnswer;
  bool? _selectedAnswerCorrect;
  bool _isAnswerLocked = false;
  String? _correctAnswer;
  bool _isAnswersUnblurred = false;
  bool _showRemoveFromMaster = false;
  bool isAnswersUnblurred = false;
  bool isFirstLoad = true;


  bool get showRemoveFromMaster => _showRemoveFromMaster;

  void setShowRemoveFromMaster(bool value) {
    _showRemoveFromMaster = value;
    notifyListeners();
  }

  void resetShowRemoveFromMaster() {
    _showRemoveFromMaster = false;
    notifyListeners();
  }


  bool get isCorrectAnswerSelected => _isCorrectAnswerSelected;
  int get chances => _chances;
  int get correctAnswerCount => _correctAnswerCount;
  bool get isAddedToMaster => _isAddedToMaster;
  bool get isRemovedFromMaster => _isRemovedFromMaster;
  bool get isAnswerSelected => _isAnswerSelected;
  bool get showAddToMaster => _showAddToMaster;
  String? get selectedAnswer => _selectedAnswer;
  bool? get selectedAnswerCorrect => _selectedAnswerCorrect;
  bool get isAnswerLocked => _isAnswerLocked;
  String? get correctAnswer => _correctAnswer;

  void setAnswersUnblurred(bool value) {
    isAnswersUnblurred = value;
    notifyListeners();
  }

  void setFirstLoad(bool value) {
    isFirstLoad = value;
    notifyListeners();
  }


  void decrementChance() {
    if (_chances > 0) {
      _chances--;
      notifyListeners();
    }
  }

  void unblurAnswers() {
    setAnswersUnblurred(true);
  }

  void blurAnswers() {
    setAnswersUnblurred(false);
  }


  void addCorrectAnswerCount() {
    _correctAnswerCount++;
    notifyListeners();
  }

  void resetChances() {
    _chances = 3;
    _selectedAnswer = null;
    _selectedAnswerCorrect = null;
    _correctAnswer = null;
    _showAddToMaster = false;
    _isAnswerLocked = false;
    notifyListeners();
  }

  void addToMaster(bool value) {
    _isAddedToMaster = value;
    notifyListeners();
  }

  void updateBlurStatus(bool isQuizHidden) {
    _isAnswersUnblurred = !isQuizHidden;
    notifyListeners();
  }

  void setCorrectAnswerSelected(bool value) {
    _isCorrectAnswerSelected = value;
    _showAddToMaster = value;
    notifyListeners();
  }

  void setCorrectAnswer(String? answer) {
    _correctAnswer = answer;
    notifyListeners();
  }



  bool selectAnswer(bool isSelected) {
    _isAnswerSelected = isSelected;
    notifyListeners();
    return _isAnswerSelected;
  }

  void setSelectedAnswer(String answer, bool isCorrect, String correctAnswer) {
    if (_isAnswerLocked) return;

    _selectedAnswer = answer;
    _selectedAnswerCorrect = isCorrect;
    _isAnswerLocked = true;
    _correctAnswer = correctAnswer;

    notifyListeners();
  }

  void unlockAnswerSelection() {
    _isAnswerLocked = false;
    _selectedAnswer = null;
    _correctAnswer = correctAnswer;
    _selectedAnswerCorrect = null;
    notifyListeners();
  }

  bool setAddToMaster(bool value) {
    _isAddedToMaster = value;
    notifyListeners();
    return _showAddToMaster;
  }

  bool removeFromMaster(bool value) {
    _isRemovedFromMaster = value;
    notifyListeners();
    return _isRemovedFromMaster;
  }
}

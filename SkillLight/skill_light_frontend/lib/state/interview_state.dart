class InterviewState {
  String currentQuestion = "";
  String level = "";
  List<Map<String, String>> QnA = [];

  void setLevel(String lvl) {
    level = lvl;
  }

  void saveQuestion(String q) {
    currentQuestion = q;
  }

  void saveAnswer(String question, String answer) {
    QnA.add({
      "question": question,
      "answer": answer,
    });
  }

  void reset() {
    currentQuestion = "";
    QnA.clear();
  }
}

final interviewState = InterviewState();

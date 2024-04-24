class QuizModel {
  List<Questions>? questions;
  String? status;

  QuizModel({this.questions, this.status});

  QuizModel.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Questions {
  String? question;
  String? answer;
  List<String>? options;

  Questions({this.question, this.answer, this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['options'] = this.options;
    return data;
  }
}

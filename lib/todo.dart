class TodoModel {
  String title;
  String description;
  bool isFinished;

  TodoModel({
    required this.title,
    required this.description,
    required this.isFinished,
  });

  static List<TodoModel> todoList = [
    TodoModel(
      title: 'Wash Teeth',
      description: 'Lorem Ipsum text',
      isFinished: false,
    ),
    TodoModel(
      title: 'Wash Teeth',
      description: 'Lorem Ipsum text',
      isFinished: false,
    ),
    TodoModel(
      title: 'Wash Teeth',
      description: 'Lorem Ipsum text',
      isFinished: false,
    )
  ];
}

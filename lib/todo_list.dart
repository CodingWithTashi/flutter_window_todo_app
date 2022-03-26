import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_window_todo_app/create_edit_todo_dialog.dart';
import 'package:flutter_window_todo_app/todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    if (TodoModel.todoList.isNotEmpty) {
      return ListView.builder(
        itemCount: TodoModel.todoList.length,
        itemBuilder: (context, index) {
          TodoModel model = TodoModel.todoList[index];
          return GestureDetector(
            onTap: () => _editTodoDialog(model),
            child: ListTile(
              title: Text(model.title),
              subtitle: Text(
                model.description,
              ),
              trailing: IconButton(
                icon: const Icon(FluentIcons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return ContentDialog(
                          title: const Text('Delete Todo'),
                          content: const Text(
                              'Do you really want to delete this todo'),
                          actions: [
                            Button(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            Button(
                                child: const Text('Yes'),
                                onPressed: () {
                                  setState(() {
                                    TodoModel.todoList.remove(model);
                                    Navigator.pop(context);
                                  });
                                })
                          ],
                        );
                      });
                },
              ),
            ),
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          'No Todo Found',
        ),
      );
    }
  }

  _editTodoDialog(TodoModel todoModel) {
    showDialog(
        context: context,
        builder: (context) {
          return CreateEditTodoContent(
              todoModel: todoModel,
              onUpdated: () {
                showSnackbar(
                  context,
                  const Snackbar(
                    content: Text(
                      'Todo Updated',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
                Navigator.pop(context);
              });
        }).then((value) {
      setState(() {});
    });
  }
}

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_window_todo_app/todo.dart';

class CreateEditTodoContent extends StatefulWidget {
  final Function? onCreated;
  final Function? onUpdated;
  final TodoModel? todoModel;
  const CreateEditTodoContent(
      {Key? key, this.onCreated, this.todoModel, this.onUpdated})
      : super(key: key);

  @override
  State<CreateEditTodoContent> createState() => _CreateEditTodoContentState();
}

class _CreateEditTodoContentState extends State<CreateEditTodoContent> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool isFinish = false;
  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    if (widget.todoModel != null) {
      isFinish = widget.todoModel!.isFinished;
      _titleController.text = widget.todoModel!.title;
      _descriptionController.text = widget.todoModel!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: widget.todoModel == null
          ? const Text('Create New Todo')
          : const Text('Update Todo'),
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBox(
              controller: _titleController,
              header: 'Title',
              placeholder: 'Enter title here',
            ),
            const SizedBox(
              height: 20,
            ),
            TextBox(
              controller: _descriptionController,
              minLines: 5,
              maxLines: 8,
              header: 'Description',
              placeholder: 'Enter description here',
            ),
            const SizedBox(
              height: 20,
            ),
            Checkbox(
                checked: isFinish,
                onChanged: (val) {
                  setState(() {
                    isFinish = !isFinish;
                  });
                },
                content: const Text('Is Finished')),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                if (widget.todoModel != null) ...[
                  Button(
                    child: const Text('Update'),
                    onPressed: () => updateTodo(widget.todoModel!),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ] else ...[
                  Button(
                    child: const Text('Create'),
                    onPressed: createTodo,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
                Button(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  createTodo() {
    TodoModel.todoList.add(
      TodoModel(
        title: _titleController.text,
        description: _descriptionController.text,
        isFinished: isFinish,
      ),
    );
    if (widget.onCreated != null) {
      widget.onCreated!();
    }
  }

  void updateTodo(TodoModel todoModel) {
    int index = TodoModel.todoList.indexOf(todoModel);
    TodoModel.todoList[index] = TodoModel(
      title: _titleController.text,
      description: _descriptionController.text,
      isFinished: isFinish,
    );
    if (widget.onUpdated != null) {
      widget.onUpdated!();
    }
  }
}

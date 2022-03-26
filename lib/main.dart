import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_window_todo_app/todo.dart';
import 'package:flutter_window_todo_app/todo_list.dart';

import 'create_edit_todo_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.blue,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = false;
  int index = 0;
  List<TodoModel> toModelList = [];
  @override
  void initState() {
    toModelList = TodoModel.todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Todo App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Button(
                child: const Text('Create Todo'),
                onPressed: _createNewTodo,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.event_to_do_logo),
            title: const Text('Todo List'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
        ],
      ),
      content: NavigationBody(index: index, children: [
        //TODO LIST
        TodoListPage(),
        //
        Container(),
      ]),
    );
  }

  void _createNewTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return CreateEditTodoContent(onCreated: () {
            showSnackbar(
              context,
              const Snackbar(
                content: Text(
                  'Todo Created',
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/boards_services.dart';
import 'package:trelltech/arbory/services/lists_service.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/text_input.dart';

class CreateListScreen extends StatefulWidget {
  final String? boardId;
  const CreateListScreen({super.key, required this.boardId});

  @override
  _CreateListScreenState createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen>{
  String listName = '';
  String? error;

  void validateForm(String? name) {
    if (name == null) {
      setState(() {
        error = 'Please fill in the form';
      });
      return;
    }
    context
        .read<TrelloLists>()
        .create(idBoard: widget.boardId!, name: name)
        .then((value) => context.go('/board/${widget.boardId}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(text: 'Create a list'),
            const SizedBox(height: 20),
            const Text('destination board: ', style: TextStyle(fontFamily: 'LexendExa', fontSize: 16)),
            Text(context.read<Boards>().boardsById[widget.boardId]?.name ?? '', style: const TextStyle(fontFamily: 'LexendExa')),
            const SizedBox(height: 20),
            CustomTextField(
              name: "list name",
              errorText: error,
              onTextChanged: (String value) {
                setState(() {
                  listName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (error != null) Text(error!, style: const TextStyle(fontFamily: 'LexendExa', color: Colors.redAccent),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  iconName: Icons.add,
                  text: 'create list',
                  onPressed: () {
                    validateForm(listName);
                  },
                ),
                const SizedBox(width: 20),
                TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                    ),
                    onPressed: () => context.go('/board/${widget.boardId}'),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        Text(" go back",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'LexendExa',
                                color: Colors.white)),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
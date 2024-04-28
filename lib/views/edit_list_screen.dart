import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/boards_services.dart';
import 'package:trelltech/arbory/services/lists_service.dart';
import 'package:trelltech/components/checkbox.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/text_input.dart';

class EditListScreen extends StatefulWidget {
  final String listId;
  const EditListScreen({super.key, required this.listId});

  @override
  _EditListScreenState createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen>{
  String listName = '';
  String? boardId;
  String? error;
  bool subscribed = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Consumer<TrelloLists>(
          builder: (builder, lists, child){
            var list = lists.listsById[widget.listId];
            if(list == null) return const Text('No list', style: TextStyle(fontFamily: 'LexendExa'),);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTitle(text: 'Edit list ${list.name}'),
                const SizedBox(height: 20),
                CustomTextField(
                  name: "list name",
                  helperText: list.name,
                  errorText: error,
                  onTextChanged: (String value){
                    setState(() {
                      listName = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Consumer<Boards>(
                    builder: (builder, boards, child){
                      return DropdownMenu(
                        label: const Text('destination board: ', style: TextStyle(fontFamily: 'LexendExa'),),
                        inputDecorationTheme: const InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 191, 22, 1.0),
                                width: 3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 191, 22, 1.0),
                                width: 3),
                          ),
                        ),
                        menuStyle: MenuStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          side: MaterialStateProperty.all(const BorderSide(
                            color: Color.fromRGBO(234, 191, 22, 1.0),
                            width: 3,
                          )),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: const BorderSide(
                                  color: Color.fromRGBO(234, 191, 22, 1.0),
                                  width: 3),
                            ),
                          ),
                        ),
                        onSelected: (String? value){
                          setState(() {
                            boardId = value;
                          });
                        },
                        dropdownMenuEntries: boards.boards
                            .map((e) => DropdownMenuEntry(
                            value: e.id,
                            label: e.name,
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                                textStyle:
                                MaterialStateProperty.all(const TextStyle(
                                  color: Color.fromRGBO(20, 25, 70, 1),
                                  fontFamily: 'LexendExa',
                                ))),
                        ))
                            .toList(),
                      );
                    }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('subscribed :', style: TextStyle(fontFamily: 'LexendExa', fontSize: 16)),
                    CustomCheckbox(
                      value: subscribed,
                      onChanged: (value){
                        setState(() {
                          subscribed = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                if (!list.closed)
                  SizedBox(
                    width: 200,
                    child: TextButton(
                        onPressed: () {
                          list.update(closed: true);
                          context.go('/board/${list.id}');
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(top: 16.0, bottom: 16.0)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontFamily: 'LexendExa', color: Colors.black)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.red[100]),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.close,
                              color: Colors.redAccent,
                            ),
                            Text(
                              ' close board',
                              style: TextStyle(
                                  fontFamily: 'LexendExa', color: Colors.black),
                            )
                          ],
                        )),
                  ),
                if (list.closed)
                  SizedBox(
                    width: 200,
                    child: TextButton(
                        onPressed: () {
                          list.update(closed: false);
                          context.go('/list/${list.id}');
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(top: 16.0, bottom: 16.0)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontFamily: 'LexendExa', color: Colors.black)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.greenAccent[100]),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.open_in_browser,
                              color: Colors.greenAccent,
                            ),
                            Text(
                              ' open board',
                              style: TextStyle(
                                  fontFamily: 'LexendExa', color: Colors.black),
                            )
                          ],
                        )),
                  ),
                const SizedBox(height: 20),
                if (error != null) Text(error!, style: const TextStyle(fontFamily: 'LexendExa', color: Colors.redAccent),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      iconName: Icons.edit,
                      text: 'edit list',
                      onPressed: () {
                        if(listName == '' && boardId == null){
                          setState(() {
                            error = 'Please fill in the form';
                          });
                          return;
                        }
                        list.update(
                            name: listName,
                            idBoard: boardId,
                            subscribed: subscribed
                        );
                        context.go('/list/${list.id}');
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
                        onPressed: () => context.go('/board/${list.idBoard}'),
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
            );
          },
        ),
      ),
    );
  }
}
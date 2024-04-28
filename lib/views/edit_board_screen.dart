import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/boards_services.dart';
import 'package:trelltech/arbory/services/organization_service.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/text_input.dart';

class EditBoardScreen extends StatefulWidget {
  final String boardId;
  const EditBoardScreen({super.key, required this.boardId});

  @override
  EditBoardScreenState createState() => EditBoardScreenState();
}

class EditBoardScreenState extends State<EditBoardScreen> {
  String name = '';
  String? boardDesc;
  String orgId = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Consumer<Boards>(
          builder: (builder, boards, child) {
            var board = boards.boardsById[widget.boardId]!;
            orgId = board.idOrganization ?? '';
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTitle(text: 'Edit board ${board.name}'),
                const SizedBox(height: 40),
                CustomTextField(
                    name: 'name',
                    onTextChanged: (String value) => {
                          setState(() {
                            name = value;
                          })
                        }),
                CustomTextField(
                    name: 'description',
                    onTextChanged: (String value) => {
                          setState(() {
                            boardDesc = value;
                          })
                        }),
                Consumer<Organizations>(
                    builder: (builder, organizations, child) {
                  return Center(
                    child: DropdownMenu(
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
                      label: Text(
                        organizations.organizationsById[board.idOrganization]!
                            .displayName,
                        style: const TextStyle(
                          fontFamily: 'LexendExa',
                          color: Color.fromRGBO(20, 25, 70, 1),
                        ),
                      ),
                      dropdownMenuEntries: organizations.organizations
                          .map((e) => DropdownMenuEntry(
                              label: e.displayName,
                              value: e.id,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  textStyle:
                                      MaterialStateProperty.all(const TextStyle(
                                    color: Color.fromRGBO(20, 25, 70, 1),
                                    fontFamily: 'LexendExa',
                                  )))))
                          .toList(),
                      onSelected: (String? value) {
                        orgId = value!;
                      },
                    ),
                  );
                }),
                const SizedBox(height: 40),
                if (!board.closed)
                  SizedBox(
                    width: 200,
                    child: TextButton(
                        onPressed: () {
                          board.update(closed: true);
                          context.go('/board/${board.id}');
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
                if (board.closed)
                  SizedBox(
                    width: 200,
                    child: TextButton(
                        onPressed: () {
                          board.update(closed: false);
                          context.go('/board/${board.id}');
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
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        iconName: Icons.save_outlined,
                        text: 'Save',
                        onPressed: () async {
                          if (name == '' &&
                              boardDesc != board.desc &&
                              boardDesc != '') {
                            name = board.name;
                          }
                          if (boardDesc == '' &&
                              name != board.name &&
                              name != '') {
                            boardDesc = board.desc;
                          }
                          if (orgId == '') {
                            orgId = board.idOrganization ?? '';
                          }
                          board
                              .update(
                                  name: name,
                                  desc: boardDesc,
                                  idOrganization: orgId)
                              .then((lol) => context.go('/board/${board.id}'));
                        }),
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
                        onPressed: () {
                          context.go('/board/${widget.boardId}');
                        },
                        child: const Row(
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
                        ))
                  ],
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

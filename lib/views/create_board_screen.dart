import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/boards_services.dart';
import 'package:trelltech/arbory/services/organization_service.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_bottom_navigation_bar.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/text_input.dart';

class CreateBoardScreen extends StatefulWidget {
  const CreateBoardScreen({super.key});

  @override
  CreateBoardScreenState createState() => CreateBoardScreenState();
}

class CreateBoardScreenState extends State<CreateBoardScreen> {
  String? selectedBoard;
  String? selectedOrg;
  String boardName = '';
  String? boardDesc;
  String? error;

  void validateForm(String? board, String? org, String? name, String? desc) {
    if (board == null || org == null || name == null || desc == null) {
      setState(() {
        error = 'Please fill in the form';
      });
      return;
    }
    context
        .read<Boards>()
        .createBoard(
            idBoardSource: board, idOrganization: org, name: name, desc: desc)
        .then((value) => context.go('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomTitle(text: 'Create a new board'),
            const SizedBox(height: 40),
            CustomTextField(
                name: "board name",
                onTextChanged: (String value) {
                  setState(() {
                    boardName = value;
                  });
                }),
            const SizedBox(height: 20),
            CustomTextField(
                name: "board description",
                onTextChanged: (String value) {
                  setState(() {
                    boardDesc = value;
                  });
                }),
            const SizedBox(height: 28),
            Consumer<Boards>(
              builder: (builder, boards, child) {
                return DropdownMenu(
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      borderSide:
                          BorderSide(width: 3, color: Color(0xfffcda5e)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      borderSide:
                          BorderSide(width: 3, color: Color(0xfffcda5e)),
                    ),
                  ),
                  menuStyle: MenuStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: const BorderSide(
                            width: 3, color: Color(0xfffcda5e)),
                      ),
                    ),
                  ),
                  label: const Text(
                    "select board's template",
                    style: TextStyle(
                      color: Color.fromRGBO(20, 25, 70, 1),
                      fontFamily: 'LexendExa',
                    ),
                  ),
                  expandedInsets: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  dropdownMenuEntries: boards.boards.map((board) {
                    return DropdownMenuEntry(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            color: Color.fromRGBO(20, 25, 70, 1),
                            fontFamily: 'LexendExa',
                          ),
                        ),
                      ),
                      value: board.id,
                      label: board.name,
                    );
                  }).toList(),
                  onSelected: (String? value) => {
                    setState(() {
                      selectedBoard = value;
                    })
                  },
                );
              },
            ),
            const SizedBox(height: 32),
            Consumer<Organizations>(builder: (builder, organizations, child) {
              return DropdownMenu(
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(width: 3, color: Color(0xfffcda5e)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(width: 3, color: Color(0xfffcda5e)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(width: 3, color: Color(0xfffcda5e)),
                  ),
                ),
                menuStyle: MenuStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 3, color: Color(0xfffcda5e)),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                label: const Text(
                  "select board's organization",
                  style: TextStyle(
                    color: Color.fromRGBO(20, 25, 70, 1),
                    fontFamily: 'LexendExa',
                  ),
                ),
                dropdownMenuEntries:
                    organizations.organizations.map((organization) {
                  return DropdownMenuEntry(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          color: Color.fromRGBO(20, 25, 70, 1),
                          fontFamily: 'LexendExa',
                        ),
                      ),
                    ),
                    value: organization.id,
                    label: organization.name,
                  );
                }).toList(),
                onSelected: (String? value) => {
                  setState(() {
                    selectedOrg = value;
                  })
                },
              );
            }),
            const SizedBox(height: 28),
            CustomButton(
                text: 'Create',
                iconName: Icons.add,
                onPressed: () => {
                      validateForm(
                          selectedBoard, selectedOrg, boardName, boardDesc),
                    }),
            const SizedBox(height: 16),
            Text(
              error ?? "",
              style: const TextStyle(
                fontFamily: 'LexendExa',
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

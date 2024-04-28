import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/boards_services.dart';
import 'package:trelltech/arbory/services/lists_service.dart';
import 'package:trelltech/arbory/services/organization_service.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_bottom_navigation_bar.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:trelltech/components/custom_card.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/delete_text_button.dart';
import 'package:trelltech/components/edit_text_button.dart';

class BoardScreen extends StatelessWidget {
  final String? boardId;
  const BoardScreen({super.key, required this.boardId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
          primary: true,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Consumer<Boards>(
            builder: (context, boards, child) {
              var board = boards.boardsById[boardId];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: CustomTitle(text: board?.name ?? "No board"),
                      ),
                      CustomIconEdit(onPressed: () {
                        context.go('/edit-board/${board!.id}');
                      }),
                      CustomIconDelete(
                          onPressed: () => {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Delete board"),
                                        content: const Text(
                                            "Are you sure you want to delete this board?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () {
                                                board?.delete();
                                                Navigator.of(context).pop();
                                                context.go('/');
                                              },
                                              child: const Text("Delete")),
                                        ],
                                      );
                                    }),
                              })
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Badge(
                      label: Text(
                        board!.closed ? 'closed' : 'open',
                        style: const TextStyle(
                          color: Color.fromRGBO(20, 25, 70, 1),
                          fontFamily: 'LexendExa',
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: board.closed
                          ? Colors.red[100]
                          : Colors.greenAccent[200],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'descritpion : ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'LexendExa',
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(20, 25, 70, 1),
                    ),
                  ),
                  Text(
                    board.desc.isEmpty ? 'no description' : board.desc,
                    softWrap: true,
                    style: const TextStyle(
                      fontFamily: 'LexendExa',
                      color: Color.fromRGBO(20, 25, 70, 1),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Consumer<Organizations>(
                    builder: (context, organizations, child) {
                      var organization =
                          organizations.organizationsById[board.idOrganization];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'organization : ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'LexendExa',
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(20, 25, 70, 1),
                            ),
                          ),
                          organization?.id == null
                              ? const Text(
                                  'no organization for this board',
                                  style: TextStyle(fontFamily: 'LexendExa'),
                                )
                              : TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue[100]),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            fontFamily: 'LexendExa',
                                            color: Colors.black)),
                                  ),
                                  onPressed: () =>
                                      context.go('/org/${organization.id}'),
                                  child: Text(
                                    organization!.displayName,
                                    style: const TextStyle(
                                      fontFamily: 'LexendExa',
                                      color: Colors.black,
                                    ),
                                  ))
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'lists',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'LexendExa',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(20, 25, 70, 1),
                    ),
                  ),
                  Consumer<TrelloLists>(builder: (context, lists, child) {
                    return lists.listsByBoardId[boardId] == null
                        ? const Text(
                            'no lists in this board',
                            style: TextStyle(
                              fontFamily: 'LexendExa',
                              color: Color.fromRGBO(20, 25, 70, 1),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (var list in lists.listsByBoardId[boardId]!)
                                CustomCard(
                                  iconData: Icons.list_alt_outlined,
                                  title: list.name,
                                  subtitle: list.closed ? '❌ closed' : '✅ open',
                                  onTap: () => {context.go('/list/${list.id}')},
                                ),
                              CustomButton(
                                  text: "create a new list",
                                  iconName: Icons.add,
                                  onPressed: () =>
                                      context.go('/create-list/${board.id}')),
                              const SizedBox(height: 20),
                            ],
                          );
                  }),
                ],
              );
            },
          )),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

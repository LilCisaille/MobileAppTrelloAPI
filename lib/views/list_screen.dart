import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/boards_services.dart';
import 'package:trelltech/arbory/services/cards_service.dart';
import 'package:trelltech/arbory/services/lists_service.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_bottom_navigation_bar.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:trelltech/components/custom_card.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/delete_text_button.dart';
import 'package:trelltech/components/edit_text_button.dart';

class ListScreen extends StatelessWidget {
  final String listId;
  const ListScreen({super.key, required this.listId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Consumer<TrelloLists>(
        builder: (builder, lists, child){
          var list = lists.listsById[listId];
          return list == null
              ? const Text('No list', style: TextStyle(fontFamily: 'LexendExa'),)
              : SingleChildScrollView(
            primary: true,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: CustomTitle(text: lists.listsById[listId]!.name,),
                    ),
                    CustomIconEdit(
                      onPressed: () => context.go('/edit-list/${list.id}'),
                    ),
                    CustomIconDelete(
                        onPressed: (){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text("Delete list"),
                              content: const Text("You can't delete this list because there is no api endpoint to perform this action."),
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Ok")
                                ),
                              ],
                            );
                          });
                        }
                    ),
                  ],
                ),
                Row(
                  children: [
                    Badge(
                      label: Text(
                        list.closed ? 'closed' : 'open',
                        style: const TextStyle(
                          fontFamily: 'LexendExa',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: list.closed ? Colors.redAccent[100] : Colors.greenAccent[200],
                    ),
                    const SizedBox(width: 10),
                    Badge(
                      label: Text(
                        list.subscribed == null ? 'not subscribed' : list.subscribed == true ? 'subscribed' : 'not subscribed',
                        style: const TextStyle(
                          fontFamily: 'LexendExa',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: list.subscribed! ? Colors.cyanAccent[200] : Colors.pink[100],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("board :",
                    style: TextStyle(
                        fontFamily: 'LexendExa',
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    )),
                Consumer<Boards>(
                  builder: (builder, boards, child){
                    var board = boards.boardsById[list.idBoard];
                    return board == null
                        ? const Text('no board', style: TextStyle(fontFamily: 'LexendExa'),)
                        : TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue[100]),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                                fontFamily: 'LexendExa',
                                color: Colors.black),
                          ),
                        ),
                        onPressed: () => context.go('/board/${board.id}'),
                        child: Text(
                          board.name,
                          style: const TextStyle(
                            fontFamily: 'LexendExa',
                            color: Colors.black,
                          ),)
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text("cards :",
                    style: TextStyle(
                        fontFamily: 'LexendExa',
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    )),
                Consumer<Cards>(
                  builder: (builder, cards, child){
                    var cardsList = cards.cardsByListId[listId];
                    return cardsList == null
                        ? const Text('no cards', style: TextStyle(fontFamily: 'LexendExa'),)
                        : Column(
                      children: cardsList.map((card){
                        return CustomCard(
                          title: card.name,
                          subtitle: '${card.desc ?? "no description"}, due on ${card.due ?? "never"}',
                          iconData: Icons.task_alt,
                          onTap: ()=> context.go('/card/${card.id}'),);
                      }).toList(),
                    );

                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child:   CustomButton(
                      text: 'create a card',
                      iconName: Icons.add,
                      onPressed: () => context.go('/create-card/$listId')
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
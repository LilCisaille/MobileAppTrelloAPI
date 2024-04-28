import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/cards_service.dart';
import 'package:trelltech/arbory/services/lists_service.dart';
import 'package:trelltech/arbory/services/members_service.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_bottom_navigation_bar.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/delete_text_button.dart';
import 'package:trelltech/components/edit_text_button.dart';

class CardScreen extends StatelessWidget {
  final String cardId;
  const CardScreen({super.key, required this.cardId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Consumer<Cards>(
          builder: (builder, cards, child) {
            var trelloCard = cards.cardsById[cardId];
            var idList = trelloCard?.idList;
            return trelloCard == null
                ? const Text(
                    'No card',
                    style: TextStyle(fontFamily: 'LexendExa'),
                  )
                : SingleChildScrollView(
                    primary: true,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: CustomTitle(text: trelloCard.name),
                            ),
                            CustomIconEdit(
                                onPressed: () =>
                                    context.go('/edit-card/$cardId')),
                            CustomIconDelete(
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Delete card"),
                                        content: const Text(
                                            "Are you sure you want to delete this card?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                trelloCard.delete();
                                                Navigator.of(context).pop();
                                                idList == null
                                                    ? context
                                                        .go('/list/$idList')
                                                    : context.go('/');
                                              },
                                              child: const Text("Delete")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel")),
                                        ],
                                      );
                                    })),
                          ],
                        ),
                        Row(
                          children: [
                            Badge(
                              backgroundColor: trelloCard.dueComplete
                                  ? Colors.green[200]
                                  : Colors.orange[100],
                              label: Text(
                                trelloCard.dueComplete
                                    ? "completed"
                                    : "not completed",
                                style: const TextStyle(
                                  fontFamily: 'LexendExa',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Badge(
                              backgroundColor: trelloCard.subscribed
                                  ? Colors.blue[200]
                                  : Colors.pink[100],
                              label: Text(
                                trelloCard.subscribed
                                    ? "subscribed"
                                    : "not subscribed",
                                style: const TextStyle(
                                  fontFamily: 'LexendExa',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'list :',
                          style: TextStyle(
                              fontFamily: 'LexendExa',
                              color: Color(0xff141946),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        Consumer<TrelloLists>(
                          builder: (builder, lists, child) {
                            var board = lists.listsById[trelloCard.idList];
                            return board == null
                                ? const Text(
                                    'no board',
                                    style: TextStyle(fontFamily: 'LexendExa'),
                                  )
                                : TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue[100]),
                                      textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            fontFamily: 'LexendExa',
                                            color: Colors.black),
                                      ),
                                    ),
                                    child: Text(board.name,
                                        style: const TextStyle(
                                          fontFamily: 'LexendExa',
                                          color: Colors.black,
                                        )),
                                    onPressed: () {
                                      context.go('/list/${trelloCard.idList}');
                                    },
                                  );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                            ),
                            const Text(
                              ' due date :',
                              style: TextStyle(
                                  fontFamily: 'LexendExa',
                                  color: Color(0xff141946),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            Text(
                              trelloCard.due ?? " no due date",
                              style: const TextStyle(
                                fontFamily: 'LexendExa',
                                color: Color(0xff141946),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'descritpion :',
                          style: TextStyle(
                              fontFamily: 'LexendExa',
                              color: Color(0xff141946),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        Text(
                          trelloCard.desc ?? "no description",
                          style: const TextStyle(
                            fontFamily: 'LexendExa',
                            color: Color(0xff141946),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'assigned to :',
                          style: TextStyle(
                              fontFamily: 'LexendExa',
                              color: Color(0xff141946),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        Row(
                          children: [
                            if (trelloCard.idMembers == null)
                              const Text(
                                'no member assigned',
                                style: TextStyle(fontFamily: 'LexendExa'),
                              ),
                            if (trelloCard.idMembers!.isEmpty)
                              const Text(
                                'no member assigned',
                                style: TextStyle(fontFamily: 'LexendExa'),
                              ),
                            const SizedBox(width: 20),
                            Row(
                              children: trelloCard.idMembers!.map((memberId) {
                                var member =
                                    Provider.of<Members>(context, listen: false)
                                        .membersById[memberId];
                                return member == null
                                    ? const Text(
                                        'no member',
                                        style:
                                            TextStyle(fontFamily: 'LexendExa'),
                                      )
                                    : Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          member.username,
                                        ),
                                      );
                              }).toList(),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blue[100],
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text('Add member'),
                                            content: Column(
                                              children: [
                                                for (var member
                                                    in Provider.of<Members>(
                                                            context,
                                                            listen: false)
                                                        .members)
                                                  ListTile(
                                                    title: Text(member.username,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'LexendExa')),
                                                    onTap: () {
                                                      trelloCard
                                                          .addMember(member.id);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                              ],
                                            ),
                                          ));
                                },
                                icon: const Icon(Icons.add),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
          },
        ),
        bottomNavigationBar: const CustomNavigationBar());
  }
}

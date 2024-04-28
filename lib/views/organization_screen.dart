import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/boards_services.dart';
import 'package:trelltech/arbory/services/organization_service.dart';
import 'package:trelltech/components/custom_appbar.dart';
import 'package:trelltech/components/custom_bottom_navigation_bar.dart';
import 'package:trelltech/components/custom_button.dart';
import 'package:trelltech/components/custom_card.dart';
import 'package:trelltech/components/custom_title.dart';
import 'package:trelltech/components/delete_text_button.dart';
import 'package:trelltech/components/edit_text_button.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key, required this.orgId});
  final String? orgId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        primary: true,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Consumer<Organizations>(
          builder: (context, organizations, child) {
            var organization = organizations.organizationsById[orgId];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: CustomTitle(
                        text: organization?.displayName ?? "No organization"),
                  ),
                  CustomIconEdit(onPressed: () {
                    context.go('/edit-organization/${organization?.id}');
                  }),
                  CustomIconDelete(onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete organization"),
                            content: const Text(
                                "Are you sure you want to delete this organization?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    organization?.delete();
                                    Navigator.of(context).pop();
                                    context.go('/');
                                  },
                                  child: const Text("Delete")),
                            ],
                          );
                        });
                  })
                ]),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("description : ",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(20, 25, 70, 1),
                          fontFamily: 'LexendExa',
                        )),
                    Text(
                      organization?.desc ?? "No description",
                      style: const TextStyle(
                        fontFamily: 'LexendExa',
                        color: Color.fromRGBO(20, 25, 70, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "members : ",
                      style: TextStyle(
                        fontFamily: 'LexendExa',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(20, 25, 70, 1),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      organization?.membersCount.toString() ?? "0",
                      style: const TextStyle(
                        fontFamily: "LexendExa",
                        color: Color.fromRGBO(20, 25, 70, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                const Text(
                  "boards",
                  style: TextStyle(
                    fontFamily: 'LexendExa',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(20, 25, 70, 1),
                  ),
                ),
                Consumer<Boards>(builder: (context, boards, child) {
                  var boardsByOrg = boards.boardsByOrganizationId[orgId];
                  return boardsByOrg == null
                      ? const Text(
                          "no boards",
                          style: TextStyle(
                            fontFamily: 'LexendExa',
                            color: Color.fromRGBO(20, 25, 70, 1),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return CustomCard(
                              iconData: Icons.dataset_outlined,
                              title: boardsByOrg[index].name,
                              subtitle: boardsByOrg[index].desc == ''
                                  ? 'No description'
                                  : boardsByOrg[index].desc,
                              onTap: () {
                                context.go('/board/${boardsByOrg[index].id}');
                              },
                            );
                          },
                          itemCount: boardsByOrg.length,
                          shrinkWrap: true,
                          primary: false,
                        );
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        text: 'create a board',
                        iconName: Icons.add,
                        onPressed: () {
                          context.go('/create-board');
                        }),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

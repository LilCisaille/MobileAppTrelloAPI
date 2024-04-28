import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/organization_service.dart';
import 'package:trelltech/components/custom_card.dart';

class OrganizationsList extends StatelessWidget {
  const OrganizationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Organizations>(
      builder: (context, organizations, child) {
        return ListView.builder(
          itemCount: organizations.organizations.length,
          dragStartBehavior: DragStartBehavior.start,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          primary: false,
          itemBuilder: (context, index) {
            return CustomCard(
              iconData: Icons.workspaces_outlined,
              title: organizations.organizations[index].displayName,
              subtitle: '${organizations.organizations[index].idBoards.length} boards',
              onTap: () => {
                context.goNamed('org', pathParameters: {'orgId': organizations.organizations[index].id})
              },
            );
          },
        );
      },
    );
  }
}
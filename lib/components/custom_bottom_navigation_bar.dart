import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/arbory/services/auth_service.dart';

class CustomNavigationBar extends StatelessWidget {
  /// Constructs a [CustomNavigationBar]
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return (Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(253, 218, 95, 1),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 4),
              blurRadius: 16,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => {
                      context.go('/'),
                    },
                icon: const Icon(
                  Icons.cottage_outlined,
                  color: Color.fromRGBO(20, 25, 70, 1),
                  size: 26,
                )),
            IconButton(
                onPressed: () => {print('Search')},
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: Color.fromRGBO(20, 25, 70, 1),
                  size: 26,
                )),
            IconButton(
                onPressed: () => {
                      context.go('/debug'),
                    },
                icon: const Icon(
                  Icons.bug_report_outlined,
                  color: Color.fromRGBO(20, 25, 70, 1),
                  size: 26,
                )),
            IconButton(
                onPressed: () =>
                    {Provider.of<Auth>(context, listen: false).signOut()},
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Color.fromRGBO(20, 25, 70, 1),
                  size: 26,
                )),
          ],
        )));
  }
}

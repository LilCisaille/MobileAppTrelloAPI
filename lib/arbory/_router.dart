import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trelltech/views/board_screen.dart';
import 'package:trelltech/views/card_screen.dart';
import 'package:trelltech/views/create_board_screen.dart';
import 'package:trelltech/views/create_card_screen.dart';
import 'package:trelltech/views/create_list_screen.dart';
import 'package:trelltech/views/create_workspace_screen.dart';
import 'package:trelltech/views/edit_board_screen.dart';
import 'package:trelltech/views/edit_card_screen.dart';
import 'package:trelltech/views/edit_list_screen.dart';
import 'package:trelltech/views/edit_organization_screen.dart';
import 'package:trelltech/views/list_screen.dart';
import 'package:trelltech/views/organization_screen.dart';
import 'package:trelltech/views/orgs_and_boards_lists_screen.dart';

import 'debug_screen.dart';
import 'details_screen.dart';
import '../views/home_screen.dart';
import 'services/auth_service.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        //if auth is not available, redirect to login
        if (context.watch<Auth>().apiToken != null) {
          return const OrgsAndBoardsListScreens();
        }
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'debug',
          builder: (BuildContext context, GoRouterState state) {
            return const DebugScreen();
          },
        ),
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        ),
        GoRoute(
          path: 'create-workspace',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateWorkspaceScreen();
          },
        ),
        GoRoute(
          name: 'org',
          path: 'org/:orgId',
          builder: (BuildContext context, GoRouterState state) {
            return OrganizationScreen(orgId: state.pathParameters['orgId']);
          },
        ),
        GoRoute(
          path: 'create-board',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateBoardScreen();
          },
        ),
        GoRoute(
          path: 'board/:boardId',
          builder: (BuildContext context, GoRouterState state) {
            return BoardScreen(boardId: state.pathParameters['boardId']);
          },
        ),
        GoRoute(
          path: 'edit-organization/:orgId',
          builder: (BuildContext context, GoRouterState state) {
            return EditOrganizationScreen(orgId: state.pathParameters['orgId']);
          },
        ),
        GoRoute(
          path: 'edit-board/:boardId',
          builder: (BuildContext context, GoRouterState state) {
            return EditBoardScreen(boardId: state.pathParameters['boardId']!);
          },
        ),
        GoRoute(
          path: 'list/:listId',
          builder: (BuildContext context, GoRouterState state) {
            return ListScreen(listId: state.pathParameters['listId']!);
          },
        ),
        GoRoute(
          path: 'create-list/:boardId',
          builder: (BuildContext context, GoRouterState state) {
            return CreateListScreen(boardId: state.pathParameters['boardId']!);
          },
        ),
        GoRoute(
          path: 'edit-list/:listId',
          builder: (BuildContext context, GoRouterState state) {
            return EditListScreen(listId: state.pathParameters['listId']!);
          },
        ),
        GoRoute(
          path: 'card/:cardId',
          builder: (BuildContext context, GoRouterState state) {
            return CardScreen(cardId: state.pathParameters['cardId']!);
          },
        ),
        GoRoute(
            path: 'create-card/:listId',
            builder: (BuildContext context, GoRouterState state) {
              return CreateCardScreen(listId: state.pathParameters['listId']!);
            }
        ),
        GoRoute(
          path: 'edit-card/:cardId',
          builder: (BuildContext context, GoRouterState state) {
            return EditCardScreen(cardId: state.pathParameters['cardId']!);
          },
        )
      ],
    ),
  ],
);

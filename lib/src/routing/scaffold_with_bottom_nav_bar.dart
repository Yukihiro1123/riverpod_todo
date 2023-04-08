import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_todo/src/routing/app_router.dart';

class ScaffoldWithBottomNavBar extends HookWidget {
  final Widget child;
  const ScaffoldWithBottomNavBar({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    const routes = {0: "tasks", 1: "feed", 2: "account"};
    final String location = GoRouterState.of(context).location;
    final _selectedIndex = useState(0);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex.value,
        items: const [
          // products
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_headline),
            label: 'Feeds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        onTap: (int index) {
          _selectedIndex.value = index;
          context.goNamed(routes[index]!);
        },
      ),
    );
  }
}

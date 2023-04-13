import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNavBar extends HookWidget {
  final Widget child;
  const ScaffoldWithBottomNavBar({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    const routes = {0: "projects", 1: "feed", 2: "account"};
    int calculateSelectedIndex(BuildContext context) {
      final String location = GoRouterState.of(context).location;
      if (location.startsWith("/projects")) {
        return 0;
      }
      if (location.startsWith("/feed")) {
        return 1;
      }
      if (location.startsWith("/account")) {
        return 2;
      }
      return 0;
    }

    final selectedIndex = useState(calculateSelectedIndex(context));
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex.value,
        items: const [
          // products
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Projects',
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
          selectedIndex.value = index;
          context.goNamed(routes[index]!);
        },
      ),
    );
  }
}

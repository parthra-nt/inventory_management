import 'package:flutter/material.dart';
import 'package:untitled/constants/app_constant.dart';
import 'package:untitled/presentation/screens/home/dashboard_screen.dart';
import 'package:untitled/presentation/screens/items_page.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int selectedIndex = 0;
  List<Widget> destinations = [DashboardScreen(), ItemsPage()];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = MediaQuery.of(context).size.width >= 300;
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isWideScreen)
                NavigationRail(
                  backgroundColor: AppColors.scaffoldBackColor,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard),
                      label: Text("Dashboard"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.inventory_2),
                      label: Text("Items"),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                ),
              Expanded(child: destinations[selectedIndex]),
            ],
          ),
        );
      },
    );
  }
}

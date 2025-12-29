import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../navigation/navigation.dart';
import '../../../theme/theme.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const <PageRouteInfo>[
        ShopRoute(),
        ScheduleRoute(),
        DashboardRoute(),
        CommunityRoute(),
        ProfileRoute(),
      ],
      builder: (BuildContext tabContext, Widget child) {
        final TabsRouter tabsRouter = AutoTabsRouter.of(tabContext);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: AppTheme.secondaryText,
            unselectedLabelStyle: const TextStyle(color: AppTheme.primaryText),
            showUnselectedLabels: true,
            selectedItemColor: AppTheme.primary,
            backgroundColor: AppTheme.sageGreen,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(label: 'Shop', icon: Icon(Icons.shop)),
              BottomNavigationBarItem(
                label: 'Schedule',
                icon: Icon(Icons.calendar_today),
              ),
              BottomNavigationBarItem(
                label: 'Dashboard',
                icon: Icon(Icons.dashboard),
              ),
              BottomNavigationBarItem(
                label: 'Community',
                icon: Icon(Icons.people),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              ),
            ],
          ),
        );
      },
    );
  }
}

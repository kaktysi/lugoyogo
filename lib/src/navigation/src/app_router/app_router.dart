import 'package:auto_route/auto_route.dart';
import '../../../presentation/presentation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: SignInRoute.page, initial: true),
    AutoRoute(
      page: HomeRoute.page,
      children: <AutoRoute>[
        AutoRoute(page: ShopRoute.page),
        AutoRoute(page: ScheduleRoute.page),
        AutoRoute(page: DashboardRoute.page, initial: true),
        AutoRoute(page: CommunityRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
  ];
}

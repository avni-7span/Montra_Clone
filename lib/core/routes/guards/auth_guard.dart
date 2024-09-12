import 'package:auto_route/auto_route.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/routes/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (AuthenticationRepository.instance.currentUser != null) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}

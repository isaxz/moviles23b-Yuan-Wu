import 'package:firebase_app/presentation/blocs.dart';
import 'package:firebase_app/presentation/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final appRouter = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuth = context.read<AuthCubit>().state.isAuth;
      final isCreatingAccount =
          context.read<AuthCubit>().state.isCreatingAccount;

      if (!isAuth && !isCreatingAccount) {
        return '/login';
      } else {
        return null;
      }
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
      GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    ]);

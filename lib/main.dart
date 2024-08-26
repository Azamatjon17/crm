import 'package:crm/bloc/admin_bloc/admin_bloc.dart';
import 'package:crm/bloc/authentication/authentication_bloc.dart';
import 'package:crm/bloc/group_bloc/group_bloc.dart';
import 'package:crm/bloc/phone_bloc/phone_bloc.dart';
import 'package:crm/bloc/room_bloc/room_bloc.dart';
import 'package:crm/bloc/user_bloc/user_bloc.dart';
import 'package:crm/bloc/working_hour_bloc/working_bloc.dart';
import 'package:crm/data/repositories/admin_repositories.dart';
import 'package:crm/data/repositories/authentication_repositories.dart';
import 'package:crm/data/repositories/group_repositories.dart';
import 'package:crm/data/repositories/room_repositories.dart';
import 'package:crm/data/repositories/phone_number_repositories.dart';
import 'package:crm/data/repositories/user_repositories.dart';
import 'package:crm/data/repositories/working_repositories.dart';
import 'package:crm/services/admin_services.dart';
import 'package:crm/services/authentication_services.dart';
import 'package:crm/services/group_services.dart';
import 'package:crm/services/room_services.dart';
import 'package:crm/services/phone_number_services.dart';
import 'package:crm/services/user_services.dart';
import 'package:crm/services/working_services.dart';
import 'package:crm/ui/screens/authentication/sign_in_screen.dart';
import 'package:crm/ui/screens/authentication/splash_screen.dart';
import 'package:crm/ui/screens/dashboards/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationRepositories(servic: AuthenticationServices())),
        RepositoryProvider(create: (context) => PhoneNumberRepositories(servic: PhoneNumberServices())),
        RepositoryProvider(create: (context) => UserRepositories(services: UserServices())),
        RepositoryProvider(create: (context) => AdminRepositories(services: AdminServices())),
        RepositoryProvider(create: (context) => RoomRepositories(services: RoomServices())),
        RepositoryProvider(create: (context) => GroupRepositories(services: GroupServices())),
        RepositoryProvider(create: (context) => WorkingRepositories(services: WorkingServices())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthenticationBloc(repo: context.read<AuthenticationRepositories>())),
          BlocProvider(create: (context) => PhoneBloc(repo: context.read<PhoneNumberRepositories>())),
          BlocProvider(create: (context) => UserBloc(repo: context.read<UserRepositories>())),
          BlocProvider(create: (context) => AdminBloc(repo: context.read<AdminRepositories>())),
          BlocProvider(create: (context) => RoomBloc(repositories: context.read<RoomRepositories>())),
          BlocProvider(create: (context) => GroupBloc(repo: context.read<GroupRepositories>())),
          BlocProvider(create: (context) => WorkingBloc(repo: context.read<WorkingRepositories>()))
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: SplashScreen(),
        ),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authBloc/auth_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/screens/authentication/login_screen.dart';
import 'package:scriptum/screens/authentication/signup_screen.dart';
import 'package:scriptum/screens/home_screen.dart';
import 'package:scriptum/screens/splash_screen.dart';
import 'package:scriptum/storage/storageRepository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(Scriptum(
    camera: firstCamera,
  ));
}

class Scriptum extends StatefulWidget {
  final CameraDescription camera;

  Scriptum({Key key, this.camera}) : super(key: key);

  @override
  _ScriptumState createState() => _ScriptumState();
}

class _ScriptumState extends State<Scriptum> {
  AuthRepository _authRepository;
  StorageRepository _storageRepository;
  DBRepository _dbRepository;
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository();
    _storageRepository = StorageRepository();
    _dbRepository = DBRepository();
    _authBloc = AuthBloc(authRepository: _authRepository);
    _authBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _authBloc,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepository>(
              create: (BuildContext context) => _authRepository,
            ),
            RepositoryProvider<DBRepository>(
              create: (BuildContext context) => _dbRepository,
            ),
            RepositoryProvider<StorageRepository>(
              create: (BuildContext context) => _storageRepository,
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/signup': (BuildContext context) => SignUpScreen(),
              '/login': (BuildContext context) => LoginScreen(),
            },
            theme: ThemeData.dark(),
            home: BlocBuilder(
              bloc: _authBloc,
              builder: (BuildContext context, AuthState state) {
                if (state is Authenticated) {
                  // _authBloc.dispatch(LoggedOut());
                  return HomeScreen();
                }
                if (state is AuthInitial) {
                  return SplashScreen();
                } else {
                  return LoginScreen();
                }
              },
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }
}

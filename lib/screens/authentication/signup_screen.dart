// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:scriptum/authentication/authRepository.dart';
// import 'package:scriptum/constants/colors.dart';
// import 'package:scriptum/constants/typography.dart';
// // import 'package:scriptum/screens/authentication/SignIn_form.dart';

// class SignInScreen extends StatefulWidget {
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final AuthRepository _authRepository = AuthRepository();
//   // SignInBloc _signInBloc;

//   @override
//   void initState() {
//     super.initState();
//     // _SignInBloc = SignInBloc(authRepository: _authRepository);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: backgroundColor,
//         body: BlocProvider(
//           bloc: _SignInBloc,
//           child: Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(top: 24, left: 16),
//             child: Column(
//               children: <Widget>[
//                 h1('Sign In', fontSize: 48),
//                 // SignInForm(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() { 
//     _SignInBloc.dispose();
//     super.dispose();
//   }
// }

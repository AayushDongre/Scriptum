import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriptum/authentication/authBloc/auth_bloc.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/constants/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget drawer(BuildContext context) {
  return Container(
    color: backgroundColor,
    width: MediaQuery.of(context).size.width * 0.75,
    height: MediaQuery.of(context).size.height,
    child: Column(
      children: <Widget>[
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              h1('Scriptum', fontSize: 40),
              Text(
                'an open source notes organizer',
                style: GoogleFonts.poppins().copyWith(color: Colors.white54),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Image.asset(
            'assets/transparentLogo.png',
            height: 125.0,
            width: 122.0,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: button(
                  context,
                  'Logout',
                  onTap: () => context.bloc<AuthBloc>().add(LoggedOut()),
                ),
              ),
              InkWell(
                onTap: () async {
                  const url = 'https://github.com/AayushDongre/Scriptum';
                  // await launch(url);
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/github-icon.png',
                        height: 37,
                        width: 37,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Contribute on Github',
                        style: TextStyle(color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

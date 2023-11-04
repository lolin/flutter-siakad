import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siakad_indra/bloc/qrcode/qrcode_bloc.dart';
import 'package:siakad_indra/bloc/schedule/schedule_bloc.dart';
import 'package:siakad_indra/data/datasources/auth_local_datasources.dart';
import 'package:siakad_indra/pages/auth/auth_page.dart';
import 'package:siakad_indra/pages/mahasiswa/mahasiswa_page.dart';

import 'bloc/khs/khs_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => KhsBloc(),
        ),
        BlocProvider(
          create: (context) => ScheduleBloc(),
        ),
        BlocProvider(
          create: (context) => QrcodeBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Siakad',
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isLogin(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!) {
                return BlocProvider(
                  create: (context) => KhsBloc(),
                  child: const MahasiswaPage(),
                );
              } else {
                return const AuthPage();
              }
              // return const SplashPage();
            }),
      ),
    );
  }
}

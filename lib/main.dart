import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siakad_indra/bloc/qrcode/qrcode_bloc.dart';
import 'package:siakad_indra/bloc/schedule/schedule_bloc.dart';
import 'package:siakad_indra/data/datasources/auth_local_datasources.dart';
import 'package:siakad_indra/pages/auth/auth_page.dart';
import 'package:siakad_indra/pages/mahasiswa/mahasiswa_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'bloc/khs/khs_bloc.dart';

void main() {
  debugPrint('print 1');
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('print 2');

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
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!) {
                debugPrint('print 4');
                FlutterNativeSplash.remove();
                return BlocProvider(
                  create: (context) => KhsBloc(),
                  child: const MahasiswaPage(),
                );
              } else {
                debugPrint('print 3');
                FlutterNativeSplash.remove();
                return const AuthPage();
              }
            }
            return const SizedBox();
            // return const SplashPage();
          },
        ),
      ),
    );
  }
}

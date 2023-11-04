// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siakad_indra/data/datasources/auth_remote_datasources.dart';
part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      emit(const _Loading());
      final response = await AuthRemoteDataSource().logout();
      response.fold(
        (l) => emit(const _Error()),
        (r) => emit(const _Loaded()),
      );
    });
  }
}

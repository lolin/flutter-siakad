// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siakad_indra/data/datasources/schedule_remote_datasource.dart';
import 'package:siakad_indra/data/models/response/schedule_response_mode.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';
part 'schedule_bloc.freezed.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(const _Initial()) {
    on<_GetSchedule>((event, emit) async {
      emit(const _Loading());
      final response = await ScheduleRemoteDataSource().getSchedule();
      response.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r.data)));
    });
  }
}

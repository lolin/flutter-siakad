part of 'schedule_bloc.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState.initial() = _Initial;
  const factory ScheduleState.loading() = _Loading;
  const factory ScheduleState.loaded(List<Schedule> schedule) = _Loaded;
  const factory ScheduleState.error(String message) = _Error;
}

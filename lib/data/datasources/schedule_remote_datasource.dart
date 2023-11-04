import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_indra/data/datasources/auth_local_datasources.dart';
import '../../common/constants/variables.dart';
import '../models/response/schedule_response_mode.dart';

class ScheduleRemoteDataSource {
  Future<Either<String, ScheduleResponseModel>> getSchedule() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${await AuthLocalDatasource().getToken()}',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseURL}/api/schedules'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(ScheduleResponseModel.fromJson(response.body));
    } else {
      return const Left('server error');
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_indra/common/constants/variables.dart';
import 'package:siakad_indra/data/datasources/auth_local_datasources.dart';
import 'package:siakad_indra/data/models/request/auth_request_model.dart';
import 'package:siakad_indra/data/models/response/auth_response_model.dart';

class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> login(
      AuthRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('${Variables.baseURL}/api/login'),
      headers: headers,
      body: requestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('server error');
    }
  }

  Future<Either<String, String>> logout() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await AuthLocalDatasource().getToken()}',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseURL}/api/logout'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return const Right('Logout success');
    } else {
      return const Left('server error');
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_indra/data/datasources/auth_local_datasources.dart';
import 'package:siakad_indra/data/models/response/khs_response_model.dart';
import '../../common/constants/variables.dart';

class KhsRemoteDataSource {
  Future<Either<String, KhsResponseModel>> getKhs() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${await AuthLocalDatasource().getToken()}',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseURL}/api/khs'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(KhsResponseModel.fromJson(response.body));
    } else {
      return const Left('server error');
    }
  }
}

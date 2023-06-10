import 'package:http/http.dart' as http;
import 'package:nano/helper/api_manager.dart';
import 'package:nano/utils/constant.dart';

class HomeApi extends APIManager {
  final http.Client httpClient;

  HomeApi({
    required this.httpClient,
  });

  Future getProducts() async {
    final url = Uri.parse(Constants.GetProducts);
    final response = await getAPICall(url);
    return response;
  }
}

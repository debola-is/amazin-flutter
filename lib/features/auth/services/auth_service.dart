import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        type: '',
        token: '',
        address: '',
        email: email,
      );

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
    } catch (e) {}
  }
}

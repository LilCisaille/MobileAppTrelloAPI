import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:trelltech/arbory/services/auth_service.dart';
import 'package:trelltech/arbory/services/user_info_service.dart';

@GenerateMocks([http.Client, TokenMember, Auth])
void main() {}

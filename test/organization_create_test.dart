// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;
// import 'package:trelltech/arbory/services/user_info_service.dart';
// import 'package:trelltech/arbory/services/organization_service.dart';

// import 'mocks.mocks.dart';

// class MockMember extends Mock implements Member {}

// void main() {
//   group('Organizations', () {
//     test('createOrganization creates an organization correctly', () async {
//       final client = MockClient();
//       final tokenMember = MockTokenMember();
//       final auth = MockAuth();
//       final service = Organizations(tokenMember, auth);

//       // Mock the http.post call
//       when(client.post(any, headers: anyNamed('headers'))).thenAnswer(
//           (_) async =>
//               http.Response('{"id": "1", "name": "Test Organization"}', 200));

//       // Mock the _auth.apiToken getter
//       when(auth.apiToken).thenReturn('valid_api_token');

//       // Create a MockMember and set its id
//       final member = MockMember();
//       when(member.id).thenReturn('valid_member_id');

//       // Mock the _tokenMember.member getter to return the MockMember
//       when(tokenMember.member).thenReturn(member);

//       await service.createOrganization(
//         displayName: 'Test Organization',
//         desc: 'dd',
//         name: 'dd',
//         website: Uri.parse('www.example.com'),
//       );

//       // Verify that the http.post method was called
//       verify(client.post(any, headers: anyNamed('headers'))).called(1);
//     });
//   });
// }

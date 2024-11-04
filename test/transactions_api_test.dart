import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

void main() {
  const String apiUrl =
      'https://6728ccaa6d5fa4901b6af807.mockapi.io/transactions';
  group('API Tests with Mock', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Fetch transactions successfully', () async {
      // Define a mock response for the transactions API
      final mockResponse = [
        {
          "amount": 150.50,
          "date": "2024-10-31T14:48:00.000Z",
          "description": "Freelance Project Payment",
          "type": "Income"
        },
        {
          "amount": 75.75,
          "date": "2024-11-01T09:30:00.000Z",
          "description": "Grocery Shopping",
          "type": "Expense"
        }
      ];

      // Set up the mock client to return the mock response
      when(mockClient.get(Uri.parse(apiUrl))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      // Perform the request using the mock client
      final response = await mockClient.get(Uri.parse(apiUrl));

      // Validate the response
      expect(response.statusCode, 200);
      final data = jsonDecode(response.body);

      // Check that the response is a list and matches the mock data structure
      expect(data, isA<List<dynamic>>());
      expect(data.length, 2);
      expect(data[0]['description'], 'Freelance Project Payment');
      expect(data[1]['description'], 'Grocery Shopping');
    });

    test('Handle API error gracefully', () async {
      // Set up the mock client to return an error response
      when(mockClient.get(Uri.parse(apiUrl)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Perform the request using the mock client
      final response = await mockClient.get(Uri.parse(apiUrl));

      // Validate the error response
      expect(response.statusCode, 404);
      expect(response.body, 'Not Found');
    });
  });
}

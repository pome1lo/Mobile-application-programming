import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';


class MockFirebaseApp extends Mock implements FirebaseApp {}

void main() {

  group('ItemPage Tests', () {
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference<Map<String, dynamic>> mockCollection;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockCollection = MockCollectionReference<Map<String, dynamic>>();

      when(mockFirestore.collection(any)).thenReturn(mockCollection);
    });

    test('Add item to Firestore', () async {
      final itemData = {
        'name': 'Test Item',
        'description': 'Test Description',
        'price': 10.0,
        'rating': 5.0,
        'imageUrl': 'http://example.com/image.png',
      };

      final mockDocRef = MockDocumentReference<Map<String, dynamic>>();

      when(mockCollection.add(any)).thenAnswer((_) async => mockDocRef);

      await mockCollection.add(itemData);

      verify(mockCollection.add(itemData)).called(1);
    });
  });
}

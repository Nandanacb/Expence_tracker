import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteServices {
  late Client client;
  late Databases databases;

  static const endpoint = "https://cloud.appwrite.io/v1";
  static const projectId = "674818e700193479773a";
  static const databaseId = "6748194e0035d0befe67";
  static const collectionId = "6748195d0019bddcf2e9";

  AppwriteServices() {
    client = Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases = Databases(client);
  }

  Future<List<Document>> getExpence() async {
    try {
      final result = await databases.listDocuments(
          databaseId: databaseId, collectionId: collectionId);
      return result.documents;
    } catch (e) {
      print('Error loading notes:$e');
      rethrow;
    }
  }

  Future<Document> addExpence(String Item, String Amount, String Date) async {
    try {
      final documentId = ID.unique();

      final result = await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        data: {
          'Item': Item,
          'Amount': Amount,
          'Date': Date,
        },
        documentId: documentId,
      );
      return result;
    } catch (e) {
      print('Error creating note:$e');
      rethrow;
    }
  }
}

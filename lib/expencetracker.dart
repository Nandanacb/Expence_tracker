import 'package:appwrite/models.dart';

class Expence {
  final String id;
  final String Item;
  final String Amount;
  final String Date;

  Expence(
      {required this.id,
      required this.Item,
      required this.Amount,
      required this.Date});
  factory Expence.fromDocument(Document doc) {
    return Expence(
        id: doc.$id,
        Item: doc.data['Item'],
        Amount: doc.data['Amount'],
        Date: doc.data['Date']);
  }
}

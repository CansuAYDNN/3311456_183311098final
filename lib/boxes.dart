import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');
}
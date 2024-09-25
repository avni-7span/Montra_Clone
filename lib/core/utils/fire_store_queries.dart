import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';

class FireStoreQueries {
  /// singleton
  static final FireStoreQueries instance = FireStoreQueries._internal();
  factory FireStoreQueries() => instance;
  FireStoreQueries._internal();

  final db = FirebaseFirestore.instance;
  final currentUserId = AuthenticationRepository.instance.currentUser?.uid;

  /// Converts epoch(milliseconds) into date
  String getFormatedDate(int epoch) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  /// Converts DateTime into epoch(milliseconds)
  int _getEpochFromDateTime(DateTime date) {
    return date.millisecondsSinceEpoch;
  }

  Future<CollectionReference<Map<String, dynamic>>>
      getCollectionReference() async {
    return db.collection('users').doc(currentUserId).collection('transaction');
  }

  /// Get documents created today
  Future<
      (
        List<QueryDocumentSnapshot<Map<String, dynamic>>>,
        List<QueryDocumentSnapshot<Map<String, dynamic>>>
      )> getTodayData() async {
    final now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day); // 12 am
    DateTime endOfToday = startOfToday.add(const Duration(days: 1));
    final reference = await getCollectionReference();
    final querySnapshotOne = await reference
        .where('createdAt',
            isGreaterThanOrEqualTo: _getEpochFromDateTime(startOfToday))
        .get();
    final querySnapshotTwo = await reference
        .where('createdAt', isLessThan: _getEpochFromDateTime(endOfToday))
        .get();
    return (querySnapshotOne.docs, querySnapshotTwo.docs);
  }

  /// Get documents created this week
  /// now.weekday returns integer as per day (1,2,...)
  /// subtract is to get to monday by subtracting 1 from integers got ( span of in between days)
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getThisWeekData() async {
    final now = DateTime.now();
    final startOfWeek =
        now.subtract(Duration(days: now.weekday - 1)); // gives monday
    // final startOfWeek = now.subtract(
    //     Duration(days: now.weekday == 7 ? 6 : now.weekday - 1)); // gives monday
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    final collectionReference = await getCollectionReference();
    final querySnapshot = await collectionReference
        .where('createdAt',
            isGreaterThanOrEqualTo: _getEpochFromDateTime(startOfWeek))
        .where('createdAt', isLessThan: _getEpochFromDateTime(endOfWeek))
        .get();
    return querySnapshot.docs;
  }

  /// Get documents created this month
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getThisMonthData() async {
    final now = DateTime.now();
    final startOfMonth =
        DateTime(now.year, now.month, 1); // 1 : day 1 (first day)
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1).subtract(
      const Duration(seconds: 1),
    );
    final collectionReference = await getCollectionReference();
    final querySnapshot = await collectionReference
        .where('createdAt',
            isGreaterThanOrEqualTo: _getEpochFromDateTime(startOfMonth))
        .where('createdAt', isLessThan: _getEpochFromDateTime(endOfMonth))
        .get();
    return querySnapshot.docs;
  }

  /// Get documents created this month
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getThisYearData() async {
    DateTime now = DateTime.now();
    DateTime startOfYear =
        DateTime(now.year, 1, 1); // month 1 - jan , day 1- date 1
    DateTime endOfYear =
        DateTime(now.year + 1, 1, 1).subtract(const Duration(seconds: 1));
    final collectionReference = await getCollectionReference();
    final querySnapshot = await collectionReference
        .where('createdAt',
            isGreaterThanOrEqualTo: _getEpochFromDateTime(startOfYear))
        .where('createdAt', isLessThan: _getEpochFromDateTime(endOfYear))
        .get();
    return querySnapshot.docs;
  }
}
//
// import 'dart:convert';
//
// import 'package:drift/drift.dart';
//
// import '../../home/data/model/news_response.dart';
//
// class SourceConverter extends TypeConverter<Source, String> {
//   const SourceConverter();
//
//   @override
//   Source fromSql(String fromDb) {
//     return Source.fromJson(jsonDecode(fromDb));
//   }
//
//   @override
//   String toSql(Source value) {
//     return jsonEncode(value.toJson());
//   }
// }
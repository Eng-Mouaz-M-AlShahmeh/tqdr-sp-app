// /* Developed by: Eng Mouaz M. Al-Shahmeh */
// import 'package:localstore/localstore.dart';
//
// class Login {
//   final String id;
//   bool isLogged;
//   Login({
//     required this.id,
//     required this.isLogged,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'isLogged': isLogged,
//     };
//   }
//
//   factory Login.fromMap(Map<String, dynamic> map) {
//     return Login(
//       id: map['id'],
//       isLogged: map['isLogged'],
//     );
//   }
// }
//
// extension ExtLogin on Login {
//   Future save() async {
//     final _db = Localstore.instance;
//     return _db.collection('login').doc(id).set(toMap());
//   }
//
//   Future delete() async {
//     final _db = Localstore.instance;
//     return _db.collection('login').doc(id).delete();
//   }
// }
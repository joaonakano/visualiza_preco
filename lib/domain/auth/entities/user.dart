import '../value_objects/email.dart';

/// Entidade User do domínio
class User {
  final String id;
  final Email email;
  final String? displayName;

  const User({required this.id, required this.email, this.displayName});

  User copyWith({String? id, Email? email, String? displayName}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
    );
  }

  @override
  String toString() =>
      'User(id: $id, email: ${email.value}, displayName: $displayName)';
}

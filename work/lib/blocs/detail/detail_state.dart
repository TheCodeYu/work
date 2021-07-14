part of 'detail_bloc.dart';

/// 个人用户信息
/// flutter packages pub run json_model
/// flutter packages pub run build_runner build
class DetailState extends Equatable {
  final String? token;

  final String name;

  final String avatar;

  final List roles;

  final List permissions;

  DetailState({
    this.token,
    this.name = '',
    this.avatar = '',
    this.roles = const [],
    this.permissions = const [],
  });

  @override
  List<Object?> get props => [token, name, avatar, roles, permissions];

  DetailState copyWith(
          {String? token,
          String? name,
          String? avatar,
          List? roles,
          List? permissions}) =>
      DetailState(
          token: token ?? this.token,
          name: name ?? this.name,
          avatar: avatar ?? this.avatar,
          roles: roles ?? this.roles,
          permissions: permissions ?? this.permissions);
  @override
  String toString() {
    return 'GlobalState{token:$token, name:$name, avatar:$avatar, roles:$roles, permissions:$permissions}';
  }
}

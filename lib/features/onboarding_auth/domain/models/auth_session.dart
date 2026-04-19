/// Signed-in user snapshot (mock / future API).
class AuthSession {
  const AuthSession({required this.userId, required this.displayName});

  final String userId;
  final String displayName;
}

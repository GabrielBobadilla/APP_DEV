import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isInitialized = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isInitialized => _isInitialized;
  bool get isAdmin => _currentUser?.role == UserRole.admin;
  bool get isTrainor => _currentUser?.role == UserRole.trainor;
  bool get isPresident => _currentUser?.role == UserRole.president;

  static const _prefsKey = 'saved_username';

  final List<User> _mockUsers = const [
    User(id: '1', username: 'admin', password: 'admin123', name: 'System Admin', role: UserRole.admin),
    User(id: '2', username: 'trainor_diw', password: 'trainor123', name: 'Maria Santos', role: UserRole.trainor, rpagId: 'rpag_1'),
    User(id: '3', username: 'trainor_indak', password: 'trainor123', name: 'Juan Dela Cruz', role: UserRole.trainor, rpagId: 'rpag_2'),
    User(id: '4', username: 'trainor_adlib', password: 'trainor123', name: 'Ana Gonzales', role: UserRole.trainor, rpagId: 'rpag_3'),
    User(id: '5', username: 'trainor_dulaang', password: 'trainor123', name: 'Pedro Reyes', role: UserRole.trainor, rpagId: 'rpag_4'),
    User(id: '6', username: 'trainor_sikha', password: 'trainor123', name: 'Lisa Mercado', role: UserRole.trainor, rpagId: 'rpag_5'),
    User(id: '7', username: 'pres_diw', password: 'pres123', name: 'Carlos Yabut', role: UserRole.president, rpagId: 'rpag_1'),
    User(id: '8', username: 'pres_indak', password: 'pres123', name: 'Bella Torres', role: UserRole.president, rpagId: 'rpag_2'),
    User(id: '9', username: 'pres_adlib', password: 'pres123', name: 'Rico Manalo', role: UserRole.president, rpagId: 'rpag_3'),
    User(id: '10', username: 'pres_dulaang', password: 'pres123', name: 'Sofia Villanueva', role: UserRole.president, rpagId: 'rpag_4'),
    User(id: '11', username: 'pres_sikha', password: 'pres123', name: 'Dante Lopez', role: UserRole.president, rpagId: 'rpag_5'),
  ];

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString(_prefsKey);

    if (savedUsername != null) {
      final user = _mockUsers.firstWhere(
        (u) => u.username == savedUsername,
        orElse: () => const User(id: '', username: '', password: '', name: '', role: UserRole.admin),
      );
      if (user.id.isNotEmpty) {
        _currentUser = user;
        _isLoggedIn = true;
      }
    }
    _isInitialized = true;
    notifyListeners();
  }

  bool login(String username, String password, {bool rememberMe = true}) {
    final user = _mockUsers.firstWhere(
      (u) => u.username == username && u.password == password,
      orElse: () => const User(
        id: '', username: '', password: '', name: '', role: UserRole.admin,
      ),
    );

    if (user.id.isNotEmpty) {
      _currentUser = user;
      _isLoggedIn = true;
      if (rememberMe) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString(_prefsKey, username);
        });
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(_prefsKey);
    });
    notifyListeners();
  }

  List<String> getAccessibleRpagIds() {
    if (_currentUser == null) return [];
    if (_currentUser!.role == UserRole.admin) {
      return ['rpag_1', 'rpag_2', 'rpag_3', 'rpag_4', 'rpag_5'];
    }
    if (_currentUser!.rpagId != null) {
      return [_currentUser!.rpagId!];
    }
    return [];
  }
}

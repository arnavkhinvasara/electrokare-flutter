import 'dart:convert';
import 'package:crypto/crypto.dart';

// Utility class for password-related operations
class PasswordUtils {
  // Encrypts a password using SHA-256 hashing
  // This is a one-way hash function
  static String encryptPassword(String password) {
    // Convert the password to bytes
    final bytes = utf8.encode(password);

    // Hash the bytes using SHA-256
    final digest = sha256.convert(bytes);

    // Return the hash as a hex string
    return digest.toString();
  }

  // Verifies a password against a stored hash
  // Returns true if the password matches the hash
  static bool verifyPassword(String password, String storedHash) {
    final hash = encryptPassword(password);
    return hash == storedHash;
  }
}

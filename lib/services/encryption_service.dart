// ===== SERVICES =====
// lib/services/encryption_service.dart
/*
import 'package:cryptography/cryptography.dart';
import 'dart:convert';

class EncryptionService {
  static final _algorithm = Chacha20.poly1305Aead();

  static Future<SecretKey> generateKey() async {
    return await _algorithm.newSecretKey();
  }

  static Future<String> encryptMessage(
      String message,
      SecretKey key,
      ) async {
    final nonce = _algorithm.newNonce();
    final encrypted = await _algorithm.encrypt(
      utf8.encode(message),
      secretKey: key,
      nonce: nonce,
    );

    final combined = nonce.bytes + encrypted.cipherText + encrypted.mac.bytes;
    return base64.encode(combined);
  }

  static Future<String> decryptMessage(
      String encryptedMessage,
      SecretKey key,
      ) async {
    try {
      final combined = base64.decode(encryptedMessage);
      final nonce = combined.sublist(0, 12);
      final ciphertext = combined.sublist(12, combined.length - 16);
      final mac = combined.sublist(combined.length - 16);

      final decrypted = await _algorithm.decrypt(
        AeadDecryptionResult(
          cipherText: ciphertext,
          mac: Mac(mac),
        ),
        secretKey: key,
        nonce: List<int>.from(nonce),
      );

      return utf8.decode(decrypted);
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }
}*/

import 'package:cryptography/cryptography.dart';
import 'dart:convert';

class EncryptionService {
  static final _algorithm = Chacha20.poly1305Aead();

  static Future<SecretKey> generateKey() async {
    return await _algorithm.newSecretKey();
  }

  static Future<String> encryptMessage(
      String message,
      SecretKey key,
      ) async {
    final nonce = _algorithm.newNonce();
    final secretBox = await _algorithm.encrypt(
      utf8.encode(message),
      secretKey: key,
      nonce: nonce,
    );

    final combined = nonce + secretBox.cipherText + secretBox.mac.bytes;
    return base64.encode(combined);
  }

  static Future<String> decryptMessage(
      String encryptedMessage,
      SecretKey key,
      ) async {
    try {
      final combined = base64.decode(encryptedMessage);
      final nonceLength = _algorithm.nonceLength;
      final macLength = _algorithm.macAlgorithm.macLength;

      final nonce = combined.sublist(0, nonceLength);
      final ciphertext = combined.sublist(nonceLength, combined.length - macLength);
      final mac = combined.sublist(combined.length - macLength);

      final secretBox = SecretBox(
        ciphertext,
        nonce: nonce,
        mac: Mac(mac),
      );

      final decrypted = await _algorithm.decrypt(
        secretBox,
        secretKey: key,
      );

      return utf8.decode(decrypted);
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import '../../core/api_const.dart';
import 'dart:developer' as dev;

class DataEncryption {
  static String encodeKeyWith(String key) {
    dev.log(key);
    for (int i = 0; i < 32; i++) {
      if (i > 7 && i < 16) {
        var asciiCode = key.codeUnitAt(i);

        if (asciiCode < 68) {
          asciiCode += 23;
        } else if (asciiCode < 100 && asciiCode > 96) {
          asciiCode += 23;
        } else {
          asciiCode -= 3;
        }
        key = replaceCharAt(key, i, String.fromCharCode(asciiCode));
      } else if (i > 23 && i < 32) {
        var asciiCode = key.codeUnitAt(i);

        if (asciiCode < 68) {
          asciiCode += 23;
        } else if (asciiCode < 100 && asciiCode > 96) {
          asciiCode += 23;
        } else {
          asciiCode -= 3;
        }
        key = replaceCharAt(key, i, String.fromCharCode(asciiCode));
      } else {
        continue;
      }
    }

    return key;
  }

  static String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  // generates random string  len 32
  static String generateKey() {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        32, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  //encode generated key
  static String encodeKey(String str, int k) {
    var encodedString = "";
    var encodedString2 = "";
    var nothingEncoded = "";
    var nothingEncoded2 = "";

    for (int i = 0; i < 8; i++) {
      // var char = str[i];
      var charCode = str.codeUnitAt(i);
      var newChar2 = String.fromCharCode(charCode);
      nothingEncoded += newChar2;
    }

    for (int i = 8; i < 16; i++) {
      // var char = str[i];
      var charCode = str.codeUnitAt(i);
      var newCharCode = charCode + k;
      var newChar = String.fromCharCode(newCharCode);

      //if k-th character exceeds 'Z'
      if (newCharCode > 122) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString += newChar2;
      }
      //if k-th character exceeds 'Z'
      else if (newCharCode > 90 && newCharCode < 97) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString += newChar2;
      } else if (newCharCode < 65) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString += newChar2;
      } else {
        encodedString += newChar;
      }
    }

    for (int i = 16; i < 24; i++) {
      // var char = str[i];
      var charCode = str.codeUnitAt(i);
      var newChar2 = String.fromCharCode(charCode);
      nothingEncoded2 += newChar2;
    }

    for (int i = 24; i < str.length; i++) {
      // val char = str[i];
      var charCode = str.codeUnitAt(i);
      var newCharCode = charCode + k;
      var newChar = String.fromCharCode(newCharCode);

      //if k-th character exceeds 'Z'
      if (newCharCode > 122) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString2 += newChar2;
      }
      //if k-th character exceeds 'Z'
      else if (newCharCode > 90 && newCharCode < 97) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString2 += newChar2;
      } else if (newCharCode < 65) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString2 += newChar2;
      } else {
        encodedString2 += newChar;
      }
    }

    // print(
    //     "converted key: ${nothingEncoded + encodedString + nothingEncoded2 + encodedString2}");
    return nothingEncoded + encodedString + nothingEncoded2 + encodedString2;
  }

  //Encrypt source data
  static String encryptWithAES(String strToEncrypt, String secretKey) {
    final encrypter = Encrypter(
        AES(Key.fromUtf8(secretKey), mode: AESMode.ecb, padding: "PKCS7"));

    final encrypted = encrypter.encrypt(strToEncrypt, iv: IV.fromUtf8(""));

    // print('encryptedData ${encrypted.base64}');

    return encrypted.base64;
  }

  //decode generated key
  static String decodeKey(String str, int k) {
    var encodedString = "";
    var encodedString2 = "";
    var nothingencoded = "";
    var nothingencoded2 = "";

    for (int i = 0; i < 8; i++) {
      // val char = str[i]
      var charCode = str.codeUnitAt(i);
      var newChar2 = String.fromCharCode(charCode);
      nothingencoded += newChar2;
    }

    for (int i = 8; i < 16; i++) {
      // val char = str[i]
      var charCode = str.codeUnitAt(i);
      var newCharCode = charCode + k;
      var newChar = String.fromCharCode(newCharCode);

      //if k-th character exceeds 'Z'
      if (newCharCode > 122) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString += newChar2;
      }
      //if k-th character exceeds 'Z'
      else if (newCharCode > 90 && newCharCode < 97) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString += newChar2;
      } else if (newCharCode < 65) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString += newChar2;
      } else {
        encodedString += newChar;
      }
    }

    for (int i = 16; i < 24; i++) {
      // val char = str[i]
      var charCode = str.codeUnitAt(i);
      var newChar2 = String.fromCharCode(charCode);
      nothingencoded2 += newChar2;
    }

    for (int i = 24; i < str.length; i++) {
      // val char = str[i]
      var charCode = str.codeUnitAt(i);
      var newCharCode = charCode + k;
      var newChar = String.fromCharCode(newCharCode);

      //if k-th character exceeds 'Z'
      if (newCharCode > 122) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString2 += newChar2;
      }
      //if k-th character exceeds 'Z'
      else if (newCharCode > 90 && newCharCode < 97) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString2 += newChar2;
      } else if (newCharCode < 65) {
        var newCharCode2 = newCharCode + 26;
        var newChar2 = String.fromCharCode(newCharCode2);
        encodedString2 += newChar2;
      } else {
        encodedString2 += newChar;
      }
    }
    // print(
    //     "decodedkey: ${nothingencoded + encodedString + nothingencoded2 + encodedString2}");
    return nothingencoded + encodedString + nothingencoded2 + encodedString2;
  }

  //Decrypt received data
  static String? decryptWithAES(String key, String? strToDecrypt) {
    // var iv = getRandString(16);
    // print('strToDecrypt: $strToDecrypt');
    final decodedKey = decodeKey(key, -3);

    // print('encodedKey: $decodedKey');

    final encrypter = encrypt.Encrypter(
        AES(Key.fromUtf8(decodedKey), mode: AESMode.ecb, padding: "PKCS7"));

    final decrypted = encrypter.decrypt(Encrypted.fromBase64(strToDecrypt!),
        iv: IV.fromUtf8(""));

    dev.log("Decrypted Data: $decrypted");

    return decrypted;
  }

  static Map<String, dynamic> getEncryptedData(
      Map<String, dynamic> jsonObject) {
    var generateKey = DataEncryption.generateKey().toString();

    // print('original $generateKey');

    var encodedReqKey = DataEncryption.encodeKey(generateKey, -3).toString();

    dev.log("mainJsonObject: ${jsonEncode(jsonObject)}");

    var encryptedData =
        DataEncryption.encryptWithAES(json.encode(jsonObject), generateKey);

    Map<String, dynamic> encryptedJsonObject = {
      "env_type": ApiEndPoints.envType,
      "reqdata": encryptedData,
      "reqkey": encodedReqKey
    };

    dev.log("encryptedJsonObject: ${jsonEncode(encryptedJsonObject)}");

    return encryptedJsonObject;
  }

  static Map<String, dynamic> getDecryptedData(String resKey, String resData) {
    // var decodeKey = DataEncryption.decodeKey(resKey, -3);

    //decrypt data
    var decryptData = DataEncryption.decryptWithAES(resKey, resData);

    // print("ResData : $resData");
    // print("ResKey : $resKey");
    // print("type : ${jsonDecode(decryptData!).runtimeType}");

    Map<String, dynamic> map = jsonDecode(decryptData!);

    return map;
  }
}

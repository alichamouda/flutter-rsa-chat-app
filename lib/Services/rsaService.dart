import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import "package:x509csr/x509csr.dart";
import "package:pointycastle/export.dart";

class RSASpecialService {
  RSASpecialService._privateConstructor();
  static final RSASpecialService  instance = RSASpecialService._privateConstructor();

  static SecureRandom getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(new KeyParameter(new Uint8List.fromList(seeds)));
    return secureRandom;
  }

  static AsymmetricKeyPair<PublicKey, PrivateKey> getRsaKeyPair(
      SecureRandom secureRandom) {
    var rsapars = new RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);
    var params = new ParametersWithRandom(rsapars, secureRandom);
    var keyGenerator = new RSAKeyGenerator();
    keyGenerator.init(params);
    return keyGenerator.generateKeyPair();
  }

  Future<AsymmetricKeyPair<PublicKey, PrivateKey>> computeRSAKeyPair(
      SecureRandom secureRandom) async {
    return await compute(getRsaKeyPair, secureRandom);
  }

  decryptString(keyPair,cipherText){
    print(cipherText.runtimeType);
    AsymmetricKeyParameter<RSAPublicKey> keyParametersPublic = new PublicKeyParameter(keyPair.publicKey);
    var cipher = new RSAEngine()..init(true, keyParametersPublic);

    AsymmetricKeyParameter<RSAPrivateKey> keyParametersPrivate = new PrivateKeyParameter(keyPair.privateKey);

    cipher.init( false, keyParametersPrivate );
    return cipher.process(cipherText);
  }

  encryptString(keyPair,message) {
    AsymmetricKeyParameter<RSAPublicKey> keyParametersPublic = new PublicKeyParameter(keyPair.publicKey);
    var cipher = new RSAEngine()..init(true, keyParametersPublic);
    var cipherText = cipher.process(new Uint8List.fromList(message.codeUnits));
    return cipherText;
  }
  static decryptStringPem(publicKeyStr,privateKeyStr,cipherText){
    AsymmetricKeyParameter<RSAPublicKey> keyParametersPublic = new PublicKeyParameter(decodeRSAPublicKeyFromPEM(publicKeyStr));
    var cipher = new RSAEngine()..init(true, keyParametersPublic);
    AsymmetricKeyParameter<RSAPrivateKey> keyParametersPrivate = new PrivateKeyParameter(decodeRSAPrivateKeyFromPEM(privateKeyStr));
    cipher.init( false, keyParametersPrivate );
    return cipher.process(cipherText);
  }
  
  static encryptStringPem(publicKeyStr,message) {
    AsymmetricKeyParameter<RSAPublicKey> keyParametersPublic = new PublicKeyParameter(decodeRSAPublicKeyFromPEM(publicKeyStr));
    var cipher = new RSAEngine()..init(true, keyParametersPublic);
    var cipherText = cipher.process(new Uint8List.fromList(message.codeUnits));
    return cipherText;
  }

  static  cipherToString(cipher) {
    return new String.fromCharCodes(cipher);
  }

  test() {
    computeRSAKeyPair(getSecureRandom()).then( (keyPair) {
      print('Keyss');
      print(new RsaKeyHelper().encodePublicKeyToPemPKCS1(keyPair.publicKey));
      print(new RsaKeyHelper().encodePrivateKeyToPemPKCS1(keyPair.privateKey));
      print(cipherToString(decryptString(keyPair, encryptString(keyPair, 'hamza'))));


//      ASN1ObjectIdentifier.registerFrequentNames();
//      Map<String, String> dn = {
//        "CN": "www.davidjanes.com",
//        "O": "Consensas",
//        "L": "Toronto",
//        "ST": "Ontario",
//        "C": "CA",
//      };

//      ASN1Object encodedCSR = makeRSACSR(dn, keyPair.privateKey, keyPair.publicKey);

//      print(encodeCSRToPem(encodedCSR));
//      print(encodeRSAPublicKeyToPem(keyPair.publicKey));
//      print(encodeRSAPrivateKeyToPem(keyPair.privateKey));
    }
    );

  }

}
library my_prj.globals;

import 'package:cryptography/cryptography.dart';

final cipher = chacha20Poly1305Aead;

final secretKey = SecretKey.randomBytes(32);

final nonce = Nonce.randomBytes(12);

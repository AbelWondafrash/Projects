import javax.crypto.*;
import javax.crypto.interfaces.*;
import javax.crypto.spec.*;
import org.bouncycastle.asn1.*;
import org.bouncycastle.asn1.pkcs.*;
import org.bouncycastle.asn1.x509.*;
import Decoder.*;

Blowfish blowfish;

void setup () {
  blowfish = new Blowfish ();
  try {
    println(blowfish.encrypt("Processing", "Key here"));
    println(blowfish.decrypt("ERt09vPI6ADGmveJj+xIfg==", "Key here"));
  }
  catch (Exception e) {
    println(e);
  }

  exit();
}

class Blowfish {

  String encrypt (String raw, String key_) throws Exception {
    byte[] keyData = (key_).getBytes();
    SecretKeySpec secretKeySpec = new SecretKeySpec(keyData, "Blowfish");
    Cipher cipher = Cipher.getInstance("Blowfish");
    cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);
    byte[] hasil = cipher.doFinal(raw.getBytes());
    return new BASE64Encoder().encode(hasil);
  }

  String decrypt (String string, String key_) throws Exception {
    byte[] keyData = (key_).getBytes();
    SecretKeySpec secretKeySpec = new SecretKeySpec(keyData, "Blowfish");
    Cipher cipher = Cipher.getInstance("Blowfish");
    cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);
    byte[] hasil = cipher.doFinal(new BASE64Decoder().decodeBuffer(string));
    return new String(hasil);
  }
}

package model;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtils {

    public static String hashPassword(String passwordInChiaro) {
        try {
            //chiediamo a Java l'algoritmo SHA-256 richiesto per la sicurezza
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            
            //convertiamo la stringa in un array di byte e calcoliamo l'impronta (hash)
            byte[] hashBytes = digest.digest(passwordInChiaro.getBytes(StandardCharsets.UTF_8));
            
            //ora dobbiamo convertire l'array di byte in una stringa Esadecimale 
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                //operazione bitwise per convertire il singolo byte in esadecimale
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0'); // formattazione a due cifre
                }
                hexString.append(hex);
            }
            
            //ritorniamo l'hash definitivo
            return hexString.toString();
            
        } catch (NoSuchAlgorithmException e) {
            //questo errore si verifica solo se l'ambiente Java non supporta lo SHA-256 (impossibile sui sistemi moderni)
            throw new RuntimeException("Errore critico: Algoritmo SHA-256 non supportato.", e);
        }
    }
}
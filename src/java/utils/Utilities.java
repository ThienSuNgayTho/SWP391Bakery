/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.Serializable;
import java.text.Normalizer;
import java.util.regex.Pattern;

/**
 *
 * @author RiceShower
 */
public class Utilities implements Serializable{
    public static String encryptPassword(String password) {
        /*Code Here*/
        return password;
    }
    public static String unAccent(String s) {
//        String temp = Normalizer.normalize(s, Normalizer.Form.NFD);
//        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
//        return pattern.matcher(temp).replaceAll("");
            return s;
    }
}

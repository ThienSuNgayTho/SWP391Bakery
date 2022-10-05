/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Dang Minh Quan
 */
public class DbConnect implements Serializable{
    private String dbName = "BakeryShop";
    private String username = "sa";
    private String password = "123456";
    
    public Connection makeConnection(){
        Connection connector ;
        try {
            // JDBC type 4 : native protocol
            // 
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Tạo đối tượng connector 
            String url = "jdbc:sqlserver://localhost:1433;databaseName = " + dbName;
            connector = DriverManager.getConnection(url,username,password);
            return connector;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
    
//    public static Connection makeConnection()
//        throws NamingException, SQLException{
//        
//        Context currentContext = new InitialContext();
//        Context tomcatContext = (Context)currentContext.lookup("java:comp/env");
//        DataSource ds = (DataSource)tomcatContext.lookup("OS001"); 
//        Connection con = ds.getConnection();
//        
//        return con; 
//    }
}

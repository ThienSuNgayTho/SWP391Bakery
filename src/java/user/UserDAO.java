/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import role.RoleDTO;
import utils.DbConnect;

public class UserDAO implements Serializable {
    //Login Function
/*----------------------------------------------------------------------------*/
    public UserDTO checkLogin(String email, String password)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String encryptPassword = utils.Utilities.encryptPassword(password);
        //                      encrypt password
        try {
            //1. Make Connection
            con = new DbConnect().makeConnection();
            //2. Create Connection String
            if (con != null) {
                String sql = "SELECT Email, Password, AvatarLink, Address, FullName, PhoneNumber, Gender, CreationDate,  Status, [User].RoleId, [Role].Name "
                        + "FROM [User] FULL JOIN [Role] ON [User].RoleId = [Role].RoleId "
                        + "WHERE Email = ? AND Password = ? AND Status = ?";
                //3. Create Statement and assign Parameters if any
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, encryptPassword);
                stm.setBoolean(3, true);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process ResultSet
                if (rs.next()) {
                    String avatarLink = rs.getString("AvatarLink");
                    String address = rs.getString("Address");
                    String fullname = rs.getString("FullName");
                    String phoneNumber = rs.getString("PhoneNumber");
                    String gender = rs.getString("Gender");
                    Date date = rs.getDate("CreationDate");
                    boolean status = rs.getBoolean("Status");
                    int roleId = rs.getInt("RoleId");
                    String roleName = rs.getString("Name");
                    RoleDTO roleDto = new RoleDTO(roleId, roleName);
                    UserDTO dto = new UserDTO(email, password, avatarLink, address, fullname, phoneNumber, gender, date, status, roleDto);
                    return dto;
                }
            } // end if cant connect
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }
    
    //Test function
    public List<UserDTO> getAllUser(int index) throws NamingException, SQLException {
        List<UserDTO> list = new ArrayList<>();
        String query = "SELECT Email, Password, AvatarLink, Address, FullName, PhoneNumber, Gender, CreationDate,  Status, [User].RoleId, [Role].Name "
                        + "FROM [User] FULL JOIN [Role] ON [User].RoleId = [Role].RoleId "
                + "order by [User].RoleId \n"
                + "offset ? rows \n"
                + "fetch first 10 rows only";
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = new DbConnect().makeConnection();
            if (con != null) {
                stm = con.prepareStatement(query);
                stm.setInt(1, (index - 1) * 10);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String email = rs.getString("Email");
                    String password = rs.getString("Password");
                    String avatarLink = rs.getString("AvatarLink");
                    String address = rs.getString("Address");
                    String fullname = rs.getString("FullName");
                    String phoneNumber = rs.getString("PhoneNumber");
                    String gender = rs.getString("Gender");
                    Date date = rs.getDate("CreationDate");
                    boolean status = rs.getBoolean("Status");
                    int roleId = rs.getInt("RoleId");
                    String roleName = rs.getString("Name");
                    RoleDTO roleDto = new RoleDTO(roleId, roleName);
                    UserDTO dto = new UserDTO(email, password, avatarLink, address, fullname, phoneNumber, gender, date, status, roleDto);
                    list.add(dto);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }

    //Get max page by 10 user
    public int getMaxPagesBy10()
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();
            if (con != null) {
                String sql = "select count(*) from [User]";

                stm = con.prepareStatement(sql);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int total = rs.getInt(1);
                    int countPage = 0;
                    countPage = total / 10;
                    if (total % 10 != 0) {
                        countPage++;
                    }
                    return countPage;
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (stm != null) {
                stm.close();
            }

            if (con != null) {
                con.close();
            }
        }

        return 0;
    }

//    //used for flitering the user list using inputed keys
//    public List<UserDTO> getUsersWithFilter(String[] keys) {
//        List<UserDTO> list = new ArrayList<>();
//        int count = 0;
//        Connection con = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        String query = "SELECT * FROM User WHERE\n";
//        //this is fucking retarded.
//        //used to define the query based on the keys
//        for (String key : keys) {
//            if (count != 0) {
//                //second key and so on
//                query += "AND(";
//                query += "[Email] LIKE '%" + key + "%' OR\n";
//                query += "[Address] LIKE '%" + key + "%' OR\n";
//                query += "[FullName] LIKE '%" + key + "%' OR\n";
//                query += "[PhoneNumber] LIKE '%" + key + "%' OR\n";
//                query += "[Gender] LIKE '%" + key + "%' \n";
//                query += ")";
//                count++;
//            } else //first key
//            {
//                query += "(";
//                query += "[Email] LIKE '%" + key + "%' OR\n";
//                query += "[Address] LIKE '%" + key + "%' OR\n";
//                query += "[FullName] LIKE '%" + key + "%' OR\n";
//                query += "[PhoneNumber] LIKE '%" + key + "%' OR\n";
//                query += "[Gender] LIKE '%" + key + "%'\n";
//                query += ")";
//                count++;
//            }
//        }
//        try {
//            con = new DbConnect().makeConnection();
//            stm = con.prepareStatement(query);
//            //execute query and hope for the best
//            rs = stm.executeQuery();
//            while (rs.next()) {
//                UserDTO u = new UserDTO(
//                        rs.getString(1),
//                        rs.getString(2),
//                        rs.getString(3),
//                        rs.getString(4),
//                        rs.getString(5),
//                        rs.getString(6),
//                        rs.getString(7),
//                        rs.getDate(8),
//                        rs.getBoolean(9),
//                        rs.getInt(10));
//                list.add(u);
//            }
//            return list;
//
//        } catch (Exception e) {
//        }
//        return null;
//    }

//    public boolean getUserExistency(String email) {
//        String query = "select * from [user]\n"
//                + "where [email]= ?\n";
//        userDTO u;
//        try {
//            conn = new dBContext().getConnection();
//            ps = conn.prepareStatement(query);
//            ps.setString(1, email);
//
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                u = new userDTO(
//                        rs.getString(1),
//                        rs.getString(2),
//                        rs.getString(3),
//                        rs.getString(4),
//                        rs.getString(5),
//                        rs.getString(6),
//                        rs.getString(7),
//                        rs.getDate(8),
//                        rs.getInt(9),
//                        rs.getInt(10));
//
//                if (u != null) {
//                    return true;
//                }
//            }
//        } catch (Exception e) {
//        }
//        return false;
//    }
    
    public Date getCurrentDate() {
        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);

        return date;
    }

//    public void signUp(String email, String password, String address, String fullName, String phoneNumber) throws NoSuchAlgorithmException {
//        // String email, String passwor, String address, String fullName, String phoneNumber
//        String encryptedPass = encryptPassword(password);
//        userDAO dao = new userDAO();
//        String query = "insert into [user]\n"
//                + "values (?, ?, NULL, ?, ?, ?, NULL, ? , 1, 0);";
//        try {
//            conn = new dBContext().getConnection();
//            ps = conn.prepareStatement(query);
//            ps.setString(1, email);
//            ps.setString(2, encryptedPass);
//            ps.setString(3, address);
//            ps.setString(4, fullName);
//            ps.setString(5, phoneNumber);
//            ps.setDate(6, dao.getCurrentDate());
//            rs = ps.executeQuery();
//
//        } catch (Exception e) {
//        }
//
//    }
    
    public UserDTO getUserByEmail(String email) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "SELECT Email, Password, AvatarLink, Address, FullName, PhoneNumber, Gender, CreationDate,  Status, [User].RoleId, [Role].Name "
                        + "FROM [User] FULL JOIN [Role] ON [User].RoleId = [Role].RoleId "
                + "where Email= ? \n";
        try {
            con = new DbConnect().makeConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, email);

            rs = stm.executeQuery();
            while (rs.next()) {
                    String password = rs.getString("Password");
                    String avatarLink = rs.getString("AvatarLink");
                    String address = rs.getString("Address");
                    String fullname = rs.getString("FullName");
                    String phoneNumber = rs.getString("PhoneNumber");
                    String gender = rs.getString("Gender");
                    Date date = rs.getDate("CreationDate");
                    boolean status = rs.getBoolean("Status");
                    int roleId = rs.getInt("RoleId");
                    String roleName = rs.getString("Name");
                    RoleDTO roleDto = new RoleDTO(roleId, roleName);
                    UserDTO dto = new UserDTO(email, password, avatarLink, address, fullname, phoneNumber, gender, date, status, roleDto);

                return dto;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean updateAccountInfo(String address, String password, String fullName, String phoneNumber,
            String gender, boolean status, int roleId, String email)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String

                String sql = "UPDATE [User] "
                        + "SET Address = ?, Password = ?, FullName = ?, PhoneNumber = ?, Gender = ?, Status = ?, RoleId = ? "
                        + "Where Email = ?";
                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setString(1, address);
                stm.setString(2, password);
                stm.setString(3, fullName);
                stm.setString(4, phoneNumber);
                stm.setString(5, gender);
                stm.setBoolean(6, status);
                stm.setInt(7, roleId);
                stm.setString(8, email);
                //4. Execute Query             
                int row = stm.executeUpdate(); //Insert, Delete, Update deu la Update
                //5. Process rs
                if (row > 0) {
                    return true;
                }

            }//end if con is connected
        } finally {
            if (stm != null) {
                stm.close();
            }

            if (con != null) {
                con.close();
            }
        }

        return false;
    }

    public boolean addNewAccount(String email, String password, String address, String fullName, String phoneNumber,
            String gender, Date CreationDate, boolean status, int roleId)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String

                String sql = "Insert Into "
                        + "[User] (Email, Password, AvatarLink, Address, FullName, PhoneNumber, Gender, CreationDate, Status, RoleId) "
                        + "Values(?, ?, NULL, ?, ?, ?, ?, ?, ?, ?)";
                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, password);
                stm.setString(3, address);
                stm.setString(4, fullName);
                stm.setString(5, phoneNumber);
                stm.setString(6, gender);
                stm.setDate(7, CreationDate);
                stm.setBoolean(8, status);
                stm.setInt(9, roleId);
                //4. Execute Query             
                int row = stm.executeUpdate(); //Insert, Delete, Update deu la Update
                //5. Process rs
                if (row > 0) {
                    return true;
                }

            }//end if con is connected
        } finally {
            if (stm != null) {
                stm.close();
            }

            if (con != null) {
                con.close();
            }
        }

        return false;
    }

    public boolean changeAccountStatus(String email, boolean status)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String

                String sql = "UPDATE [User] "
                        + "SET Status = ? "
                        + "Where Email = ?";
                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, status);
                stm.setString(2, email);
                //4. Execute Query             
                int row = stm.executeUpdate(); //Insert, Delete, Update deu la Update
                //5. Process rs
                if (row > 0) {
                    return true;
                }

            }//end if con is connected
        } finally {
            if (stm != null) {
                stm.close();
            }

            if (con != null) {
                con.close();
            }
        }

        return false;
    }
    
    public boolean changeAccountPassword(String email, String password)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String

                String sql = "UPDATE [User] "
                        + "SET Password = ? "
                        + "Where Email = ?";
                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setString(1, password);
                stm.setString(2, email);
                //4. Execute Query             
                int row = stm.executeUpdate(); //Insert, Delete, Update deu la Update
                //5. Process rs
                if (row > 0) {
                    return true;
                }

            }//end if con is connected
        } finally {
            if (stm != null) {
                stm.close();
            }

            if (con != null) {
                con.close();
            }
        }

        return false;
    }
    
    public int getMaxPagesSearchBy10(String searchValue) throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        try {
            con = new DbConnect().makeConnection();
            if(con != null){
                String sql = "select count(*) from [User] "
                            + "Where Email Like ? ";
                
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                
                 rs = stm.executeQuery();
                 
                 while (rs.next()) {
                    int total = rs.getInt(1);
                    int countPage = 0;
                    countPage = total / 10;
                    if (total % 10 != 0) {
                        countPage++;
                    }
                    return countPage;
                }
            }
        } finally{
            if(rs != null){
                rs.close();
            }
            
            if(stm != null){
                stm.close();
            }
            
            if(con != null){
                con.close();
            }
        }
        
        return 0;
    }
    
    public List<UserDTO> searchAccountEmail (String searchValue, int index)
        throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<UserDTO> list = new ArrayList<>();
        
        try{
        //1.Connect DB
            con = new DbConnect().makeConnection();
            if(con != null){
                //2.Create sQL String
                String sql = "SELECT Email, Password, AvatarLink, Address, FullName, PhoneNumber, Gender, CreationDate,  Status, [User].RoleId, [Role].Name "
                        + "FROM [User] FULL JOIN [Role] ON [User].RoleId = [Role].RoleId "
                            + "Where Email Like ? "
                            + "order by Email \n"
                            + "offset ? rows \n"
                            + "fetch first 10 rows only";
                
                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                stm.setInt(2, (index - 1) * 10);
                //4.Execute Query
                rs = stm.executeQuery();
                
                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    String email = rs.getString("Email");
                    String password = rs.getString("Password");
                    String avatarLink = rs.getString("AvatarLink");
                    String address = rs.getString("Address");
                    String fullname = rs.getString("FullName");
                    String phoneNumber = rs.getString("PhoneNumber");
                    String gender = rs.getString("Gender");
                    Date date = rs.getDate("CreationDate");
                    boolean status = rs.getBoolean("Status");
                    int roleId = rs.getInt("RoleId");
                    String roleName = rs.getString("Name");
                    RoleDTO roleDto = new RoleDTO(roleId, roleName);
                    UserDTO dto = new UserDTO(email, password, avatarLink, address, fullname, phoneNumber, gender, date, status, roleDto);
                    list.add(dto);
                }//end While traversal
                
                return list;
            }//end is con is opened
        }
        finally{
            if(rs != null){
                rs.close();
            }
            
            if(stm != null){
                stm.close();
            }
            if(con != null){
                con.close();
            }
        }
        
        return null;
    }
    
    public int getActiveAccount() throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;
        try {
            con = new DbConnect().makeConnection();
            if(con != null){
                String sql = "select count(*) from [User] "
                            + "Where Status = ? ";
                
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, true);
                
                 rs = stm.executeQuery();
                 
                while (rs.next()) {
                    count = rs.getInt(1);
                }
                return count;
            }
        } finally{
            if(rs != null){
                rs.close();
            }
            
            if(stm != null){
                stm.close();
            }
            
            if(con != null){
                con.close();
            }
        }
        
        return 0;
    }
    
    public int getDeactivatedAccount() throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;
        try {
            con = new DbConnect().makeConnection();
            if(con != null){
                String sql = "select count(*) from [User] "
                            + "Where Status = ? ";
                
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, false);
                
                 rs = stm.executeQuery();
                 
                while (rs.next()) {
                    count = rs.getInt(1);
                }
                return count;
            }
        } finally{
            if(rs != null){
                rs.close();
            }
            
            if(stm != null){
                stm.close();
            }
            
            if(con != null){
                con.close();
            }
        }
        
        return 0;
    }
    
    public int totalOfNewUserInOneWeek(Date date1, Date date2)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT COUNT(*) FROM [User] "
                    + "WHERE [User].RoleId = 3 AND (CreationDate BETWEEN ? AND ?)";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setDate(1, date1);
            stm.setDate(2, date2);
            //4. Execute Query
            rs = stm.executeQuery();
            //5. Process Result Set 
            while (rs.next()) {
                int count = rs.getInt(1);
                return count;
            }
            return 0;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
    public int getNewUserForOneDay(Date date)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT COUNT(*) FROM [User] "
                    + "WHERE [User].RoleId = 3 AND CreationDate = ? ";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setDate(1, date);
            //4. Execute Query
            rs = stm.executeQuery();
            //5. Process Result Set 
            while (rs.next()) {
                int count = rs.getInt(1);
                return count;
            }
            if (rs == null) {
                return 0;
            }
            return 0;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}


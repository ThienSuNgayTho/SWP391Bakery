/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package category;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import utils.DbConnect;

/**
 *
 * @author dell
 */
public class CategoryDAO implements Serializable {

    private List<CategoryDTO> categoryList;

    public List<CategoryDTO> getCategoryList() {
        return categoryList;
    }

    public CategoryDTO getCategory(String categoryID)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();

            String sql = "Select CategoryId, Name, Type "
                    + "From Category "
                    + "Where CategoryId = ? ";

            stm = con.prepareStatement(sql);
            stm.setString(1, categoryID);

            rs = stm.executeQuery();

            if (rs.next()) {
                String id = rs.getString("CategoryId");
                String name = rs.getString("Name");
                String type = rs.getString("Type");
                CategoryDTO c = new CategoryDTO(categoryID, name, type);

                return c;
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

        return null;
    }

    public void getAllCategory()
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();

            String sql = "Select CategoryId, Name, Type "
                    + "From Category ";

            stm = con.prepareStatement(sql);

            rs = stm.executeQuery();

            while (rs.next()) {
                String id = rs.getString("CategoryId");
                String name = rs.getString("Name");
                String type = rs.getString("Type");
                CategoryDTO dto = new CategoryDTO(id, name, type);

                if (this.categoryList == null) {
                    this.categoryList = new ArrayList<>();
                }

                this.categoryList.add(dto);
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

    }

    public List<CategoryDTO> getCakeCategory()
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();

            String sql = "Select CategoryId, Name, Type "
                    + "From Category "
                    + "Where Type = ?";

            stm = con.prepareStatement(sql);
            stm.setString(1, "cake");
            rs = stm.executeQuery();

            List<CategoryDTO> categoryCakeList = new ArrayList<>();

            while (rs.next()) {
                String id = rs.getString("CategoryId");
                String name = rs.getString("Name");
                String type = rs.getString("Type");
                CategoryDTO dto = new CategoryDTO(id, name, type);

                categoryCakeList.add(dto);
            }

            return categoryCakeList;
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
    
    public List<CategoryDTO> getPostCategory()
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();

            String sql = "Select CategoryId, Name, Type "
                    + "From Category "
                    + "Where Type = ?";

            stm = con.prepareStatement(sql);
            stm.setString(1, "post");
            rs = stm.executeQuery();

            List<CategoryDTO> categoryPostList = new ArrayList<>();

            while (rs.next()) {
                String id = rs.getString("CategoryId");
                String name = rs.getString("Name");
                String type = rs.getString("Type");
                CategoryDTO dto = new CategoryDTO(id, name, type);

                categoryPostList.add(dto);
            }

            return categoryPostList;
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

    //Get number of Category
/*----------------------------------------------------------------------------*/
    public int numberOfCategories(String status)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT count(*) FROM Category "
                    + "WHERE [Category].Type = ? ";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setString(1, status);
            //4. Execute Query
            rs = stm.executeQuery();
            //5. Process Result Set 
            while (rs.next()) {
                int cate = rs.getInt(1);
                return cate;
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

    public void UpdateCategory(String CategoryName, String CategoryId) {
        String query = "update [Category] set [Name] = ? where [CategoryId]= ?";
        try {

            Connection conn = new DbConnect().makeConnection();
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, CategoryName);
            ps.setString(2, CategoryId);

            ps.executeQuery();

        } catch (Exception E) {
        }
    }

    public boolean addNewCategoryCake(String CategoryId, String CategoryName, String CategoryType) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String
                String sql = "Insert Into "
                        + "Category (CategoryId, Name, Type) "
                        + "Values(?, ?, ?)";

                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setString(1, CategoryId);
                stm.setString(2, CategoryName);
                stm.setString(3, CategoryType);

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
    
    public boolean addNewCategoryPost(String CategoryId, String CategoryName, String CategoryType) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String
                String sql = "Insert Into "
                        + "Category (CategoryId, Name, Type) "
                        + "Values(?, ?, ?)";

                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setString(1, CategoryId);
                stm.setString(2, CategoryName);
                stm.setString(3, CategoryType);

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
    
    public int countCakeType() throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();

            String sql = "Select Count(*) "
                    + "From Category "
                    + "Where Type = ? ";

            stm = con.prepareStatement(sql);
            stm.setString(1, "cake");
            rs = stm.executeQuery();

            if (rs.next()) {
                int result = rs.getInt(1);
                return result;
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
    
    public int countPostType() throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();

            String sql = "Select Count(*) "
                    + "From Category "
                    + "Where Type = ? ";

            stm = con.prepareStatement(sql);
            stm.setString(1, "post");
            rs = stm.executeQuery();

            if (rs.next()) {
                int result = rs.getInt(1);
                return result;
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
}

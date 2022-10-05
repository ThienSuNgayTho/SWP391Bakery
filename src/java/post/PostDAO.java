/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package post;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import utils.DbConnect;
import java.util.ArrayList;

/**
 *
 * @author dell
 */
public class PostDAO implements Serializable {

    private List<PostDTO> postList;

    public List<PostDTO> getPostList() {
        return postList;
    }

    public int getFullMaxPagesBy10()
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();
            if (con != null) {
                String sql = "select count(*) from Post";

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

    public void getFullPostList(int index)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select Id, Email, Title, ThumbnailLink, UploadDate, "
                        + "Status, Details, CategoryId, OnSlider, UpdateDate "
                        + "From [Post] "
                        + "order by Id \n"
                        + "offset ? rows \n"
                        + "fetch first 10 rows only";

                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setInt(1, (index - 1) * 10);

                //4.Execute Query
                rs = stm.executeQuery();

                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    int id = rs.getInt(1);
                    String email = rs.getString(2);
                    String title = rs.getString(3);
                    String imageLink = rs.getString(4);
                    Date uploadDate = rs.getDate(5);
                    boolean status = rs.getBoolean(6);
                    String detail = rs.getString(7);
                    String categoryId = rs.getString(8);
                    boolean onSlider = rs.getBoolean(9);
                    Date updateDate = rs.getDate(10);

                    PostDTO dto = new PostDTO(id, email, title, imageLink, uploadDate, status, detail, categoryId, onSlider, updateDate);

                    if (this.postList == null) {
                        this.postList = new ArrayList<>();
                    }

                    this.postList.add(dto);
                }//end While traversal

            }//end is con is opened

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

    public void getSliderPostList()
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select Id, Email, Title, ThumbnailLink, UploadDate, "
                        + "Status, Details, CategoryId, OnSlider, UpdateDate "
                        + "From [Post] "
                        + "Where OnSlider = ? ";
//                        + "order by Id \n"
//                        + "offset ? rows \n"
//                        + "fetch first 10 rows only";

                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, true);
//                stm.setInt(2, (index - 1) * 10);

                //4.Execute Query
                rs = stm.executeQuery();

                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    int id = rs.getInt(1);
                    String email = rs.getString(2);
                    String title = rs.getString(3);
                    String imageLink = rs.getString(4);
                    Date uploadDate = rs.getDate(5);
                    boolean status = rs.getBoolean(6);
                    String detail = rs.getString(7);
                    String categoryId = rs.getString(8);
                    boolean onSlider = rs.getBoolean(9);
                    Date updateDate = rs.getDate(10);

                    PostDTO dto = new PostDTO(id, email, title, imageLink, uploadDate, status, detail, categoryId, onSlider, updateDate);

                    if (this.postList == null) {
                        this.postList = new ArrayList<>();
                    }

                    this.postList.add(dto);
                }//end While traversal

            }//end is con is opened

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

    public int getMaxPostId() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();

            String sql = "Select MAX(Id) "
                    + "From Post ";

            stm = con.prepareStatement(sql);

            rs = stm.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) + 1;
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

    public boolean addNewPost(String email, String title, String postPicName,
            Date uploadDate, boolean status, String postDetail, String categoryId,
            boolean onSlider, Date updateDate) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String
                String sql = "Insert Into "
                        + "Post (Email, Title, ThumbnailLink, UploadDate, Status, Details, CategoryId, OnSlider, UpdateDate) "
                        + "Values(?, ?, ?, ?, ?, ?, ?, ?, ?)";

                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, title);
                stm.setString(3, postPicName);
                stm.setDate(4, uploadDate);
                stm.setBoolean(5, status);
                stm.setString(6, postDetail);
                stm.setString(7, categoryId);
                stm.setBoolean(8, onSlider);
                stm.setDate(9, updateDate);

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

    public PostDTO getPostById(int postId)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select Id, Email, Title, ThumbnailLink, UploadDate, "
                        + "Status, Details, CategoryId, OnSlider, UpdateDate "
                        + "From [Post] "
                        + "Where Id = ?";

                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setInt(1, postId);
                //4.Execute Query
                rs = stm.executeQuery();

                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    int id = rs.getInt(1);
                    String email = rs.getString(2);
                    String title = rs.getString(3);
                    String imageLink = rs.getString(4);
                    Date uploadDate = rs.getDate(5);
                    boolean status = rs.getBoolean(6);
                    String detail = rs.getString(7);
                    String categoryId = rs.getString(8);
                    boolean onSlider = rs.getBoolean(9);
                    Date updateDate = rs.getDate(10);

                    PostDTO dto = new PostDTO(id, email, title, imageLink, uploadDate, status, detail, categoryId, onSlider, updateDate);

                    return dto;
                }//end While traversal

            }//end is con is opened

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

    public boolean updatePostInfo(int postId, String title,
            String postDetail, String categoryId,
            boolean onSlider, Date updateDate) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE Post "
                        + "SET Title = ?, Details = ?, CategoryId = ?, OnSlider = ?, UpdateDate = ? "
                        + "Where Id = ?";
                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setString(1, title);
                stm.setString(2, postDetail);
                stm.setString(3, categoryId);
                stm.setBoolean(4, onSlider);
                stm.setDate(5, updateDate);
                stm.setInt(6, postId);
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

    public int getMaxPagesSearchBy10(String searchValue) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();
            if (con != null) {
                String sql = "select count(*) from [Post] "
                        + "Where Title Like ? ";

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

    public void searchPostTitle(String searchValue, int index)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<PostDTO> list = new ArrayList<>();

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select Id, Email, Title, ThumbnailLink, UploadDate, "
                        + "Status, Details, CategoryId, OnSlider, UpdateDate "
                        + "From [Post] "
                        + "Where Title like ? "
                        + "order by Id \n"
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
                    int id = rs.getInt(1);
                    String email = rs.getString(2);
                    String title = rs.getString(3);
                    String imageLink = rs.getString(4);
                    Date uploadDate = rs.getDate(5);
                    boolean status = rs.getBoolean(6);
                    String detail = rs.getString(7);
                    String categoryId = rs.getString(8);
                    boolean onSlider = rs.getBoolean(9);
                    Date updateDate = rs.getDate(10);

                    PostDTO dto = new PostDTO(id, email, title, imageLink, uploadDate, status, detail, categoryId, onSlider, updateDate);

                    if (this.postList == null) {
                        this.postList = new ArrayList<>();
                    }

                    this.postList.add(dto);
                }//end While traversal

            }//end is con is opened
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

    public boolean changePostStatus(String id, boolean onSlider)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String

                String sql = "UPDATE [Post] "
                        + "SET OnSlider = ? "
                        + "Where Id = ?";
                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, onSlider);
                stm.setString(2, id);
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

    /*Get the number of post by given status*/
 /*----------------------------------------------------------------------------*/
    public int totalNumberOfPostByStatus(String status)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT COUNT(*) FROM [Post] "
                    + "WHERE [Post].Status = ? ";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setString(1, status);
            //4. Execute Query
            rs = stm.executeQuery();
            //5. Process Result Set 
            while (rs.next()) {
                int order = rs.getInt(1);
                return order;
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

    //Post Number Daily
    public int getTotalPostForOneDay(Date date) 
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT COUNT(*) FROM [Post] "
                    + "WHERE [Post].Status = 'true' AND UpdateDate = ? ";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setDate(1, date);
            //4. Execute Query
            rs = stm.executeQuery();
            //5. Process Result Set 
            while (rs.next()) {
                int post = rs.getInt(1);
                return post;
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

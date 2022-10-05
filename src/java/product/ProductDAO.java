/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import category.CategoryDTO;
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
public class ProductDAO implements Serializable {

    private List<ProductDTO> productList;

    public List<ProductDTO> getProductList() {
        return productList;
    }

    public void ClearList(){
        productList.clear();
    }
    
    public int getMaxPagesBy8()
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();
            if (con != null) {
                String sql = "select count(*) from Product Where status = ? ";

                stm = con.prepareStatement(sql);
                stm.setString(1, "true");

                rs = stm.executeQuery();

                while (rs.next()) {
                    int total = rs.getInt(1);
                    int countPage = 0;
                    countPage = total / 8;
                    if (total % 8 != 0) {
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

    public int getFullMaxPagesBy8()
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();
            if (con != null) {
                String sql = "select count(*) from Product";

                stm = con.prepareStatement(sql);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int total = rs.getInt(1);
                    int countPage = 0;
                    countPage = total / 8;
                    if (total % 8 != 0) {
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
    
    public void getAvailableProductList(int index)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select p.Id, p.Name, p.CategoryId, c.Name, p.OringinalSalePrice, "
                        + "p.SalePrice, p.Details, p.Status, p.Stock, p.SaleStatus, p.ThumbnailLink "
                        + "From Product p LEFT JOIN Category c ON p.CategoryId = c.Id "
                        + "Where p.status = ? "
                        + "order by p.Id \n"
                        + "offset ? rows \n"
                        + "fetch first 8 rows only";

                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setString(1, "true");
                stm.setInt(2, (index - 1) * 8);
                //4.Execute Query
                rs = stm.executeQuery();

                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    int id = rs.getInt(1);
                    String name = rs.getString(2);
                    String categoryId = rs.getString(3);
                    String categoryName = rs.getString(4);
                    float originalSalePrice = rs.getFloat(5);
                    float salePrice = rs.getFloat(6);
                    String details = rs.getString(7);
                    boolean status = rs.getBoolean(8);
                    int stock = rs.getInt(9);
                    boolean saleStatus = rs.getBoolean(10);
                    String imageLink = rs.getString(11);

                    CategoryDTO c = new CategoryDTO(categoryId, categoryName, "cake");

                    ProductDTO dto = new ProductDTO(id, name, imageLink, originalSalePrice, details, salePrice, status, saleStatus, stock, c);

                    if (this.productList == null) {
                        this.productList = new ArrayList<>();
                    }

                    this.productList.add(dto);
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

    public void getFullProductList(int index)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select p.Id, p.Name, p.CategoryId, c.Name, p.OringinalSalePrice, "
                        + "p.SalePrice, p.Details, p.Status, p.Stock, p.SaleStatus, p.ThumbnailLink "
                        + "From Product p LEFT JOIN Category c ON p.CategoryId = c.Id "
                        + "order by p.Id \n"
                        + "offset ? rows \n"
                        + "fetch first 8 rows only";

                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setInt(1, (index - 1) * 8);

                //4.Execute Query
                rs = stm.executeQuery();

                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    int id = rs.getInt(1);
                    String name = rs.getString(2);
                    String categoryId = rs.getString(3);
                    String categoryName = rs.getString(4);
                    float originalSalePrice = rs.getFloat(5);
                    float salePrice = rs.getFloat(6);
                    String details = rs.getString(7);
                    boolean status = rs.getBoolean(8);
                    int stock = rs.getInt(9);
                    boolean saleStatus = rs.getBoolean(10);
                    String imageLink = rs.getString(11);

                    CategoryDTO c = new CategoryDTO(categoryId, categoryName, "cake");

//                    Category c = getProductCategory(categoryId);
                    ProductDTO dto = new ProductDTO(id, name, imageLink, originalSalePrice, details, salePrice, status, saleStatus, stock, c);

                    if (this.productList == null) {
                        this.productList = new ArrayList<>();
                    }

                    this.productList.add(dto);
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

    public int getMaxPagesByCategoryBy8(String cateID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();
            if (con != null) {
                String sql = "select count(*) from Product "
                        + "Where status = ? and CategoryId = ? ";

                stm = con.prepareStatement(sql);
                stm.setString(1, "true");
                stm.setString(2, cateID);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int total = rs.getInt(1);
                    int countPage = 0;
                    countPage = total / 8;
                    if (total % 8 != 0) {
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

    public void getProductByCategory(String searchId, int index)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select p.Id, p.Name, p.CategoryId, c.Name, p.OringinalSalePrice, "
                        + "p.SalePrice, p.Details, p.Status, p.Stock, p.SaleStatus, p.ThumbnailLink "
                        + "From Product p LEFT JOIN Category c ON p.CategoryId = c.Id "
                        + "Where p.CategoryId = ? and p.status = ? "
                        + "order by p.Id \n"
                        + "offset ? rows \n"
                        + "fetch first 8 rows only";

                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setString(1, searchId);
                stm.setString(2, "true");
                stm.setInt(3, (index - 1) * 8);
                //4.Execute Query
                rs = stm.executeQuery();

                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    int id = rs.getInt(1);
                    String name = rs.getString(2);
                    String categoryId = rs.getString(3);
                    String categoryName = rs.getString(4);
                    float originalSalePrice = rs.getFloat(5);
                    float salePrice = rs.getFloat(6);
                    String details = rs.getString(7);
                    boolean status = rs.getBoolean(8);
                    int stock = rs.getInt(9);
                    boolean saleStatus = rs.getBoolean(10);
                    String imageLink = rs.getString(11);

                    CategoryDTO c = new CategoryDTO(categoryId, categoryName, "cake");

//                    Category c = getProductCategory(categoryId);
                    ProductDTO dto = new ProductDTO(id, name, imageLink, originalSalePrice, details, salePrice, status, saleStatus, stock, c);

                    if (this.productList == null) {
                        this.productList = new ArrayList<>();
                    }

                    this.productList.add(dto);
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

    public ProductDTO getProductById(int productId)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select p.Id, p.Name, p.CategoryId, c.Name, p.OringinalSalePrice, "
                        + "p.SalePrice, p.Details, p.Status, p.Stock, p.SaleStatus, p.ThumbnailLink "
                        + "From Product p LEFT JOIN Category c ON p.CategoryId = c.Id "
                        + "Where p.Id = ?";

                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);
                //4.Execute Query
                rs = stm.executeQuery();

                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    int id = rs.getInt(1);
                    String name = rs.getString(2);
                    String categoryId = rs.getString(3);
                    String categoryName = rs.getString(4);
                    float originalSalePrice = rs.getFloat(5);
                    float salePrice = rs.getFloat(6);
                    String details = rs.getString(7);
                    boolean status = rs.getBoolean(8);
                    int stock = rs.getInt(9);
                    boolean saleStatus = rs.getBoolean(10);
                    String imageLink = rs.getString(11);

                    CategoryDTO c = new CategoryDTO(categoryId, categoryName, "cake");

//                    Category c = getProductCategory(categoryId);
                    ProductDTO dto = new ProductDTO(id, name, imageLink, originalSalePrice, details, salePrice, status, saleStatus, stock, c);

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

    public int getMaxPagesSearchNameBy8(String searchValue) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();
            if (con != null) {
                String sql = "select count(*) from Product "
                        + "Where status = ? and Name Like ? ";

                stm = con.prepareStatement(sql);
                stm.setString(1, "true");
                stm.setString(2, "%" + searchValue + "%");

                rs = stm.executeQuery();

                while (rs.next()) {
                    int total = rs.getInt(1);
                    int countPage = 0;
                    countPage = total / 8;
                    if (total % 8 != 0) {
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

    public void searchProductName(String searchValue, int index)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select p.Id, p.Name, p.CategoryId, c.Name, p.OringinalSalePrice, "
                        + "p.SalePrice, p.Details, p.Status, p.Stock, p.SaleStatus, p.ThumbnailLink "
                        + "From Product p LEFT JOIN Category c ON p.CategoryId = c.Id "
                        + "Where p.Name Like ? and p.status = ? "
                        + "order by p.Id \n"
                        + "offset ? rows \n"
                        + "fetch first 8 rows only";

                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                stm.setString(2, "true");
                stm.setInt(3, (index - 1) * 8);
                //4.Execute Query
                rs = stm.executeQuery();

                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    int id = rs.getInt(1);
                    String name = rs.getString(2);
                    String categoryId = rs.getString(3);
                    String categoryName = rs.getString(4);
                    float originalSalePrice = rs.getFloat(5);
                    float salePrice = rs.getFloat(6);
                    String details = rs.getString(7);
                    boolean status = rs.getBoolean(8);
                    int stock = rs.getInt(9);
                    boolean saleStatus = rs.getBoolean(10);
                    String imageLink = rs.getString(11);

                    CategoryDTO c = new CategoryDTO(categoryId, categoryName, "cake");

//                    Category c = getProductCategory(categoryId);
                    ProductDTO dto = new ProductDTO(id, name, imageLink, originalSalePrice, details, salePrice, status, saleStatus, stock, c);

                    if (this.productList == null) {
                        this.productList = new ArrayList<>();
                    }

                    this.productList.add(dto);
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

    public int getMaxPagesFullSearchNameBy8(String searchValue) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();
            if (con != null) {
                String sql = "select count(*) from Product "
                        + "Where Name Like ? ";

                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");

                rs = stm.executeQuery();

                while (rs.next()) {
                    int total = rs.getInt(1);
                    int countPage = 0;
                    countPage = total / 8;
                    if (total % 8 != 0) {
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

    public void searchFullProductName(String searchValue, int index)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2.Create sQL String
                String sql = "Select p.Id, p.Name, p.CategoryId, c.Name, p.OringinalSalePrice, "
                        + "p.SalePrice, p.Details, p.Status, p.Stock, p.SaleStatus, p.ThumbnailLink "
                        + "From Product p LEFT JOIN Category c ON p.CategoryId = c.Id "
                        + "Where p.Name Like ? "
                        + "order by p.Id \n"
                        + "offset ? rows \n"
                        + "fetch first 8 rows only";

                //3.Create Statement and Assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                stm.setInt(2, (index - 1) * 8);
                //4.Execute Query
                rs = stm.executeQuery();

                //5.Process result
                while (rs.next()) { //Tra ve nhieu dong thi dung While 
                    int id = rs.getInt(1);
                    String name = rs.getString(2);
                    String categoryId = rs.getString(3);
                    String categoryName = rs.getString(4);
                    float originalSalePrice = rs.getFloat(5);
                    float salePrice = rs.getFloat(6);
                    String details = rs.getString(7);
                    boolean status = rs.getBoolean(8);
                    int stock = rs.getInt(9);
                    boolean saleStatus = rs.getBoolean(10);
                    String imageLink = rs.getString(11);

                    CategoryDTO c = new CategoryDTO(categoryId, categoryName, "cake");

//                    Category c = getProductCategory(categoryId);
                    ProductDTO dto = new ProductDTO(id, name, imageLink, originalSalePrice, details, salePrice, status, saleStatus, stock, c);

                    if (this.productList == null) {
                        this.productList = new ArrayList<>();
                    }

                    this.productList.add(dto);
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

    public int getMaxProductId() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = new DbConnect().makeConnection();

            String sql = "Select MAX(Id) "
                    + "From Product ";

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

    public boolean addNewProduct(String productName, String categoryId, String pictureName,
            float orignalPrice, String productDescription, float salePrice, boolean availableStatus,
            int productStock, boolean saleStatus) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String
                String sql = "Insert Into "
                        + "Product (Name, CategoryId, ThumbnailLink, OringinalSalePrice, Details, SalePrice, Status, Stock, SaleStatus) "
                        + "Values(?, ?, ?, ?, ?, ?, ?, ?, ?)";

                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);
                stm.setString(2, categoryId);
                stm.setString(3, pictureName);
                stm.setFloat(4, orignalPrice);
                stm.setString(5, productDescription);
                stm.setFloat(6, salePrice);
                stm.setBoolean(7, availableStatus);
                stm.setInt(8, productStock);
                stm.setBoolean(9, saleStatus);

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

    public boolean updateProductInfo(int productId, String productName, String categoryId, String imageLink,
            float orignalPrice, String productDescription, float salePrice, boolean availableStatus,
            int productStock, boolean saleStatus) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1.Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String
//                String sql = "UPDATE Product "
//                        + "SET Name = ?, CategoryId = ?, OringinalSalePrice = ?, Details = ?, SalePrice = ?, Status = ?, Stock = ?, SaleStatus = ? "
//                        + "Where Id = ?";

                String sql = "UPDATE Product "
                        + "SET Name = ?, CategoryId = ?, OringinalSalePrice = ?, Details = ?, SalePrice = ?, Status = ?, Stock = ?, SaleStatus = ?, ThumbnailLink = ? "
                        + "Where Id = ?";
                //3. Create Statement and assign Parameter (if any)
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);
                stm.setString(2, categoryId);
                stm.setFloat(3, orignalPrice);
                stm.setString(4, productDescription);
                stm.setFloat(5, salePrice);
                stm.setBoolean(6, availableStatus);
                stm.setInt(7, productStock);
                stm.setBoolean(8, saleStatus);
                stm.setString(9, imageLink);
                stm.setInt(10, productId);
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

    public int numberOfProduct(String status)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT COUNT(*) FROM [Product] "
                    + "WHERE [Product].Status = ? ";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setString(1, status);
            //4. Execute Query
            rs = stm.executeQuery();
            //5. Process Result Set 
            while (rs.next()) {
                int product = rs.getInt(1);
                return product;
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

    public boolean updateProductStock(int productID, int quantity, boolean isCancel) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            int newStock = isCancel ? getCurrentStock(productID) + quantity : getCurrentStock(productID) - quantity;
            String sql = "UPDATE [Product] SET Stock = ? WHERE Id = ? ";
            conn = new DbConnect().makeConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, newStock);
            ps.setInt(2, productID);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getCurrentStock(int productID) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int stock = 0;
        try {
            conn = new DbConnect().makeConnection();
            String sql = "SELECT  Stock FROM [Product] WHERE Id = ? ";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            while (rs.next()) {
                stock = rs.getInt("Stock");
            }
            return stock;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public boolean isAvailable(int productID) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean status = true;
        int stock = 0;
        try {
            conn = new DbConnect().makeConnection();
            String sql = "SELECT Status, Stock FROM [Product] WHERE Id = ? ";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            while (rs.next()) {
                stock = rs.getInt("Stock");
                status = rs.getBoolean("Status");
            }

            return stock > 0 && status;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    public int getNumberOfProduct() {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        try {
            conn = new DbConnect().makeConnection();
            String sql = "SELECT Count(*) FROM [Product] ";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int getProductStockLessThan10() {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        try {
            conn = new DbConnect().makeConnection();
            String sql = "Select Count(Stock) "
                    + "From [Product] "
                    + "Where Stock = 0 ";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
            return count;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
}

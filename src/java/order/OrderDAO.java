package order;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import orderItem.OrderItemDAO;
import orderItem.OrderItemDTO;
import product.ProductDAO;
import utils.DbConnect;

/**
 *
 * @author dell
 */
public class OrderDAO implements Serializable {

    /*Get list of pending orders*/
 /*-----------------------------------------------------------------------------*/
    private List<OrderSaleDTO> orderList;

    public List<OrderSaleDTO> getOrderList() {
        return orderList;
    }

    public void getPendingOrder() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String 
                String sql = "SELECT [Order].OrderId, CustomerEmail, [User].Address, [User].PhoneNumber, [User].FullName, [Order].OrderStatus, SaleEmail, CompleteDate, TotalOrderPrice, [Order].ShippingPrice, [Order].Paid  "
                        + "FROM [Order] JOIN [User] ON [Order].CustomerEmail = [User].Email "
                        + "WHERE [Order].OrderStatus = 'submitted' ";
                //3, Create statement & assign value to parameter
                stm = con.prepareStatement(sql);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    int id = rs.getInt("OrderId"); //get OrderID
                    String customerEmail = rs.getString("CustomerEmail"); //get Customer Email
                    String address = rs.getString("Address"); //get Customer Address
                    String phoneNumber = rs.getString("PhoneNumber"); // get Customer Phone Number
                    String fullname = rs.getString("FullName"); //get Customer Full Name
                    String status = rs.getString("OrderStatus"); //get Order status
                    String saleEmail = null; //get Email of the saleperson in charge of the order
                    Date completeDate = rs.getDate("CompleteDate"); //get the date the order got updated
                    double total = rs.getDouble("TotalOrderPrice"); //get the total price of the order
                    double shipPrice = rs.getDouble("ShippingPrice");
                    boolean paidStatus = rs.getBoolean("Paid");
                    OrderSaleDTO dto = new OrderSaleDTO(address, phoneNumber, fullname, id, customerEmail, status, saleEmail, completeDate, total, shipPrice, paidStatus);
                    if (this.orderList == null) {
                        this.orderList = new ArrayList<>();
                    }// end if list not existed
                    this.orderList.add(dto);
                }//end if no result left
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

    /*Get list of assigned orders*/
 /*-----------------------------------------------------------------------------*/
    private List<OrderSaleDTO> assignedOrderList;

    public List<OrderSaleDTO> getAssignedOrderList() {
        return assignedOrderList;
    }

    public void getAssignedOrder(String saleEmail) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String 
                String sql = "SELECT [Order].OrderId, CustomerEmail, [User].Address, [User].PhoneNumber, [User].FullName, [Order].OrderStatus, SaleEmail, CompleteDate, TotalOrderPrice, [Order].ShippingPrice, [Order].Paid  "
                        + "FROM [Order] JOIN [User] ON [Order].CustomerEmail = [User].Email "
                        + "WHERE [Order].SaleEmail = ? AND [Order].OrderStatus = 'approved' ";
                //3, Create statement & assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setString(1, saleEmail);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    int id = rs.getInt("OrderId"); //get OrderID
                    String customerEmail = rs.getString("CustomerEmail"); //get Customer Email
                    String address = rs.getString("Address"); //get Customer Address
                    String phoneNumber = rs.getString("PhoneNumber"); // get Customer Phone Number
                    String fullname = rs.getString("FullName"); //get Customer Full Name
                    String status = rs.getString("OrderStatus"); //get Order status
                    Date completeDate = rs.getDate("CompleteDate"); //get the date the order got updated
                    double total = rs.getDouble("TotalOrderPrice"); //get the total price of the order
                    double shipPrice = rs.getDouble("ShippingPrice");
                    boolean paidStatus = rs.getBoolean("Paid");
                    OrderSaleDTO dto = new OrderSaleDTO(address, phoneNumber, fullname, id, customerEmail, status, saleEmail, completeDate, total, shipPrice, paidStatus);
                    if (this.assignedOrderList == null) {
                        this.assignedOrderList = new ArrayList<>();
                    }// end if list not existed
                    this.assignedOrderList.add(dto);
                }//end if no result left
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

    /*Get list of deliver orders*/
 /*-----------------------------------------------------------------------------*/
    private List<OrderSaleDTO> deliverOrderList;

    public List<OrderSaleDTO> getDeliverOrderList() {
        return deliverOrderList;
    }

    public void getDeliverOrder(String saleEmail) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String 
                String sql = "SELECT [Order].OrderId, CustomerEmail, [User].Address, [User].PhoneNumber, [User].FullName, [Order].OrderStatus, SaleEmail, CompleteDate, TotalOrderPrice, [Order].ShippingPrice, [Order].Paid  "
                        + "FROM [Order] JOIN [User] ON [Order].CustomerEmail = [User].Email "
                        + "WHERE [Order].SaleEmail = ? AND [Order].OrderStatus = 'deliver' ";
                //3, Create statement & assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setString(1, saleEmail);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    int id = rs.getInt("OrderId"); //get OrderID
                    String customerEmail = rs.getString("CustomerEmail"); //get Customer Email
                    String address = rs.getString("Address"); //get Customer Address
                    String phoneNumber = rs.getString("PhoneNumber"); // get Customer Phone Number
                    String fullname = rs.getString("FullName"); //get Customer Full Name
                    String status = rs.getString("OrderStatus"); //get Order status
                    Date completeDate = rs.getDate("CompleteDate"); //get the date the order got updated
                    double total = rs.getDouble("TotalOrderPrice"); //get the total price of the order
                    double shipPrice = rs.getDouble("ShippingPrice");
                    boolean paidStatus = rs.getBoolean("Paid");
                    OrderSaleDTO dto = new OrderSaleDTO(address, phoneNumber, fullname, id, customerEmail, status, saleEmail, completeDate, total, shipPrice, paidStatus);
                    if (this.deliverOrderList == null) {
                        this.deliverOrderList = new ArrayList<>();
                    }// end if list not existed
                    this.deliverOrderList.add(dto);
                }//end if no result left
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

    /*Get list of completed order orders*/
 /*-----------------------------------------------------------------------------*/
    private List<OrderSaleDTO> completedOrderList;

    public List<OrderSaleDTO> getCompletedOrderList() {
        return completedOrderList;
    }

    public void getCompletedOrder() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String 
                String sql = "SELECT [Order].OrderId, CustomerEmail, [User].Address, [User].PhoneNumber, [User].FullName, [Order].OrderStatus, SaleEmail, CompleteDate, TotalOrderPrice, [Order].ShippingPrice, [Order].Paid  "
                        + "FROM [Order] JOIN [User] ON [Order].CustomerEmail = [User].Email "
                        + "WHERE [Order].OrderStatus = 'completed' ORDER BY CompleteDate DESC ";
                //3, Create statement & assign value to parameter
                stm = con.prepareStatement(sql);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    int id = rs.getInt("OrderId"); //get OrderID
                    String customerEmail = rs.getString("CustomerEmail"); //get Customer Email
                    String address = rs.getString("Address"); //get Customer Address
                    String phoneNumber = rs.getString("PhoneNumber"); // get Customer Phone Number
                    String fullname = rs.getString("FullName"); //get Customer Full Name
                    String status = rs.getString("OrderStatus"); //get Order status
                    String saleEmail = rs.getString("SaleEmail"); //get Order status
                    Date completeDate = rs.getDate("CompleteDate"); //get the date the order got updated
                    double total = rs.getDouble("TotalOrderPrice"); //get the total price of the order
                    double shipPrice = rs.getDouble("ShippingPrice");
                    boolean paidStatus = rs.getBoolean("Paid");
                    OrderSaleDTO dto = new OrderSaleDTO(address, phoneNumber, fullname, id, customerEmail, status, saleEmail, completeDate, total, shipPrice, paidStatus);
                    if (this.completedOrderList == null) {
                        this.completedOrderList = new ArrayList<>();
                    }// end if list not existed
                    this.completedOrderList.add(dto);
                }//end if no result left
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

    /*Get list of completed order orders*/
 /*-----------------------------------------------------------------------------*/
    private List<OrderSaleDTO> cancelOrderList;

    public List<OrderSaleDTO> getCancelOrderList() {
        return cancelOrderList;
    }

    public void getCancelOrder() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String 
                String sql = "SELECT [Order].OrderId, CustomerEmail, [User].Address, [User].PhoneNumber, [User].FullName, [Order].OrderStatus, SaleEmail, CompleteDate, TotalOrderPrice, [Order].ShippingPrice, [Order].Paid "
                        + "FROM [Order] JOIN [User] ON [Order].CustomerEmail = [User].Email "
                        + "WHERE [Order].OrderStatus = 'cancel' ORDER BY CompleteDate DESC";
                //3, Create statement & assign value to parameter
                stm = con.prepareStatement(sql);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    int id = rs.getInt("OrderId"); //get OrderID
                    String customerEmail = rs.getString("CustomerEmail"); //get Customer Email
                    String address = rs.getString("Address"); //get Customer Address
                    String phoneNumber = rs.getString("PhoneNumber"); // get Customer Phone Number
                    String fullname = rs.getString("FullName"); //get Customer Full Name
                    String status = rs.getString("OrderStatus"); //get Order status
                    String saleEmail = rs.getString("SaleEmail"); //get Order status
                    Date completeDate = rs.getDate("CompleteDate"); //get the date the order got updated
                    double total = rs.getDouble("TotalOrderPrice"); //get the total price of the order
                    double shipPrice = rs.getDouble("ShippingPrice");
                    boolean paidStatus = rs.getBoolean("Paid");
                    OrderSaleDTO dto = new OrderSaleDTO(address, phoneNumber, fullname, id, customerEmail, status, saleEmail, completeDate, total, shipPrice, paidStatus);
                    if (this.cancelOrderList == null) {
                        this.cancelOrderList = new ArrayList<>();
                    }// end if list not existed
                    this.cancelOrderList.add(dto);
                }//end if no result left
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

    /*Set Order to Status*/
 /*----------------------------------------------------------------------------*/
    public boolean setOrderStatus(String saleEmail, int id, String status)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        String sql = "";
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                if (status.equals("completed")) {
                    sql = "UPDATE [Order] "
                            + "SET [Order].SaleEmail = ? , [Order].OrderStatus = ? , [Order].CompleteDate = ?, [Order].Paid = 1 "
                            + "WHERE [Order].OrderId = ? ";

                    
                } else {
                    sql = "UPDATE [Order] "
                            + "SET [Order].SaleEmail = ? , [Order].OrderStatus = ? , [Order].CompleteDate = ? "
                            + "WHERE [Order].OrderId = ? ";
                }

                //2. Create SQL String 
                stm = con.prepareStatement(sql);
                //Set sale Email
                stm.setString(1, saleEmail);
                //Set status
                stm.setString(2, status);
                //Set Time
                long millis = System.currentTimeMillis();
                java.sql.Date date = new java.sql.Date(millis);
                stm.setDate(3, date);
                stm.setInt(4, id);
                //Add back stock if cancel order
                if (status.equalsIgnoreCase("cancel")) {
                    List<OrderItemDTO> items = new OrderItemDAO().getOrderItemsByOrderId(id);
                    ProductDAO productDAO = new ProductDAO();
                    for (OrderItemDTO item : items) {
                        productDAO.updateProductStock(item.getProductId(), item.getQuantity(), true);
                    }
                }
                //4. Execute Query
                int row = stm.executeUpdate();
                //5. Process ResultSet
                if (row > 0) {
                    return true;
                }
            } //end if con is connected
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

    /*Get Order by Id*/
 /*-----------------------------------------------------------------------------*/
    public OrderSaleDTO getOrderById(int orderId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String 
                String sql = "SELECT [Order].OrderId, CustomerEmail, [Order].Address, [User].PhoneNumber, [User].FullName, [Order].OrderStatus, SaleEmail, CompleteDate, TotalOrderPrice, [Order].ShippingPrice, [Order].Paid "
                        + "FROM [Order] JOIN [User] ON [Order].CustomerEmail = [User].Email "
                        + "WHERE [Order].OrderId = ? ";
                //3, Create statement & assign value to parameter
                stm = con.prepareStatement(sql);
                stm.setInt(1, orderId);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    int id = rs.getInt("OrderId"); //get OrderID
                    String customerEmail = rs.getString("CustomerEmail"); //get Customer Email
                    String address = rs.getString("Address"); //get Customer Address
                    String phoneNumber = rs.getString("PhoneNumber"); // get Customer Phone Number
                    String fullname = rs.getString("FullName"); //get Customer Full Name
                    String status = rs.getString("OrderStatus"); //get Order status
                    String saleEmail = rs.getString("SaleEmail"); //get Email of the saleperson in charge of the order
                    Date completeDate = rs.getDate("CompleteDate"); //get the date the order got updated
                    double total = rs.getDouble("TotalOrderPrice"); //get the total price of the order
                    double shipPrice = rs.getDouble("ShippingPrice");
                    boolean paidStatus = rs.getBoolean("Paid");
                    OrderSaleDTO dto = new OrderSaleDTO(address, phoneNumber, fullname, id, customerEmail, status, saleEmail, completeDate, total, shipPrice, paidStatus);
                    return dto;
                }// end if list not existed
            }//end if no result left
            return null;
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

    /*Calculate the number of order with the right status in one week*/
 /*----------------------------------------------------------------------------*/
    public int totalOfOrderByStatusInOneWeek(String status, Date date1, Date date2)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT COUNT(*) FROM [Order] "
                    + "WHERE [Order].OrderStatus = ? AND (CompleteDate BETWEEN ? AND ?)";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setString(1, status);
            stm.setDate(2, date1);
            stm.setDate(3, date2);
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

    /*Get the number of order by given status*/
 /*----------------------------------------------------------------------------*/
    public int totalNumberOfOrderByStatus(String status, String saleEmail)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT COUNT(*) FROM [Order] "
                    + "WHERE [Order].OrderStatus = ? AND [Order].SaleEmail = ? ";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setString(1, status);
            stm.setString(2, saleEmail);
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

    /*Calculate the revenue in the pass 7 days*/
 /*----------------------------------------------------------------------------*/
    public double getTheRevenuePass7Days(String status, Date date1, Date date2)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT SUM(TotalOrderPrice) FROM [Order] "
                    + "WHERE [Order].OrderStatus = ? AND (CompleteDate BETWEEN ? AND ?)";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setString(1, status);
            stm.setDate(2, date1);
            stm.setDate(3, date2);
            //4. Execute Query
            rs = stm.executeQuery();
            //5. Process Result Set 
            while (rs.next()) {
                double revenue = rs.getDouble(1);
                return revenue;
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

    /*Calculate the revenue in one day*/
 /*----------------------------------------------------------------------------*/
    public double getTotalRevenueForOneDay(Date date)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            //2. Create SQL String
            String sql = "SELECT SUM(TotalOrderPrice) FROM [Order] "
                    + "WHERE OrderStatus = 'completed' AND CompleteDate = ? ";
            //3. Create Statement and assign value to parameters if any
            stm = con.prepareStatement(sql);
            stm.setDate(1, date);
            //4. Execute Query
            rs = stm.executeQuery();
            //5. Process Result Set 
            while (rs.next()) {
                double revenue = rs.getDouble(1);
                return revenue;
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

    /*Create Order*/
 /*----------------------------------------------------------------------------*/
    public boolean createOrder(OrderDTO order, List<OrderItemDTO> items, String address, float shipPrice, boolean paid) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            // Insert an order instance
            String sql = "INSERT INTO [Order](CustomerEmail, OrderStatus, SaleEmail,CompleteDate,TotalOrderPrice, Address, ShippingPrice, Paid) VALUES (?,?,?,?,?,?,?,?)";
            conn = new DbConnect().makeConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, order.getCustomerEmail());
            ps.setString(2, order.getStatus());
            ps.setString(3, order.getSaleEmail());
            ps.setDate(4, order.getCompleteDate());
            ps.setDouble(5, order.getTotalPrice());
            ps.setString(6, address);
            ps.setDouble(7, shipPrice);
            ps.setBoolean(8, paid);
            ps.executeUpdate();
            OrderItemDAO itemDAO = new OrderItemDAO();
            ProductDAO productDAO = new ProductDAO();
            // Insert a list of items
            for (OrderItemDTO item : items) {
                // GetLastOrderId: get the just-inserted order ID
                itemDAO.createOrderItems(item, getLastOrderID());
                // Update current stock in DB
                productDAO.updateProductStock(item.getProductId(), item.getQuantity(), false);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("abc");
            return false;
        }
    }

    public int getLastOrderID() {
        int orderId = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT TOP 1 OrderId FROM [Order] ORDER BY OrderId Desc";
            conn = new DbConnect().makeConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                orderId = rs.getInt("OrderId");
            }
            return orderId;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int getLastUserOrderID(String email) {
        int orderId = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT TOP 1 OrderId FROM [Order] WHERE [Order].CustomerEmail = ? ORDER BY OrderId Desc";
            conn = new DbConnect().makeConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                orderId = rs.getInt("OrderId");
            }
            return orderId;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public boolean cancelOrder(int orderId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "DELETE FROM [Order] WHERE OrderId = ? ";
            String sqlItem = "DELETE FROM [OrderItem] WHERE OrderId = ? ";
            conn = new DbConnect().makeConnection();
            ps = conn.prepareStatement(sqlItem);
            ps.setInt(1, orderId);
            List<OrderItemDTO> items = new OrderItemDAO().getOrderItemsByOrderId(orderId);
            ProductDAO productDAO = new ProductDAO();
            for (OrderItemDTO item : items) {
                productDAO.updateProductStock(item.getProductId(), item.getQuantity(), true);
            }
            ps.executeUpdate();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<HashMap<String, String>> getOrderHistoryByUserEmail(String email) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<HashMap<String, String>> result = null;
        try {
            result = new ArrayList<>();
            conn = new DbConnect().makeConnection();
            String sql = "SELECT  [Order].OrderId,[Order].CustomerEmail,[Order].OrderStatus, [Order].CompleteDate, [Order].TotalOrderPrice FROM [Order] "
                    //        + "INNER JOIN [OrderItem] ON [Order].Id = [OrderItem].OrderId INNER JOIN [Product] ON [OrderItem].ProductId = [Product].Id"
                    + " WHERE  [Order].CustomerEmail = ? ORDER BY [Order].OrderId DESC";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                HashMap<String, String> temp = new HashMap<>();
                //      temp.put("thumbnailLink",rs.getString("ThumbnailLink"));

                String stringTotalPrice = String.valueOf(rs.getInt("TotalOrderPrice"));
                while (stringTotalPrice.length() < 10) {
                    stringTotalPrice = stringTotalPrice + " ";
                }
                stringTotalPrice = stringTotalPrice + " VND";

                temp.put("status", rs.getString("OrderStatus"));
                temp.put("completeDate", rs.getDate("CompleteDate").toString());
                temp.put("totalOrderPrice", stringTotalPrice);
                temp.put("orderId", "OD-" + String.valueOf(rs.getInt("OrderId")));
                //      temp.put("name", rs.getString("Name"));
                result.add(temp);
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
package orderItem;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DbConnect;

/**
 *
 * @author dell
 */
public class OrderItemDAO implements Serializable {
    //Get order detail
/*-----------------------------------------------------------------------------*/
    private List<OrderDetailDTO> orderDetailList;

    public List<OrderDetailDTO> getOrderDetailList() {
        return orderDetailList;
    }

    public void getOrderDetail(int orderId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. Connect DB
            con = new DbConnect().makeConnection();
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT [OrderItem].OrderId, [OrderItem].ProductId, [Product].ProductName, [Product].ThumbnailLink, [OrderItem].Quantity, [OrderItem].TotalItemPrice "
                        + "FROM [OrderItem] JOIN [Product] ON [OrderItem].ProductId = [Product].ProductId "
                        + "WHERE OrderId = ? ";
                //3. Create statement & assign value to parameter if any
                stm = con.prepareStatement(sql);
                stm.setInt(1, orderId);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    int productId = rs.getInt("ProductId"); //get ProductId
                    String productName = rs.getString("ProductName"); //get Product Name
                    String productImage = rs.getString("ThumbnailLink"); // get Product Image
                    int quantity = rs.getInt("Quantity"); // get the quanity of the product in order
                    double totalItemPrice = rs.getDouble("TotalItemPrice"); //get the total price of the product in order
                    
                    OrderDetailDTO dto = new OrderDetailDTO(productImage, productName, orderId, productId, quantity, totalItemPrice);
                    if (this.orderDetailList == null) {
                        this.orderDetailList = new ArrayList<>();
                    }// end if list not existed
                    this.orderDetailList.add(dto);
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
    public List<OrderItemDTO> getOrderItemsByOrderId(int orderId){
        List<OrderItemDTO> orderItems = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            String sql =  "SELECT * FROM [OrderItem] WHERE OrderId = ? ";
            conn = new DbConnect().makeConnection();
            ps =  conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            while(rs.next()){
                int Id = rs.getInt("OrderId");
                int productId = rs.getInt("ProductId");
                int quantity = rs.getInt("Quantity");
                double unitPrice = rs.getDouble("TotalItemPrice");
                orderItems.add(new OrderItemDTO(orderId, productId, quantity, unitPrice));
            }
            return orderItems;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public boolean createOrderItems(OrderItemDTO item, int orderId){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = new DbConnect().makeConnection();
            String sql = "INSERT INTO [OrderItem](OrderId,ProductId,Quantity,TotalItemPrice) VALUES (?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getTotalItemPrice());
            ps.executeUpdate();
            return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }
    public static void main(String[] args) throws SQLException {
        OrderItemDAO orderItemDao = new OrderItemDAO();
        List<OrderItemDTO> temp = orderItemDao.getOrderItemsByOrderId(33);
        for (OrderItemDTO orderItemDTO : temp) {
            System.out.println(orderItemDTO.getProductId());
        }
    }
    
}
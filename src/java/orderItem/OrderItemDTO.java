package orderItem;

import java.io.Serializable;

/**
 *
 * @author dell
 */
public class OrderItemDTO implements Serializable {

    private int orderId;
    private int productId;
    private int quantity;
    private double totalItemPrice;

    public OrderItemDTO() {
    }

    public OrderItemDTO(int orderId, int productId, int quantity, double totalItemPrice) {
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.totalItemPrice = totalItemPrice;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalItemPrice() {
        return totalItemPrice;
    }

    public void setTotalItemPrice(double totalItemPrice) {
        this.totalItemPrice = totalItemPrice;
    }
    
    
}
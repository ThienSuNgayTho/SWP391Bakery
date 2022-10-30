package orderItem;

import java.io.Serializable;

/**
 *
 * @author RiceShower
 */
public class OrderDetailDTO extends OrderItemDTO implements Serializable {

    private String imageLink;
    private String productName;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String imageLink, String productName, int orderId, int productId, int quantity, double totalItemPrice) {
        super(orderId, productId, quantity, totalItemPrice);
        this.imageLink = imageLink;
        this.productName = productName;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
}
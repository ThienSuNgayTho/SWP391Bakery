package order;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author dell
 */
public class OrderDTO implements Serializable {

    private int id;
    private String customerEmail;
    private String status;
    private String saleEmail;
    private Date completeDate;
    private double totalPrice;

    public OrderDTO() {
    }

    public OrderDTO(int id, String customerEmail, String status, String saleEmail, Date completeDate, double totalPrice) {
        this.id = id;
        this.customerEmail = customerEmail;
        this.status = status;
        this.saleEmail = saleEmail;
        this.completeDate = completeDate;
        this.totalPrice = totalPrice;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSaleEmail() {
        return saleEmail;
    }

    public void setSaleEmail(String saleEmail) {
        this.saleEmail = saleEmail;
    }

    public Date getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(Date completeDate) {
        this.completeDate = completeDate;
    }

}
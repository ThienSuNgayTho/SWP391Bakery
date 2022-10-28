package order;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author RiceShower
 */
public class OrderSaleDTO extends OrderDTO implements Serializable {

    private String address;
    private String phoneNumber;
    private String fullname;
    private double shipPrice;
    private boolean paidStatus;

    public OrderSaleDTO() {
    }

    public OrderSaleDTO(String address, String phoneNumber, String fullname, int id, String customerEmail, String status, String saleEmail, Date completeDate, double totalPrice, double shipPrice, boolean paidStatus) {
        super(id, customerEmail, status, saleEmail, completeDate, totalPrice);
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.fullname = fullname;
        this.shipPrice = shipPrice;
        this.paidStatus = paidStatus;
    }

    public boolean isPaidStatus() {
        return paidStatus;
    }

    public void setPaidStatus(boolean paidStatus) {
        this.paidStatus = paidStatus;
    }

    
    
    public double getShipPrice() {
        return shipPrice;
    }

    public void setShipPrice(double shipPrice) {
        this.shipPrice = shipPrice;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    
}
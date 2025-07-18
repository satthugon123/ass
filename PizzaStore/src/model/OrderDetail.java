package model;

import java.math.BigDecimal;

public class OrderDetail {
    private String orderID;
    private String productID;
    private BigDecimal unitPrice;
    private int quantity;
    
    public OrderDetail() {}
    
    public OrderDetail(String orderID, String productID, BigDecimal unitPrice, int quantity) {
        this.orderID = orderID;
        this.productID = productID;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public String getOrderID() {
        return orderID;
    }
    
    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }
    
    public String getProductID() {
        return productID;
    }
    
    public void setProductID(String productID) {
        this.productID = productID;
    }
    
    public BigDecimal getUnitPrice() {
        return unitPrice;
    }
    
    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public BigDecimal getTotalPrice() {
        return unitPrice.multiply(new BigDecimal(quantity));
    }
}
package model;

public class Supplier {
    private String supplierID;
    private String companyName;
    private String address;
    private String phone;
    
    public Supplier() {}
    
    public Supplier(String supplierID, String companyName, String address, String phone) {
        this.supplierID = supplierID;
        this.companyName = companyName;
        this.address = address;
        this.phone = phone;
    }
    
    // Getters and Setters
    public String getSupplierID() {
        return supplierID;
    }
    
    public void setSupplierID(String supplierID) {
        this.supplierID = supplierID;
    }
    
    public String getCompanyName() {
        return companyName;
    }
    
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
}
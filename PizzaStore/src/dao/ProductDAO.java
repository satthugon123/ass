package dao;

import model.Product;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ProductDAO {
    
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Product product = new Product(
                    rs.getString("ProductID"),
                    rs.getString("ProductName"),
                    rs.getString("SupplierID"),
                    rs.getString("CategoryID"),
                    rs.getInt("QuantityPerUnit"),
                    rs.getBigDecimal("UnitPrice"),
                    rs.getString("ProductImage")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public Product getProductById(String productID) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, productID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                        rs.getString("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("SupplierID"),
                        rs.getString("CategoryID"),
                        rs.getInt("QuantityPerUnit"),
                        rs.getBigDecimal("UnitPrice"),
                        rs.getString("ProductImage")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Product> searchProducts(String keyword, String searchType) {
        List<Product> products = new ArrayList<>();
        String sql;
        
        switch (searchType.toLowerCase()) {
            case "id":
                sql = "SELECT * FROM Products WHERE ProductID LIKE ?";
                break;
            case "name":
                sql = "SELECT * FROM Products WHERE LOWER(ProductName) LIKE LOWER(?)";
                break;
            case "price":
                sql = "SELECT * FROM Products WHERE UnitPrice = ?";
                break;
            default:
                sql = "SELECT * FROM Products WHERE LOWER(ProductName) LIKE LOWER(?) OR ProductID LIKE ?";
        }
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (searchType.equals("price")) {
                ps.setBigDecimal(1, new BigDecimal(keyword));
            } else if (searchType.equals("default")) {
                ps.setString(1, "%" + keyword + "%");
                ps.setString(2, "%" + keyword + "%");
            } else {
                ps.setString(1, "%" + keyword + "%");
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                        rs.getString("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("SupplierID"),
                        rs.getString("CategoryID"),
                        rs.getInt("QuantityPerUnit"),
                        rs.getBigDecimal("UnitPrice"),
                        rs.getString("ProductImage")
                    );
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, ProductImage) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, product.getProductID());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getSupplierID());
            ps.setString(4, product.getCategoryID());
            ps.setInt(5, product.getQuantityPerUnit());
            ps.setBigDecimal(6, product.getUnitPrice());
            ps.setString(7, product.getProductImage());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateProduct(Product product) {
        String sql = "UPDATE Products SET ProductName = ?, SupplierID = ?, CategoryID = ?, QuantityPerUnit = ?, UnitPrice = ?, ProductImage = ? WHERE ProductID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getSupplierID());
            ps.setString(3, product.getCategoryID());
            ps.setInt(4, product.getQuantityPerUnit());
            ps.setBigDecimal(5, product.getUnitPrice());
            ps.setString(6, product.getProductImage());
            ps.setString(7, product.getProductID());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteProduct(String productID) {
        String sql = "DELETE FROM Products WHERE ProductID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, productID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Product> getProductsByCategory(String categoryID) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE CategoryID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, categoryID);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                        rs.getString("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("SupplierID"),
                        rs.getString("CategoryID"),
                        rs.getInt("QuantityPerUnit"),
                        rs.getBigDecimal("UnitPrice"),
                        rs.getString("ProductImage")
                    );
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
package dao;

import model.Order;
import model.OrderDetail;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import java.util.Date;

public class OrderDAO {
    
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Order order = new Order(
                    rs.getString("OrderID"),
                    rs.getString("CustomerID"),
                    rs.getDate("OrderDate"),
                    rs.getDate("RequiredDate"),
                    rs.getDate("ShippedDate"),
                    rs.getBigDecimal("Freight"),
                    rs.getString("ShipAddress")
                );
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    public List<Order> getOrdersByCustomer(String customerID) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE CustomerID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, customerID);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order(
                        rs.getString("OrderID"),
                        rs.getString("CustomerID"),
                        rs.getDate("OrderDate"),
                        rs.getDate("RequiredDate"),
                        rs.getDate("ShippedDate"),
                        rs.getBigDecimal("Freight"),
                        rs.getString("ShipAddress")
                    );
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    public Order getOrderById(String orderID) {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, orderID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Order(
                        rs.getString("OrderID"),
                        rs.getString("CustomerID"),
                        rs.getDate("OrderDate"),
                        rs.getDate("RequiredDate"),
                        rs.getDate("ShippedDate"),
                        rs.getBigDecimal("Freight"),
                        rs.getString("ShipAddress")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addOrder(Order order) {
        String sql = "INSERT INTO Orders (OrderID, CustomerID, OrderDate, RequiredDate, ShippedDate, Freight, ShipAddress) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, order.getOrderID());
            ps.setString(2, order.getCustomerID());
            ps.setDate(3, order.getOrderDate() != null ? new java.sql.Date(order.getOrderDate().getTime()) : null);
            ps.setDate(4, order.getRequiredDate() != null ? new java.sql.Date(order.getRequiredDate().getTime()) : null);
            ps.setDate(5, order.getShippedDate() != null ? new java.sql.Date(order.getShippedDate().getTime()) : null);
            ps.setBigDecimal(6, order.getFreight());
            ps.setString(7, order.getShipAddress());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateOrder(Order order) {
        String sql = "UPDATE Orders SET CustomerID = ?, OrderDate = ?, RequiredDate = ?, ShippedDate = ?, Freight = ?, ShipAddress = ? WHERE OrderID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, order.getCustomerID());
            ps.setDate(2, order.getOrderDate() != null ? new java.sql.Date(order.getOrderDate().getTime()) : null);
            ps.setDate(3, order.getRequiredDate() != null ? new java.sql.Date(order.getRequiredDate().getTime()) : null);
            ps.setDate(4, order.getShippedDate() != null ? new java.sql.Date(order.getShippedDate().getTime()) : null);
            ps.setBigDecimal(5, order.getFreight());
            ps.setString(6, order.getShipAddress());
            ps.setString(7, order.getOrderID());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteOrder(String orderID) {
        String sql = "DELETE FROM Orders WHERE OrderID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, orderID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<OrderDetail> getOrderDetails(String orderID) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetails WHERE OrderID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, orderID);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail(
                        rs.getString("OrderID"),
                        rs.getString("ProductID"),
                        rs.getBigDecimal("UnitPrice"),
                        rs.getInt("Quantity")
                    );
                    orderDetails.add(detail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }
    
    public boolean addOrderDetail(OrderDetail orderDetail) {
        String sql = "INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, orderDetail.getOrderID());
            ps.setString(2, orderDetail.getProductID());
            ps.setBigDecimal(3, orderDetail.getUnitPrice());
            ps.setInt(4, orderDetail.getQuantity());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Sales Report - Statistics by period and sorted in descending order
    public List<Object[]> getSalesReport(Date startDate, Date endDate) {
        List<Object[]> salesData = new ArrayList<>();
        String sql = "SELECT p.ProductName, SUM(od.Quantity) as TotalQuantity, " +
                     "SUM(od.UnitPrice * od.Quantity) as TotalSales " +
                     "FROM Orders o " +
                     "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                     "JOIN Products p ON od.ProductID = p.ProductID " +
                     "WHERE o.OrderDate BETWEEN ? AND ? " +
                     "GROUP BY p.ProductID, p.ProductName " +
                     "ORDER BY TotalSales DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setDate(1, new java.sql.Date(startDate.getTime()));
            ps.setDate(2, new java.sql.Date(endDate.getTime()));
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Object[] row = {
                        rs.getString("ProductName"),
                        rs.getInt("TotalQuantity"),
                        rs.getBigDecimal("TotalSales")
                    };
                    salesData.add(row);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return salesData;
    }
}
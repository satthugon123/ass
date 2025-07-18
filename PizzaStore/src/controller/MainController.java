package controller;

import dao.*;
import model.*;
import utils.DBContext;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/main")
public class MainController extends HttpServlet {
    
    private AccountDAO accountDAO;
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        accountDAO = new AccountDAO();
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        orderDAO = new OrderDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "home";
        }
        
        try {
            switch (action) {
                case "home":
                    showHome(request, response);
                    break;
                case "login":
                    login(request, response);
                    break;
                case "logout":
                    logout(request, response);
                    break;
                case "register":
                    register(request, response);
                    break;
                case "showLogin":
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    break;
                case "showRegister":
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    break;
                    
                // Product actions
                case "listProducts":
                    listProducts(request, response);
                    break;
                case "searchProducts":
                    searchProducts(request, response);
                    break;
                case "showProductForm":
                    showProductForm(request, response);
                    break;
                case "addProduct":
                    addProduct(request, response);
                    break;
                case "editProduct":
                    editProduct(request, response);
                    break;
                case "updateProduct":
                    updateProduct(request, response);
                    break;
                case "deleteProduct":
                    deleteProduct(request, response);
                    break;
                    
                // Order actions
                case "listOrders":
                    listOrders(request, response);
                    break;
                case "addToCart":
                    addToCart(request, response);
                    break;
                case "viewCart":
                    viewCart(request, response);
                    break;
                case "checkout":
                    checkout(request, response);
                    break;
                case "orderHistory":
                    orderHistory(request, response);
                    break;
                    
                // Reports
                case "salesReport":
                    salesReport(request, response);
                    break;
                    
                default:
                    showHome(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private void showHome(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Load featured products for home page
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
    private void login(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Account account = accountDAO.login(username, password);
        
        if (account != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", account);
            response.sendRedirect("main?action=home");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("main?action=home");
    }
    
    private void register(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String accountID = request.getParameter("accountID");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        int type = Integer.parseInt(request.getParameter("type"));
        
        if (accountDAO.checkAccountExists(accountID)) {
            request.setAttribute("error", "Account ID already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        Account account = new Account(accountID, username, password, fullName, type);
        
        if (accountDAO.register(account)) {
            request.setAttribute("success", "Registration successful. Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    private void listProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
    
    private void searchProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String searchType = request.getParameter("searchType");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            listProducts(request, response);
            return;
        }
        
        List<Product> products = productDAO.searchProducts(keyword, searchType);
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("keyword", keyword);
        request.setAttribute("searchType", searchType);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
    
    private void showProductForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is staff
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        
        if (user == null || !user.isStaff()) {
            response.sendRedirect("main?action=login");
            return;
        }
        
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("product-form.jsp").forward(request, response);
    }
    
    private void addProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is staff
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        
        if (user == null || !user.isStaff()) {
            response.sendRedirect("main?action=login");
            return;
        }
        
        String productID = request.getParameter("productID");
        String productName = request.getParameter("productName");
        String supplierID = request.getParameter("supplierID");
        String categoryID = request.getParameter("categoryID");
        int quantityPerUnit = Integer.parseInt(request.getParameter("quantityPerUnit"));
        BigDecimal unitPrice = new BigDecimal(request.getParameter("unitPrice"));
        String productImage = request.getParameter("productImage");
        
        Product product = new Product(productID, productName, supplierID, categoryID, 
                                    quantityPerUnit, unitPrice, productImage);
        
        if (productDAO.addProduct(product)) {
            response.sendRedirect("main?action=listProducts");
        } else {
            request.setAttribute("error", "Failed to add product");
            showProductForm(request, response);
        }
    }
    
    private void editProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productID = request.getParameter("id");
        Product product = productDAO.getProductById(productID);
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("product", product);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("product-form.jsp").forward(request, response);
    }
    
    private void updateProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productID = request.getParameter("productID");
        String productName = request.getParameter("productName");
        String supplierID = request.getParameter("supplierID");
        String categoryID = request.getParameter("categoryID");
        int quantityPerUnit = Integer.parseInt(request.getParameter("quantityPerUnit"));
        BigDecimal unitPrice = new BigDecimal(request.getParameter("unitPrice"));
        String productImage = request.getParameter("productImage");
        
        Product product = new Product(productID, productName, supplierID, categoryID, 
                                    quantityPerUnit, unitPrice, productImage);
        
        if (productDAO.updateProduct(product)) {
            response.sendRedirect("main?action=listProducts");
        } else {
            request.setAttribute("error", "Failed to update product");
            editProduct(request, response);
        }
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productID = request.getParameter("id");
        
        if (productDAO.deleteProduct(productID)) {
            response.sendRedirect("main?action=listProducts");
        } else {
            request.setAttribute("error", "Failed to delete product");
            listProducts(request, response);
        }
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementation for adding products to cart (session-based)
        response.sendRedirect("main?action=viewCart");
    }
    
    private void viewCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
    
    private void checkout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementation for checkout process
        response.sendRedirect("main?action=orderHistory");
    }
    
    private void listOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("orders.jsp").forward(request, response);
    }
    
    private void orderHistory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("main?action=login");
            return;
        }
        
        List<Order> orders;
        if (user.isStaff()) {
            orders = orderDAO.getAllOrders();
        } else {
            orders = orderDAO.getOrdersByCustomer(user.getAccountID());
        }
        
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("order-history.jsp").forward(request, response);
    }
    
    private void salesReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        if (startDateStr != null && endDateStr != null) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = sdf.parse(startDateStr);
                Date endDate = sdf.parse(endDateStr);
                
                List<Object[]> salesData = orderDAO.getSalesReport(startDate, endDate);
                request.setAttribute("salesData", salesData);
                request.setAttribute("startDate", startDateStr);
                request.setAttribute("endDate", endDateStr);
            } catch (ParseException e) {
                request.setAttribute("error", "Invalid date format");
            }
        }
        
        request.getRequestDispatcher("sales-report.jsp").forward(request, response);
    }
}
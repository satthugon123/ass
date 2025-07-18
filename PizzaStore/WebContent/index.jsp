<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PizzaStore - Delicious Pizzas Delivered</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="main">
                <i class="fas fa-pizza-slice me-2"></i>PizzaStore
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="main">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="main?action=listProducts">Pizzas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="main?action=listProducts&category=categories">Categories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="main?action=orderHistory">Reviews</a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i>Welcome, ${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="main?action=orderHistory">Order History</a></li>
                                    <c:if test="${sessionScope.user.staff}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="main?action=showProductForm">Add Product</a></li>
                                        <li><a class="dropdown-item" href="main?action=listOrders">Manage Orders</a></li>
                                        <li><a class="dropdown-item" href="main?action=salesReport">Sales Report</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="main?action=logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="main?action=showLogin">
                                    <i class="fas fa-sign-in-alt me-1"></i>Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="main?action=showRegister">Register</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center min-vh-100">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold text-white mb-4">
                        Authentic Italian Pizzas
                    </h1>
                    <p class="lead text-white mb-4">
                        Fresh ingredients, traditional recipes, and fast delivery. 
                        Experience the taste of Italy right at your doorstep.
                    </p>
                    <div class="d-flex gap-3">
                        <a href="main?action=listProducts" class="btn btn-warning btn-lg">
                            <i class="fas fa-pizza-slice me-2"></i>Order Now
                        </a>
                        <a href="#menu" class="btn btn-outline-light btn-lg">
                            View Menu
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <img src="images/hero-pizza.png" alt="Delicious Pizza" class="img-fluid">
                </div>
            </div>
        </div>
    </section>

    <!-- Search Section -->
    <section class="py-5 bg-light" id="search">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card shadow">
                        <div class="card-body">
                            <h3 class="text-center mb-4">Find Your Perfect Pizza</h3>
                            <form action="main" method="get">
                                <input type="hidden" name="action" value="searchProducts">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <input type="text" class="form-control form-control-lg" 
                                               name="keyword" placeholder="Search pizzas..." 
                                               value="${param.keyword}">
                                    </div>
                                    <div class="col-md-4">
                                        <select class="form-select form-select-lg" name="searchType">
                                            <option value="name" ${param.searchType == 'name' ? 'selected' : ''}>By Name</option>
                                            <option value="id" ${param.searchType == 'id' ? 'selected' : ''}>By ID</option>
                                            <option value="price" ${param.searchType == 'price' ? 'selected' : ''}>By Price</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary btn-lg w-100">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Pizzas Section -->
    <section class="py-5" id="menu">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Our Featured Pizzas</h2>
                <p class="lead text-muted">Handcrafted with love and the finest ingredients</p>
            </div>
            
            <div class="row g-4">
                <c:forEach var="product" items="${products}" varStatus="status">
                    <c:if test="${status.count <= 6}">
                        <div class="col-lg-4 col-md-6">
                            <div class="card h-100 shadow-sm pizza-card">
                                <img src="${product.productImage != null ? product.productImage : 'images/default-pizza.jpg'}" 
                                     class="card-img-top" alt="${product.productName}" style="height: 250px; object-fit: cover;">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${product.productName}</h5>
                                    <p class="card-text text-muted flex-grow-1">
                                        Serves ${product.quantityPerUnit} people
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="h4 text-primary mb-0">
                                            $<fmt:formatNumber value="${product.unitPrice}" pattern="#,##0.00"/>
                                        </span>
                                        <div class="btn-group">
                                            <button class="btn btn-outline-primary btn-sm" onclick="addToCart('${product.productID}')">
                                                <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            
            <div class="text-center mt-5">
                <a href="main?action=listProducts" class="btn btn-primary btn-lg">
                    View All Pizzas <i class="fas fa-arrow-right ms-2"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4 text-center">
                    <div class="feature-icon mb-3">
                        <i class="fas fa-shipping-fast fa-3x text-primary"></i>
                    </div>
                    <h4>Fast Delivery</h4>
                    <p class="text-muted">Hot and fresh pizzas delivered in 30 minutes or less</p>
                </div>
                <div class="col-md-4 text-center">
                    <div class="feature-icon mb-3">
                        <i class="fas fa-leaf fa-3x text-success"></i>
                    </div>
                    <h4>Fresh Ingredients</h4>
                    <p class="text-muted">We use only the freshest and highest quality ingredients</p>
                </div>
                <div class="col-md-4 text-center">
                    <div class="feature-icon mb-3">
                        <i class="fas fa-star fa-3x text-warning"></i>
                    </div>
                    <h4>5-Star Quality</h4>
                    <p class="text-muted">Rated #1 pizza place by our satisfied customers</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-pizza-slice me-2"></i>PizzaStore</h5>
                    <p class="text-muted">Delivering happiness, one pizza at a time.</p>
                </div>
                <div class="col-md-6">
                    <h6>Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="main?action=listProducts" class="text-muted">Menu</a></li>
                        <li><a href="main?action=showLogin" class="text-muted">Login</a></li>
                        <li><a href="main?action=showRegister" class="text-muted">Register</a></li>
                    </ul>
                </div>
            </div>
            <hr class="my-4">
            <div class="text-center">
                <p class="mb-0">&copy; 2024 PizzaStore. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function addToCart(productId) {
            // Implementation for adding to cart
            window.location.href = 'main?action=addToCart&productId=' + productId;
        }
    </script>
</body>
</html>
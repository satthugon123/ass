<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pizzas Menu - PizzaStore</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 80px;
            background-color: #f8f9fa;
        }
        .pizza-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
        }
        .pizza-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .search-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
        }
        .admin-badge {
            background: linear-gradient(45deg, #ff6b6b, #ee5a52);
        }
    </style>
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
                        <a class="nav-link" href="main">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="main?action=listProducts">Pizzas</a>
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
                                <a class="nav-link" href="main?action=showLogin">Login</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Search Section -->
    <section class="search-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="text-center mb-4">
                        <h2 class="fw-bold">Our Delicious Pizzas</h2>
                        <p class="lead">Find your perfect pizza from our amazing collection</p>
                    </div>
                    
                    <div class="card shadow">
                        <div class="card-body">
                            <form action="main" method="get">
                                <input type="hidden" name="action" value="searchProducts">
                                <div class="row g-3">
                                    <div class="col-md-5">
                                        <input type="text" class="form-control form-control-lg" 
                                               name="keyword" placeholder="Search pizzas..." 
                                               value="${keyword}">
                                    </div>
                                    <div class="col-md-3">
                                        <select class="form-select form-select-lg" name="searchType">
                                            <option value="name" ${searchType == 'name' ? 'selected' : ''}>By Name</option>
                                            <option value="id" ${searchType == 'id' ? 'selected' : ''}>By ID</option>
                                            <option value="price" ${searchType == 'price' ? 'selected' : ''}>By Price</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary btn-lg w-100">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                    <div class="col-md-2">
                                        <a href="main?action=listProducts" class="btn btn-outline-secondary btn-lg w-100">
                                            <i class="fas fa-redo"></i>
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Admin Controls -->
    <c:if test="${sessionScope.user != null && sessionScope.user.staff}">
        <section class="py-3 bg-warning">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <span class="badge admin-badge me-2">ADMIN</span>
                        <strong>Administrator Panel</strong> - Manage your pizza inventory
                    </div>
                    <div class="col-md-4 text-end">
                        <a href="main?action=showProductForm" class="btn btn-success">
                            <i class="fas fa-plus me-2"></i>Add New Pizza
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </c:if>

    <!-- Products Section -->
    <section class="py-5">
        <div class="container">
            <!-- Results Info -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <h4 class="text-primary">
                        <c:choose>
                            <c:when test="${keyword != null}">
                                Search Results for "${keyword}"
                            </c:when>
                            <c:otherwise>
                                All Pizzas
                            </c:otherwise>
                        </c:choose>
                    </h4>
                    <p class="text-muted">${products.size()} pizzas found</p>
                </div>
                <div class="col-md-6 text-end">
                    <div class="btn-group" role="group">
                        <input type="radio" class="btn-check" name="viewType" id="gridView" checked>
                        <label class="btn btn-outline-primary" for="gridView">
                            <i class="fas fa-th"></i> Grid
                        </label>
                        
                        <input type="radio" class="btn-check" name="viewType" id="listView">
                        <label class="btn btn-outline-primary" for="listView">
                            <i class="fas fa-list"></i> List
                        </label>
                    </div>
                </div>
            </div>

            <!-- Products Grid -->
            <div class="row g-4" id="productsGrid">
                <c:forEach var="product" items="${products}">
                    <div class="col-lg-4 col-md-6">
                        <div class="card pizza-card shadow-sm h-100">
                            <div class="position-relative">
                                <img src="${product.productImage != null ? product.productImage : 'images/default-pizza.jpg'}" 
                                     class="card-img-top" alt="${product.productName}" 
                                     style="height: 250px; object-fit: cover;">
                                
                                <!-- Admin Controls Overlay -->
                                <c:if test="${sessionScope.user != null && sessionScope.user.staff}">
                                    <div class="position-absolute top-0 end-0 p-2">
                                        <div class="btn-group-vertical">
                                            <a href="main?action=editProduct&id=${product.productID}" 
                                               class="btn btn-sm btn-warning" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button class="btn btn-sm btn-danger" 
                                                    onclick="confirmDelete('${product.productID}', '${product.productName}')" 
                                                    title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${product.productName}</h5>
                                <p class="card-text text-muted">
                                    <small><strong>ID:</strong> ${product.productID}</small><br>
                                    <small><strong>Serves:</strong> ${product.quantityPerUnit} people</small>
                                </p>
                                
                                <div class="mt-auto">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="h4 text-primary mb-0">
                                            $<fmt:formatNumber value="${product.unitPrice}" pattern="#,##0.00"/>
                                        </span>
                                        <div class="btn-group">
                                            <button class="btn btn-primary btn-sm" onclick="addToCart('${product.productID}')">
                                                <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- No Results -->
            <c:if test="${products.size() == 0}">
                <div class="text-center py-5">
                    <i class="fas fa-search fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted">No pizzas found</h4>
                    <p class="text-muted">Try adjusting your search criteria or browse all pizzas.</p>
                    <a href="main?action=listProducts" class="btn btn-primary">
                        <i class="fas fa-arrow-left me-2"></i>View All Pizzas
                    </a>
                </div>
            </c:if>
        </div>
    </section>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="productNameToDelete"></strong>?</p>
                    <p class="text-danger"><small>This action cannot be undone.</small></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="deleteConfirmBtn" class="btn btn-danger">Delete</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function addToCart(productId) {
            window.location.href = 'main?action=addToCart&productId=' + productId;
        }

        function confirmDelete(productId, productName) {
            document.getElementById('productNameToDelete').textContent = productName;
            document.getElementById('deleteConfirmBtn').href = 'main?action=deleteProduct&id=' + productId;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        // View type switching (future enhancement)
        document.querySelectorAll('input[name="viewType"]').forEach(radio => {
            radio.addEventListener('change', function() {
                // Toggle between grid and list view
                console.log('View changed to:', this.id);
            });
        });
    </script>
</body>
</html>
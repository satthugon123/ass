<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${product != null}">Edit Product</c:when>
            <c:otherwise>Add New Product</c:otherwise>
        </c:choose>
        - PizzaStore Admin
    </title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 80px;
            background-color: #f8f9fa;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 15px 15px 0 0;
            margin: -2rem -2rem 2rem -2rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 600;
        }
        .preview-image {
            max-width: 200px;
            max-height: 200px;
            object-fit: cover;
            border-radius: 10px;
            border: 3px solid #e9ecef;
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
            
            <div class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-user me-1"></i>Admin Panel
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item active" href="main?action=listProducts">Manage Products</a></li>
                        <li><a class="dropdown-item" href="main?action=listOrders">Manage Orders</a></li>
                        <li><a class="dropdown-item" href="main?action=salesReport">Sales Report</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="main?action=logout">Logout</a></li>
                    </ul>
                </li>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-container">
                    <div class="form-header">
                        <h2 class="mb-0">
                            <c:choose>
                                <c:when test="${product != null}">
                                    <i class="fas fa-edit me-3"></i>Edit Product
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-plus-circle me-3"></i>Add New Product
                                </c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="mb-0 mt-2">
                            <c:choose>
                                <c:when test="${product != null}">
                                    Update the details of your pizza product
                                </c:when>
                                <c:otherwise>
                                    Add a delicious new pizza to your menu
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <!-- Error Message -->
                    <c:if test="${error != null}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="main" method="post" id="productForm">
                        <input type="hidden" name="action" value="${product != null ? 'updateProduct' : 'addProduct'}">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="productID" class="form-label">
                                    <i class="fas fa-barcode me-2"></i>Product ID <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="productID" name="productID" 
                                       value="${product != null ? product.productID : ''}"
                                       ${product != null ? 'readonly' : ''} 
                                       placeholder="e.g., PIZZA013" required>
                                <div class="form-text">
                                    ${product != null ? 'Product ID cannot be changed' : 'Unique identifier for the product'}
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="productName" class="form-label">
                                    <i class="fas fa-pizza-slice me-2"></i>Product Name <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="productName" name="productName" 
                                       value="${product != null ? product.productName : ''}"
                                       placeholder="e.g., Supreme Deluxe Pizza" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="categoryID" class="form-label">
                                    <i class="fas fa-tags me-2"></i>Category <span class="text-danger">*</span>
                                </label>
                                <select class="form-select" id="categoryID" name="categoryID" required>
                                    <option value="">Select a category</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.categoryID}" 
                                                ${product != null && product.categoryID == category.categoryID ? 'selected' : ''}>
                                            ${category.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="supplierID" class="form-label">
                                    <i class="fas fa-truck me-2"></i>Supplier ID
                                </label>
                                <input type="text" class="form-control" id="supplierID" name="supplierID" 
                                       value="${product != null ? product.supplierID : ''}"
                                       placeholder="e.g., SUP001">
                                <div class="form-text">Leave empty if not specified</div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="quantityPerUnit" class="form-label">
                                    <i class="fas fa-users me-2"></i>Serves (People) <span class="text-danger">*</span>
                                </label>
                                <input type="number" class="form-control" id="quantityPerUnit" name="quantityPerUnit" 
                                       value="${product != null ? product.quantityPerUnit : 2}"
                                       min="1" max="10" required>
                                <div class="form-text">Number of people this pizza serves</div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="unitPrice" class="form-label">
                                    <i class="fas fa-dollar-sign me-2"></i>Price (USD) <span class="text-danger">*</span>
                                </label>
                                <input type="number" class="form-control" id="unitPrice" name="unitPrice" 
                                       value="${product != null ? product.unitPrice : ''}"
                                       step="0.01" min="0" placeholder="e.g., 19.99" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="productImage" class="form-label">
                                <i class="fas fa-image me-2"></i>Product Image URL
                            </label>
                            <input type="url" class="form-control" id="productImage" name="productImage" 
                                   value="${product != null ? product.productImage : ''}"
                                   placeholder="e.g., images/supreme-deluxe.jpg">
                            <div class="form-text">URL or path to the product image</div>
                            
                            <!-- Image Preview -->
                            <c:if test="${product != null && product.productImage != null}">
                                <div class="mt-3">
                                    <label class="form-label">Current Image:</label><br>
                                    <img src="${product.productImage}" alt="${product.productName}" 
                                         class="preview-image" onerror="this.style.display='none'">
                                </div>
                            </c:if>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="main?action=listProducts" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Back to Products
                            </a>
                            
                            <div>
                                <c:if test="${product != null}">
                                    <button type="button" class="btn btn-outline-danger me-2" 
                                            onclick="confirmDelete('${product.productID}', '${product.productName}')">
                                        <i class="fas fa-trash me-2"></i>Delete
                                    </button>
                                </c:if>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>
                                    ${product != null ? 'Update Product' : 'Add Product'}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle me-2"></i>Confirm Delete
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="productNameToDelete"></strong>?</p>
                    <div class="alert alert-warning">
                        <i class="fas fa-warning me-2"></i>
                        <strong>Warning:</strong> This action cannot be undone. The product will be permanently removed from the system.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="deleteConfirmBtn" class="btn btn-danger">
                        <i class="fas fa-trash me-2"></i>Delete Product
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(productId, productName) {
            document.getElementById('productNameToDelete').textContent = productName;
            document.getElementById('deleteConfirmBtn').href = 'main?action=deleteProduct&id=' + productId;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        // Image preview
        document.getElementById('productImage').addEventListener('input', function() {
            const url = this.value;
            let preview = document.querySelector('.preview-image');
            
            if (url) {
                if (!preview) {
                    preview = document.createElement('img');
                    preview.className = 'preview-image mt-3';
                    preview.style.display = 'block';
                    this.parentNode.appendChild(preview);
                }
                preview.src = url;
                preview.alt = 'Product Image Preview';
                preview.onerror = function() { this.style.display = 'none'; };
            } else if (preview) {
                preview.style.display = 'none';
            }
        });

        // Form validation
        document.getElementById('productForm').addEventListener('submit', function(e) {
            const productID = document.getElementById('productID').value.trim();
            const productName = document.getElementById('productName').value.trim();
            const categoryID = document.getElementById('categoryID').value;
            const unitPrice = parseFloat(document.getElementById('unitPrice').value);
            const quantityPerUnit = parseInt(document.getElementById('quantityPerUnit').value);

            // Validate Product ID format
            const productIDPattern = /^[A-Z]+[0-9]+$/;
            if (!productIDPattern.test(productID)) {
                e.preventDefault();
                alert('Product ID must start with letters followed by numbers (e.g., PIZZA013)');
                return;
            }

            // Validate required fields
            if (productName === '' || categoryID === '') {
                e.preventDefault();
                alert('Please fill in all required fields!');
                return;
            }

            // Validate price
            if (isNaN(unitPrice) || unitPrice <= 0) {
                e.preventDefault();
                alert('Please enter a valid price greater than 0!');
                return;
            }

            // Validate quantity
            if (isNaN(quantityPerUnit) || quantityPerUnit < 1 || quantityPerUnit > 10) {
                e.preventDefault();
                alert('Serves must be between 1 and 10 people!');
                return;
            }
        });

        // Auto-generate Product ID suggestion
        document.getElementById('productName').addEventListener('input', function() {
            const name = this.value.trim();
            const productIDField = document.getElementById('productID');
            
            // Only suggest if it's a new product and field is empty
            if (name && productIDField.value === '' && !productIDField.hasAttribute('readonly')) {
                const suggestion = 'PIZZA' + String(Math.floor(Math.random() * 900) + 100);
                productIDField.placeholder = 'Suggested: ' + suggestion;
            }
        });
    </script>
</body>
</html>
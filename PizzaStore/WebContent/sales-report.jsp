<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Report - PizzaStore Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 80px;
            background-color: #f8f9fa;
        }
        .report-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .stats-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .stats-card:hover {
            transform: translateY(-5px);
        }
        .table-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .badge-sales {
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
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
                        <li><a class="dropdown-item" href="main?action=listProducts">Manage Products</a></li>
                        <li><a class="dropdown-item" href="main?action=listOrders">Manage Orders</a></li>
                        <li><a class="dropdown-item active" href="main?action=salesReport">Sales Report</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="main?action=logout">Logout</a></li>
                    </ul>
                </li>
            </div>
        </div>
    </nav>

    <!-- Report Header -->
    <section class="report-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-5 fw-bold mb-2">
                        <i class="fas fa-chart-line me-3"></i>Sales Report
                    </h1>
                    <p class="lead mb-0">Analyze your pizza sales performance and trends</p>
                </div>
                <div class="col-md-4 text-end">
                    <button class="btn btn-light btn-lg" onclick="window.print()">
                        <i class="fas fa-print me-2"></i>Print Report
                    </button>
                </div>
            </div>
        </div>
    </section>

    <div class="container">
        <!-- Date Range Selector -->
        <div class="row mb-4">
            <div class="col-lg-8 mx-auto">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="fas fa-calendar-alt me-2"></i>Select Date Range
                        </h5>
                        <form action="main" method="get" class="row g-3">
                            <input type="hidden" name="action" value="salesReport">
                            
                            <div class="col-md-4">
                                <label for="startDate" class="form-label">Start Date</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" 
                                       value="${startDate}" required>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="endDate" class="form-label">End Date</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" 
                                       value="${endDate}" required>
                            </div>
                            
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search me-2"></i>Generate Report
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Error Message -->
        <c:if test="${error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Report Results -->
        <c:if test="${salesData != null}">
            <!-- Summary Statistics -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card stats-card bg-primary text-white">
                        <div class="card-body text-center">
                            <i class="fas fa-pizza-slice fa-2x mb-2"></i>
                            <h3 class="card-title">${salesData.size()}</h3>
                            <p class="card-text">Products Sold</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="card stats-card bg-success text-white">
                        <div class="card-body text-center">
                            <i class="fas fa-dollar-sign fa-2x mb-2"></i>
                            <h3 class="card-title">
                                <c:set var="totalSales" value="0" />
                                <c:forEach var="data" items="${salesData}">
                                    <c:set var="totalSales" value="${totalSales + data[2]}" />
                                </c:forEach>
                                $<fmt:formatNumber value="${totalSales}" pattern="#,##0.00"/>
                            </h3>
                            <p class="card-text">Total Sales</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="card stats-card bg-info text-white">
                        <div class="card-body text-center">
                            <i class="fas fa-shopping-cart fa-2x mb-2"></i>
                            <h3 class="card-title">
                                <c:set var="totalQuantity" value="0" />
                                <c:forEach var="data" items="${salesData}">
                                    <c:set var="totalQuantity" value="${totalQuantity + data[1]}" />
                                </c:forEach>
                                ${totalQuantity}
                            </h3>
                            <p class="card-text">Units Sold</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3">
                    <div class="card stats-card bg-warning text-dark">
                        <div class="card-body text-center">
                            <i class="fas fa-chart-bar fa-2x mb-2"></i>
                            <h3 class="card-title">
                                $<fmt:formatNumber value="${totalSales / salesData.size()}" pattern="#,##0.00"/>
                            </h3>
                            <p class="card-text">Avg per Product</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Report Period Info -->
            <div class="alert alert-info">
                <i class="fas fa-info-circle me-2"></i>
                <strong>Report Period:</strong> 
                <fmt:parseDate value="${startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" />
                <fmt:parseDate value="${endDate}" pattern="yyyy-MM-dd" var="parsedEndDate" />
                <fmt:formatDate value="${parsedStartDate}" pattern="MMMM dd, yyyy" /> - 
                <fmt:formatDate value="${parsedEndDate}" pattern="MMMM dd, yyyy" />
            </div>

            <!-- Detailed Sales Table -->
            <div class="table-container">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">
                                    <i class="fas fa-pizza-slice me-2"></i>Product Name
                                </th>
                                <th scope="col" class="text-center">
                                    <i class="fas fa-list-ol me-2"></i>Quantity Sold
                                </th>
                                <th scope="col" class="text-end">
                                    <i class="fas fa-dollar-sign me-2"></i>Total Sales
                                </th>
                                <th scope="col" class="text-center">
                                    <i class="fas fa-percentage me-2"></i>Sales %
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="data" items="${salesData}" varStatus="status">
                                <tr>
                                    <td>
                                        <span class="badge badge-sales">${status.count}</span>
                                    </td>
                                    <td>
                                        <strong>${data[0]}</strong>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge bg-primary">${data[1]} units</span>
                                    </td>
                                    <td class="text-end">
                                        <strong class="text-success">
                                            $<fmt:formatNumber value="${data[2]}" pattern="#,##0.00"/>
                                        </strong>
                                    </td>
                                    <td class="text-center">
                                        <c:set var="percentage" value="${(data[2] / totalSales) * 100}" />
                                        <div class="progress" style="height: 20px;">
                                            <div class="progress-bar bg-success" role="progressbar" 
                                                 style="width: ${percentage}%" 
                                                 aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100">
                                                <fmt:formatNumber value="${percentage}" pattern="#0.0"/>%
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot class="table-light">
                            <tr>
                                <th colspan="2">TOTAL</th>
                                <th class="text-center">
                                    <span class="badge bg-dark">${totalQuantity} units</span>
                                </th>
                                <th class="text-end">
                                    <strong class="text-success">
                                        $<fmt:formatNumber value="${totalSales}" pattern="#,##0.00"/>
                                    </strong>
                                </th>
                                <th class="text-center">
                                    <span class="badge bg-success">100%</span>
                                </th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <!-- No Data Message -->
            <c:if test="${salesData.size() == 0}">
                <div class="text-center py-5">
                    <i class="fas fa-chart-line fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted">No sales data found</h4>
                    <p class="text-muted">No sales were recorded for the selected date range.</p>
                    <p class="text-muted">Try selecting a different date range or check if there are any orders in the system.</p>
                </div>
            </c:if>

        </c:if>

        <!-- Quick Actions -->
        <div class="row mt-5">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="fas fa-tools me-2"></i>Quick Actions
                        </h5>
                        <div class="d-flex gap-2 flex-wrap">
                            <a href="main?action=listProducts" class="btn btn-outline-primary">
                                <i class="fas fa-pizza-slice me-2"></i>Manage Products
                            </a>
                            <a href="main?action=listOrders" class="btn btn-outline-success">
                                <i class="fas fa-shopping-cart me-2"></i>View Orders
                            </a>
                            <a href="main?action=showProductForm" class="btn btn-outline-warning">
                                <i class="fas fa-plus me-2"></i>Add Product
                            </a>
                            <a href="main" class="btn btn-outline-secondary">
                                <i class="fas fa-home me-2"></i>Back to Home
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set default dates (last 30 days)
        document.addEventListener('DOMContentLoaded', function() {
            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');
            
            if (!startDateInput.value) {
                const thirtyDaysAgo = new Date();
                thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
                startDateInput.value = thirtyDaysAgo.toISOString().split('T')[0];
            }
            
            if (!endDateInput.value) {
                const today = new Date();
                endDateInput.value = today.toISOString().split('T')[0];
            }
        });

        // Validate date range
        document.querySelector('form').addEventListener('submit', function(e) {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);
            
            if (startDate > endDate) {
                e.preventDefault();
                alert('Start date cannot be later than end date!');
            }
        });
    </script>
</body>
</html>
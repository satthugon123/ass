<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Oops! Something went wrong - PizzaStore</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Arial', sans-serif;
        }
        .error-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            text-align: center;
            max-width: 600px;
            margin: 0 auto;
        }
        .error-icon {
            font-size: 5rem;
            color: #e74c3c;
            margin-bottom: 2rem;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        .error-code {
            font-size: 6rem;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        .btn {
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-container">
            <!-- Pizza Icon -->
            <div class="error-icon">
                <i class="fas fa-pizza-slice"></i>
            </div>

            <!-- Error Code -->
            <div class="error-code">
                <c:choose>
                    <c:when test="${pageContext.errorData.statusCode == 404}">
                        404
                    </c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">
                        500
                    </c:when>
                    <c:otherwise>
                        Error
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Error Message -->
            <h2 class="text-primary mb-3">
                <c:choose>
                    <c:when test="${pageContext.errorData.statusCode == 404}">
                        Page Not Found!
                    </c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">
                        Internal Server Error!
                    </c:when>
                    <c:otherwise>
                        Something went wrong!
                    </c:otherwise>
                </c:choose>
            </h2>

            <p class="text-muted mb-4">
                <c:choose>
                    <c:when test="${pageContext.errorData.statusCode == 404}">
                        Sorry, the page you're looking for doesn't exist. 
                        It might have been moved, deleted, or you entered the wrong URL.
                    </c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">
                        We're experiencing some technical difficulties. 
                        Our team has been notified and is working to fix this issue.
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${error != null}">
                                ${error}
                            </c:when>
                            <c:otherwise>
                                We encountered an unexpected error while processing your request.
                                Please try again later or contact support if the problem persists.
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </p>

            <!-- Error Details (for development) -->
            <c:if test="${pageContext.errorData.throwable != null}">
                <div class="alert alert-danger text-start mt-4" style="display: none;" id="errorDetails">
                    <h6><i class="fas fa-bug me-2"></i>Technical Details:</h6>
                    <small>
                        <strong>Exception:</strong> ${pageContext.errorData.throwable.class.name}<br>
                        <strong>Message:</strong> ${pageContext.errorData.throwable.message}<br>
                        <strong>URI:</strong> ${pageContext.errorData.requestURI}
                    </small>
                </div>
                <button class="btn btn-outline-secondary btn-sm mt-2" onclick="toggleErrorDetails()">
                    <i class="fas fa-code me-2"></i>Show Technical Details
                </button>
            </c:if>

            <!-- Action Buttons -->
            <div class="mt-4">
                <a href="main" class="btn btn-primary btn-lg me-3">
                    <i class="fas fa-home me-2"></i>Go Home
                </a>
                <button class="btn btn-outline-secondary btn-lg" onclick="history.back()">
                    <i class="fas fa-arrow-left me-2"></i>Go Back
                </button>
            </div>

            <!-- Additional Help -->
            <div class="mt-4 pt-4 border-top">
                <p class="text-muted mb-2">
                    <small>Need help? Try these options:</small>
                </p>
                <div class="d-flex justify-content-center gap-3 flex-wrap">
                    <a href="main?action=listProducts" class="text-decoration-none">
                        <i class="fas fa-pizza-slice me-1"></i>Browse Pizzas
                    </a>
                    <a href="main?action=showLogin" class="text-decoration-none">
                        <i class="fas fa-sign-in-alt me-1"></i>Login
                    </a>
                    <a href="main?action=showRegister" class="text-decoration-none">
                        <i class="fas fa-user-plus me-1"></i>Register
                    </a>
                </div>
            </div>

            <!-- Fun Fact -->
            <div class="mt-4">
                <div class="alert alert-info">
                    <i class="fas fa-lightbulb me-2"></i>
                    <strong>Did you know?</strong> The first pizza was made in Naples, Italy in 1889!
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleErrorDetails() {
            const details = document.getElementById('errorDetails');
            const button = event.target;
            
            if (details.style.display === 'none') {
                details.style.display = 'block';
                button.innerHTML = '<i class="fas fa-code me-2"></i>Hide Technical Details';
            } else {
                details.style.display = 'none';
                button.innerHTML = '<i class="fas fa-code me-2"></i>Show Technical Details';
            }
        }

        // Auto-hide technical details after 10 seconds if shown
        setTimeout(function() {
            const details = document.getElementById('errorDetails');
            if (details && details.style.display === 'block') {
                details.style.display = 'none';
                const button = document.querySelector('button[onclick="toggleErrorDetails()"]');
                if (button) {
                    button.innerHTML = '<i class="fas fa-code me-2"></i>Show Technical Details';
                }
            }
        }, 10000);
    </script>
</body>
</html>
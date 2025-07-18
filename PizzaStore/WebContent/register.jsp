<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - PizzaStore</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .register-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card register-card">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <i class="fas fa-pizza-slice fa-3x text-primary mb-3"></i>
                            <h2 class="fw-bold">Join PizzaStore!</h2>
                            <p class="text-muted">Create your account to start ordering delicious pizzas</p>
                        </div>

                        <!-- Error Message -->
                        <c:if test="${error != null}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="main" method="post" id="registerForm">
                            <input type="hidden" name="action" value="register">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="accountID" class="form-label">
                                        <i class="fas fa-id-card me-2"></i>Account ID
                                    </label>
                                    <input type="text" class="form-control" id="accountID" name="accountID" 
                                           placeholder="Enter unique account ID" required>
                                    <div class="form-text">This will be your unique identifier</div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="username" class="form-label">
                                        <i class="fas fa-user me-2"></i>Username
                                    </label>
                                    <input type="text" class="form-control" id="username" name="username" 
                                           placeholder="Choose a username" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="fullName" class="form-label">
                                    <i class="fas fa-user-circle me-2"></i>Full Name
                                </label>
                                <input type="text" class="form-control" id="fullName" name="fullName" 
                                       placeholder="Enter your full name" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock me-2"></i>Password
                                    </label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="password" name="password" 
                                               placeholder="Create password" required>
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password')">
                                            <i class="fas fa-eye" id="toggleIcon1"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="confirmPassword" class="form-label">
                                        <i class="fas fa-lock me-2"></i>Confirm Password
                                    </label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="confirmPassword" 
                                               placeholder="Confirm password" required>
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword')">
                                            <i class="fas fa-eye" id="toggleIcon2"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="type" class="form-label">
                                    <i class="fas fa-users me-2"></i>Account Type
                                </label>
                                <select class="form-select" id="type" name="type" required>
                                    <option value="">Select account type</option>
                                    <option value="2">Customer</option>
                                    <option value="1">Staff (Admin approval required)</option>
                                </select>
                                <div class="form-text">
                                    Staff accounts require administrator approval before activation
                                </div>
                            </div>

                            <div class="mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="terms" required>
                                    <label class="form-check-label" for="terms">
                                        I agree to the <a href="#" class="text-primary">Terms of Service</a> 
                                        and <a href="#" class="text-primary">Privacy Policy</a>
                                    </label>
                                </div>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-user-plus me-2"></i>Create Account
                                </button>
                            </div>
                        </form>

                        <div class="text-center">
                            <p class="mb-0">Already have an account? 
                                <a href="main?action=showLogin" class="text-primary text-decoration-none fw-bold">
                                    Sign in here
                                </a>
                            </p>
                        </div>

                        <div class="text-center mt-4">
                            <a href="main" class="text-muted text-decoration-none">
                                <i class="fas fa-arrow-left me-2"></i>Back to Home
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const icon = fieldId === 'password' ? document.getElementById('toggleIcon1') : document.getElementById('toggleIcon2');
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                field.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }

        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const accountID = document.getElementById('accountID').value.trim();
            const username = document.getElementById('username').value.trim();
            const fullName = document.getElementById('fullName').value.trim();
            const type = document.getElementById('type').value;
            const terms = document.getElementById('terms').checked;

            // Check if passwords match
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return;
            }

            // Check password strength
            if (password.length < 4) {
                e.preventDefault();
                alert('Password must be at least 4 characters long!');
                return;
            }

            // Check required fields
            if (accountID === '' || username === '' || fullName === '' || type === '') {
                e.preventDefault();
                alert('Please fill in all required fields!');
                return;
            }

            // Check terms acceptance
            if (!terms) {
                e.preventDefault();
                alert('Please accept the terms and conditions!');
                return;
            }

            // Validate account ID format (alphanumeric)
            const accountIDPattern = /^[a-zA-Z0-9]+$/;
            if (!accountIDPattern.test(accountID)) {
                e.preventDefault();
                alert('Account ID can only contain letters and numbers!');
                return;
            }
        });
    </script>
</body>
</html>
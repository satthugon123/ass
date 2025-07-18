# PizzaStore - Java Web Application

A comprehensive Java Web Application for pizza store management built using **MVC2 Model**, **JavaBean**, **JSP**, **JSTL**, **Custom Tags**, **EL**, **Filters**, and **Servlets** with **SQL Server** database.

## 🍕 Features

### Core Functionality
- **Member Management**: User registration, login, profile management
- **Product Management**: CRUD operations for pizza products
- **Order Management**: Complete order processing system
- **Search**: Advanced search by ID, ProductName (case-insensitive), and UnitPrice
- **Sales Reports**: Statistics by date range with descending order sorting
- **User Authentication**: Staff vs Customer role-based access control

### Technical Features
- **MVC2 Architecture**: Clean separation of concerns
- **CRUD Operations**: Complete Create, Read, Update, Delete functionality
- **Data Validation**: Type validation for all fields
- **JDBC Integration**: Direct database operations with SQL Server
- **Session Management**: Secure user sessions and authentication
- **Responsive Design**: Modern UI with Bootstrap 5
- **Error Handling**: Comprehensive error management

### User Roles
- **Staff (Type=1)**: Full access to all management features
- **Normal User (Type=2)**: Profile management, ordering, order history viewing

## 🏗️ Project Structure

```
PizzaStore/
│
├── 📁 src/
│   ├── 📁 controller/
│   │   └── MainController.java          # Main servlet handling all requests
│   ├── 📁 model/                        # DTO classes
│   │   ├── Account.java
│   │   ├── Customer.java
│   │   ├── Category.java
│   │   ├── Supplier.java
│   │   ├── Product.java
│   │   ├── Order.java
│   │   └── OrderDetail.java
│   ├── 📁 dao/                          # Data Access Objects
│   │   ├── AccountDAO.java
│   │   ├── ProductDAO.java
│   │   ├── CategoryDAO.java
│   │   └── OrderDAO.java
│   ├── 📁 utils/
│   │   └── DBContext.java               # Database connection utility
│   └── 📁 filter/
│       └── AuthenticationFilter.java    # Security filter
│
├── 📁 WebContent/
│   ├── 📁 WEB-INF/
│   │   └── web.xml                      # Deployment descriptor
│   ├── 📁 css/
│   │   └── style.css                    # Custom styles
│   ├── 📁 js/                           # JavaScript files
│   ├── 📁 images/                       # Product images
│   ├── index.jsp                        # Home page
│   ├── login.jsp                        # Login page
│   ├── register.jsp                     # Registration page
│   ├── products.jsp                     # Product listing
│   └── sales-report.jsp                 # Sales analytics
│
└── database-script.sql                  # Database creation script
```

## 🚀 Setup Instructions

### Prerequisites
- **Java 8+**
- **Apache Tomcat 9+**
- **SQL Server 2017+**
- **IDE**: Eclipse, IntelliJ IDEA, or VS Code

### Database Setup
1. Install SQL Server and SQL Server Management Studio
2. Run the `database-script.sql` file to create the database and tables
3. Update database connection settings in `src/utils/DBContext.java`:
   ```java
   private static final String SERVER = "localhost";
   private static final String PORT = "1433";
   private static final String DATABASE = "PizzaStore";
   private static final String USERNAME = "sa";
   private static final String PASSWORD = "your_password";
   ```

### Application Setup
1. **Clone/Download** the project
2. **Import** into your IDE as a Dynamic Web Project
3. **Add Libraries**:
   - SQL Server JDBC Driver (`mssql-jdbc-x.x.x.jre8.jar`)
   - JSTL Libraries (`jstl-1.2.jar`, `standard-1.1.2.jar`)
   - Servlet API (usually provided by Tomcat)

4. **Configure Tomcat Server** in your IDE
5. **Deploy** the application to Tomcat
6. **Access** the application at `http://localhost:8080/PizzaStore`

### Required JAR Files
Add these JAR files to `WebContent/WEB-INF/lib/`:
- `mssql-jdbc-12.4.1.jre8.jar` (SQL Server JDBC Driver)
- `jstl-1.2.jar` (JSTL Core)
- `standard-1.1.2.jar` (JSTL Standard Tag Library)

## 🔑 Default Credentials

### Admin Account
- **Username**: `admin`
- **Password**: `admin`
- **Type**: Staff (Full access)

### Customer Account
- **Username**: `user`
- **Password**: `user`
- **Type**: Customer (Limited access)

## 📱 User Interface Features

### Modern Design
- **Responsive Layout**: Works on desktop, tablet, and mobile
- **Bootstrap 5**: Modern UI components and styling
- **Font Awesome Icons**: Professional icon set
- **Custom CSS**: Beautiful gradients and animations
- **Interactive Elements**: Hover effects, modals, and transitions

### Key Pages
1. **Home Page**: Featured pizzas, search functionality
2. **Products Page**: Full pizza catalog with search and filters
3. **Login/Register**: Secure authentication
4. **Admin Dashboard**: Product management, sales reports
5. **Sales Reports**: Detailed analytics with charts and graphs

## 🔍 Search Functionality

The application supports advanced search capabilities:
- **By ID**: Exact product ID matching
- **By Name**: Case-insensitive partial matching
- **By Price**: Exact price matching
- **Combined Search**: Multiple criteria support

## 📊 Database Schema

### Core Tables
- **Account**: User authentication and authorization
- **Products**: Pizza inventory management
- **Categories**: Product categorization
- **Suppliers**: Vendor information
- **Customers**: Customer details
- **Orders**: Order header information
- **OrderDetails**: Order line items

### Key Relationships
- Products → Categories (Many-to-One)
- Products → Suppliers (Many-to-One)
- Orders → Customers (Many-to-One)
- OrderDetails → Orders (Many-to-One)
- OrderDetails → Products (Many-to-One)

## 🔧 Technical Implementation

### MVC2 Architecture
- **Model**: JavaBeans (DTOs) for data representation
- **View**: JSP pages with JSTL for presentation
- **Controller**: Servlets for request processing

### Security Features
- **Authentication Filter**: Protects admin pages
- **Session Management**: Secure user sessions
- **Role-based Access**: Staff vs Customer permissions
- **Input Validation**: SQL injection prevention

### JDBC Operations
- **Connection Pooling**: Efficient database connections
- **Prepared Statements**: Secure SQL execution
- **Transaction Management**: Data consistency
- **Error Handling**: Robust exception management

## 🧪 Testing

### Test the Application
1. **Register** a new customer account
2. **Login** with admin credentials
3. **Add/Edit/Delete** products
4. **Search** for products using different criteria
5. **Place** test orders
6. **Generate** sales reports
7. **Test** role-based access control

### Sample Data
The database script includes sample data:
- 12 pizza products
- 5 categories
- 5 suppliers
- 5 customers
- 5 sample orders

## 🚨 Troubleshooting

### Common Issues
1. **Database Connection Failed**
   - Check SQL Server is running
   - Verify connection string in `DBContext.java`
   - Ensure JDBC driver is in classpath

2. **404 Errors**
   - Verify Tomcat deployment
   - Check web.xml configuration
   - Ensure all JSP files are in correct locations

3. **Login Issues**
   - Verify database contains sample data
   - Check password matching in `AccountDAO.java`
   - Clear browser cache and cookies

## 📝 Assignment Requirements Met

✅ **MVC2 Model Implementation**  
✅ **JavaBean, JSP, JSTL & Custom Tag**  
✅ **EL (Expression Language)**  
✅ **Filter and Servlet**  
✅ **CRUD Operations using JDBC**  
✅ **Data Type Validation**  
✅ **Search Functionality** (ID, ProductName, UnitPrice)  
✅ **Sales Reports** with date range and sorting  
✅ **Member Registration** with unique AccountID  
✅ **Role-based Access Control** (Staff vs Normal User)  
✅ **SQL Server Database**  

## 🎯 Future Enhancements

- Shopping cart functionality
- Payment integration
- Email notifications
- Product reviews and ratings
- Inventory management
- Multi-language support
- REST API endpoints
- Mobile application

## 👥 Contributing

1. Fork the project
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📄 License

This project is created for educational purposes as part of a Java Web Application assignment.

---

**Developed with ❤️ for PizzaStore Management System**
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Detail</title>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <style type="text/css">
            #addAccountForm label.error{
                color: red;
                width: 250px;
                font-style: italic;
            }
            
            #formCheckPass label.error{
                color: red;
                width: 250px;
                font-style: italic;
            }
        </style>
        <style>
            .navbar-brand {
                padding-right: 70%;
            }
            .jumbotron-heading {
                font-family: sans-serif;
                color: #990000;
                text-shadow: -2px -2px 0 white, 2px -2px 0 white, -2px 2px 0 white, 2px 2px 0 white;
            }
            .lead {
            }
        </style>
        <script>
            function myFunction() {
                var x = document.getElementById("txtConfirmPassword");
                if (x.type === "password") {
                     x.type = "text";
                } else {
                    x.type = "password";
                }
                
                var y = document.getElementById("txtNewPassword");
                if (y.type === "password") {
                     y.type = "text";
                } else {
                    y.type = "password";
                }
                
                var z = document.getElementById("txtReNewPassword");
                if (z.type === "password") {
                     z.type = "text";
                } else {
                    z.type = "password";
                }
            }
        </script>
    </head>
    <body>
        <script type="text/javascript" src="js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="js/jquery.validate.js"></script>
        <script type="text/javascript" src="js/additional-methods.js"></script>
        <script type="text/javascript">
            $(function () {
                $("#addAccountForm").validate({
                    rules: {
                        txtAccFullName: {
                            required: true,
                            rangelength: [5, 60]
                        },
                        txtAccAddress: {
                            required: true,
                            rangelength: [10, 100]
                        },
                        txtAccPhoneNumber: {
                            required: true,
                            number: true,
                            minlength: 10,
                            maxlength: 12
                        }
                    },
                    messages: {
                        txtAccFullName: {
                            required: " Please input Full Name!",
                            rangelength: " Full Name must be 5-60 characters long!"
                        },
                        txtAccAddress: {
                            required: " Please input Address!",
                            rangelength: " Address must be 10-100 characters long!"
                        },
                        txtAccPhoneNumber: {
                            required: " Please input Phone number!",
                            number: " Please input number only!",
                            minlength: " Min length is 10!",
                            maxlength: " Max length is 12!"
                        }
                    }
                })
            });
        </script>
        <script type="text/javascript">
            $(function () {
                $("#formCheckPass").validate({
                    rules: {
                        txtConfirmPassword: {
                            required: true,
                            rangelength: [8, 20],
                            equalTo: function () {
                                return document.getElementById("txtAccPassword");
                            }
                        },
                        txtNewPassword: {
                            required: true,
                            rangelength: [8, 20],
                            notEqualTo: function () {
                                return document.getElementById("txtAccPassword");
                            }
                        },
                        txtReNewPassword: {
                            required: true,
                            rangelength: [8, 20],
                            equalTo: function () {
                                return document.getElementById("txtNewPassword");
                            }
                        }
                    },
                    messages: {
                        txtConfirmPassword: {
                            required: " Please input your current Password!",
                            rangelength: " Password must be 8-20 characters long!",
                            equalTo: "Your current Password is Wrong!"
                        },
                        txtNewPassword: {
                            required: " Please input new Password!",
                            rangelength: " Password must be 8-20 characters long!",
                            notEqualTo: "New Password must not be the same with current Password!"
                        },
                        txtReNewPassword: {
                            required: " Please input new Password again!",
                            rangelength: " Password must be 8-20 characters long!",
                            equalTo: "Not equal to your new Password!"
                        }
                    }
                })
            });
        </script>
        <!--begin of menu-->
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <a class="navbar-brand" href="home"> <img src="images/logo.png" alt="Home" width="120px" height="55px" style="background: 100% 100%; margin: auto; padding: auto;"></img></a>

            <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                <c:set var="userEmail" value="${sessionScope.CURRENT_USER.getEmail()}"/>
                <c:if test="${empty userEmail}">
                    <ul class="navbar-nav m-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="Login.jsp">Login <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="Registration.jsp">Sign Up</a>
                        </li>
                    </ul>
                </c:if>
                <c:if test="${not empty userEmail}">
                    <ul class="navbar-nav m-auto">
                        <li class="nav-item active">
                            <b class="nav-link" style="color: white">Welcome, ${sessionScope.CURRENT_USER.getFullName()}</b>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="UpdateAccount?Email=${userEmail}">Profile <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="logOut">Log Out</a>
                        </li>
                    </ul>
                </c:if>
            </div>
        </nav>
        <section class="jumbotron text-center" style="background-image: url('images/Home_Background.jpg'); background-repeat: repeat;">
            <div class="container-fluid">
                <h1 class="jumbotron-heading">BAKERY STARTUP </h1>
                <p class="lead text-muted mb-0">High quality products only!</p>
            </div>
        </section>
        <c:set var="accountDto" value="${requestScope.ACCOUNT_DETAIL}"/>
        <c:set var="user" value="${sessionScope.CURRENT_USER.getEmail()}"/>
        <div class="container-fluid">
            <div class="row">
                <!--Left side of the page - The Dashboard-->

                <div class="col-sm-2">
                    <c:if test="${sessionScope.CURRENT_USER.getRole().getName().trim() eq 'Marketing'}">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="ManageProduct">Manage Product</a></li>
                            <li class="list-group-item text-white" ><a href="CategoryManaging">Manage Category</a></li>
                        </ul>
                    </c:if>
                    <c:if test="${sessionScope.CURRENT_USER.getRole().getRoleId() == 2}">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="getPendingOrder">Manage Order</a></li>
                            <li class="list-group-item text-white" ><a href="manageProduct?index=1">View Product List</a></li>
                        </ul>
                    </c:if>
                    <c:if test="${sessionScope.CURRENT_USER.getRole().getRoleId() == 0}">    
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="ManageUser">Manage User</a></li>
                        </ul>
                    </c:if>
                    <c:if test="${sessionScope.CURRENT_USER.getRole().getRoleId() == 3}">    
                        <form action="SearchProduct" method="post" id="SearchProductForm">
                            <input type="hidden" name="jspname" value="home" />
                            <div class="input-group input-group-sm">
                                <input name="txtSearchValue" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search..." value="${param.txtSearchValue}" maxlength="20">
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-secondary btn-number">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </div></br>
                            <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories </div>
                            <ul class="list-group category_block">
                                <c:set var="categoryList" value="${applicationScope.CAKE_CATEGORY_LIST}"/>
                                <c:forEach items="${categoryList}" var="cateDto">
                                    <li class="list-group-item text-white" ><a href="filterProductByCategory?categoryID=${cateDto.categoryId}">${cateDto.name}</a></li>
                                    </c:forEach>
                            </ul>
                        </form>
                        <c:if test="${not empty user}">
                            <c:set var="numberCart" value="${sessionScope.NUMBER_CART}"/>
                            <a href="Cart.jsp"><div class="list-group-item btn card-header bg-primary text-white text-uppercase">View my Cart <c:if test="${numberCart gt 0}"><span style="display: inline-block;" class="noti" data-count="${numberCart}" /></c:if></div></a>
                                <a href="OrderHistory"><div class="list-group-item btn card-header bg-primary text-white text-uppercase">View my Order History</div></a>
                        </c:if>
                    </c:if>
                </div>
                <div class="col-sm-10">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <form action="updateAccountInfo" id="addAccountForm">
                                <div class="modal-header">						
                                    <h4 class="modal-title">Account Details</h4>
                                    <a data-toggle="modal" data-target="#modalConfirmPass" class="btn btn-success" style="float: right;"><span>Change Password</span></a>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group" style="display: flex; ">
                                        <span style="width: 50%; float:left;">
                                            <label>Email</label>
                                            <input value="${accountDto.email.trim()}" name="txtAccEmail" minlength="5" maxlength="60" type="text" style="width: 80%;" class="form-control" readonly>
                                        </span>
                                        <span style="width: 50%; float:right;">
                                            <label>Password</label>
                                            <input value="${accountDto.password.trim()}" name="txtAccPassword" minlength="8" maxlength="20" type="password" style="width: 80%;" class="form-control" id="txtAccPassword" readonly>
                                        </span>
                                    </div>
                                    <div class="form-group" style="display: flex; ">
                                        <span style="width: 50%; float:left;">
                                            <label>Full Name</label>
                                            <input value="${accountDto.fullName.trim()}" name="txtAccFullName" minlength="5" maxlength="60" type="text" style="width: 80%;" class="form-control" >
                                        </span>
                                        <span style="width: 50%; float:right;">
                                            <label>Address</label>
                                            <input value="${accountDto.address.trim()}" name="txtAccAddress" type="text" minlength="10" maxlength="100" type="text" style="width: 80%;" class="form-control" >
                                        </span>
                                    </div>
                                    <div class="form-group" style="display: flex; ">
                                        <span style="width: 50%; float:left;">
                                            <label>Phone Number</label>
                                            <input value="${accountDto.phoneNumber.trim()}" name="txtAccPhoneNumber" type="text" style="width: 80%;" class="form-control" >
                                        </span>
                                        <span style="width: 50%; float:right;">
                                            <label>Creation Date</label>
                                            <input value="${accountDto.creationDate}" name="txtAccDate" type="text" style="width: 80%;" class="form-control" readonly>
                                        </span>
                                    </div>
                                    <div class="form-group" style="display: flex; ">
                                        <span style="width: 30%;">
                                            Gender: 
                                            <select name="txtAccGender" class="form-select">
                                                <option value="Male" <c:if test="${accountDto.gender.trim() eq 'Male'}">selected</c:if>>Male</option>
                                                <option value="Female" <c:if test="${accountDto.gender.trim() eq 'Female'}">selected</c:if>>Female</option>
                                                </select>
                                            </span>
                                            <span style="width: 30%;">
                                                <input value="${accountDto.role.roleId}" name="txtAccRole" type="hidden">
                                            Role: <b>${accountDto.role.name}</b>
                                        </span>
                                    </div>    
                                </div>
                                <div class="modal-footer">
                                    <input type="submit" class="btn btn-info" value="Save">
                                    <a href="home"><input type="button" class="btn btn-default" data-dismiss="modal" value="Back"></a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>                    
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
        <!--Modal Confirm Pass-->
        <div id="modalConfirmPass" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="updateAccountPassword" id="formCheckPass">
                        <div class="modal-header">						
                            <h4 class="modal-title">Change Password</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <input value="${accountDto.email.trim()}" name="txtAccEmail" type="hidden">
                            <div class="form-group">
                                <label>Please enter your current Password</label>
                                <input name="txtConfirmPassword" minlength="8" maxlength="20" type="password" style="width: 50%;" class="form-control" id="txtConfirmPassword">
                            </div>
                            <div class="form-group">
                                <label>Please enter new Password</label>
                                <input name="txtNewPassword" minlength="8" maxlength="20" type="password" style="width: 50%;" class="form-control" id="txtNewPassword">
                            </div>
                            <div class="form-group">
                                <label>Please enter new Password again</label>
                                <input name="txtReNewPassword" minlength="8" maxlength="20" type="password" style="width: 50%;" class="form-control" id="txtReNewPassword">
                            </div>
                            <input type="checkbox" onclick="myFunction()"> Show Password
                        </div>
                        <div class="modal-footer">
                            <input type="submit" class="btn btn-info" value="Save">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Detail</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <style type="text/css">
            #addAccountForm label.error{
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
    </head>
    <body>
        <script type="text/javascript" src="js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="js/jquery.validate.js"></script>
        <script type="text/javascript" src="js/additional-methods.js"></script>
        <script type="text/javascript">
            $(function () {
                $("#addAccountForm").validate({
                    rules: {
                        txtAccEmail: {
                            required: true,
                            email: true,
                            rangelength: [5, 60]
                        },
                        txtAccPassword: {
                            required: true,
                            rangelength: [8, 20]
                        },
                        txtAccConfirmPassword: {
                            required: true,
                            equalTo: "#txtAccPassword"
                        },
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
                        txtAccEmail: {
                            required: " Please input Email!",
                            email: " Wrong Email format!",
                            rangelength: " Email must be 5-60 characters long!"
                        },
                        txtAccPassword: {
                            required: " Please input Password!",
                            rangelength: " Password must be 8-20 characters long!"
                        },
                        txtAccConfirmPassword: {
                            required: " Please input Password again to confirm!",
                            equalTo: " Not equal to Password!"
                        },
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
            <div class="container">
                <h1 class="jumbotron-heading">BAKERY STARTUP </h1>
                <p class="lead text-muted mb-0">High quality products only!</p>
            </div>
        </section>
        <div class="container-fluid">
            <div class="row">
                    <!--Left side of the page - The Dashboard-->
                    <div class="col-sm-2">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="ManageUser">Manage User</a></li>
                        </ul>
                    </div>
            <div id="editAccount" class="col-sm-10">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <form action="addAccount" id="addAccountForm">
                            <div class="modal-header">						
                                <h4 class="modal-title">Add new Account</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group" style="display: flex; ">
                                    <span style="width: 50%; float:left;">
                                    <label>Email</label>
                                    <input value="${accountDto.email.trim()}" name="txtAccEmail" minlength="5" maxlength="60" type="text" style="width: 80%;" class="form-control" >
                                    </span>
                                    <span style="width: 50%; float:right;">
                                    <label>Full Name</label>
                                    <input value="${accountDto.fullName.trim()}" name="txtAccFullName" minlength="5" maxlength="60" type="text" style="width: 80%;" class="form-control">
                                    </span>
                                </div>
                                <div class="form-group" style="display: flex; ">
                                    <span style="width: 50%; float:left;">
                                    <label>Password</label>
                                    <input value="${accountDto.password.trim()}" name="txtAccPassword" minlength="8" maxlength="20" type="text" style="width: 80%;" class="form-control" id="txtAccPassword">
                                    </span>
                                    <span style="width: 50%; float:right;">
                                    <label>Confirm Password</label>
                                    <input value="${accountDto.password.trim()}" name="txtAccConfirmPassword" minlength="8" maxlength="20" type="text" style="width: 80%;" class="form-control" >
                                    </span>
                                </div>
                                <div class="form-group" style="display: flex; ">
                                    <span style="width: 50%; float:left;">
                                    <label>Address</label>
                                    <input value="${accountDto.address.trim()}" name="txtAccAddress" type="text" minlength="10" maxlength="100" type="text" style="width: 80%;" class="form-control">
                                    </span>
                                    <span style="width: 50%; float:right;">
                                    <label>Phone Number</label>
                                    <input value="${accountDto.phoneNumber.trim()}" name="txtAccPhoneNumber" type="text" minlength="10" maxlength="12" type="text" style="width: 80%;" class="form-control">
                                    </span>
                                </div>
                                <div class="form-group" style="display: flex; ">
                                    <span style="width: 30%;">
                                    <label>Gender</label>
                                    <select name="txtAccGender" class="form-select">
                                        <option value="Male" <c:if test="${accountDto.gender.trim() eq 'Male'}">selected</c:if>>Male</option>
                                        <option value="Female" <c:if test="${accountDto.gender.trim() eq 'Female'}">selected</c:if>>Female</option>
                                    </select>
                                    </span>
                                    <span style="width: 30%;">
                                    <label>Role</label>
                                    <select id = "txtAccRole" name="txtAccRole" class="form-select">
                                        <option value="0" <c:if test="${accountDto.roleID == 0}">selected</c:if>>Admin</option>
                                        <option value="1" <c:if test="${accountDto.roleID == 1}">selected</c:if>>Marketing</option>
                                        <option value="2" <c:if test="${accountDto.roleID == 2}">selected</c:if>>Sale</option>
                                        <option value="3" <c:if test="${accountDto.roleID == 3}">selected</c:if>>Customer</option>
                                    </select>
                                    </span>
                                    <span style="width: 30%;">
                                    <label>Status</label>
                                        <select name="txtAccStatus" class="form-select">
                                            <option value="true" <c:if test="${accountDto.status}">selected</c:if>>True</option>
                                            <option value="false" <c:if test="${!accountDto.status}">selected</c:if>>False</option>
                                        </select>
                                    </span>
                                </div>
                                
                                </div>
                                <div class="modal-footer">
                                    <input type="submit" class="btn btn-info" value="Save">
                                    <a href="manageUser"><input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel"></a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>                        
            </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>

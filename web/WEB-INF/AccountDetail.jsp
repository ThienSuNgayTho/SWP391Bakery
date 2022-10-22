<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Detail</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
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
        <c:set var="accountDto" value="${requestScope.ACCOUNT_DETAIL}"/>
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
                            <form action="updateAccountInfo" id="addAccountForm">
                                <div class="modal-header">						
                                    <h4 class="modal-title">Account Details</h4>
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
                                            <input value="${accountDto.fullName.trim()}" name="txtAccFullName" minlength="5" maxlength="60" type="text" style="width: 80%;" class="form-control" readonly>
                                        </span>
                                        <span style="width: 50%; float:right;">
                                            <label>Address</label>
                                            <input value="${accountDto.address.trim()}" name="txtAccAddress" type="text" minlength="10" maxlength="100" type="text" style="width: 80%;" class="form-control" readonly>
                                        </span>
                                    </div>
                                    <div class="form-group" style="display: flex; ">
                                        <span style="width: 50%; float:left;">
                                            <label>Phone Number</label>
                                            <input value="${accountDto.phoneNumber.trim()}" name="txtAccPhoneNumber" type="text" style="width: 80%;" class="form-control" readonly>
                                        </span>
                                        <span style="width: 50%; float:right;">
                                            <label>Creation Date</label>
                                            <input value="${accountDto.creationDate}" name="txtAccDate" type="text" style="width: 80%;" class="form-control" readonly>
                                        </span>
                                    </div>
                                    <div class="form-group" style="display: flex; ">
                                        <span style="width: 30%;">
                                            Gender: <b>${accountDto.gender.trim()}</b>
                                        </span>
                                        <span style="width: 30%;">
                                            Role: <b>${accountDto.role.name}</b>
                                        </span>
                                        <span style="width: 30%;">
                                            Status: 
                                            <c:if test="${accountDto.status}"><span class="update-link-true" onclick="changeStatus('${accountDto.email}', '${accountDto.status}')">Activated</span></c:if>
                                            <c:if test="${!accountDto.status}"><span class="update-link-false" onclick="changeStatus('${accountDto.email}', '${accountDto.status}')">Deactivated</span></c:if>
                                            </span>
                                        </div>    
                                    </div>
                                    <div class="modal-footer">
                                        <a href="manageUser"><input type="button" class="btn btn-default" data-dismiss="modal" value="Back"></a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>                    
            </div>
        <jsp:include page="Footer.jsp"></jsp:include>
        <script>
            function changeStatus(email, status) {
                $.ajax({
                    url: "/bakeryShopping/UpdateAccountStatus",
                    type: "get", //send it through get method
                    data: {
                        Email: email,
                        Status: status
                    },
                    success: function (response) {
                        location.reload();
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            }
        </script>
    </body>
</html>
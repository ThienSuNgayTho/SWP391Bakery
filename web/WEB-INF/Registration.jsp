<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
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
                        email: {
                            required: true,
                            email: true,
                            rangelength: [5, 60]
                        },
                        password: {
                            required: true,
                            rangelength: [8, 20]
                        },
                        repassword: {
                            required: true,
                            equalTo: "#user-pass"
                        },
                        fullName: {
                            required: true,
                            rangelength: [5, 60]
                        },
                        address: {
                            required: true,
                            rangelength: [10, 100]
                        },
                        phoneNumber: {
                            required: true,
                            number: true,
                            minlength: 10,
                            maxlength: 12
                        }
                    },
                    messages: {
                        email: {
                            required: " Please input Email!",
                            email: " Wrong Email format!",
                            rangelength: " Email must be 5-60 characters long!"
                        },
                        password: {
                            required: " Please input Password!",
                            rangelength: " Password must be 8-20 characters long!"
                        },
                        repassword: {
                            required: " Please input Password again to confirm!",
                            equalTo: " Not equal to Password!"
                        },
                        fullName: {
                            required: " Please input Full Name!",
                            rangelength: " Full Name must be 5-60 characters long!"
                        },
                        address: {
                            required: " Please input Address!",
                            rangelength: " Address must be 10-100 characters long!"
                        },
                        phoneNumber: {
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
            <a class="navbar-brand" href="home"> <img src="images/logo.png" alt="Home" width="130px" height="50px" style="background: 100% 100%; margin: auto; padding: auto;"></img></a>

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
        <!--End Menu-->
        <div class="container align-middle">
            <div id="logreg-forms" style="padding-left: 25%; padding-right: 25%"> 
                <form action="signUp" class="form-signin" method="post" class="form-signup" id="addAccountForm">
                    <h1 class="h3 mb-3 font-weight-normal display-4 text-info" style="text-align: center">Sign up</h1>
                    <c:set var="error" value="${requestScope.REGIS_ERROR_MESSAGE}"/>
                    <c:if test="${not empty error}">
                        <font color="red">${error}</font>
                    </c:if>
                    <b>Email</b> <input name="email" type="text" id="user-name" maxlength = "50" class="form-control regis-email" placeholder="Email" value="${requestScope.EMAIL}" required= autofocus="">
                    <div class="row">
                        <div class="col-sm-6">
                            <b>Password</b><input name="password" type="password" id="user-pass" maxlength = "50" class="form-control regis-password" placeholder="Password" value="${requestScope.PASSWORD}" required autofocus="">
                        </div>
                        <div class="col-sm-6">
                            <b>Repeat Password</b><input name="repassword" type="password" id="user-repeatpass" maxlength = "50" class="form-control regis-password" placeholder="Repeat Password" value="" required autofocus="">
                        </div>
                    </div>
                    <b>Full Name</b><input name="fullName" type="text" id="userFullName" maxlength = "50" class="form-control regis-fullname" placeholder="Full Name" value="${requestScope.FULLNAME}" required autofocus="">
                    <b>Address</b><input name="address" type="text" id="address" maxlength = "100" class="form-control regis-address" placeholder="Address" value="${requestScope.ADDRESS}" required autofocus="">
                    <div class="row">
                        <div class="col-sm-6"><b>Phone Number</b><input name="phoneNumber" type="text"  maxlength = "12" id="phoneNumber" class="form-control regis-phone-number" placeholder="Phone Number" value="${requestScope.PHONENUMBER}" required autofocus="" style="width: 90%"></div>
                        <div clclass="gender" class="col-sm-6" style="display: inline;">
                            <b>Gender:</b> <br>
                            <input type="radio" id="userGender" name="gender" value="Male" checked> Male
                            <input type="radio" id="userGender" name="gender" value="Female"> Female
                        </div>
                    </div>
                    <br>
                    <br>
                    <button class="btn btn-primary btn-block" type="submit">Sign Up</button>
                </form>
                <br>
            </div>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>

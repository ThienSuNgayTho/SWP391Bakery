<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css"/>
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
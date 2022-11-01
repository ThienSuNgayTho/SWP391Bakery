<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <style>
            .gallery-wrap .img-big-wrap img {
                height: 450px;
                width: auto;
                display: inline-block;
                cursor: zoom-in;
            }
            .gallery-wrap .img-small-wrap .item-gallery {
                width: 60px;
                height: 60px;
                border: 1px solid #ddd;
                margin: 7px 2px;
                display: inline-block;
                overflow: hidden;
            }
            .gallery-wrap .img-small-wrap {
                text-align: center;
            }
            .gallery-wrap .img-small-wrap img {
                max-width: 100%;
                max-height: 100%;
                object-fit: cover;
                border-radius: 4px;
                cursor: zoom-in;
            }
            .img-big-wrap img{
                width: 100% !important;
                height: auto !important;
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
        <c:set var="postDto" value="${requestScope.POST_DETAIL}"/>
        <c:set var="user" value="${sessionScope.CURRENT_USER.getEmail()}"/>
        <div class="container-fluid">
            <div class="row">
                <!--Left side of the page - The Dashboard-->
                <div class="col-sm-2" style="margin-bottom: 30px">
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
                </div>
                <!--End of the left side-->
                <div class="col-sm-10">
                    <img src="images/${postDto.thumbnailLink.trim()}" alt="Post image" width="50%" style="display:block ;margin-left: auto; margin-right: auto;"></br>
                    <h1><b>${postDto.title}</b></h1>
                    <h6>
                        <span style="float: left;">
                            <b>Author: </b>${postDto.email} <b> Date: </b>${postDto.updateDate}
                        </span>
                    </h6>
                    </br></br></br>
                    <h4><textarea style="width: 100%; border: none;" rows="15" readonly>${postDto.detail.trim()}</textarea></h4>
                </div>
            </div>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
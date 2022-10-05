<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script>
            function AlertLogin() {
                alert("Please Login before buying Products!");
            }
        </script>
        <script>
            window.onunload = function() {
                localStorage.setItem("scrollY", window.scrollY);
            }

            window.onload = function() {  
                var scrollY = parseInt(localStorage.getItem("scrollY"));
                    window.scroll(0, scrollY);
            }
        </script>
        <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css'>
        <style>
            .noti[data-count]:after {
                position: absolute;
                right: 0%;
                top: 1%;
                content: attr(data-count);
                font-size: 80%;
                padding: .6em;
                border-radius: 50%;
                line-height: .8em;
                color: white;
                background: rgba(255, 0, 0, 0.85);
                text-align: center;
                min-width: 1em;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <c:set var="jspname" value="home"/>
        <c:set var="user" value="${sessionScope.CURRENT_USER.getEmail()}"/>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="container-fluid">
                <div class="row">
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
                
                <div class="col-sm-10">
                        <div style="width: 100%;">
                        <jsp:include page="Slider.jsp"></jsp:include>
                        </div>
                        <c:set var="searchValue" value="${param.txtSearchValue}"/>
                        <c:if test="${not empty searchValue}">
                            <c:if test="${not empty requestScope.PRODUCT_LIST}">
                                <c:set var="productHomeList" value="${requestScope.PRODUCT_LIST}"/>
                            </c:if>
                            <c:if test="${empty requestScope.PRODUCT_LIST}">
                                <h2>No Result!</h2>
                            </c:if>
                        </c:if>
                        <c:if test="${empty searchValue}">
                            <c:if test="${not empty requestScope.PRODUCT_LIST}">
                                <c:set var="productHomeList" value="${requestScope.PRODUCT_LIST}"/>
                            </c:if>
                            <c:if test="${empty requestScope.PRODUCT_LIST}">
                                <c:set var="productHomeList" value="${requestScope.ALL_AVAILABLE_PRODUCT_LIST}"/>
                            </c:if>
                        </c:if>
                        <div class="row">
                        <c:if test="${not empty productHomeList}">
                            <c:forEach items="${productHomeList}" var="productDto">
                                <div class="col-12 col-md-6 col-lg-3" style="margin-bottom: 30px">
                                    <div class="card" style="margin: auto;">
                                        <img class="card-img-top" src="images/${productDto.thumbnailLink.trim()}" alt="Product image" width="270px" height="180px">
                                        <div class="card-body">
                                            <h4 class="card-title show_txt"><a href="productDetail?productId=${productDto.id}" title="View Product">${productDto.name}</a></h4>
                                            <p style="
                                               white-space:nowrap;
                                               text-overflow:ellipsis;
                                               overflow:hidden;
                                               position:relative;
                                               padding:0;">${productDto.details}</p>
                                            <div class="row">
                                                <c:if test="${productDto.saleStatus == true}">
                                                    <div style="margin: auto;">
                                                        <p class="btn btn-danger btn-block"><fmt:formatNumber type="number" maxFractionDigits="0" value="${productDto.salePrice}" /> VND</p>
                                                    </div>
                                                </c:if>
                                                <c:if test="${productDto.saleStatus == false}">
                                                    <div style="margin: auto;">
                                                        <p class="btn btn-danger btn-block"><fmt:formatNumber type="number" maxFractionDigits="0" value="${productDto.originalSalePrice}" /> VND</p>
                                                    </div>
                                                </c:if>
                                                <div style="margin: auto;">
                                                    <c:if test="${not empty user}">
                                                        <c:if test="${productDto.status}">
                                                            <p><a href="Cart?id=${productDto.id}&jspPage=Home&txtSearchValue=${searchValue}" ><button class="btn btn-success btn-block">Add to cart</button></a></p>
                                                        </c:if>
                                                        <c:if test="${!productDto.status}">
                                                            <p><a href="Cart?id=${productDto.id}&jspPage=Home&txtSearchValue=${searchValue}" ><button class="btn btn-success btn-block" disabled>Add to cart</button></a></p>
                                                        </c:if>
                                                    </c:if>
                                                    <c:if test="${empty user}">
                                                        <p><a href="Login.jsp"><button class="btn btn-success btn-block" onclick="AlertLogin()">Add to cart</button></a></p>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>    
                    </div>
                    <div>
                        <ul class="pagination" style="float: right;">
                            <c:if test="${empty searchValue}">
                                <c:forEach begin="1" end="${maxPages}" var="i">
                                    <li class="page-item ${index == i ? "active": ""} "><a class="page-link" href="home?index=${i}&jspname=${jspname}" ${index == i ? "active": ""}>${i}</a></li>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${not empty searchValue}">
                                    <c:forEach begin="1" end="${maxPages}" var="i">
                                    <li class="page-item ${index == i ? "active": ""} "><a class="page-link" href="searchProduct?index=${i}&txtSearchValue=${searchValue}&jspname=${jspname}" ${index == i ? "active": ""}>${i}</a></li>
                                    </c:forEach>
                                </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
                                                <input type="hidden" name="focusDummy" id="focusDummy">
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>


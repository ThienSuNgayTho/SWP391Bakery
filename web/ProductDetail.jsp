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
        <jsp:include page="Menu.jsp"></jsp:include>
        <c:set var="user" value="${sessionScope.CURRENT_USER.getEmail()}"/>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-2">
                    <c:if test="${sessionScope.CURRENT_USER.getRole().getRoleId() != 2}">
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
                    <c:if test="${sessionScope.CURRENT_USER.getRole().getRoleId() == 2}">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="getPendingOrder">Manage Order</a></li>
                            <li class="list-group-item text-white" ><a href="manageProduct?index=1">View Product List</a></li>
                        </ul>
                    </c:if>
                </div>
                <c:set var="product" value="${requestScope.PRODUCT_DETAIL}"/>
                <div class="col-sm-10">
                    <div class="container">
                        <div class="card">
                            <div class="row">
                                <aside class="col-sm-5 border-right">
                                    <article class="gallery-wrap"> 
                                        <div class="img-big-wrap">
                                            <div> <a href="#"><img src="images/${product.thumbnailLink.trim()}" alt="Cake image"></a></div>
                                        </div> <!-- slider-product.// -->
                                        <div class="img-small-wrap">
                                        </div> <!-- slider-nav.// -->
                                    </article> <!-- gallery-wrap .end// -->
                                </aside>
                                <aside class="col-sm-7">
                                    <article class="card-body p-5">
                                        <h3 class="title mb-3">${product.name}</h3>

                                        <p class="price-detail-wrap"> 
                                            <span class="price h3 text-warning">
                                                <c:if test="${product.saleStatus == true}">
                                                    <span class="currency">VND: </span><span class="num"><fmt:formatNumber type="number" maxFractionDigits="0" value="${product.salePrice}" /></span> <br>
                                                    <span class="currency">VND: </span><span class="num"><del><fmt:formatNumber type="number" maxFractionDigits="0" value="${product.originalSalePrice}" /></del></span>
                                                </c:if>
                                                <c:if test="${product.saleStatus == false}">
                                                    <span class="currency">VND: </span><span class="num"><fmt:formatNumber type="number" maxFractionDigits="0" value="${product.originalSalePrice}" /></span> <br>
                                                </c:if>
                                            </span> 
                                        </p> <!-- price-detail-wrap .// -->
                                        <dl class="item-property">
                                            <dt><b>Description</b></dt>
                                            <dd><p>
                                                    ${product.details}
                                                </p></dd>
                                        </dl>

                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-5">
                                                <dl class="param param-inline">
                                                    <dt>In Stock: ${product.stock} </dt>
                                                    <!--<c:if test="${not empty user}">
                                                        <dd>
                                                            </br>
                                                            <input type="number" id="quantity" name="quantity" min="1" max="${product.stock}" style="width:70px;" value="1"><br><br>
                                                        </dd>
                                                    </c:if>-->
                                                </dl>  <!-- item-property .// -->
                                            </div> <!-- col.// -->

                                        </div> <!-- row.// -->
                                        <c:if test="${sessionScope.CURRENT_USER.getRole().getRoleId() == 3}">
                                            <c:set var="jspPage" value="ProductDetail"/>
                                            <c:if test="${not empty user}">
                                                <hr>
                                                <c:if test="${product.status}">
                                                    <c:set var="i" value="ProductDetail"/>
                                                    <a href="Cart?id=${product.id}&jspPage=${jspPage}&txtSearchValue=${searchValue}" ><button class="btn btn-success btn-block">Add to cart</button></a>
                                                </c:if>
                                                    <div style="padding-top: 20px">
                                                    <a href="Cart.jsp" class="btn btn-lg btn-outline-primary text-uppercase"> View your Cart </a>
                                                    </div>
                                            </c:if>
                                        </c:if>
                                    </article> <!-- card-body.// -->
                                </aside> <!-- col.// -->
                            </div> <!-- row.// -->
                        </div> <!-- card.// -->
                    </div>
                </div>
            </div>
            <div style="padding-top: 30px; padding-left: 30%;">                                   
                <a href="home"><button type="button" class="btn btn-success">Back to home</button></a>     
            </div>   
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
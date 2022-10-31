<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Cart</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>
            #empty-inform{
                margin-left: 300px;
            }
        </style>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" integrity="sha512-3P8rXCuGJdNZOnUx/03c1jOTnMn3rP63nBip5gOP2qmUh5YAdVAvFZ1E+QLZZbC1rtMrQb+mah3AfYW11RUrWA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/core.js" integrity="sha512-pDorjUV3/kd4nJZxurFAKSrSddNPQAgjjvO15ZrA5qQ1Uet2ZS8obCo3CXPEHQSQ7tfold4P4UZqiqLpD/ZpAg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!------ Include the above in your HEAD tag ---------->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link href="css/sale.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="js/sale.js" type="text/javascript" />
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
                    <form action="SearchProduct" method="post" id="SearchProductForm">
                        <input type="hidden" name="jspname" value="${jspname}" />
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
            <div class="shopping-cart col-sm-10">
                    <div class="row">
                        <div class="col-sm-12 p-5 bg-white rounded shadow-sm mb-5">

                            <!-- Shopping cart table -->
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="border-0 bg-light">
                                                <div class="p-2 px-3 text-uppercase">Product</div>
                                            </th>
                                            <th scope="col" class="border-0 bg-light">
                                                <div class="py-2 text-uppercase">Price</div>
                                            </th>
                                            <th scope="col" class="border-0 bg-light">
                                                <div class="py-2 text-uppercase">Quantity</div>
                                            </th>
                                            <th scope="col" class="border-0 bg-light">
                                                <div class="py-2 text-uppercase">Delete</div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="total" value="0"></c:set>
                                        <c:forEach var="productItem" items="${sessionScope.productList}">
                                            <tr>
                                                <th scope="row">
                                                    <div class="p-2">
                                                        <div class="ml-3 d-inline-block align-middle">
                                                            <h5 class="mb-0"> <a href="#" class="text-dark d-inline-block">${productItem.key.name}</a></h5><span class="text-muted font-weight-normal font-italic"></span>
                                                        </div>
                                                    </div>
                                                </th>
                                                <c:if test="${!productItem.key.saleStatus}">
                                                <td class="align-middle"><strong><fmt:formatNumber type="number" maxFractionDigits="0" value="${productItem.key.originalSalePrice}" /></strong></td>
                                                </c:if>
                                                <c:if test="${productItem.key.saleStatus}">
                                                <td class="align-middle"><strong><fmt:formatNumber type="number" maxFractionDigits="0" value="${productItem.key.salePrice}" /></strong></td>
                                                </c:if>
                                                <td class="align-middle">
                                                    <a href="UpdateQuantity?type=sub&id=${productItem.key.id}"><button class="btnSub">-</button></a> 
                                                    <strong>${productItem.value}</strong>
                                                    <a href="UpdateQuantity?type=add&id=${productItem.key.id}"><button class="btnAdd">+</button></a>
                                                </td>
                                                <td class="align-middle"><a href="RemoveCartItem?id=${productItem.key.id}" class="text-dark">
                                                        <button type="button" class="btn btn-danger">Delete</button>
                                                    </a>
                                                </td>
                                            </tr>
                                            <c:if test="${!productItem.key.saleStatus}">
                                            <c:set var="total" value="${total+productItem.key.originalSalePrice*productItem.value}"></c:set>
                                            </c:if>
                                            <c:if test="${productItem.key.saleStatus}">
                                            <c:set var="total" value="${total+productItem.key.salePrice*productItem.value}"></c:set>
                                            </c:if>
                                        </c:forEach>

                                    </tbody>
                                </table>
                                <c:if test="${empty sessionScope.productList}">
                                    <h2 id="empty-inform" style="padding-left: 20%;">Cart is currently empty</h2>
                                </c:if>
                            </div>
                            <!-- End -->
                        </div>
                    </div>
                    <c:if test="${requestScope.isValid != null && !requestScope.isValid }">
                        <h2>Some products is currently not available, We have removed those from your cart </h2>
                    </c:if>
                    <div class="row py-5 p-4 bg-white rounded shadow-sm">
                        <!--<div class="col-lg-6">
                            <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Voucher</div>
                            <div class="p-4">
                                <div class="input-group mb-4 border rounded-pill p-2">
                                    <input type="text" placeholder="Nhập Voucher" aria-describedby="button-addon3" class="form-control border-0">
                                    <div class="input-group-append border-0">
                                        <button id="button-addon3" type="button" class="btn btn-dark px-4 rounded-pill"><i class="fa fa-gift mr-2"></i>Sử dụng</button>
                                    </div>
                                </div>
                            </div>
                        </div>-->
                        <div class="col-sm-6">
                                <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">To Money</div>
                                <div class="p-4">
                                    <ul class="list-unstyled mb-4">
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Total Price</strong><strong><fmt:formatNumber type="number" maxFractionDigits="0" value="${total}" /> VND</strong></li>
<!--                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Phí vận chuyển</strong><strong>Free ship</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">VAT</strong><strong>${total*10/100} $</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tổng thanh toán</strong>
                                            <h5 class="font-weight-bold"> $</h5>
                                        </li>-->
                                    </ul>
                                         <c:if test="${empty sessionScope.productList}">
                                              <a href="#"  class="btn btn-dark rounded-pill py-2 btn-block">Purchase</a>
                                         </c:if>
                                         <c:if test="${!empty sessionScope.productList}">
                                              <a href="Bill.jsp"  class="btn btn-dark rounded-pill py-2 btn-block">Purchase</a>
                                         </c:if>       
                                </div>
                            </div>
                    </div>
                    <div style="padding-top: 30px;">                                   
                        <a href="home"><button type="button" class="btn btn-success">Back to home</button></a>     
                    </div>                
                </div>
            </div>    
        </div>                           
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
</html>
<script>
</script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Detail</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link href="css/sale.css" rel="stylesheet" type="text/css"/>
        <style>
            .update-link-true {
                display: inline-block;
                border: 1px;
                border-style: solid;
                border-radius: 10px;
                background-color: #00cc33;
                color: white;
                text-decoration: none;
                padding: 0.3em 0.6em;
            }
            .update-link-false {
                display: inline-block;
                border: 1px;
                border-style: solid;
                border-radius: 10px;
                background-color: red;
                color: white;
                text-decoration: none;
                padding: 0.3em 0.6em;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        <c:set var="user" value="${sessionScope.CURRENT_USER.getEmail()}"/>
        <div class="container-fluid">
            <div class="row">
                <!--Left side of the page -->
                <div class="col-sm-2">
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
                    <c:if test="${sessionScope.CURRENT_USER.getRole().getRoleId() == 2}">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="getPendingOrder">Manage Order</a></li>
                            <li class="list-group-item text-white" ><a href="manageProduct?index=1">View Products List</a></li>
                        </ul>
                    </c:if>
                </div>

                <!--Right side of the page -->
                <div class="card col-sm-10" style="padding: 3% 5% 3% 5%;">
                    <div class="row">
                        <div class="col-sm-10">
                            <h1 style="text-align: center; color: #435d7d;">Order Detail</h1><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-5">
                            <c:set var="orderInfo" value="${requestScope.ORDER_INFO}"></c:set>
                            <c:set var="orderDetailInfo" value="${requestScope.ORDER_DETAIL_INFO}"></c:set>
                                <table border="0">
                                    <tbody>
                                        <tr>
                                            <th style="width: 30%;"><b>Order Id:</b></th>
                                            <td style="width: 70%;">OD-${orderInfo.id}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 30%;"><b>Customer Email:</b></th>
                                        <td style="width: 70%;">${orderInfo.customerEmail}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 30%;"><b>Customer Name:</b></th>
                                        <td style="width: 70%;">${orderInfo.fullname}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 30%;"><b>Customer Phone Number:</b></th>
                                        <td style="width: 70%;">${orderInfo.phoneNumber}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 30%;"><b>Shipping Address:</b></th>
                                        <td style="width: 70%;">${orderInfo.address}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 30%;"><b>Sale person in charge:</b></th>
                                        <td style="width: 70%;">
                                            <c:if test="${not empty orderInfo.saleEmail}">
                                                ${orderInfo.saleEmail}
                                            </c:if>
                                            <c:if test="${empty orderInfo.saleEmail}">
                                                N/A
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="width: 30%;"><b>Order Status:</b></th>
                                        <td style="width: 70%;">                        
                                            <c:if test="${orderInfo.status eq 'submitted'}">
                                                <font color="orange">${orderInfo.status}</font>
                                            </c:if>
                                            <c:if test="${orderInfo.status eq 'approved'}">
                                                <font color="orange">${orderInfo.status}</font>
                                            </c:if>
                                            <c:if test="${orderInfo.status eq 'deliver'}">
                                                <font color="orange">${orderInfo.status}</font>
                                            </c:if>
                                            <c:if test="${orderInfo.status eq 'completed'}">
                                                <font color="orange">${orderInfo.status}</font>
                                            </c:if>
                                            <c:if test="${orderInfo.status eq 'cancel'}">
                                                <font color="red">${orderInfo.status}</font>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="width: 30%;"><b>Update Date:</b></th>
                                        <td style="width: 70%;">${orderInfo.completeDate}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-sm-7">
                            <table class="table table-striped" style="width: 100%; border-collapse: collapse;">
                                <thead>
                                    <tr style="background-color: #435d7d;">
                                        <th scope="col">Product Id</th>
                                        <th scope="col">Product Name</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col" style="text-align: right; padding-right: 2%;">Product Price</th>
                                        <th scope="col" style="text-align: right; padding-right: 2%;">Total Item Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="dto" items="${orderDetailInfo}" varStatus="counter">
                                        <tr>
                                            <th>
                                                ${counter.count}.
                                            </th>
                                            <td>
                                                ${dto.productName}
                                            </td>
                                            <td>
                                                ${dto.quantity}
                                            </td>
                                            <td style="text-align: right; padding-right: 2%;">
                                                <div class="line"><fmt:formatNumber type="number" maxFractionDigits="0" value="${dto.totalItemPrice/dto.quantity}" /> VND</div>     
                                            </td>
                                            <td style="text-align: right; padding-right: 2%;">
                                                <div class="line"><fmt:formatNumber type="number" maxFractionDigits="0" value="${dto.totalItemPrice}" /> VND</div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <p style="display: inline;"><b>Shipping Address:</b> ${orderInfo.address}</p><br> 
                            <p style="display: inline;"><b>Shipping Price:</b> <fmt:formatNumber type="number" maxFractionDigits="0" value="${orderInfo.shipPrice}" /> VND</p><br> 
                            <p style="display: inline;"><b>Total Order Price:</b> <fmt:formatNumber type="number" maxFractionDigits="0" value="${orderInfo.totalPrice}" /> VND</p><br>
                            <b>Payment Status: </b>
                            <c:if test="${orderInfo.paidStatus}"><span class="update-link-true" >Yes</span></c:if>
                            <c:if test="${!orderInfo.paidStatus}"><span class="update-link-false" >No</span></c:if>
                                <br>
                            <c:if test="${sessionScope.CURRENT_USER.getRole().getRoleId() == 2}">
                                <div style="text-align: center; padding-top: 2%;">
                                    <c:if test="${orderInfo.status eq 'submitted'}">
                                        <c:url var="updateLink" value="setOrderStatus">
                                            <c:param name="id" value="${orderInfo.id}" />
                                            <c:param name="saleEmail" value="${sessionScope.CURRENT_USER.email}" />
                                            <c:param name="status" value="approved" />
                                            <c:param name="currentPage" value="detail" />
                                        </c:url>
                                        <a class="update-link-detail" href="${updateLink}" style="display: compact;">Approve</a>
                                    </c:if>

                                    <c:if test="${orderInfo.status eq 'approved'}">
                                        <c:url var="updateLink" value="setOrderStatus">
                                            <c:param name="id" value="${orderInfo.id}" />
                                            <c:param name="saleEmail" value="${sessionScope.CURRENT_USER.email}" />
                                            <c:param name="status" value="deliver" />
                                            <c:param name="currentPage" value="detail" />
                                        </c:url>
                                        <a class="update-link-detail" href="${updateLink}" style="display: compact;">Deliver</a>
                                        <c:url var="cancelLink" value="setOrderStatus">
                                            <c:param name="id" value="${orderInfo.id}" />
                                            <c:param name="saleEmail" value="${sessionScope.CURRENT_USER.email}" />
                                            <c:param name="status" value="cancel" />
                                            <c:param name="currentPage" value="detail" />
                                        </c:url>
                                        <a class="cancel-link-detail" href="${cancelLink}">Cancel</a>
                                    </c:if>

                                    <c:if test="${orderInfo.status eq 'deliver'}">
                                        <c:url var="updateLink" value="setOrderStatus">
                                            <c:param name="id" value="${orderInfo.id}" />
                                            <c:param name="saleEmail" value="${sessionScope.CURRENT_USER.email}" />
                                            <c:param name="status" value="completed" />
                                            <c:param name="currentPage" value="detail" />
                                        </c:url>
                                        <a class="update-link-detail" href="${updateLink}" style="display: compact;">Finish</a>
                                        <c:url var="cancelLink" value="setOrderStatus">
                                            <c:param name="id" value="${orderInfo.id}" />
                                            <c:param name="saleEmail" value="${sessionScope.CURRENT_USER.email}" />
                                            <c:param name="status" value="cancel" />
                                            <c:param name="currentPage" value="detail" />
                                        </c:url>
                                        <a class="cancel-link-detail" href="${cancelLink}">Cancel</a>
                                    </c:if>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order History</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
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
            ul li{
                list-style: none;
            }
            .btnCancel{
                margin-top: 5px
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
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-2" style="margin-bottom: 30px">
                    <c:set var="user" value="${sessionScope.CURRENT_USER.getEmail()}"/>
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
                        <a href="Cart.jsp" ><div class="list-group-item btn card-header bg-primary text-white text-uppercase">View my Cart</div></a>
                        <a href="OrderHistory"><div class="list-group-item btn card-header bg-primary text-white text-uppercase">View my Order History</div></a>
                    </c:if>
                </div>

                <div class="col-sm-10">
                    <h1 class="display-4 my-4 text-info" style="text-align: center;">Order History</h1>
                    <c:set var="orderHistory" value="${requestScope.orderHistory}" />
                    <!--Display pending order if any-->
                    <c:if test="${not empty orderHistory}">
                        <table class="table table-striped" id="pending-order" style="width: 100%; border-collapse: collapse">
                            <thead>
                                <tr class="list-header">
                                    <th scope="col">No.</th>
                                    <th scope="col">Order ID</th>
                                    <th scope="col">Total Price</th>    
                                    <th scope="col">Status</th>
                                    <th scope="col">Completed Date</th>
                                    <th></th>

                                </tr>
                            </thead>
                            <tbody>
                            <form action="getOrderDetail">
                                <c:set var="orderId" value=""></c:set>

                                <c:forEach var="dto" items="${orderHistory}" varStatus="counter">
                                    <c:set var="isPending" value="false"></c:set>
                                        <tr>
                                            <th>
                                            ${counter.count}.
                                        </th>
                                        <c:forEach var="order" items="${dto}" >

                                            <c:if test="${order.key.trim() eq 'orderId'}">
                                                <c:set var="orderId" value="${order.value}"></c:set>
                                            </c:if>
                                            <c:if test="${order.value.trim() eq 'pending' || order.value.trim() eq 'submitted'}">
                                                <c:set var="isPending" value="true"></c:set>
                                            </c:if>
                                            <td>
                                                ${order.value}
                                            </td>

                                        </c:forEach>
                                        <td>
                                            <a href="getOrderDetail?orderId=${orderId}" class="btn btn-primary">Detail</a>
                                            <c:if test="${isPending eq 'true'}">
                                                <a  href="CancelOrder?id=${orderId}" onclick="Confirm(event)" class="btnCancel btn btn-danger" style="margin-top: -1px;">Cancel</a>
                                            </c:if>
                                            <c:if test="${isPending eq 'false'}">
                                                <button class="btnCancel btn btn-danger" disabled style="margin-top: -1px;">Cancel</button>
                                            </c:if>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </form>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${empty orderHistory}">
                        <h2>No Order History</h2>
                    </c:if>
                    <div style="padding-top: 30px;">                                   
                        <a href="home"><button type="button" class="btn btn-success">Back to home</button></a>     
                    </div>    
                </div>
            </div>
        </div>
    </body>

</html>
<script>
    function Confirm(event) {
        if (!confirm("Are you sure ? You cannot undo this once confirmed"))
            event.preventDefault();
    }
</script>
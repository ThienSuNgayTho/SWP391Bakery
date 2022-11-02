<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assigned Order</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
              id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
              integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
              crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link href="css/sale.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-2">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="getPendingOrder">Manage Order</a></li>
                            <li class="list-group-item text-white" ><a href="manageProduct?index=1">View Products List</a></li>
                        </ul>
                    </div>
                    <div class="col-sm-10">
                        <div class="col-sm-12" style="border-bottom: 0.5rem solid #007bff; padding-top: 1.3%;">
                            <ul style="list-style: none;">
                                <li style="display: inline; padding: 1.6rem 0.9rem;"><a href="getPendingOrder" style="font-size: 1.2rem;">Pending Order</a></li>
                                <li style="display: inline; padding: 1.6rem 0.9rem; background-color: #007bff; "><a href="getAssignedOrder?currentPage=assigned" style="font-size: 1.2rem; color: white;">Approved Order</a></li>
                                <li style="display: inline; padding: 1.6rem 0.9rem;"><a href="getAssignedOrder?currentPage=deliver" style="font-size: 1.2rem;">Deliver Order</a></li>
                                <li style="display: inline; padding: 1.6rem 0.9rem;"><a href="getCompletedOrder" style="font-size: 1.2rem;">Completed Order</a></li>
                                <li style="display: inline; padding: 1.6rem 0.9rem;"><a href="getCancelOrder" style="font-size: 1.2rem;">Cancel Order</a></li>
                            </ul>
                        </div>

                        <p class="text-danger">${requestScope.ASSIGNED_ORDER_LIMIT_REACH_ERROR}</p>
                    <h1 class="display-4 my-4 text-info" style="text-align: center;">Approved Order</h1>
                    <c:set var="approved" value="${requestScope.APPROVED_ORDER}" />
                    <!--Display pending order if any-->
                    <c:if test="${not empty approved}">
                        <table class="table table-striped" style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr class="list-header">
                                    <th scope="col">No.</th>
                                    <th scope="col">Id</th>
                                    <th scope="col">Customer Email</th>
                                    <th scope="col">Customer Name</th>
                                    <th scope="col">Complete Date</th>
                                    <th scope="col" style="text-align: right;">Total Price</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dtoa" items="${approved}" varStatus="counter">
                                <form action="getOrderDetail">
                                    <tr>
                                        <th scope="row">
                                            ${counter.count}.
                                            <input type="hidden" name="orderId" value="${dtoa.id}" 
                                        </th>
                                        <td>
                                            <div class="textline" style="display: inline-block;">
                                                <p>OD-${dtoa.id}</p>
                                            </div>
                                        </td>
                                        <td>
                                            ${dtoa.customerEmail}
                                            <input type="hidden" name="customerEmail"
                                                   value="${dtoa.customerEmail}" />
                                        </td>
                                        <td>
                                            ${dtoa.fullname}
                                            <input type="hidden" name="customerFullname" value="${dtoa.fullname}" />
                                        </td>
                                        <td>
                                            ${dtoa.completeDate}
                                            <input type="hidden" name="completeDate" value="${dtoa.completeDate}" />
                                        </td>
                                        <td style="text-align: right;">
                                            <div class="line"><fmt:formatNumber type="number" maxFractionDigits="0" value="${dtoa.totalPrice}" /> VND</div>
                                            <input type="hidden" name="totalPrice" value="${dtoa.totalPrice}" />
                                        </td>
                                        <td style="text-align: center;">
                                            <div class="link" style="padding-top: 2%;">
                                                <c:url var="updateLink" value="setOrderStatus">
                                                    <c:param name="id" value="${dtoa.id}" />
                                                    <c:param name="saleEmail" value="${sessionScope.CURRENT_USER.email}" />
                                                    <c:param name="status" value="deliver" />
                                                    <c:param name="currentPage" value="assigned" />
                                                </c:url>
                                                <a class="update-link" href="${updateLink}" style="display: compact;">Deliver</a>

                                                <c:url var="cancelLink" value="setOrderStatus">
                                                    <c:param name="id" value="${dtoa.id}" />
                                                    <c:param name="saleEmail" value="${sessionScope.CURRENT_USER.email}" />
                                                    <c:param name="status" value="cancel" />
                                                    <c:param name="currentPage" value="assigned" />
                                                </c:url>
                                                <a class="cancel-link" href="${cancelLink}" style="display: compact;">Cancel</a>
                                            </div>
                                        </td>
                                        <td>
                                            <input type="hidden" name="orderId" value="${dtoa.id}" />
                                            <input type="submit" value="Detail" name="btAction" class="get-order-detail"/>
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${empty approved}">
                        <h2>No Approved Order</h2>
                    </c:if>
                </div>
            </div>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>

</html>
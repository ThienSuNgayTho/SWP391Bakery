<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pending Order</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
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
                                <li style="display: inline; padding: 1.6rem 0.9rem; background-color: #007bff; "><a href="getPendingOrder" style="font-size: 1.2rem; color: white;">Pending Order</a></li>
                                <li style="display: inline; padding: 1.6rem 0.9rem;"><a href="getAssignedOrder?currentPage=assigned" style="font-size: 1.2rem;">Approved Order</a></li>
                                <li style="display: inline; padding: 1.6rem 0.9rem;"><a href="getAssignedOrder?currentPage=deliver" style="font-size: 1.2rem;">Deliver Order</a></li>
                                <li style="display: inline; padding: 1.6rem 0.9rem;"><a href="getCompletedOrder" style="font-size: 1.2rem;">Completed Order</a></li>
                                <li style="display: inline; padding: 1.6rem 0.9rem;"><a href="getCancelOrder" style="font-size: 1.2rem;">Cancel Order</a></li>
                            </ul>
                        </div>
                        
                        <p class="text-danger">${requestScope.ASSIGNED_ORDER_LIMIT_REACH_ERROR}</p>
                    <h1 class="display-4 my-4 text-info" style="text-align: center;">Pending Order</h1>
                    <c:set var="result" value="${requestScope.PENDING_ORDER}" />
                    <!--Display pending order if any-->
                    <c:if test="${not empty result}">
                        <div class="nav">
                            <table class="table table-striped" id="data" style="width: 100%; border-collapse: collapse">
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
                                    <c:forEach var="dto" items="${result}" varStatus="counter">
                                    <form action="getOrderDetail">
                                        <tr>
                                            <th scope="row">
                                                ${counter.count}.
                                            </th>
                                            <td>
                                                <div class="textline" style="display: inline-block;">
                                                    <p>OD-${dto.id}</p>
                                                </div>
                                            </td>
                                            <td>
                                                ${dto.customerEmail}
                                                <input type="hidden" name="customerEmail" value="${dto.customerEmail}" />
                                            </td>
                                            <td>
                                                ${dto.fullname}
                                                <input type="hidden" name="customerFullname" value="${dto.fullname}" />
                                            </td>
                                            <td>
                                                ${dto.completeDate}
                                                <input type="hidden" name="completeDate" value="${dto.completeDate}" />
                                            </td>
                                            <td style="text-align: right;">
                                                <div class="line"><fmt:formatNumber type="number" maxFractionDigits="0" value="${dto.totalPrice}" /> VND</div>
                                                <input type="hidden" name="totalPrice" value="${dto.totalPrice}" />
                                            </td>
                                            <td style="text-align: center;">
                                                <c:url var="updateLink" value="setOrderStatus">
                                                    <c:param name="id" value="${dto.id}" />
                                                    <c:param name="saleEmail" value="${sessionScope.CURRENT_USER.email}" />
                                                    <c:param name="status" value="approved" />
                                                    <c:param name="currentPage" value="pending" />
                                                </c:url>
                                                <a class="update-link" href="${updateLink}">Approved</a>
                                            </td>
                                            <td style="text-align: center;">
                                                <input type="hidden" name="orderId" value="${dto.id}" />
                                                <input type="submit" value="Detail" name="btAction" class="get-order-detail"/>
                                            </td>
                                        </tr>
                                    </form>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>

                    <!--If there's no pending orders-->
                    <c:if test="${empty result}">
                        <h2>No Pending Order</h2>
                    </c:if>
                </div>
                <!--end of right div-->
            </div>
            <!--end of row div-->
        </div>
        <!--end of container div-->
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>

</html>
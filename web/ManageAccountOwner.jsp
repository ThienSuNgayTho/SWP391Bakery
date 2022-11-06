<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Account</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
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
            <div class="container-fluid">
                <div class="row">
                    <!--Left side of the page - The Dashboard-->
                    <nav class="col-sm-2">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Admin Statistic</a></li>
                            <li class="list-group-item text-white" ><a href="getSaleStatisticOwner">Sale Statistic</a></li>
                            <li class="list-group-item text-white" ><a href="getMarketingStatisticOwner">Marketing Statistic</a></li>
                            <li class="list-group-item text-white" ><a href="manageUserOwner">Manage User</a></li>
                        </ul>
                    </nav>
                    <!--End of the left side-->
                <div class="table-wrapper col-sm-10">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-4">
                                <h2><b>Manage Account</b></h2>
                            </div>
                            <!--
                            Filter form used to filter shit
                            -->
                            <!--<div class="col-sm-4">
                                <form class="form-filter" action="userManaging" method="post">
                                    <input name="filter" type="text" id="filter" class="form-control" placeholder="Keywords" autofocus="" value="${param.txtSearchValue}">
                                    <button class="btn btn-success btn-block" type="Filter"><i class="fas fa-sign-in-alt"></i>Filter</button>
                                </form>
                            </div>-->
                            <div class="col-sm-4">
                                <form action="searchAccount" method="post" id="SearchAccountForm">
                                    <div class="input-group input-group-sm">
                                        <input name="txtSearchValue" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search..." value="${param.txtSearchValue}" maxlength="20">
                                        <div class="input-group-append">
                                            <button type="submit" class="btn btn-secondary btn-number">
                                                <i class="fa fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="col-sm-4">
                                <a href="AddNewAccountOwnerPage.jsp"  class="btn btn-success"><i class="material-icons">&#xE147;</i> <span>Add New Account</span></a>
                            </div>
                        </div>
                    </div>


                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>No. </th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Role Id </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${ACCOUNT_LIST}" var="userDto" varStatus="counter">
                                <tr>
                                    <td>${counter.count}.</td>
                                    <td>${userDto.email}</td>    
                                    <td>
                                        <c:if test="${userDto.status}"><span class="update-link-true" onclick="changeStatus('${userDto.email}', '${userDto.status}')">Activated</span></c:if>
                                        <c:if test="${!userDto.status}"><span class="update-link-false" onclick="changeStatus('${userDto.email}', '${userDto.status}')">Deactivated</span></c:if>
                                        </td>
                                        <td>
                                        ${userDto.role.name}
                                    </td>
                                    <td>
                                        <a href="AccountDetail?Email=${userDto.email}"><i class="material-icons" data-toggle="tooltip" title="View Details">&#xE254;</i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div>
                        <ul class="pagination">
                            <c:if test="${empty searchValue}">
                                <c:forEach begin="1" end="${maxPages}" var="i">
                                    <li class="page-item ${index == i ? "active": ""} "><a class="page-link" href="ManageUser?index=${i}" ${index == i ? "active": ""}>${i}</a></li>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${not empty searchValue}">
                                    <c:forEach begin="1" end="${maxPages}" var="i">
                                    <li class="page-item ${index == i ? "active": ""} "><a class="page-link" href="searchAccount?index=${i}&txtSearchValue=${searchValue}" ${index == i ? "active": ""}>${i}</a></li>
                                    </c:forEach>
                                </c:if>
                        </ul>
                    </div>
                    <a href="home"><button type="button" class="btn btn-success">Back to home</button></a>
                </div>
            </div>                    
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
        <script>
            function changeStatus(email, status) {
                $.ajax({
                    url: "/bakeryShopping/UpdateAccountStatusOwner",
                    type: "get", //send it through get method
                    data: {
                        Email: email,
                        Status: status
                    },
                    success: function (response) {
                        location.reload();
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            }
        </script>
    </body>
</html>
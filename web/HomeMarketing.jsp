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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/charts.css/dist/charts.min.css"> <!--This is the chart css lib for making chart-->
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="container-fluid">
                <div class="row">
                    <!--Left side of the page - The Dashboard-->
                    <div class="col-sm-2">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="ManageProduct">Manage Product</a></li>
                            <li class="list-group-item text-white" ><a href="CategoryManaging">Manage Category</a></li>
                            <li class="list-group-item text-white" ><a href="ManagePost">Manage Post</a></li>
                        </ul>
                    </div>
                    <!--End of the left side-->

                    <!--Right side of the page - The Statistic-->
                    <div class="col-sm-10">
                        <h1 class="display-4 my-4 text-info" style="text-align: center;">Statistic</h1>
                        <div class="row">
                        <c:set var="numberOfProduct" value="${requestScope.NUMBER_OF_PRODUCT}"></c:set>
                        <c:set var="productLessThan10" value="${requestScope.PRODUCT_LESS_THAN_10}"></c:set>
                        <c:set var="totalPost" value="${requestScope.TOTAL_POST}"></c:set>
                        <c:set var="#" value=""></c:set>
                            <div class="col-sm-4">
                                <div class="card" style="background-color: #66ff66;">
                                    <div class="card-content">
                                        <div class="card-body">
                                            <div class="media d-flex">
                                                <div class="align-self-center">
                                                    <i class="icon-speech warning font-large-2 float-left"></i>
                                                </div>
                                                <div class="media-body text-right">
                                                    <h3 style="color: white;">${numberOfProduct}</h3>
                                                <span style="color: white;">Number Of Products</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="card" style="background-color: #ff6666;">
                                <div class="card-content">
                                    <div class="card-body">
                                        <div class="media d-flex">
                                            <div class="align-self-center">
                                                <i class="icon-speech warning font-large-2 float-left"></i>
                                            </div>
                                            <div class="media-body text-right">
                                                <h3 style="color: white;">${productLessThan10}</h3>
                                                <span style="color: white;">Out of Stock Product</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="card" style="background-color: #66ccff;">
                                <div class="card-content">
                                    <div class="card-body">
                                        <div class="media d-flex">
                                            <div class="align-self-center">
                                                <i class="icon-speech warning font-large-2 float-left"></i>
                                            </div>
                                            <div class="media-body text-right">
                                                <h3 style="color: white;">${totalPost}</h3>
                                                <span style="color: white;">Total Number of Post</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="card col-sm-12" style="border: none; padding-top: 2%;">
                            <div class="card-content">
                                <div class="card-body">
                                    <p class="text-info">Number of Post</p>

                                    <style>
                                        #my-chart {
                                            --color: linear-gradient(#66ff66, #66ccff); 
                                        }
                                        .text-date {
                                            background: -webkit-linear-gradient(#0099cc, #66ccff);
                                            -webkit-background-clip: text;
                                            -webkit-text-fill-color: transparent;
                                        }
                                    </style>

                                    <table class="charts-css column show-heading  show-data-on-hover datasets-spacing-5" id="my-chart" style="height: 25rem; padding-top: 2%;">
                                        <caption style="text-align: center; margin-bottom: 3%"> Daily Post Past 7 Days </caption>
                                        <c:set var="post" value="${requestScope.DAILY_POST}"/>
                                        <thead>
                                            <tr>
                                                <th scope="col">Date</th>
                                                    <c:forEach var="detail" items="${post}">
                                                    <th scope="col">${detail.key}</th>
                                                    </c:forEach>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row">Revenue</th>
                                                    <c:forEach var="detail" items="${post}">
                                                    <td style="--size: calc( ${detail.value} / (${requestScope.MAX_POST} + 0.005));"><span class="data" style="color: gray;"><b>${detail.value}</b></span></td>
                                                </c:forEach>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br>
                                    <table border="0" style="width: 100%; padding-top: 1%;">
                                        <tbody>
                                            <tr>
                                                <c:forEach var="detail" items="${post}">
                                                    <td style="text-align: center;" class="text-date"><b>${detail.key}</b><td>
                                                        </c:forEach>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End of the right side-->
                </div>
            </div>
            <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>

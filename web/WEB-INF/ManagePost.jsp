<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Post</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <style type="text/css">
            #addProductForm label.error{
                color: red;
                width: 250px;
                font-style: italic;
            }
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
        <script type="text/javascript" src="js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="js/jquery.validate.js"></script>
        <script type="text/javascript" src="js/additional-methods.js"></script>
        <script src="js/manager.js" type="text/javascript"></script>
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        <c:set var="jspname" value="managePost"/>
        <c:set var="searchValue" value="${param.txtSearchValue}"/>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-2">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="ManageProduct">Manage Product</a></li>
                            <li class="list-group-item text-white" ><a href="CategoryManaging">Manage Category</a></li>
                            <li class="list-group-item text-white" ><a href="ManagePost">Manage Post</a></li>
                        </ul>
                </div>
                <div class="col-sm-10">
                    <div class="table-wrapper">
                        <div class="table-title">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h2><b>Manage Post</b></h2>
                                </div>
                                <div class="col-sm-4">
                                    <form action="searchPost" method="post" id="SearchPostForm">
                                        <input type="hidden" name="jspname" value="${jspname}" />
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
                                <c:if test="${sessionScope.CURRENT_USER.getRole().getName().trim() eq 'Marketing'}">
                                    <div class="col-sm-4">
                                        <a href="AddNewPostPage.jsp"  class="btn btn-success"><i class="material-icons">&#xE147;</i> <span>Add New Post</span></a>
                                    </div>
                                </c:if>          
                            </div>
                        </div>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th style="width: 5%;">No.</th>
                                    <th style="width: 10%;">ID</th>
                                    <th style="width: 70%;">Title</th>
                                    <th style="width: 10%;">Slider Status</th>
                                        <c:if test="${sessionScope.CURRENT_USER.getRole().getName().trim() eq 'Marketing'}">
                                        <th style="width: 50%;">Actions</th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="count" value="${(Integer.parseInt(1)-1)*10}"/>
                                <c:forEach items="${POST_LIST}" var="postDto">
                                    <c:set var="count" value="${Integer.parseInt(count) + 1}"/>
                                    <tr>
                                        <td>${count}.</td>
                                        <td>POST-${postDto.id}</td>
                                        <td>${postDto.title}</td>
                                        <td>
                                            <c:if test="${postDto.onSlider}"><span class="update-link-true" onclick="changeStatus('${postDto.id}', '${postDto.onSlider}')">ON</span></c:if>
                                            <c:if test="${!postDto.onSlider}"><span class="update-link-false" onclick="changeStatus('${postDto.id}', '${postDto.onSlider}')">OFF</span></c:if>
                                            </td>
                                        <c:if test="${sessionScope.CURRENT_USER.getRole().getName().trim() eq 'Marketing'}">
                                            <td>
                                                <a href="updatePost?postId=${postDto.id}"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div>
                            <ul class="pagination">
                                <c:if test="${empty searchValue}">
                                    <c:forEach begin="1" end="${maxPages}" var="i">
                                        <li class="page-item ${index == i ? "active": ""} "><a class="page-link" href="ManagePost?index=${i}&jspname=${jspname}" ${index == i ? "active": ""}>${i}</a></li>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${not empty searchValue}">
                                        <c:forEach begin="1" end="${maxPages}" var="i">
                                        <li class="page-item ${index == i ? "active": ""} "><a class="page-link" href="searchPost?index=${i}&txtSearchValue=${searchValue}&jspname=${jspname}" ${index == i ? "active": ""}>${i}</a></li>
                                        </c:forEach>
                                    </c:if>
                            </ul>
                        </div>
                        <a href="home"><button type="button" class="btn btn-success">Back to home</button></a>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
        <script>
            function changeStatus(id, onslider) {
                $.ajax({
                    url: "/bakeryShopping/UpdatePostStatus",
                    type: "get", //send it through get method
                    data: {
                        Id: id,
                        OnSlider: onslider
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
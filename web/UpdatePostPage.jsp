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
        <style>
            .navbar-brand {
                padding-right: 70%;
            }
            .jumbotron-heading {
                font-family: sans-serif;
                color: #990000;
                text-shadow: -2px -2px 0 white, 2px -2px 0 white, -2px 2px 0 white, 2px 2px 0 white;
            }
            .lead {
            }
        </style>
        <script>
            function showImage(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#imagePreview')
                                .attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
        <script>
            function ResetImage() {
                $("#productImage").val('');
                var image = document.getElementById("imagePlaceholder").getAttribute('src');
                $('#imagePreview').attr('src', image);
            }
        </script>
    </head>
    <body>
        <script type="text/javascript" src="js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="js/jquery.validate.js"></script>
        <script type="text/javascript" src="js/additional-methods.js"></script>
        <script type="text/javascript">
            $(function () {
                $("#addPostForm").validate({
                    rules: {
                        txtPostTitle: {
                            required: true,
                            rangelength: [5, 150]
                        },
                        postImage: {
                            extension: "jpg|png"
                        },
                        txtPostDetail: {
                            required: true,
                            rangelength: [50, 10000]
                        }
                    },
                    messages: {
                        txtPostTitle: {
                            required: " Please input Post Title!",
                            rangelength: " Post Title must be 5-150 characters long!"
                        },
                        postImage: {
                            extension: " Post Image can only be either .jpg or .png!"
                        },
                        txtPostDetail: {
                            required: " Please input Post Detail!",
                            rangelength: " Product Name must be 50-10000 characters long!"
                        }
                    }
                })
            });
        </script>
        <!--begin of menu-->
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <a class="navbar-brand" href="home"> <img src="images/logo.png" alt="Home" width="120px" height="55px" style="background: 100% 100%; margin: auto; padding: auto;"></img></a>

            <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                <c:set var="userEmail" value="${sessionScope.CURRENT_USER.getEmail()}"/>
                <c:if test="${empty userEmail}">
                    <ul class="navbar-nav m-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="Login.jsp">Login <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="Registration.jsp">Sign Up</a>
                        </li>
                    </ul>
                </c:if>
                <c:if test="${not empty userEmail}">
                    <ul class="navbar-nav m-auto">
                        <li class="nav-item active">
                            <b class="nav-link" style="color: white">Welcome, ${sessionScope.CURRENT_USER.getFullName()}</b>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="UpdateAccount?Email=${userEmail}">Profile <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="logOut">Log Out</a>
                        </li>
                    </ul>
                </c:if>
            </div>
        </nav>
        <section class="jumbotron text-center" style="background-image: url('images/Home_Background.jpg'); background-repeat: repeat;">
            <div class="container">
                <h1 class="jumbotron-heading">BAKERY STARTUP </h1>
                <p class="lead text-muted mb-0">High quality products only!</p>
            </div>
        </section>
        <c:set var="postDto" value="${requestScope.POST_DETAIL}"/>
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
                <div id="editProduct" class="col-sm-10">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <form action="updatePostInfo" id="addPostForm" method="post"
                                  enctype="multipart/form-data">
                                <div class="modal-header">						
                                    <h4 class="modal-title">Update Post</h4>
                                </div>
                                <div class="modal-body">
                                    <input value="${postDto.id}" name="txtPostId" type="hidden">
                                    <div class="form-group" style="display: flex; ">
                                        <span style="width: 100%;">
                                            <label>Post Title</label>
                                            <input value="${postDto.title.trim()}" name="txtPostTitle" type="text" minlength="5" maxlength="150" class="form-control" style="width: 100%;">
                                        </span>
                                    </div>
                                    <div class="form-group" style="display: flex;">
                                        <span style="width: 30%; float:left;">
                                            <label>Post Category</label><br/>
                                            <select id = "txtCategoryId" name="txtCategoryId" class="form-select">
                                                <c:set var="categoryPostList" value="${applicationScope.POST_CATEGORY_LIST}"/>
                                                <c:forEach items="${categoryPostList}" var="cateDto">
                                                    <option value="${cateDto.categoryId}" <c:if test="${cateDto.categoryId eq postDto.categoryId}">selected</c:if>>${cateDto.name}</option>
                                                </c:forEach>
                                            </select>        
                                        </span>
                                        <span style="width: 20%; float:left;">
                                            <label>Post Thumbnail</label>
                                            <input type="file" id="postImage" name="postImage" value="" class="form-control" onchange="showImage(this)" style="width: 80%;">
                                        </span>
                                        <span style="width: 50%; float:right;">
                                            <img id="imagePreview" width="200px" height="120px" src="images/${postDto.thumbnailLink.trim()}"/>
                                            <img id="imagePlaceholder" width="200px" height="120px" src="images/${postDto.thumbnailLink.trim()}" style="display: none"/>
                                            <input type="text" name="currentImageLink" id="currentImageLink" value="${postDto.thumbnailLink.trim()}" style="display: none"/>
                                            <input type="button" value="Reset Image" onclick="ResetImage()" style="display: inline-block;"/>
                                        </span>
                                    </div>
                                    <div class="form-group" style="display: flex;">
                                        <span style="width: 50%; float:left;">
                                            <label>Email</label>
                                            <input value="${postDto.email.trim()}" name="txtPostEmail" minlength="5" maxlength="60" type="text" style="width: 80%;" class="form-control" readonly>
                                        </span>
                                        <span style="width: 50%; float:right;">
                                            <label>Show On Slider:</label></br>
                                            <select name="txtOnSlider" class="form-select">
                                                <option value="true" <c:if test="${postDto.onSlider}">selected</c:if>>True</option>
                                                <option value="false" <c:if test="${!postDto.onSlider}">selected</c:if>>False</option>
                                                </select>
                                            </span>
                                        </div>
                                        <div class="form-group" style="display: flex;">
                                            <span style="width: 50%; float:left;">
                                                <label>Upload Date</label>
                                                <input value="${postDto.uploadDate}" name="txtUploadDate" type="text" style="width: 80%;" class="form-control" readonly>
                                        </span>      
                                        <span style="width: 50%; float:right;">
                                            <label>Upload Date</label>
                                            <input value="${postDto.updateDate}" name="txtUpdateDate" type="text" style="width: 80%;" class="form-control" readonly>
                                        </span>
                                    </div>
                                    <div class="form-group" style="display: flex; ">
                                        <span style="width: 100%;">
                                            <label>Post Details</label><br/>
                                            <textarea name="txtPostDetail" rows="10" placeholder="Post Details here!" class="form-control" minlength="50" maxlength="10000">${postDto.detail}</textarea>
                                        </span>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input type="submit" class="btn btn-info" value="Save">
                                    <a href="managePost"><input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel"></a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
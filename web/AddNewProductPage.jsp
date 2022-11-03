<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Online Shopping</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                document.getElementById("imagePreview").style.display = "inline-block";
            }
        </script>
        <script>
            function ResetImage() {
                $("#productImage").val('');
                document.getElementById("imagePreview").style.display = "none";
            }
        </script>
    </head>
    <style type="text/css">
        #addProductForm label.error{
            color: red;
            width: 250px;
            font-style: italic;
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
    <body>
        <script type="text/javascript" src="js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="js/jquery.validate.js"></script>
        <script type="text/javascript" src="js/additional-methods.js"></script>
        <script type="text/javascript">
            $(function () {
                $("#addProductForm").validate({
                    rules: {
                        txtProductName: {
                            required: true,
                            rangelength: [6, 50]
                        },
                        productImage: {
                            required: true,
                            extension: "jpg|png"
                        },
                        txtProductDescription: {
                            required: true,
                            rangelength: [10, 500]
                        },
                        txtOriginalPrice: {
                            required: true,
                            range: [1000, 10000000]
                        },
                        txtSalePrice: {
                            required: true,
                            min: 0,
                            max: function () {
                                return parseInt(document.getElementById("txtOriginalPrice").value, 10) - 1;
                            }
                        },
                        txtProductStock: {
                            required: true,
                            range: [0, 1000]
                        }
                    },
                    messages: {
                        txtProductName: {
                            required: " Please input Product Name!",
                            rangelength: " Product Name must be 6-50 characters long!"
                        },
                        productImage: {
                            required: " Please input Product Image!",
                            extension: " Product Image can only be either .jpg or .png!"
                        },
                        txtProductDescription: {
                            required: " Please input Product Description!",
                            rangelength: " Product Name must be 10-500 characters long!"
                        },
                        txtOriginalPrice: {
                            required: " Please input Product Original Price!",
                            range: " Product Price must be from 1000 to 10000000!"
                        },
                        txtSalePrice: {
                            required: " Please input Product Sale Price!",
                            min: " Min value is 0!",
                            max: " Max value must be less than Original Price!"
                        },
                        txtProductStock: {
                            required: " Please input Product Stock!",
                            range: " Product Stock must be from 0 to 1000!"
                        }
                    }
                })
            });
        </script>
        <!--begin of menu-->
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <a class="navbar-brand" href="home"> <img src="images/logo.png" alt="Home" width="130px" height="50px" style="background: 100% 100%; margin: auto; padding: auto;"></img></a>

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
        <div class="container">
            <div class="row">
                    <!--Left side of the page - The Dashboard-->
                    <div class="col-sm-4">
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Dashboard </div>
                        <ul class="list-group category_block">
                            <li class="list-group-item text-white" ><a href="home">Home</a></li>
                            <li class="list-group-item text-white" ><a href="ManageProduct">Manage Product</a></li>
                            <li class="list-group-item text-white" ><a href="CategoryManaging">Manage Category</a></li>
                        </ul>
                    </div>
                    <!--End of the left side-->
            <div id="editProduct" class="col-sm-8">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <form action="addProduct" id="addProductForm" method="post"
                              enctype="multipart/form-data">
                            <div class="modal-header">						
                                <h4 class="modal-title">Add new Product</h4>
                            </div>
                            <div class="modal-body">
                                <input value="${productDto.id}" name="txtProductId" type="hidden">
                                <div class="form-group" style="display: flex; ">
                                    <span style="width: 50%; float:left;">
                                        <label>Name</label>
                                        <input value="${productDto.name.trim()}" name="txtProductName" type="text" maxlength="50" class="form-control" style="width: 80%;" style="display: inline-block;">
                                    </span>
                                    <span style="width: 50%; float:right;">
                                        <label>Category</label><br/>
                                        <select id = "txtCategoryId" name="txtCategoryId" class="form-select">
                                            <c:set var="categoryList" value="${applicationScope.CAKE_CATEGORY_LIST}"/>
                                            <c:forEach items="${categoryList}" var="cateDto">
                                                <option value="${cateDto.categoryId}">${cateDto.name}</option>
                                            </c:forEach>
                                        </select>
                                    </span>
                                </div>

                                <div class="form-group" style="display: flex;">
                                    <span style="width: 50%; float:left;">
                                    <label>Product Image</label>
                                    <input type="file" id="productImage" name="productImage" value="" class="form-control" onchange="showImage(this)" style="width: 80%;">
                                    </span>
                                    <span style="width: 50%; float:right;">
                                    <img id="imagePreview" width="200px" height="120px" src="" style="display: none; padding-left: 10px;"/>
                                    <input type="button" value="Reset Image" onclick="ResetImage()" style="display: inline-block;"/>
                                    </span>
                                </div>
                                <div class="form-group" style="display: flex; ">
                                    <span class="form-group" style="width: 50%; float:left;">
                                        <label>Original Price (VND)</label>
                                        <input type="text" name="txtOriginalPrice" id="txtOriginalPrice" value="${productDto.originalSalePrice}" maxlength="10" class="form-control" style="text-align: right;width: 60%;"/>
                                    </span>
                                    <span class="form-group" style="width: 50%; float:right;">
                                        <label>Sale Price (VND)</label>
                                        <input type="text" name="txtSalePrice" id="txtSalePrice" value="${productDto.salePrice}" maxlength="10" class="form-control" style="text-align: right;width: 60%;"/>
                                    </span>
                                </div>

                                <div class="form-group" style="display: flex; ">
                                    <span class="form-group" style="width: 50%; float:left;">
                                        <label>Stock</label>
                                        <input type="text" name="txtProductStock" value="${productDto.stock}" class="form-control" style="text-align: right;width:40%;" maxlength="4"/>
                                    </span>
                                    <span class="form-group" style="width: 20%;">
                                        <label>Status</label><br/>
                                        <select name="txtStatus" class="form-select">
                                            <option value="true" <c:if test="${productDto.status}">selected</c:if>>True</option>
                                            <option value="false" <c:if test="${!productDto.status}">selected</c:if>>False</option>
                                            </select>
                                        </span>
                                        <span class="form-group" style="width: 20%;">
                                            <label>Sale Status</label><br/>
                                            <select name="txtSaleStatus" class="form-select">
                                                <option value="true" <c:if test="${productDto.saleStatus}">selected</c:if>>True</option>
                                            <option value="false" <c:if test="${!productDto.saleStatus}">selected</c:if>>False</option>
                                            </select>
                                        </span>
                                    </div>

                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea name="txtProductDescription" rows="5" cols="50" placeholder="Product Description here!" class="form-control" maxlength="200">${productDto.details}</textarea>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-info" value="Save">
                                <a href="manageProduct"><input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel"></a>
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
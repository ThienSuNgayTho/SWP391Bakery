<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link href="css/login.css" rel="stylesheet" type="text/css"/>
        <title>Category Editing</title>
        <style>
            vis{display: block;
                width: 30vw;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="home">Home Page</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
                    <ul class="navbar-nav m-auto">


                    </ul>

                    <form action="search" method="post" class="form-inline my-2 my-lg-0">
                        <div class="input-group input-group-sm">
                            <input name="txt" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search...">
                            <div class="input-group-append">
                                <button type="submit" class="btn btn-secondary btn-number">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>
                        <a class="btn btn-success btn-sm ml-3" href="show">
                            <i class="fa fa-shopping-cart"></i> Cart
                            <span class="badge badge-light"></span>
                        </a>
                    </form>
                </div>
            </div>
        </nav>

        <section class="jumbotron text-center">
            <div class="container">
                <h1 class="jumbotron-heading"><b>SWP</b> Bakery </h1>
                <p class="lead text-muted mb-0">High Quality Products Only</p>
            </div>
        </section>
        <div class="container">
            <c:set var="Update" value="${sessionScope.Update}"/>
            <div id="logreg-forms"> 
                <form action="CategoryEdit" method="post" class="form-signin">
                <c:if test="${Update eq '2'}">    
                    <h1 name="Title" class="h3 mb-3 font-weight-normal" style="text-align: center">Creating a new Category</h1>
                    <p class="text-danger">${mess}</p>
                    <input value="${cDTO.categoryId}" name="cId" type="text" class="form-control" maxlength="10">
                    <input type="text" value="${cDTO.name}"name="name" id="name" class="form-control" placeholder="Category Name" autofocus="">

                    <label for="type">Category Type:</label>
                    
                    <select id="type" name="type">
                        <c:if test="${cDTO!=null}">
                            <option value="${cDTO.type}">${cDTO.type}</option>
                        </c:if>
                        
                        <option value="cake">cake</option>
                        <option value="post">post</option>
                    </select>

                    <input type="hidden" id="Update" name="Update" value=${Update}>
                     
                    <button class="btn btn-primary btn-block" type="update"><i class="fas fa-user-plus"></i> Create</button>
                </form>
                </c:if>    
                    
                <c:if test="${Update eq '1' || Update eq '3'}">
                <form action="CategoryEdit" method="post" class="form-signin">
                    
                    <h1 name="Title" class="h3 mb-3 font-weight-normal" style="text-align: center">Updating Category</h1>
                    <p class="text-danger">${mess}</p>
                    <input value="${cDTO.categoryId}" name="cId" type="text" class="form-control" readonly maxlength="10">
                    <input type="text" value="${cDTO.name}" name="name" id="name" class="form-control" placeholder="Category Name" autofocus="">
                    <label for="type">Category Type:</label>
                    
                    <select id="type" name="type">
                        <c:if test="${cDTO!=null}">
                            <option value="${cDTO.type}">${cDTO.type}</option>
                        </c:if>
                        
                        <option value="cake">cake</option>
                        <option value="post">post</option>
                    </select>

                    <input type="hidden" id="Update" name="Update" value="${Update}">
                     
                    <button class="btn btn-primary btn-block" type="update"><i class="fas fa-user-plus"></i> Update</button>
                </form>
                </c:if>    
                    
                <br>

            </div>
            </div>
            <jsp:include page="Footer.jsp"></jsp:include>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
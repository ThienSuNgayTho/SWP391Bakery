<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link href="css/login.css" rel="stylesheet" type="text/css"/>
        <title>Login</title>
        <script>
            function myFunction() {
                var x = document.getElementById("inputPassword");
                if (x.type === "password") {
                     x.type = "text";
                } else {
                    x.type = "password";
                }
            }
        </script>
    </head>
    <body>
        <style type="text/css">
            .update-link-true {
                border: 1px;
                border-style: solid;
                border-radius: 10px;
                background-color: #00cc33;
                color: white;
                justify-content: center;
                align-items: center;
                text-decoration: none;
                padding: 0.3em 0.6em;
                display: flex;
                width: 28%;
                margin-left: auto;
                margin-right: auto;
            }
        </style>
        <jsp:include page="Menu.jsp"></jsp:include>
        <c:set var="success" value="${requestScope.REGIS_SUCCESS_MESSAGE}"/>
        <c:if test="${not empty success}">
            <div class="update-link-true">${success}</div>
        </c:if>
        <div id="logreg-forms">
            <form class="form-signin" action="login" method="post">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Sign in</h1>
                <input name="txtEmail"  type="text" id="inputEmail" class="form-control" placeholder="Username" value="${requestScope.EMAIL}" required="" autofocus="" maxlength="30">
                <input name="txtPassword"  type="password" id="inputPassword" class="form-control" placeholder="Password" value="${requestScope.PASSWORD}" required="" maxlength="30">
                <c:set var="error" value="${requestScope.LOGIN_ERROR_MESSAGE}"/>
                <c:if test="${not empty error}">
                    <font color="red">${error}</font>
                </c:if>
                    <div><input type="checkbox" onclick="myFunction()"> Show Password</div>
                <button class="btn btn-success btn-block" type="submit"><i class="fas fa-sign-in-alt"></i> Sign in</button>
                <hr>
                <a href="Registration.jsp" class=""><button class="btn btn-primary btn-block" type="button">Sign up New Account</button></a>
            </form>
            <br>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>
            function toggleResetPswd(e) {
                e.preventDefault();
                $('#logreg-forms .form-signin').toggle() // display:block or none
                $('#logreg-forms .form-reset').toggle() // display:block or none
            }

            function toggleSignUp(e) {
                e.preventDefault();
                $('#logreg-forms .form-signin').toggle(); // display:block or none
                $('#logreg-forms .form-signup').toggle(); // display:block or none
            }

            $(() => {
                // Login Register Form
                $('#logreg-forms #forgot_pswd').click(toggleResetPswd);
                $('#logreg-forms #cancel_reset').click(toggleResetPswd);
                $('#logreg-forms #btn-signup').click(toggleSignUp);
                $('#logreg-forms #cancel_signup').click(toggleSignUp);
            })
        </script>
    </body>
</html>
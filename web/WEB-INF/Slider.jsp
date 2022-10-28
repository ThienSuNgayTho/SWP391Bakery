<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            * {box-sizing: border-box}
            body {font-family: Verdana, sans-serif; margin:0}
            .mySlides {display: none}
            .mySlides img {vertical-align: middle;}
            /* Slideshow container */
            .slideshow-container {
                position: relative;
                margin: auto;
            }
            /* Next & previous buttons */
            .prev, .next {
                cursor: pointer;
                position: absolute;
                top: 50%;
                width: auto;
                padding: 16px;
                margin-top: -22px;
                color: white;
                font-weight: bold;
                font-size: 18px;
                transition: 0.6s ease;
                border-radius: 0 3px 3px 0;
                user-select: none;
            }
            /* Position the "next button" to the right */
            .next {
                right: 0;
                border-radius: 3px 0 0 3px;
            }
            /* On hover, add a black background color with a little bit see-through */
            .prev:hover, .next:hover {
                background-color: aqua;
            }
            /* Caption text */
            .text {
                color: #f2f2f2;
                font-size: 15px;
                padding: 8px 12px;
                position: absolute;
                bottom: 8px;
                width: 100%;
                text-align: center;
                -webkit-text-fill-color: red;
                -webkit-text-stroke-color: black;
                -webkit-text-stroke-width: 2.00px; 
            }
            /* Number text (1/3 etc) */
            .numbertext {
                color: #f2f2f2;
                font-size: 12px;
                padding: 8px 12px;
                position: absolute;
                top: 0;
            }
            /* The dots/bullets/indicators */
            .dot {
                cursor: pointer;
                height: 15px;
                width: 15px;
                margin: 0 2px;
                background-color: #bbb;
                border-radius: 50%;
                display: inline-block;
                transition: background-color 0.6s ease;
            }
            .activeSlide, .dot:hover {
                background-color: #717171;
            }
            /* Fading animation */
            .fade {
                -webkit-animation-name: fade;
                -webkit-animation-duration: 1.5s;
                animation-name: fade;
                animation-duration: 1.5s;
            }
            @-webkit-keyframes fade {
                from {opacity: .4} 
                to {opacity: 1}
            }
            @keyframes fade {
                from {opacity: .4} 
                to {opacity: 1}
            }
            /* On smaller screens, decrease text size */
            @media only screen and (max-width: 300px) {
                .prev, .next,.text {font-size: 11px}
            }
        </style>
    </head>
    <body>
        <c:set var="sliderList" value="${applicationScope.POST_SLIDER_LIST}"/>
        
        <div class="slideshow-container" style="margin-top: 20px; border-style: solid; width: 100%;">
            <c:forEach items="${sliderList}" var="postDto" varStatus="counter">
                <div class="mySlides" style="width: 100%;">
                    <div class="numbertext"> ${counter.count}/${sliderList.size()}</div> 
                    <a href="postDetail?txtPostId=${postDto.id}"><img src="images/${postDto.thumbnailLink}" style="width:100%; height: 400px; background-size: 100% 100%;" /></a>
                    <div class="text"><h3>${postDto.title}</h3></div>
                </div>
            </c:forEach>

            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </div>
        <br>
        <div style="text-align:center; margin-bottom: 30px">
            <c:forEach items="${sliderList}" var="postDto" varStatus="counter">
                <span class="dot" onclick="currentSlide(${counter.count})"></span> 
            </c:forEach>
        </div>

        <script>
            var slideIndex = 1;
            showSlides(slideIndex);
            setInterval(function(){ showSlides(slideIndex += 1); }, 3000);
            function plusSlides(n) {
                showSlides(slideIndex += n);
            }
            function currentSlide(n) {
                showSlides(slideIndex = n);
            }
            function showSlides(n) {
                var i;
                var slides = document.getElementsByClassName("mySlides");
                var dots = document.getElementsByClassName("dot");
                if (n > slides.length) {
                    slideIndex = 1
                }
                if (n < 1) {
                    slideIndex = slides.length
                }
                for (i = 0; i < slides.length; i++) {
                    slides[i].style.display = "none";
                }
                for (i = 0; i < dots.length; i++) {
                    dots[i].className = dots[i].className.replace(" activeSlide", "");
                }
                slides[slideIndex - 1].style.display = "block";
                dots[slideIndex - 1].className += " activeSlide";
            }
        </script>

    </body>
</html> 
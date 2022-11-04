<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://maps.google.com/maps?file=api&v=2&key=ABQIAAAA7j_Q-rshuWkc8HyFI4V2HxQYPm-xtd00hTQOC0OXpAMO40FHAxT29dNBGfxqMPq5zwdeiDSHEPL89A" type="text/javascript"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
                integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
        <title>Billing</title>
        <style>
            .bill {
                border: 0.8px solid gray;
            }
            .bill-detail {
                border: 0.8px solid gray;
            }
            .ShippingAddress {
                border: 0.8px solid gray;
            }
            .payingSection {
                border: 0.8px solid gray;
            }
            button {
                width: 30px;
            }
            #address {
                display: inline;
            }
            #modify{
                margin-top: 5px;
            }
        </style>
        <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css'>
        <style>
            .noti[data-count]:after {
                position: absolute;
                right: 0%;
                top: 1%;
                content: attr(data-count);
                font-size: 80%;
                padding: .6em;
                border-radius: 50%;
                line-height: .8em;
                color: white;
                background: rgba(255, 0, 0, 0.85);
                text-align: center;
                min-width: 1em;
                font-weight: bold;
            }
        </style>
    </head>

    <body>
        <fmt:requestEncoding value="UTF-8" /> 
        <fmt:setLocale value="zh_CN"/> 
        <jsp:include page="Menu.jsp"></jsp:include>
        <c:set var="total" value="0"></c:set>
        <c:set var="user" value="${sessionScope.CURRENT_USER.getEmail()}"/>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-2" style="margin-bottom: 30px">
                        <form action="SearchProduct" method="post" id="SearchProductForm">
                            <input type="hidden" name="jspname" value="home" />
                            <div class="input-group input-group-sm">
                                <input name="txtSearchValue" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search..." value="${param.txtSearchValue}" maxlength="20">
                            <div class="input-group-append">
                                <button type="submit" class="btn btn-secondary btn-number">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div></br>
                        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories </div>
                        <ul class="list-group category_block">
                            <c:set var="categoryList" value="${applicationScope.CAKE_CATEGORY_LIST}"/>
                            <c:forEach items="${categoryList}" var="cateDto">
                                <li class="list-group-item text-white" ><a href="filterProductByCategory?categoryID=${cateDto.categoryId}">${cateDto.name}</a></li>
                                </c:forEach>
                        </ul>
                    </form>
                    <c:if test="${not empty user}">
                        <c:set var="numberCart" value="${sessionScope.NUMBER_CART}"/>
                        <a href="Cart.jsp"><div class="list-group-item btn card-header bg-primary text-white text-uppercase">View my Cart <c:if test="${numberCart gt 0}"><span style="display: inline-block;" class="noti" data-count="${numberCart}" /></c:if></div></a>
                            <a href="OrderHistory"><div class="list-group-item btn card-header bg-primary text-white text-uppercase">View my Order History</div></a>
                    </c:if>
                </div>
                <div class="col-sm-10">
                    <h3>Billing</h3>
                    <div class=" col-12 col-md-12 bill-detail  ">
                        <table class="table">

                            <thead>
                                <tr>

                                    <th style="text-align: left;" scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase">Name</div>
                                    </th>
                                    <th style="text-align: right;" scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase">Unit Price</div>
                                    </th>
                                    <th style="text-align: right;" scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase">Quantity</div>
                                    </th>
                                    <th style="text-align: right;" scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase">Total Price</div>
                                    </th>
                                </tr>
                            </thead>

                            <tbody id="productList">

                                <c:forEach var="productItem" items="${sessionScope.productList}">
                                <tr>
                                    <td style="text-align: left;">${productItem.key.name}</td>
                                    <c:if test="${!productItem.key.saleStatus}">
                                    <td style="text-align: right;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${productItem.key.originalSalePrice}" /></td>
                                    </c:if>
                                    <c:if test="${productItem.key.saleStatus}">
                                    <td style="text-align: right;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${productItem.key.salePrice}" /></td>
                                    </c:if>
                                    <td style="text-align: right;">${productItem.value}</td>
                                    <c:if test="${!productItem.key.saleStatus}">
                                    <td style="text-align: right;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${productItem.value * productItem.key.originalSalePrice}" /></td>
                                    </c:if>
                                    <c:if test="${productItem.key.saleStatus}">
                                    <td style="text-align: right;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${productItem.value * productItem.key.salePrice}" /></td>
                                    </c:if>
                                </tr>
                                <c:if test="${!productItem.key.saleStatus}">
                                <c:set var="total" value="${total+productItem.key.originalSalePrice*productItem.value}"></c:set>
                                </c:if>
                                <c:if test="${productItem.key.saleStatus}">
                                <c:set var="total" value="${total+productItem.key.salePrice*productItem.value}"></c:set>
                                </c:if>
                            </c:forEach>

                            </tbody>

                        </table>
                        <c:if test="${requestScope.isValid != null && !requestScope.isValid }">
                            <h2>Some products is currently not available, We have removed those from your cart </h2>
                        </c:if>

                    </div>

                    <div class="col-12 col-md-12">
                        <div>
                            <div style="margin-left: 7px; ">
                                <div class="row">
                                    <div class="col-md-8">
                                        <h3 style="display: inline-block" >Shipping to :</h3>

                                        <c:if test="${sessionScope.modified ne null && !requestScope.fail}">
                                            <b>${sessionScope.shippingAddress}</b>
                                            <c:set var="fail" value="${false}"></c:set>
                                        </c:if>
                                        <c:if test="${sessionScope.modified eq null || requestScope.fail || sessionScope.shippingAddress eq null}">
                                            <b>N/A</b>
                                            <c:set var="fail" value="${true}"></c:set>
                                        </c:if>
                                        <br>
                                        <a data-bs-toggle="modal" onclick="fetchDistrict()" data-bs-target="#exampleModal" id="modify" class="col-md-3 btn btn-warning">Change</a>

                                        <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <h3>Please fulfill your order address details</h3> 
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button style="width: 100%" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <input id="address" type="hidden" value="${currentUser.address}" />
                                    </div>
                                    <div class="col-md-4">
                                        <div >

                                            <form action="Purchase">


                                                <table class="table">
                                                    <tr>
                                                        <td>Price: </td>
                                                        <td style="text-align: right;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${total}" /> VND</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Shipping fee: </td>
                                                        <c:if test="${sessionScope.shippingFee ne null && !requestScope.fail}">
                                                            <td style="text-align: right;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${sessionScope.shippingFee}" /> VND</td>
                                                        </c:if>
                                                        <c:if test="${sessionScope.shippingFee eq null || requestScope.fail}">
                                                            <td style="text-align: right;">0 VND</td>
                                                        </c:if>

                                                    </tr>
                                                    <tr>
                                                        <td>Total: </td>
                                                        <c:if test="${sessionScope.shippingFee ne null && !requestScope.fail}">
                                                            <c:set var="total" value="${total+sessionScope.shippingFee }"></c:set>
                                                        </c:if>
                                                        <td style="text-align: right;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${total}" /> VND</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Payment method: </td>
                                                        <td style="padding-left: 120px ">
                                                            <input type="radio"  value="VNPAY" name="paymentMethod"/> VN PAY <br>
                                                            <input type="radio" checked value="Cash" name="paymentMethod" /> Cash
                                                        </td>
                                                    </tr>
                                                </table>
                                                <c:if test="${fail}">
                                                    <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal1" href="#" class="btn btn-danger" style="width : 100%; margin-top: 5px;">Confirm Order</button>
                                                </c:if>
                                                <c:if test="${!fail}">
                                                    <button type="submit" class="btn btn-danger" style="width : 100%; margin-top: 5px;">Confirm Order</button>
                                                </c:if>
                                                <div >
                                                    <a href="Cart.jsp" class="btn btn-success" style="width : 100%; margin-top: 5px;">Go Back to Cart</a>
                                                </div>
                                            </form>

                                        </div>



                                    </div> 


                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                </div>                                    
            </div>
            <form action="Shipping" method="POST">
                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel" style="margin-left: 35%;" >Shipping address</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">


                                <div class="form-group">
                                    <h4 >City</h4>
                                    <span>
                                        <select style="width:300px" id="provinceSelect"  class="form-select">
                                            <option value="203"  selected>Đà Nẵng</option>
                                            <input type="hidden"  name="City" value="Da Nang" id="City">
                                        </select>
                                    </span>

                                    <h4>District</h4>
                                    <select style="width:300px" onchange="fetchWard()"  id="districtSelect" class="form-select">
                                        <option selected>District</option>
                                        <input type="hidden"  name="District" id="District">
                                    </select>
                                    <h4>Ward</h4>
                                    <select onchange="fetchShippingFee()" style="width:300px" id="wardSelect"  class="form-select">
                                        <option selected>Ward</option>
                                        <input type="hidden"  name="Ward" id="Ward">
                                    </select>
                                    <h4>House number & Street</h4>
                                    <input style="width:300px" type="text" name="Street" placeholder="EX: 157 Str. Le Van Viet" />
                                    <input type="hidden" name="shippingFee" id="shippingFee"  />
                                </div>


                            </div>
                            <div class="modal-footer">
                                <button style="width:100%" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" style="width:100%" class="btn btn-primary"  >Save changes</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
<script>
    let provinceId = 0;
    let districtId = 0;
    let wardId = 0;
//    fetch("https://online-gateway.ghn.vn/shiip/public-api/master-data/province", {
//        method: 'GET', // *GET, POST, PUT, DELETE, etc.
//        headers: {
//            'token': 'beeffb36-e516-11eb-9cee-6e1c80ec1bcb'
//        }
//    }).then(async function (response) {
//        let provinceSelect = document.getElementById("provinceSelect");
//
//        response = await response.json();
//        province = response;
//        console.log(province.data);
//        for (let i in province.data) {
//          //  console.log(province.data[i].ProvinceID);
//            let provinceOption = document.createElement("option");
//            provinceOption.textContent = province.data[i].ProvinceName;
//            provinceOption.value = province.data[i].ProvinceID;
//            provinceSelect.appendChild(provinceOption);
//        }
//    });
    function fetchDistrict() {
        let districtSelect = document.getElementById("districtSelect");
//        districtSelect.textContent = '<option selected>District</option>';
//        let provinceSelect = document.getElementById("provinceSelect");
        provinceId = 203;
        console.log(provinceId);
        fetch("https://online-gateway.ghn.vn/shiip/public-api/master-data/district?province_id=" + provinceId, {
            method: 'GET',
            headers: {
                'token': 'beeffb36-e516-11eb-9cee-6e1c80ec1bcb'
            }
        }).then(async function (response) {
            response = await response.json();
            district = response;
            for (let i in district.data) {
                let districtOption = document.createElement("option");
                districtOption.textContent = district.data[i].DistrictName;
                districtOption.value = district.data[i].DistrictID;
                // districtInput.value = district.data[i].DistrictID;
                districtSelect.appendChild(districtOption);
            }
        });
    }
    function fetchWard() {
        let wardSelect = document.getElementById("wardSelect");
        wardSelect.textContent = '<option selected>Ward</option>';
        let districtSelect = document.getElementById("districtSelect");
        let districtInput = document.getElementById("District");
        districtInput.value = districtSelect.options[districtSelect.selectedIndex].textContent;
        districtId = parseInt(districtSelect.options[districtSelect.selectedIndex].value);
        fetch("https://online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=" + districtId, {
            method: 'GET',
            headers: {
                'token': 'beeffb36-e516-11eb-9cee-6e1c80ec1bcb'
            }
        }).then(async function (response) {
            response = await response.json();
            ward = response;
            let wardOption = document.createElement("option");
            wardOption.textContent = 'Ward';
            wardOption.value = 0;
            wardSelect.appendChild(wardOption);
            for (let i in ward.data) {
                wardOption = document.createElement("option");
                wardOption.textContent = ward.data[i].WardName;
                wardOption.value = ward.data[i].WardCode;
                wardSelect.appendChild(wardOption);
            }
            console.log(provinceId, districtId, wardId);
        });
    }
    function fetchShippingFee() {
        let numOfProducts = document.getElementById("productList").children.length;
        let extra = numOfProducts % 4 > 0 ? numOfProducts / 4 * 2 : 1;
        console.log(numOfProducts);
        console.log(extra);
        let wardInput = document.getElementById("Ward");
        let wardSelect = document.getElementById("wardSelect");
        wardInput.value = wardSelect.options[wardSelect.selectedIndex].textContent;
        let shippingFeeContainer = document.getElementById("shippingFee");
        let shippingFee = document.getElementById("shippingFee");
        fetch("https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee?service_type_id=2&insurance_value=0&coupon=&from_district_id=1529&to_district_id=" + districtId + "&to_ward_code=" + wardId + "&height=" + extra * 10 + "&length=" + extra * 10 + "&weight=" + extra * 100 + "&width=" + extra * 10, {
            method: 'GET',
            headers: {
                'token': 'beeffb36-e516-11eb-9cee-6e1c80ec1bcb'
            }
        }).then(async function (response) {
            shipFeeReturned = await response.json();
            console.log(shipFeeReturned);
            shippingFee.value = shipFeeReturned.data.total;
            console.log(shippingFee.value);
//            for(let i in shipFeeReturned.data){
//                console.log(shipFeeReturned.data[i]);
//            }
        })
    }
</script>
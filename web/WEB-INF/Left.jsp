<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--begin of left-->
<div class="col-sm-3">
    <div class="card bg-light mb-3">
        <form action="searchProduct" method="post">
                <div class="input-group input-group-sm">
                    <input name="txtSearchValue" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search...">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-secondary btn-number">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
        </form>
        
        <!--<div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories </div>
        <ul class="list-group category_block">
            <c:set var="categoryList" value="${applicationScope.ALL_CATEGORY_LIST}"/>
            <c:forEach items="${categoryList}" var="cateDto">
                <li class="list-group-item text-white  ${cIDcc.equals(cateDto.categoryId) ? "active":""}" ><a href="filterProductByCategory?categoryID=${cateDto.categoryId}">${cateDto.name}</a></li>
            </c:forEach>
        </ul>-->
    </div>
</div>
<!--end of left-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="https://jakarta.ee/jsp/jstl/core" %>
<%@ page import="com.test.dl.model.User" %>
<nav class="navbar">
    <div class="brand">&#x1F52C; 实验室设备管理</div>
    <c:choose>
        <c:when test="${empty sessionScope.loginUser}">
            <div class="nav-right">
                <a href="${pageContext.request.contextPath}/login.jsp">登录 / 注册</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="nav-right">
                <a href="${pageContext.request.contextPath}/device/list.action">设备列表</a>
                <a href="${pageContext.request.contextPath}/borrow/my.action">我的借用</a>
                <a href="${pageContext.request.contextPath}/borrow/overdueList.action">逾期提醒</a>
                <c:if test="${sessionScope.loginUser.admin}">
                    <a href="${pageContext.request.contextPath}/admin/main.action">管理后台</a>
                </c:if>
                <a style="opacity:.85;">&#x1F464; ${sessionScope.loginUser.realName} <c:if test="${sessionScope.loginUser.admin}">(管理员)</c:if></a>
                <a href="${pageContext.request.contextPath}/login/logoutLogin.action">退出</a>
            </div>
        </c:otherwise>
    </c:choose>
</nav>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>错误 - 校园实验室设备管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container login-box">
    <div class="card">
        <h2 style="text-align:center;color:#dc3545;">❌ 发生错误</h2>
        <p style="text-align:center;color:#6c757d;">很抱歉，系统处理您的请求时发生了异常。</p>
        <div style="text-align:center;margin-top:20px;">
            <a href="${pageContext.request.contextPath}/device/list.action" class="btn">返回首页</a>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-warning">重新登录</a>
        </div>
    </div>
</div>
</body>
</html>

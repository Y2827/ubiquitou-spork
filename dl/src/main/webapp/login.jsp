<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="https://jakarta.ee/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录 - 校园实验室设备管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container login-box">
    <div class="card">
        <h2>&#x1F52C; 校园实验室设备管理系统</h2>

        <s:if test="hasActionMessages()">
            <div class="alert alert-success"><s:actionmessage/></div>
        </s:if>
        <s:if test="hasActionErrors()">
            <div class="alert alert-error"><s:actionerror/></div>
        </s:if>

        <s:form action="loginLogin" namespace="/login" method="post" theme="simple">
            <div class="form-group">
                <label>用户名</label>
                <s:textfield name="model.username" class="form-control" placeholder="请输入用户名" />
            </div>
            <div class="form-group">
                <label>密码</label>
                <s:password name="model.password" class="form-control" placeholder="请输入密码" />
            </div>
            <s:submit value="登录" class="btn" style="width:100%;padding:10px;font-size:16px;margin-top:8px;"/>
        </s:form>

        <hr style="margin:20px 0;border:none;border-top:1px solid #eee;">

        <h3 style="margin-top:0;color:#2a5298;">&#x1F4DD; 注册账号</h3>
        <s:form action="loginRegister" namespace="/login" method="post" theme="simple">
            <div class="form-group">
                <label>用户名</label>
                <s:textfield name="model.username" placeholder="自定义登录名" />
            </div>
            <div class="form-group">
                <label>密码</label>
                <s:textfield name="model.password" placeholder="至少 6 位" />
            </div>
            <div class="form-group">
                <label>真实姓名</label>
                <s:textfield name="model.realName" placeholder="你的姓名" />
            </div>
            <div class="form-group">
                <label>学号</label>
                <s:textfield name="model.studentNo" placeholder="你的学号" />
            </div>
            <s:submit value="注册" class="btn btn-success" style="width:100%;padding:10px;font-size:16px;"/>
        </s:form>

        <div style="margin-top:18px;padding:12px;background:#f8f9fa;border-radius:6px;font-size:13px;color:#495057;">
            <b>测试账号：</b><br>
            管理员：<code>admin / 123456</code><br>
            学生：<code>zhangsan / 123456</code>、<code>lisi / 123456</code>
        </div>
    </div>
</div>
</body>
</html>

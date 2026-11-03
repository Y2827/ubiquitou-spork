<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="https://jakarta.ee/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>逾期提醒 - 校园实验室设备管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/header.jsp" %>
<div class="container">
    <div class="card">
        <h2>&#x26A0;&#xFE0F; 逾期提醒</h2>

        <div class="alert alert-warning">
            &#x26A0;&#xFE0F; 以下设备已超过应还时间，请尽快到实验室归还，逾期将影响后续设备借用权限。
        </div>

        <s:if test="hasActionMessages()">
            <div class="alert alert-success"><s:actionmessage/></div>
        </s:if>

        <table>
            <thead>
            <tr>
                <th>设备编号</th><th>设备名称</th><th>借用人</th><th>学号</th>
                <th>借用时间</th><th>应还时间</th><th>逾期天数</th><th>状态</th>
            </tr>
            </thead>
            <tbody>
            <s:iterator value="borrowList" var="r">
                <tr>
                    <td><s:property value="#r.deviceCode"/></td>
                    <td><b><s:property value="#r.deviceName"/></b></td>
                    <td><s:property value="#r.realName"/> (<s:property value="#r.username"/>)</td>
                    <td>--</td>
                    <td><s:date name="#r.borrowTime" format="yyyy-MM-dd HH:mm"/></td>
                    <td><s:date name="#r.dueTime" format="yyyy-MM-dd HH:mm"/></td>
                    <td style="color:#dc3545;font-weight:bold;">
                        <s:property value="%{new java.text.SimpleDateFormat('yyyy-MM-dd').parse(#r.dueTime.toString()) != null ?
                          (new java.util.Date().getTime() - #r.dueTime.getTime()) / 86400000 : 0}"/> 天
                    </td>
                    <td><span class="tag tag-overdue">已逾期</span></td>
                </tr>
            </s:iterator>
            <s:if test="borrowList == null || borrowList.size() == 0">
                <tr><td colspan="8" style="text-align:center;color:#28a745;font-weight:bold;">&#x1F389; 太棒了！当前没有逾期设备</td></tr>
            </s:if>
            </tbody>
        </table>
    </div>
</div>
<footer>&copy; 2026 校园实验室设备管理系统 &middot; Struts 7 + Jakarta EE + MySQL</footer>
</body>
</html>

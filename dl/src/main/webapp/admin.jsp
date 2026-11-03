<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="https://jakarta.ee/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理后台 - 校园实验室设备管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/header.jsp" %>
<div class="container">
    <div class="card">
        <h2>&#x1F6E0;&#xFE0F; 管理员后台</h2>

        <s:if test="hasActionMessages()">
            <div class="alert alert-success"><s:actionmessage/></div>
        </s:if>
        <s:if test="hasActionErrors()">
            <div class="alert alert-error"><s:actionerror/></div>
        </s:if>

        <div class="stat-grid">
            <div class="stat-item">
                <div class="num"><s:property value="deviceList.size"/></div>
                <div class="label">设备总数</div>
            </div>
            <div class="stat-item">
                <div class="num"><s:property value="userList.size"/></div>
                <div class="label">注册用户</div>
            </div>
            <div class="stat-item">
                <div class="num" style="color:#856404;">
                    <s:property value="borrowList.{?#this.status=='BORROWED'}.size()"/>
                </div>
                <div class="label">借用中</div>
            </div>
            <div class="stat-item">
                <div class="num" style="color:#dc3545;">
                    <s:property value="borrowList.{?#this.status=='OVERDUE' or (#this.status=='BORROWED' and #this.dueTime != null and #this.dueTime.before(new java.util.Date()))}.size()"/>
                </div>
                <div class="label">逾期设备</div>
            </div>
        </div>

        <div style="margin:16px 0;">
            <a href="${pageContext.request.contextPath}/admin/deviceListAdmin.action" class="btn">设备管理</a>
            <a href="${pageContext.request.contextPath}/admin/overdueAdmin.action" class="btn btn-warning">查看逾期</a>
            <a href="${pageContext.request.contextPath}/admin/refreshOverdueAdmin.action" class="btn btn-success">刷新逾期状态</a>
        </div>

        <h3 style="color:#2a5298;">全部借用记录</h3>
        <table>
            <thead>
            <tr>
                <th>编号</th><th>借用人</th><th>设备</th><th>借用时间</th>
                <th>应还时间</th><th>归还时间</th><th>状态</th><th>操作</th>
            </tr>
            </thead>
            <tbody>
            <s:iterator value="borrowList" var="r">
                <tr>
                    <td><s:property value="#r.id"/></td>
                    <td><s:property value="#r.realName"/> (<s:property value="#r.username"/>)</td>
                    <td><s:property value="#r.deviceCode"/> - <s:property value="#r.deviceName"/></td>
                    <td><s:date name="#r.borrowTime" format="yyyy-MM-dd HH:mm"/></td>
                    <td><s:date name="#r.dueTime" format="yyyy-MM-dd HH:mm"/></td>
                    <td><s:if test="#r.returnTime != null"><s:date name="#r.returnTime" format="yyyy-MM-dd HH:mm"/></s:if><s:else>--</s:else></td>
                    <td>
                        <s:if test="#r.status == 'BORROWED'">
                            <span class="tag tag-borrowed">借用中</span>
                        </s:if>
                        <s:elseif test="#r.status == 'OVERDUE'">
                            <span class="tag tag-overdue">逾期</span>
                        </s:elseif>
                        <s:else>
                            <span class="tag tag-returned">已归还</span>
                        </s:else>
                    </td>
                    <td>
                        <s:if test="#r.status != 'RETURNED'">
                            <form action="${pageContext.request.contextPath}/admin/adminReturnAdmin.action" method="post" style="display:inline;"
                                  onsubmit="return confirm('管理员强制归还？');">
                                <input type="hidden" name="recordId" value="<s:property value='#r.id'/>">
                                <input type="hidden" name="deviceId" value="<s:property value='#r.deviceId'/>">
                                <button type="submit" class="btn btn-sm btn-success">强制归还</button>
                            </form>
                        </s:if>
                        <s:else>--</s:else>
                    </td>
                </tr>
            </s:iterator>
            <s:if test="borrowList == null || borrowList.size() == 0">
                <tr><td colspan="8" style="text-align:center;color:#6c757d;">暂无借用记录</td></tr>
            </s:if>
            </tbody>
        </table>
    </div>
</div>
<footer>&copy; 2026 校园实验室设备管理系统 &middot; Struts 7 + Jakarta EE + MySQL</footer>
</body>
</html>

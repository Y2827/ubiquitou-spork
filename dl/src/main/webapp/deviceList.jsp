<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="https://jakarta.ee/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>设备列表 - 校园实验室设备管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/header.jsp" %>
<div class="container">
    <div class="card">
        <h2>&#x1F4E6; 设备列表</h2>

        <s:if test="hasActionMessages()">
            <div class="alert alert-success"><s:actionmessage/></div>
        </s:if>
        <s:if test="hasActionErrors()">
            <div class="alert alert-error"><s:actionerror/></div>
        </s:if>

        <form class="form-inline" action="${pageContext.request.contextPath}/device/list.action" method="get">
            <div class="form-group">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="搜索设备名称 / 编号 / 类别">
            </div>
            <div class="form-group">
                <button type="submit" class="btn">&#x1F50D; 搜索</button>
                <a href="${pageContext.request.contextPath}/device/list.action" class="btn btn-warning">全部</a>
            </div>
        </form>

        <table>
            <thead>
            <tr>
                <th>编号</th><th>名称</th><th>类别</th><th>型号</th>
                <th>存放位置</th><th>库存</th><th>已借出</th><th>可用</th><th>操作</th>
            </tr>
            </thead>
            <tbody>
            <s:iterator value="deviceList" var="d">
                <tr>
                    <td><s:property value="#d.deviceCode"/></td>
                    <td><b><s:property value="#d.deviceName"/></b></td>
                    <td><s:property value="#d.category"/></td>
                    <td><s:property value="#d.model"/></td>
                    <td><s:property value="#d.location"/></td>
                    <td><s:property value="#d.totalNum"/></td>
                    <td><s:property value="#d.borrowNum"/></td>
                    <td>
                        <s:if test="#d.availableNum > 0">
                            <span class="tag tag-available"><s:property value="#d.availableNum"/></span>
                        </s:if>
                        <s:else>
                            <span class="tag tag-sold-out">0</span>
                        </s:else>
                    </td>
                    <td>
                        <s:if test="#d.availableNum > 0">
                            <a class="btn btn-sm btn-success"
                               href="${pageContext.request.contextPath}/device/borrowDevice.action?id=<s:property value='#d.id'/>">
                                借用
                            </a>
                        </s:if>
                        <s:else>
                            <span class="tag tag-sold-out">已满</span>
                        </s:else>
                    </td>
                </tr>
                <tr><td colspan="9" style="font-size:12px;color:#6c757d;background:#fafbfc;"><s:property value="#d.description"/></td></tr>
            </s:iterator>
            <s:if test="deviceList == null || deviceList.size() == 0">
                <tr><td colspan="9" style="text-align:center;color:#6c757d;">暂无设备</td></tr>
            </s:if>
            </tbody>
        </table>
    </div>
</div>
<footer>&copy; 2026 校园实验室设备管理系统 &middot; Struts 7 + Jakarta EE + MySQL</footer>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="https://jakarta.ee/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>设备管理 - 校园实验室设备管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/header.jsp" %>
<div class="container">
    <div class="card">
        <h2>&#x1F6E0;&#xFE0F; 设备管理</h2>

        <s:if test="hasActionMessages()">
            <div class="alert alert-success"><s:actionmessage/></div>
        </s:if>
        <s:if test="hasActionErrors()">
            <div class="alert alert-error"><s:actionerror/></div>
        </s:if>

        <div style="margin-bottom:16px;">
            <a href="${pageContext.request.contextPath}/admin/deviceFormAdmin.action" class="btn btn-success">+ 新增设备</a>
            <a href="${pageContext.request.contextPath}/admin/main.action" class="btn btn-warning">返回后台</a>
        </div>

        <form class="form-inline" action="${pageContext.request.contextPath}/admin/deviceListAdmin.action" method="get">
            <div class="form-group">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="搜索设备名称 / 编号">
            </div>
            <div class="form-group">
                <button type="submit" class="btn">&#x1F50D; 搜索</button>
            </div>
        </form>

        <table>
            <thead>
            <tr>
                <th>编号</th><th>名称</th><th>类别</th><th>型号</th><th>位置</th>
                <th>库存</th><th>已借</th><th>可用</th><th>操作</th>
            </tr>
            </thead>
            <tbody>
            <s:iterator value="deviceList" var="d">
                <tr>
                    <td><s:property value="#d.deviceCode"/></td>
                    <td><s:property value="#d.deviceName"/></td>
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
                        <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/deviceFormAdmin.action?id=<s:property value='#d.id'/>">编辑</a>
                        <form action="${pageContext.request.contextPath}/admin/deleteDeviceAdmin.action" method="post" style="display:inline;"
                              onsubmit="return confirm('确定删除该设备？');">
                            <input type="hidden" name="id" value="<s:property value='#d.id'/>">
                            <button type="submit" class="btn btn-sm btn-danger">删除</button>
                        </form>
                    </td>
                </tr>
            </s:iterator>
            <s:if test="deviceList == null || deviceList.size() == 0">
                <tr><td colspan="9" style="text-align:center;color:#6c757d;">暂无设备</td></tr>
            </s:if>
            </tbody>
        </table>
    </div>

    <s:if test="device != null">
        <div class="card">
            <h2><s:if test="device.id == null">新增设备</s:if><s:else>编辑设备</s:else></h2>
            <s:form action="saveDeviceAdmin" namespace="/admin" method="post" theme="simple">
                <s:hidden name="device.id" value="%{device.id}"/>
                <table style="width:100%;max-width:720px;">
                    <tr>
                        <td width="130px"><label>设备编号</label></td>
                        <td><s:textfield name="device.deviceCode" value="%{device.deviceCode}" placeholder="如 DEV-007"/></td>
                    </tr>
                    <tr>
                        <td><label>设备名称</label></td>
                        <td><s:textfield name="device.deviceName" value="%{device.deviceName}" placeholder="必填"/></td>
                    </tr>
                    <tr>
                        <td><label>类别</label></td>
                        <td><s:textfield name="device.category" value="%{device.category}" placeholder="如 电子仪器"/></td>
                    </tr>
                    <tr>
                        <td><label>型号</label></td>
                        <td><s:textfield name="device.model" value="%{device.model}"/></td>
                    </tr>
                    <tr>
                        <td><label>存放位置</label></td>
                        <td><s:textfield name="device.location" value="%{device.location}" placeholder="如 A301"/></td>
                    </tr>
                    <tr>
                        <td><label>库存数量</label></td>
                        <td><s:textfield name="device.totalNum" value="%{device.totalNum}"/></td>
                    </tr>
                    <tr>
                        <td><label>描述</label></td>
                        <td><s:textarea name="device.description" value="%{device.description}" rows="3"/></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <s:submit value="保存" class="btn btn-success"/>
                            <a href="${pageContext.request.contextPath}/admin/deviceListAdmin.action" class="btn btn-warning">取消</a>
                        </td>
                    </tr>
                </table>
            </s:form>
        </div>
    </s:if>
</div>
<footer>&copy; 2026 校园实验室设备管理系统 &middot; Struts 7 + Jakarta EE + MySQL</footer>
</body>
</html>

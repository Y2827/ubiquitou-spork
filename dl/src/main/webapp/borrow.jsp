<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="https://jakarta.ee/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>借用设备 - 校园实验室设备管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/header.jsp" %>
<div class="container">
    <div class="card">
        <h2>&#x1F4DD; 借用设备</h2>

        <s:if test="hasActionErrors()">
            <div class="alert alert-error"><s:actionerror/></div>
        </s:if>

        <s:if test="device != null">
            <div class="card" style="background:#f8f9fa;border:1px solid #e9ecef;">
                <h3 style="margin-top:0;color:#2a5298;">设备信息</h3>
                <table>
                    <tr><th style="width:140px;">设备编号</th><td><s:property value="device.deviceCode"/></td></tr>
                    <tr><th>设备名称</th><td><s:property value="device.deviceName"/></td></tr>
                    <tr><th>型号</th><td><s:property value="device.model"/></td></tr>
                    <tr><th>类别</th><td><s:property value="device.category"/></td></tr>
                    <tr><th>存放位置</th><td><s:property value="device.location"/></td></tr>
                    <tr><th>库存</th><td><s:property value="device.totalNum"/> / 可用 <s:property value="device.availableNum"/></td></tr>
                    <tr><th>描述</th><td><s:property value="device.description"/></td></tr>
                </table>
            </div>

            <s:form action="confirmBorrowDevice" namespace="/device" method="post" theme="simple">
                <s:hidden name="id" value="%{device.id}"/>
                <div class="form-group">
                    <label>借用天数</label>
                    <select name="days">
                        <option value="3"  <s:if test="days==3">selected</s:if>>3 天</option>
                        <option value="7"  <s:if test="days==7">selected</s:if>>7 天 (默认)</option>
                        <option value="14" <s:if test="days==14">selected</s:if>>14 天</option>
                        <option value="30" <s:if test="days==30">selected</s:if>>30 天</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>备注 / 使用目的</label>
                    <s:textarea name="remark" rows="3" placeholder="填写使用目的，便于管理员审批（可选）"/>
                </div>
                <s:submit value="确认借用" class="btn btn-success"/>
                <a href="${pageContext.request.contextPath}/device/list.action" class="btn btn-warning">取消</a>
            </s:form>
        </s:if>
        <s:else>
            <div class="alert alert-warning">设备不存在</div>
            <a href="${pageContext.request.contextPath}/device/list.action" class="btn">返回设备列表</a>
        </s:else>
    </div>
</div>
<footer>&copy; 2026 校园实验室设备管理系统 &middot; Struts 7 + Jakarta EE + MySQL</footer>
</body>
</html>

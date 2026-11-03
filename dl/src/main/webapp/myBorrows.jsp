<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="https://jakarta.ee/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的借用 - 校园实验室设备管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/header.jsp" %>
<div class="container">
    <div class="card">
        <h2>&#x1F4CB; 我的借用记录</h2>

        <s:if test="hasActionMessages()">
            <div class="alert alert-success"><s:actionmessage/></div>
        </s:if>
        <s:if test="hasActionErrors()">
            <div class="alert alert-error"><s:actionerror/></div>
        </s:if>

        <table>
            <thead>
            <tr>
                <th>设备编号</th><th>设备名称</th><th>借用时间</th><th>应还时间</th>
                <th>实际归还</th><th>状态</th><th>操作</th>
            </tr>
            </thead>
            <tbody>
            <s:iterator value="borrowList" var="r">
                <tr>
                    <td><s:property value="#r.deviceCode"/></td>
                    <td><s:property value="#r.deviceName"/></td>
                    <td><s:date name="#r.borrowTime" format="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <s:date name="#r.dueTime" format="yyyy-MM-dd HH:mm"/>
                        <s:if test="#r.status == 'BORROWED' and #r.dueTime.before(new java.util.Date())">
                            <span class="tag tag-overdue" style="margin-left:4px;">逾期</span>
                        </s:if>
                    </td>
                    <td><s:if test="#r.returnTime != null"><s:date name="#r.returnTime" format="yyyy-MM-dd HH:mm"/></s:if><s:else>--</s:else></td>
                    <td>
                        <s:if test="#r.status == 'BORROWED'">
                            <span class="tag tag-borrowed">借用中</span>
                        </s:if>
                        <s:elseif test="#r.status == 'OVERDUE'">
                            <span class="tag tag-overdue">已逾期</span>
                        </s:elseif>
                        <s:else>
                            <span class="tag tag-returned">已归还</span>
                        </s:else>
                    </td>
                    <td>
                        <s:if test="#r.status != 'RETURNED'">
                            <form action="${pageContext.request.contextPath}/borrow/returnDeviceBorrow.action" method="post" style="display:inline;"
                                  onsubmit="return confirm('确认归还？');">
                                <input type="hidden" name="recordId" value="<s:property value='#r.id'/>">
                                <input type="hidden" name="deviceId" value="<s:property value='#r.deviceId'/>">
                                <button type="submit" class="btn btn-sm btn-success">归还</button>
                            </form>
                        </s:if>
                        <s:else>--</s:else>
                    </td>
                </tr>
                <s:if test="#r.remark != null and #r.remark != ''">
                    <tr><td colspan="7" style="font-size:12px;color:#6c757d;background:#fafbfc;">备注：<s:property value="#r.remark"/></td></tr>
                </s:if>
            </s:iterator>
            <s:if test="borrowList == null || borrowList.size() == 0">
                <tr><td colspan="7" style="text-align:center;color:#6c757d;">暂无借用记录</td></tr>
            </s:if>
            </tbody>
        </table>
    </div>
</div>
<footer>&copy; 2026 校园实验室设备管理系统 &middot; Struts 7 + Jakarta EE + MySQL</footer>
</body>
</html>

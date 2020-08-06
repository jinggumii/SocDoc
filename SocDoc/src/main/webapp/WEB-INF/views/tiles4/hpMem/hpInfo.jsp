<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<%
	String ctxPath = request.getContextPath();
%>

<%-- <link rel="stylesheet" type="text/css" media="screen" href="<%=ctxPath %>/resources/css/hpInfo.css" /> --%>

<style type="text/css">
	.applicationInfoContainer {
		width: 50vw;
	}
	
	h3 {
		margin: 20px 0;
		margin-left: 0;
	}
	
	.reviewListBottom {
		width: 100%;
		display: flex;
	    flex-direction: row;
	    justify-content: space-between;
	    margin: 10px;
	}
</style>

<div class="applicationInfoContainer">
	<h3 align="left">정보관리</h3>
	<table class="customTable" style="width: 100%;">
		<tr>
			<th></th>
			<th>접수아이디</th>
			<th>병원명</th>
			<th>신청일</th>
			<th>상태</th>
		</tr>
		<c:forEach var="item" items="${infoUpdateList }" varStatus="status">
			<tr style="cursor: pointer;" onclick="javascript:location.href='<%=ctxPath%>/hpPanel/updateHpInfo.sd?submitId=${item.submitId}'">
				<td>${status.count }</td>
				<td>${item.submitId}</td>
				<td>${item.hpName }</td>
				<td>${item.uploadDate}</td>
				<td>${item.status }</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pageContainer" align="center">
		<span>< 1 2 3 4 5 6 7 8 9 10 ></span>
	</div>
</div>
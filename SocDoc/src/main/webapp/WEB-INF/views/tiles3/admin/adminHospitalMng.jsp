<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>


<style type="text/css">

	h2 {
		font-weight: bold;
		padding-top: 30px;
	}
	
    .searchWord {
        font-size: 12px;
        width: 150px;
        height: 10px;
        padding: 10px;
        border: solid 1.3px #1b5ac2;
        float: right;
        margin-left: 5px;
    }

    .searchBtn {
        width: 40px;
        height: 23px;
        border: 0px;
        float: right;
        color: #ffffff;
        background-color: #1b5ac2;
    }
	
    select {
        float: right;
		margin: 15px 10px 20px 0px;
	}
    
    table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 25px;
	}
	
    th {
		font-size: 14px;
	    font-weight: bold;
	    color: #222222;
	    text-align: center;
	    padding: 17px 3px;
	    border-top: 1px solid #333333;
	    border-bottom: 1px solid #333333;
	}
	
	td {
		font-size: 14px;
	    color: #666666;
	    text-align: center;
	    padding: 17px 0;
	    border-bottom: 1px solid #dddddd;
	    line-height: 1.8;
	
	}
	
	#hospitalList {
		width: 1000px;
		margin-left: auto;
		margin-right: auto;
	}
	
	#hospitalList:after {
		content: '';
		clear: both;
		display: block;
	}

	th {
		text-align: center;
	}


	/* 모달창 만들기 */
	.hidden {
	    display: none;
	}
	
	.modalContainer {
	    position: fixed;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    z-index: 1000;	/* 달력의 화살표가 튀어나오지 않게 방지 */
	}
	
	.modalOverlay {
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    background-color: rgba(0, 0, 0, 0.2);
	    width: 100%;
	    height: 100%;
	    position: absolute;
	}
	
	.modalContent {
	    background-color: white;
	    width: 60%;
	    height: auto;
	    min-height: 80%;
	    max-height: 80%;
	    position: relative;
	    padding: 30px;
	    border: 1px solid rgb(230, 230, 230);
	}
	
	.modalContentHeader {
	    display: flex;
	    flex-direction: row;
	    justify-content: space-between;
	}

	th {
		text-align: center;
	}
	
	
	/* =========================================================================== */
   
   .detailHpInfo{
      margin:0px auto;
   }
   
   .hospitalName{
      font-size : 15pt;
      font-weight: 900;
   }   

   .info{
      margin-top:10px;
   }
   
   .one {
      display:inline-block;
      width:55%;
      height:450px;
      padding-right:10px;      
   }
   
   .two{
      float:right;
      width:45%;
      height:300px;
   }
   
   .infoTable{
      width:100%;
      font-size: 10pt;
      height:100%;
   }
   
   .infoTable th, td{
      padding:10px !important;
      border-top: 1px solid #ddd;
      border-bottom: 1px solid #ddd;
   }
   
   .infoTable th{
      background-color: #f2f2f2;
      width:80px;
      height:25px;
   }
   
   .review{
      width:100%;
      height:70px;
      margin-bottom: 5px;
      border: 1px solid #999999;    
      border-radius: .25em;       
      font-size: 10pt;
      padding:5px;   
      resize: none;
      padding-bottom: 30px;
   }
   
   textarea:focus{
      outline: none; 
   }
   
   .name{
      margin-right: 10px;
      font-weight: bolder;
   }

   #okBtn {
 	  float: right;
	  margin-top: 10px;
      background-color: #0080ff;
      color:#fff;
      cursor: pointer;   
      border: 1px solid #dddddd;       
      padding: 0.25em .75em;    
      border-radius: .25em;       
      font-weight: 500;
      font-size: 10pt;  
   }

   #noBtn {
 	  float: right;
	  margin-top: 10px;
	  margin-right: 10px;	  
      background-color: #efefef;
      cursor: pointer;   
      border: 1px solid #dddddd;       
      padding: 0.25em .75em;    
      border-radius: .25em;       
      font-weight: 500;
      font-size: 10pt;  
   }
		
</style>


	<div id="container">
		
		<div id="hospitalList" style="min-height: 70vh;">
			<h2>병원회원관리</h2>
			 
			<form name="searchFrm">  
	            <button class="searchBtn" onclick="goSearch()">검색</button>
	            <input type="text" name="searchWord" id="searchWord" class="searchWord" placeholder="검색어를 입력하세요">
	            <select  name="searchType" id="searchType">
	                <option selected="selected" value="userid">아이디</option>
	                <option value="regId">사업자번호</option>
	                <option value="name">담당자</option>
	                <option value="email">이메일</option>
	                <option value="">병원명</option>
	            </select>
            </form>
            
            <p>전체 회원 수 : ${totalCount}명</p>	
			
			<table class="table table-hover" style="text-align: center;">
				<tr>
					<th>아이디</th>
					<th>사업자번호</th>
					<th>담당자</th>
					<th>이메일</th>
					<th>병원명</th>
					<th>가입일자</th>
					<th>등록</th>
				</tr>
				
				<c:forEach var="hpvo" items="${hospitalvoList}">
					<tr class="detailRow" onclick="showDetail('${hpvo.hpSeq}')">
						<td>${hpvo.userid}<input class="hiddenValue" type="hidden" value="${hpvo.hpSeq}" /></td>			
						<td>${hpvo.regId}</td>			
						<td>${hpvo.name}</td>			
						<td>${hpvo.email}</td>			
						<td>${hpvo.phname}</td>			
						<td>${hpvo.registerDate}</td>	
						<c:choose>
							<c:when test="${hpvo.infoStatus eq 1}">
								<td style="color:blue; font-weight:bold;">Y</td>			
							</c:when>
							<c:otherwise>
								<td style="font-weight:bold;">N</td>
							</c:otherwise>
						</c:choose>		
					</tr>
               </c:forEach>

			</table>
			<input type="hidden" id="hpSeq" name="hpSeq" />
			<div align="center" style="margin-top: 30px;">
				${pageBar}
			</div>
			
		</div>
		
		
		<div class="modalContainer hidden">
		<div class="modalOverlay">
			<div class="modalContent" align="center">
				<div class="modalContentHeader">
					<h4 align="left">병원회원 정보</h4>
					<span style="font-size: 1.2em; cursor: pointer;"
						onclick="closeModal()">X</span>
				</div>
					<div class="detailHpInfo customTable">
						
					</div>
				</div>
			</div>
		</div>
			
	</div>
	
	
	
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#searchWord").keydown(function(event){
			if(event.keyCode == 13) {
				goSearch();
			}
		});
		
		if(${paraMap != null}) {
			$("#searchType").val("${paraMap.searchType}");
			$("#searchWord").val("${paraMap.searchWord}");
		}
		
		$(".detailRow").each(function() {
			$(this).click(function(e) {
				// 체크박스 클릭시, 이벤트를 취소
				if (e.target.type == "checkbox") {
					e.stopPropagation();
					console.log("event canceled!!");
				} else {
					$(".modalContainer").removeClass("hidden");
					console.log("event going on");
				}
			});
		});

	});

	function goSearch() {
		var frm = document.searchFrm;
			frm.method = "GET";
			frm.action = "<%= request.getContextPath()%>/adminHospitalMng.sd";
			frm.submit();
	}

	function closeModal() {
		$(".modalContainer").addClass("hidden");
	}
	
	function showDetail(hpSeq) {
		console.log(hpSeq);
       	console.log(hpSeq);
       	console.log(hpSeq);
       	console.log(hpSeq);
       	console.log(hpSeq);
       	
		  $.ajax({
	             url:"<%= request.getContextPath()%>/showDetail.sd",
	             type:"GET",
	             data:{"hpSeq":hpSeq},
	             dataType:"JSON",
	             success:function(json){
	               // json결과가 오면 데이터를 동적으로 모달 안에 삽입.
	            	var html = "";

	               	console.log(hpSeq);
	               	console.log(hpSeq);
	               	console.log(hpSeq);
	               	console.log(hpSeq);
	               	console.log(hpSeq);
	               	
	               	// 여기까지 값 오는거 확인
	               	
	               	console.log(json);
	               	
	                if(json != null) {

	                	html += "<div>";
 	               		html += "<span class='hospitalName'>"+json.hpName+"</span>";
	               		html += "</div>";
	               		html += "<div class='info'>";
	               		html += "<div class='one'><img src='<%=ctxPath%>/resources/images/"+json.mainImg+"' style='width: 400px; height: 400px; margin-top: 22px; padding-right: 80px;'/></div>";
	               		html += "<div class='two'>";
	               			
	                	html += "<table class='infoTable'>";
	                	html += "<tr>";
	                	html += "<th>주소</th>";
	                	html += "<td>"+json.address+"</td>";
	                	html += "</tr>";
	                	html += "<tr>";
	                	html += "<th>대표전화</th>";
	                	html += "<td>"+json.phone+"</td>";
	                	html += "</tr>";
	                	html += "<tr>";
	                	html += "<th>기관</th>";
	                	html += "<td>"+json.dept+"</td>";
	                	html += "</tr>";
	                	html += "<tr>";
	                	html += "<th>소개</th>";
	                	html += "<td>"+json.info+"</td>";
	                	html += "</tr>";
	                	html += "<tr>";
	                	html += "<th>진료시간</th>";

	                	html += "<td>월요일: "+json.timeInfo[0].open+"~"+json.timeInfo[0].close+"<br/>";
	                	html += "화요일: "+json.timeInfo[1].open+"~"+json.timeInfo[1].close+"<br/>";
	                	html += "수요일: "+json.timeInfo[2].open+"~"+json.timeInfo[2].close+"<br/>";
	                	html += "목요일: "+json.timeInfo[3].open+"~"+json.timeInfo[3].close+"<br/>";
	                	html += "금요일: "+json.timeInfo[4].open+"~"+json.timeInfo[4].close+"<br/>";
	                	html += "토요일: "+json.timeInfo[5].open+"~"+json.timeInfo[5].close+"<br/></td>";

	                	html += "</tr>";
	                	html += "</table>";
	                	html += "</div>";
	                	html += "</div>";
	                	
	 				}
	 				
	 				$(".detailHpInfo").html(html); 
	             },
	             error: function(request, status, error){
	                      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	             }
		  });
	}
	
	
	
</script> 	
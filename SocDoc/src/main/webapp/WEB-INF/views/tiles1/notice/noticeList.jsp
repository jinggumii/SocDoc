<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>속닥 게시판</title>

<style type="text/css" >

/* 	body {
		font-family: Arial, "MS Trebuchet", sans-serif;
		width: 1100px;
		margin: 0 auto;
	} */

	.container { 
		width: 50%;
		height: 150%;
		margin: 100px auto 200px auto;
		padding: 0;
		border: solid 0px red;
	}
	
	.bowl {
   		//border: solid 1px #ccc;
   	}

	/* 탭(공지사항/건강정보) */
	ul.tabs{
		margin: 0px;
		padding: 0px;
		list-style: none;
	}
   
	ul.tabs li{
		background: none;
		display: inline-block;
       	padding: 10px 15px;
       	width:49.7%;
      	margin:0px;
      	border: solid 1px #ddd;
      	text-align: center;
      	cursor: pointer;      
	}
   
	ul.tabs li.current{
		background: #0080ff;
		color: #fff;
		font-weight: 1000;
	}
   
	.tab-content{
		display: none;
	}
   
	.tab-content.current{
		display: inherit;
	}

   	
	/* -------------------------------- 上 끝 ---------------------------------- */
	
	div#search_bar {
    	display: flex;
		width: 100%;
    	margin: 50px 0 10px 0;
	}
	
	div#search_bar_left {
		flex: 1;
		margin-top: 5px;
	}
	
	div#search_bar_right {
/* 		flex: 1;
		flex-direction: row;
		justify-content: flex-end; */
	}

	input#searchWord {
		display: inline-block;
		width: 250px;
	    height: 35px;
	    text-indent: 10px;
	    color: #666;
	    border: 1px solid #ddd;
	}
	
	input#search_button {
		display: inline-block;
	    width: 50px;
	    height: 35px;
	    padding: 0;
	    text-align: center;
	    font-size: 14px;
	    font-weight: bold;
	    color: #fff;
	    background: #777;
	    cursor: pointer;
	}
	
	p.search_button {
	    width: 54px;
	    height: 35px;
	    line-height: 38px;
	}
		
	
	/* ---------------------------- 헤더 끝 -------------------------- */
	
	
	table {
		width: 100%;
		border-collapse: collapse;
	}
	
	 th {
	    padding: 17px 3px;
	    text-align: center;
		font-size: 14px;
	    font-weight: bold;
	    color: #222222;
	    border-top: 1px solid #333333;
	    border-bottom: 1px solid #333333;
	}
	
	td {
	    padding: 17px 0;
	    text-align: center;
		font-size: 14px;
	    color: #666666;
	    border-bottom: 1px solid #dddddd;
	    //line-height: 1.8;
	}
	
	div#notice_button_wrap {
		display: inline-block;
		width: 100%;	
	}
	
	p#notice_button {
		display: inline-block;
		float: right;
	    width: 84px;
	    height: 45px;
		margin: 30px 20px 50px 0px;
	    background: #666666;
		color: white;
	}
	
	a.notice_list {
		display: inline-block;
	    width: 100%;
	    height: 45px;
	    text-align: center;
	    font-size: 14px;
	    font-weight: bold;
	    text-decoration: none;
	    color: #fff;
		cursor: pointer;
	}
	
	td.noticeTitle:hover {
		cursor: pointer;
	}
	
	div#pageBar {
		text-align: center;
	}
	
	a {
      text-decoration: none;
    }
    
    div.grid_container {
	    display: grid;
	    padding: 0px;
	    margin-bottom: 50px;
	    grid-row-gap: 50px;
	    grid-template-columns: auto auto auto;
	}
	
	////
	
	tr > td > .subject:hover {
		cursor: pointer;
	}
   	
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script type="text/javascript">

$(window).ready(function(){
	
	//탭 전환
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');
		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');
	   
		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	});
	
	$("#noticeSearchWord").keydown(function(event) {
		
		console.log($(this).prop("value"));
		 if(event.keyCode == 13) {
			 // 엔터를 했을 경우
			 getNoticeBoard(1, $(this).prop("value"));
		 }
	  });
     
});		

</script>

<script type="text/javascript">

$(window).ready(function(){
	// 공지사항
	$(".tab1").click(getNoticeBoard);
	// 건강정보
	$(".tab2").click(getHealthInfoBoard);
	
	getNoticeBoard(1, "");
//	getHealthInfoBoard();
});		

function getNoticeBoard(currentShowPageNo, searchWord){
	console.log("공지사항 클릭");
	
	$.ajax({	
		url:"<%= ctxPath%>/ajax/noticeBoard.sd",
		type:"get",
		data:{"searchWord":searchWord
			 ,"currentShowPageNo": currentShowPageNo},
		dataType:"json",
		success:function(json){
			console.log(json);		
			var html = "";
			var jsonArr = JSON.parse(json.list);
			
			if(jsonArr.length > 0) {
				$.each(jsonArr, function(index, item){
					html += "<tr>"
							+ "<td class='noticeSeq'>"+item.noticeSeq+"</td>"
							+ "<td class='subject'>"+item.subject+"</td>"
							+ "<td class='content'>"+item.regDate+"</td>"
							+ "</tr>";
				});
			
			} else {
				$(".infoBoard").html("<tr align='center'><td colspan='3'>검색 결과가 없습니다!</td></tr>");
			}
			
			$(".noticeList").html(html);
			$(".noticePagination").html(json.pageBar);
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 	}
	}); 
}
function goView(noticeSeq) {
	//	console.log(noticeSeq);
 		var frm = document.goViewFrm;
		frm.noticeSeq.value = noticeSeq; 
		
		frm.method = "GET";
		frm.action = "<%=ctxPath%>/noticeView.sd";
		frm.submit();
	}
function getHealthInfoBoard(){
	console.log("건강정보 클릭");
	$.ajax({	
		url:"<%= ctxPath%>/ajax/infoBoard.sd",
		type:"get",
		data:/* {"searchWord":$("#subject").val()
			 ,"currentShowPageNo": 1}, */
			 {"searchWord":searchWord
				,"currentShowPageNo": currentShowPageNo},
		dataType:"json",
		success:function(json){
			console.log(json);		
			var html = "";
			var jsonArr = JSON.parse(json.list);
			
			if(jsonArr.length > 0) {
				$.each(jsonArr, function(index, item){
					html += "<tr>"
							+ "<td class='noticeSeq'>"+item.noticeSeq+"</td>"
							+ "<td class='subject'>"+item.subject+"</td>"
							+ "<td class='content'>"+item.regDate+"</td>"
							+ "<td class='img'>"+item.img+"</td>"
							+ "</tr>";
				});
				
			} else {
				$(".infoBoard").html("<tr align='center'><td colspan='3'>검색 결과가 없습니다!</td></tr>");
			}
				$(".infoBoard").html(html);
				$(".noticePagination").html(json.pageBar);
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 	}
	}); 
}

function goSearch(){
	console.log("?!?!?");
	console.log($("#noticeSearchWord").prop("value"));
	getNoticeBoard(1, $("#noticeSearchWord").prop("value"));	
}

</script>

<!-- <script type="text/javascript">



var lenHIT = 8; // 매번 바뀔 수 있으니 위에서도 쓸거니 밖으로 뺌~! 8개씩 보이겠다.
// HIT상품 스크롤할때 보여줄 상품의 개수(단위)크기

var start = 1;


$(document).ready(function(){
	
	//$("#totalHITCount").hide();
	//$("#countHIT").hide();
	
	// HIT상품 게시물을 더보기 위하여 초기값 호출하기
	displayHIT(start);  // 맨처음 숫자 보여주는 것~!@
	
	// 스크롤 이벤트 발생시키기
	$(window).scroll(function(){
		
		// 스크롤탑의 위치값
		//console.log( "$(window).scrollTop() =>" +$(window).scrollTop() );
		
		// 웹브라우저 창의 높이값(디바이스마다 다르게 표현되는 고정값)
		//console.log( "$(window).height() =>" +$(window).height() );
		
		// 보여주어야 할 문서(더보기를 해주므로 apped 되어져서 높이가 계속 증가될 것임.)의 높이값
		//console.log( "$(document).height() =>" +$(document).height() );
		
		// 스크롤 내리먄 알아서 더보기더보기더보기 나오게,,,
		if( $(window).scrollTop()+1 >= $(document).height() - $(window).height()){ // +1은 보정임 안해도되는데 안나온다면 이렇게 보정하자.
			start = start + lenHIT;
			displayHIT(start);

		}
		
		// 스크롤 올릴 때
		else if($(window).scrollTop() == 0){//움직이고 올라왔따면 0 되었다면~!
			// 다시 처음부터 시작하도록 한다.
			$("#displayHIT").empty();
			$("#end").empty();
			$("#countHIT").text("0");
			
			start = 1;
			displayHIT(start);

		}
	});
	
}); -->


<script type="text/javascript">
	
/* 	var lenHIT = 8;
	var start = 1;
	
	$(document).ready(function(){
	// display할 HIT상품 정보를 추가 요청하기(Ajax로 처리함)
	function photo(start){ // start가 1이라면 1~8까지 상품 8개를 보여준다.
								// start가 9이라면 9~16까지 상품 8개을 보여준다.
								// start가 17이라면 17~24까지 상품 8개을 보여준다.
								// start가 25이라면 25~32까지 상품 8개을 보여준다.
								// start가 33이라면 33~37까지 상품 5개을 보여준다.(마지막 상품)
	$.ajax({
		url:"/MyMVC/final/noticeList.html",
		type:"GET",
		data:{"start":start
			
		},
		dataType:"JSON",
		success:function(json){
			
			var html = "";
			if(start=="1" && json.length == 0) { // null쓰는게 아니라 요소가 없으면 ==0으로 해야함.
				// 처음부터 데이터가 존재하지 않는 경우
	    		// !!! 주의 !!!
	    		// if(json == null) 이 아님!!!
	    		// if(json.length == 0) 으로 해야함!!
	    		html += "건강 정보 게시글 준비 중~";
	    		
	    		// HIT 상품 결과를 출력하기
	    		$("#photo").html(html);

			} else {
				// 데이터가 존재하는 경우

				$.each(json, function(index, item){
					
					html += "<div class='moreProdInfo'><a href='/MyMVC/shop/prodView.up?pnum="+item.pnum+"'><img width='120px;' height='130px;' src='/MyMVC/images/"+item.pimage1+"'/></a>"
			          + "<br/>"
			          + "제품명 : "+item.pname+"<br/>"
			          +"</div>";
			          
					if((index+1) % 4 == 0){
						html += "<br/>";
					}
					
				});
				
				//HIT 상품 결과를 출력하기
				$("#displayHIT").append(html);				
				
	    		//countHIT에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
	    		$("#countHIT").text( Number($("#countHIT").text()) + json.length );	//<span>태그의 텍스트
	    		
	    		// 더보기... 버튼을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
				if($("#countHIT").text() == $("#totalHITCount").text() ){
					$("#end").html("더이상 조회할 제품이 없습니다.");
				}
	    		// header.jsp 의 하단에 표신된 div content의 height값을 구해서, header.jsp의 div sideinfo의 height값으로 설정하기
				func_height(); // footer.jsp에 있음.
			}
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	}); */

</script> 
</head>

<div class="container">

	<div class="bowl">
		<ul class="tabs">
			<li class="tab-link current tab1" data-tab="tab-1" onclick="getNoticeBoard(1, '')">공지사항</li>
			<li class="tab-link tab2" data-tab="tab-2" onclick="getHealthInfoBoard()">건강정보</li>
		</ul>
	
		
		<!-- -------------------------------- 上 끝 ---------------------------------- -->
		
		<div class="notice">
			<header>
<!-- 				<form name="seachFrm"> -->
					<div id="search_header">
						<div id="search_bar">
							<div id="search_bar_left" class="total">전체 n건</div>
							<div id="search_bar_right">
								<input id="noticeSearchWord" name="searchWord" type="text" placeholder="검색어를 입력해 주세요." />
								<input id="search_button" onclick="goSearch();" type="button" value="검색" /> 
							</div>
						</div>
					</div>	
<!-- 				</form> -->
			</header>
		
		<!-- -------------------------------- 헤더 끝 ---------------------------------- -->
		
			<form name="tab1">	
				<div id="tab-1" class="tab-content current">
					<table>
						<thead>
							<tr>
								<th>NO</th>
							 	<th>제목</th>
							 	<th>날짜</th>
							</tr>
						</thead>
						
						<tbody class="noticeList">
							<%-- <c:forEach var="noticevo" items="${noticeList}">
								<tr>
									<td class="noticeSeq">${noticevo.noticeSeq}</td>
									<td class="subject" onclick="goView('${noticevo.subject}')">${noticevo.subject}</td>
									<td class="regDate">${noticevo.regDate}</td>
									<td class="hit">${noticevo.hit}</td>
								</tr>
							</c:forEach> --%>
						</tbody>
					
					</table>
					
					<!-- ${totalPage} -->
					<div class="noticePagination" id="pageBar">
						<!-- ${pageBar} -->
					</div>
				</div>
			</form>
			
		<!-- -------------------------------- 공지사항 게시글 끝 ---------------------------------- -->	
			
			<form name="tab2">
				<div id="tab-2" class="tab-content">
					<div class="grid_container">
						<c:forEach var="healthinfovo" items="${healthinfo}">
							<div id="${infoBoard.subject}" align='center'>
								<img width='310px' height='280px' src='${infoBoard.img}' />
								${infoBoard.subject}
							</div>
		       			</c:forEach>
		       		</div>			
				</div>
			</form>
			
		<!-- -------------------------------- 건강정보 게시글 끝 ---------------------------------- -->	
		<form name="goViewFrm">
        	<input type="hidden" name="noticeSeq" />
        </form>
		</div>	
	</div>
</div>
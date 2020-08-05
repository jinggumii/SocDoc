<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        
<%	String ctxPath = request.getContextPath();%>   
<title>약국 상세</title>

<style>

	.container{
		width:1080px;
		margin: 100px auto;
	}
	
	.content{
		width:90%;
		margin:0px auto;
	}
	
	.pharmacyName{
		font-size : 15pt;
		font-weight: 900;
	}	
	
	.pharmacyRating{
		margin-left: 10px;
	}
	
	.info{
		margin-top:10px;
		margin-bottom:20px;
	}
		
	
	.two{
		float:right;
		width:45%;
		height:450px;
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
	
	.btnTop{
		background-color: #0080ff;
		color:#fff;
		cursor: pointer; 
		border: 1px solid #999999; 
		border-radius: .25em; 
		padding: 0.25em .75em; 	
		font-weight: 500;
		font-size: 10pt;
	}
	
	.btnRegister{
		background-color: #0080ff;
		color:#fff;
		cursor: pointer;	
		border: 1px solid #999999; 		
		padding: 0.25em .75em; 	
		border-radius: .25em; 		
		font-weight: 500;
		font-size: 10pt;	
		float:right;
	}
	
	.reviewName{
		font-size: 13pt;
		font-weight: bolder;
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
	}
	
	.reviewContents{
		margin: 10px 0;
	}
	
	textarea:focus{
		outline: none; 
	}
	
	.reviewTable{
		width:100%;
		margin: 20px 0;
		font-size: 10pt;
	}
	
	.reviewTable td{
		padding:15px;
	}
	
	
	.starRating{
		background: url('/socdoc/resources/images/icoReview.png') no-repeat right 0;
		background-size: auto 100%;
		width: 10px;
		height: 10px;
		display: inline-block;
		text-indent: -9999px;
	}
	
	
	.name{
		margin-right: 10px;
		font-weight: bolder;
	}
	
	.registerDate{
		font-weight: bolder;
	}
	
	.reviewBtn{
		padding: 0.4em .75em; 
		background-color: #bfbfbf; 
		cursor: pointer; 
		border: 1px solid #999999; 
		border-radius: .25em; 
		font-size: 9pt;
		margin:2px 0;
	}
	
	
	.stars{
		background: url('/socdoc/resources/images/icoReview.png') no-repeat right 0;
		background-size: auto 100%;
		width: 15px;
		height: 15px;
		display: inline-block;
		text-indent: -9999px;
		cursor: pointer;
		margin-bottom: 10px;
	}
	
	.on{
		background-position:0 0;
	}	 
			 
	
		

</style>


<script type="text/javascript">

$(document).ready(function(){
	
	
	$("#review").keyup(function(){
		cntReview = $("#review").val().length;
		$("#bytesReview").val('');
		$("#bytesReview").text(cntReview);		
		
		if(cntReview==0){
			$("#bytesReview").text('0');		
		}
		
	});
	/* 
	//이미지 슬라이드
	var bxSlider = $(".bxslider").bxSlider({
		
		auto:false,
		speed:500,
		pause:5000,
		mode:'horizontal',
		autoControls:false,
		pager:true,
		infinitelLoop:false,
		adaptiveHeight:true
		
	});
	
	bxSlider.stopAuto();
	
	 */
	 
	 
	 new Swiper('.swiper-container', {

			slidesPerView : 1, // 동시에 보여줄 슬라이드 갯수
			spaceBetween : 30, // 슬라이드간 간격
			slidesPerGroup : 1, // 그룹으로 묶을 수

			loop : true, // 무한 반복

			pagination : { // 페이징
				el : '.swiper-pagination',
				clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
			},
			navigation : { // 네비게이션
				nextEl : '.swiper-button-next', // 다음 버튼 클래스명
				prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
			},
	});
	 
	
	
	//후기별점 
	$(".starRating").each(function(){
		$("#starRating3").addClass("on").prevAll("span").addClass("on");
		return false;
	})
	
	  
	
	 
	
	
	
	//별점주기
	$('.stars').click(function(){
		  $(this).parent().children("span").removeClass("on");
		  $(this).addClass("on").prevAll("span").addClass("on");
		  
		  starsNum = $(".stars.on").length;
		  $(".starsNum").text(starsNum);
		  
		  return false;
	});
	
	
})



/* 
$(function() {
	$(".heart").on("click", function() {
		$(this).toggleClass("is-active");
	});
}); */

</script>


<div class="container">
	
	<div class="content">		
		<span class="pharmacyName">어쩌고 저쩌고 약국</span>
		<span class="pharmacyRating">★★★★★</span>	
		<span class="pharmacyRatingNum">0</span><span>.0</span>
		<div class="info">			
			<div class="">
				<table class="infoTable">
					<tr>
						<th>주소</th>
						<td>서울특별시 중구 을지로 255, 기승빌딩 4층</td>
					</tr>
					<tr>
						<th>대표전화</th>
						<td>02-1234-5678</td>
					</tr>					
					<tr>
						<th>진료시간</th>
						<td>월요일<br/>
							화요일<br/>
							수요일<br/>
							목요일<br/>
							금요일<br/>
							토요일<br/></td>
					</tr>
				</table>				
			</div>
		</div>
		
		<div><span class="reviewName">후기</span></div>
		<table class="reviewTable">
			<tr>
				<td style="text-align: center; padding:20px !important; font-weight: bolder;">후기가 없습니다.</td>
			</tr>
			<tr>
				<td style="background-color: #e6f5ff;">
					<div style="display:inline-block; width:90%;">
						<div>
							<span class="starRating" id="starRating1">별1</span>
							<span class="starRating" id="starRating2">별2</span>
							<span class="starRating" id="starRating3">별3</span>
							<span class="starRating" id="starRating4">별4</span>
							<span class="starRating" id="starRating5">별5</span>
						</div>
						<div class="reviewContents">최고의 병원 추천합니다.</div>
						<span class="name">nana</span><span class="registerDate">2020.07.19</span>
					</div>
					<div style="display:inline-block; width:8%; float:right;">
						<button type="button" id="modify" class="reviewBtn">수정</button>
						<button type="button" id="delete" class="reviewBtn">삭제</button>
					</div>
				</td>
			</tr>
			<tr>	
				<td>
					<div>
						<span class="starRating" id="starRating1">별1</span>
						<span class="starRating" id="starRating2">별2</span>
						<span class="starRating" id="starRating3">별3</span>
						<span class="starRating" id="starRating4">별4</span>
						<span class="starRating" id="starRating5">별5</span>
					</div>
					<div class="reviewContents">예약하고 갔는데도 너무 오래 기다렸어요... 피부과가 원래 그렇다고 하지만 너어어어어무 오래 기다려서 좀 힘들었습니다. 악의적인 내용은 아니고 그냥 후기인데 ㄱㅊ하죠? 저는 사실 200자를 채우고 싶어서 이렇게 구구절절 하고 있습니다. 오늘 너무 졸립고 피곤하네요 하하하 50자 남았는데 그냥 끝낸다. </div>
					<span class="name">mimi</span><span class="registerDate">2020.07.19</span>	
				</td>
			</tr>
		</table>
		
		
		<div>
			<div> 
				<span class="stars on">별1</span>
				<span class="stars">별2</span>
				<span class="stars">별3</span>
				<span class="stars">별4</span>
				<span class="stars">별5</span>
				<span class="starsNum" style="margin-left: 5px;">0</span><span>.0</span>
			</div>
			<textarea id="review" name="review" class="review" maxlength="199" placeholder="관련없는 내용이나 악의적인 후기는 삭제될 수 있습니다."></textarea>
			<div>
				<span id="bytesReview">0</span>자 / 200자
				<button type="button" class="btnRegister" onclick="goRegister();">등록</button>
			</div>
		</div>
	
	
	</div>
		
</div>
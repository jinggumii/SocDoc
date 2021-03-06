<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
<%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" media="screen" href="<%=ctxPath %>/resources/css/updateHpInfo.css" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b7fa563027be4561a627edb8c3c2821f&libraries=services"></script>

	<div class="hpInfoContainer">
		<h3 align="left">병원 정보 관리</h3>
		<form id="hpInfoForm" name="hpInfoForm" enctype="multipart/form-data">
		<section id="infoContainer">
				<div class="slideshow-container" style="display: flex; justify-content: center; align-items: center;">
					<c:if test="${hpInfo.submitId == null}">
						<div class="mySlides fade" id="mainImgFileSlide">
							<img src="<%=ctxPath %>/resources/images/noImage.png" style="width: inherit; height: inherit;">
						</div>
						<div class="mySlides fade" id="subImg1FileSlide"></div>
						<div class="mySlides fade" id="subImg2FileSlide"></div>
					</c:if>
					<!-- Full-width images with number and caption text -->
					<c:if test="${not empty hpInfo.mainImg }">
						<div class="mySlides fade">
							<img src="<%=ctxPath %>/resources/images/${hpInfo.mainImg}" style="width: inherit; height: inherit;">
						</div>
					</c:if>
		
					<c:if test="${not empty hpInfo.subImg1 }">
						<div class="mySlides fade">
	<!-- 						<div class="numbertext">2 / 3</div> -->
							<img src="<%=ctxPath %>/resources/images/${hpInfo.subImg1}" style="width: inherit; height: inherit;">
						</div>
					</c:if>
		
					<c:if test="${not empty hpInfo.subImg2 }">
						<div class="mySlides fade">
	<!-- 						<div class="numbertext">3 / 3</div> -->
							<img src="<%=ctxPath %>/resources/images/${hpInfo.subImg2}" style="width: inherit; height: inherit;">
						</div>					
					</c:if>
		
					<!-- Next and previous buttons -->
					<div class="sliderBtnContainer">
						<a class="prev" style="left: 0;" onclick="plusSlides(-1)">&#10094;</a> 
						<a class="next"	onclick="plusSlides(1)">&#10095;</a>					
					</div>
				</div>
				<div id="hpDetail">
					<ul id="hpDetailList">
						<li> 
							<input type="text" name="orgMainImg" value="${hpInfo.orgMainImg }" readonly required />
							<button class="greyBtn findFile" type="button" >찾기</button> 
							<input type="file" name="attachMain" id="mainImgFile" accept="image/*" />
							<c:if test="${ not empty hpInfo.mainImg }">
								<input type="hidden" name="mainImg" value="${hpInfo.mainImg}" />
							</c:if>
						</li>
						<li>
							<input type="text" id="subImg1File" name="orgSubImg1" value="${hpInfo.orgSubImg1 }" readonly />
							<button class="greyBtn findFile" type="button">찾기</button> 
							<input type="file" name="attachMain" id="subImg1File" accept="image/*" />
							<c:if test="${ not empty hpInfo.subImg1 }">
								<input type="hidden" name="subImg1" value="${hpInfo.subImg1}" />
							</c:if>
						</li>
						<li>
							<input type="text" id="subImg2File" name="orgSubImg2" value="${hpInfo.orgSubImg2 }" readonly />
							<button class="greyBtn findFile" type="button">찾기</button> 
							<input type="file" name="attachMain" id="subImg2File" accept="image/*" />
							<c:if test="${ not empty hpInfo.subImg2 }">
								<input type="hidden" name="subImg2" value="${hpInfo.subImg2}" />
							</c:if>
						</li>
					</ul>
					<table class="hpTextInfo">
						<tr>
							<th>이름</th>
							<td>
								<input type="text" name="hpName" id="name" value="${hpInfo.hpName }" required />
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>
								<textarea name="address" id="address" form="hpInfoForm" placeholder="주소찾기를 이용해주세요!" readonly required>${hpInfo.address }</textarea>
<%-- 								<input type="text" name="address" id="address" value="${hpInfo.hpName }" /> --%>
								<input type="hidden" name="latitude" id="latitude" value="${hpInfo.latitude }" />
								<input type="hidden" name="longitude" id="longitude" value="${hpInfo.longitude}" />
								<div align="right"><button class="blueBtn" type="button" onclick="searchAddress()">주소찾기</button></div>
							</td>
						</tr>
						<tr>
							<th>대표전화</th>
							<td><input name="phone" type="tel" value="${hpInfo.phone }" required /></td>
						</tr>
						<tr>
							<th>진료과목</th>
							<td><input name="dept" id="dept" value="${hpInfo.dept}" readonly required/></td>
						</tr>
						<tr>
							<th>소개</th>
							<td align="right">
								<textarea name="info" id="info" placeholder="200자 내외로 작성해주세요!" maxlength="200" form="hpInfoForm" required>${hpInfo.info }</textarea>
								<br>
								<span id="charLength">
								<c:if test="${not empty hpInfo}">
									${fn:length("${hpInfo}")-1}
								</c:if>
								<c:if test="${empty hpInfo }">
									0
								</c:if>
								</span>/200자
							</td>
						</tr>
					</table>
				</div>
			<!-- The dots/circles -->
			<!-- <div style="text-align:center">
	            <span class="dot" onclick="currentSlide(1)"></span>
	            <span class="dot" onclick="currentSlide(2)"></span>
	            <span class="dot" onclick="currentSlide(3)"></span>
	        </div> -->
		</section>
		<table id="settingSection">
			<tr>
				<th>진료과목</th>
				<td colspan="6">
					<input type="checkbox" id="1" value="내과" /> <label for="1">내과</label>
					<input type="checkbox" id="2" value="소아청소년과" /> <label for="2">소아청소년과</label> 
					<input type="checkbox" id="3" value="정신건강의학과" /> <label for="3">정신건강의학과</label> 
					<input type="checkbox" id="4" value="피부과" /> <label for="4">피부과</label> 
					<input type="checkbox" id="5" value="여성의학과" /> <label for="5">여성의학과</label> 
					<input type="checkbox" id="6" value="안과" /> <label for="6">안과</label> 
					<input type="checkbox" id="7" value="이비인후과" /> <label for="7">이비인후과</label> 
					<input type="checkbox" id="8" value="비뇨기과" /> <label for="8">비뇨기과</label> 
					<input type="checkbox" id="9" value="가정의학과" /> <label for="9">가정의학과</label> 
					<input type="checkbox" id="0" value="치과" /> <label for="0">치과</label>
				</td>
			</tr>
			<tr>
				<th>진료시간</th>
				<td colspan="6" id="scheduleTbl">
					 <div class="timeSettingRow">
						<label>월요일</label> 
						<input type="number" class="open" min="9" max="20" step="1" value="${scheduleTbl[0].open.substring(0,2) != null ? scheduleTbl[0].open.substring(0,2) : 9}" required> : 
						<input type="text" value="00" readonly> 
						<span>부터</span> 
						<input type="number" class="close" min="10" max="20" step="1" value="${scheduleTbl[0].close.substring(0,2) != null ? scheduleTbl[0].close.substring(0,2) : 18}" required> : 
						<input type="text" value="00" readonly> 
						<span>까지</span>
					</div>
					<div class="timeSettingRow">
						<label>화요일</label> 
						<input type="number" class="open" min="9" max="20" step="1" value="${scheduleTbl[1].open.substring(0,2) != null ? scheduleTbl[1].open.substring(0,2) : 9}" required> : 
						<input type="text" value="00" readonly>
						<span>부터</span> 
						<input type="number" class="close" min="10" max="20" step="1" value="${scheduleTbl[1].close.substring(0,2) != null ? scheduleTbl[1].close.substring(0,2) : 18}"> : 
						<input type="text" value="00" readonly>
						<span>까지</span>
					</div>
					<div class="timeSettingRow">
						<label>수요일</label> 
						<input type="number" class="open" min="9" max="20" step="1" value="${scheduleTbl[2].open.substring(0,2) != null ? scheduleTbl[2].open.substring(0,2) : 9}" required> : 
						<input type="text" value="00" readonly>
						<span>부터</span> 
						<input type="number" class="close" min="10" max="20" step="1" value="${scheduleTbl[2].close.substring(0,2) != null ? scheduleTbl[2].close.substring(0,2) : 18}" required> : 
						<input type="text" value="00" readonly>
						<span>까지</span>
					</div>
					<div class="timeSettingRow">
						<label>목요일</label> 
						<input type="number" class="open" min="9" max="20" step="1" value="${scheduleTbl[3].open.substring(0,2) != null ? scheduleTbl[3].open.substring(0,2) : 9}" required> : 
						<input type="text" value="00" readonly>
						<span>부터</span> 
						<input type="number" class="close" min="10" max="20" step="1" value="${scheduleTbl[3].close.substring(0,2) != null ? scheduleTbl[3].close.substring(0,2) : 18 }" required> : 
						<input type="text" value="00" readonly>
						<span>까지</span>
					</div>
					<div class="timeSettingRow">
						<label>금요일</label> 
						<input type="number" class="open" min="9" max="20" step="1" value="${scheduleTbl[4].open.substring(0,2) != null ? scheduleTbl[4].open.substring(0,2) : 9}" required> : 
						<input type="text" value="00" readonly>
						<span>부터</span> 
						<input type="number" class="close" min="10" max="20" step="1" value="${scheduleTbl[4].close.substring(0,2) != null ? scheduleTbl[4].close.substring(0,2) : 18 }" required> : 
						<input type="text" value="00" readonly>
						<span>까지</span>
					</div>
					<div class="timeSettingRow">
						<label>토요일</label> 
						<input type="number" class="open" min="9" max="20" step="1" value="${scheduleTbl[5].open.substring(0,2) != null ? scheduleTbl[5].open.substring(0,2) : 9 }" required> : 
						<input type="text" value="00" readonly>
						<span>부터</span> 
						<input type="number" class="close" min="10" max="20" step="1" value="${scheduleTbl[5].close.substring(0,2) != null ? scheduleTbl[5].close.substring(0,2) : 18 }" required> : 
						<input type="text" value="00" readonly>
						<span>까지</span>
					</div>
				</td>
			</tr>
			<c:if test="${hpInfo.reason != null}">
			<tr>
				<th>반려사유</th>
				<td style="color: red;">${hpInfo.reason }</td>
			</tr>
			</c:if>
		</table>
		<input type="hidden" name="submitId" value="${hpInfo.submitId != null ? hpInfo.submitId : ' '}" />
		<input type="hidden" name="schedule" value=" "/>
		<input type="hidden" name="status" value="3"/>
		</form>	
		<div style="margin: 10px 0;" align="right">
			<c:if test="${(hpInfo.status != 2 || hpInfo.status != 4 || hpInfo.status != 5) && hpInfo.submitId == null}">
				<button class="blueBtn" id="submitBtn" onclick="submit()">승인 신청</button>
			</c:if>
			<c:if test="${ hpInfo.status == 3 || hpInfo.status == 1}">
				<button class="blueBtn" id="cancelBtn" onclick="cancel('${hpInfo.submitId}')">취소</button>
			</c:if>
		</div>		
	</div>

<script>
	$(document).ready(function() {
		
		// DB에 진료과목 정보가 등록돼있으면, 체크해둔다.
		$("input[type='checkbox']").each(function(){
			var deptOption = $(this).val();
			
			if(deptOption == "${hpInfo.dept}") {
				$(this).prop("checked", true);
				return;
			}
		});
		
		
		// 파일첨부
		$(".findFile").click(function() {
			console.log("찾기 버튼 클릭!");
/* 			var idToTrigger = "#" + $(this).prop("id") + "File"; */
			var fileInput = $(this).next();
			fileInput.trigger("click");
			console.log(fileInput);
			console.log("클릭 이벤트 트리거!");
		});

		$("input[type=file]").each(function() {
				$(this).hide();
					
				
				$(this).on("change", function(e) {
					
					 var files = e.target.files;
				        var filesArr = Array.prototype.slice.call(files);
				        var sliderImgId = "#" + $(this).prop("id") + "Slide";
				        
				        filesArr.forEach(function(f) {
				            if(!f.type.match("image.*")) {
				                alert("확장자는 이미지 확장자만 가능합니다.");
				                return;
				            }

				            sel_file = f;

				            var reader = new FileReader();
				            reader.onload = function(e) {
				            	var html = "<img src='"+e.target.result+"' style='width: inherit; height: inherit;'>";
					            $(sliderImgId).html(html);

				                console.log(e.target.result);
				            }
				            reader.readAsDataURL(f);
				        });

					
					// 이미지 파일명만 추출후, 보여주기
					var filename = $(this).val().split('/').pop().split('\\').pop();
					
					$(this).siblings().prev().prop("value", filename);
					
					
				});
		});
		
		
		// 진료과목 체크박스 클릭 이벤트 정의
		$("input[type=checkbox]").click(function(e) {
			// 체크박스 선택은 한 개만 가능하게 설정
			var checkedValue = $(this).prop("value");
			
			if("${hpInfo.dept}" == "") {
				console.log(checkedValue);
				
				$("input[type=checkbox]").each(function() {
					if (checkedValue != $(this).prop("value")) {
						$(this).prop("checked", false);
					} else {
						console.log("클릭된 체크박스!")
						$(this).prop("checked", true);
					}
				});

				// 체크된 과목을 상세정보에 반영
				$("#dept").val(checkedValue);
			} else {
				if($(this).val() != "${hpInfo.dept}") {
					$(this).prop("checked", false);		
					console.log("다른 벨류 !!!");
				} else {
					$(this).prop("checked", true);		
				}
			}
		});
		
		
		// 소개란 글자수 체크
		$("#info").keyup(function(){
			var charLength = $(this).val().length;

			$("#charLength").text(charLength);
		});		

/*  			
 		var scheduleTbl = "${scheduleTbl[0].open}";

 		console.log(typeof scheduleTbl);
 		console.log(scheduleTbl);
 		console.log(scheduleTbl[1].open);
 
		 */
 		
 		
	});
	
	
	
	
	// 이미지 슬라이더
	var slideIndex = 1;
	showSlides(slideIndex);
	// Next/previous controls
	function plusSlides(n) {
		showSlides(slideIndex += n);
	}
	// Thumbnail image controls
	function currentSlide(n) {
		showSlides(slideIndex = n);
	}
	function showSlides(n) {
		var i;
		var slides = document.getElementsByClassName("mySlides");
		//var dots = document.getElementsByClassName("dot");
		if (n > slides.length) {
			slideIndex = 1
		}
		if (n < 1) {
			slideIndex = slides.length
		}
		for (i = 0; i < slides.length; i++) {
			slides[i].style.display = "none";
		}
		// for (i = 0; i < dots.length; i++) {
		//     dots[i].className = dots[i].className.replace(" active", "");
		// }
		slides[slideIndex - 1].style.display = "block";
		// dots[slideIndex - 1].className += " active";
	}
	
	
	// 주소 검색
	function searchAddress(){
	    var geocoder = new daum.maps.services.Geocoder();

		new daum.Postcode({
            oncomplete: function(data) {

                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        console.log(result);
                        
                        // 주소
                        var address = result.address_name + " 우)" + result.road_address.zone_no;
                        
                        // 새로 선택한 주소 보여주기
                        $("#address").text(address);
                        
                        // 숨겨진 input에 좌표값 저장
                        $("#latitude").val(result.y);
                        $("#longitude").val(result.x);
                    }
                });
            }
        }).open();
	}
	
	// 업데이트 신청
	function submit(){
		
		// 오픈&클로즈 시간을 json array를 문자열로 저장
		var scheduleArr = [];
		
		$("div.timeSettingRow").each(function(index, item) {
			console.log($(this));
			var open = $(this).find(".open").prop("value");
			var close = $(this).find(".close").prop("value");
			var obj = {};
			
			obj[index+1] = { "open": open, "close": close };
			scheduleArr.push(obj);
		});
		
		var scheduleArrStr = JSON.stringify(scheduleArr);
		$("input[name=schedule]").prop("value", scheduleArrStr);
	

		
		// 파일타입 input제외하고 모두 기입이됐는지 확인
		var isAllFilled = true;

		$("form input:not([type=file]), form textarea").each(function() {
			$(this).css("border", "");
			
			if ($(this).val() == "" && $(this).prop("id").substring(0, 6) != "subImg") {
				$(this).css("border", "2px solid red");
				console.log($(this));
				isAllFilled = false;
			}
		});
		
		if(!isAllFilled) {
			alert("모든 영역을 기입해주세요.");
			return;
		}
		
		
		// 모든 필드 기입 완료시 전송
		var form = document.hpInfoForm;
		
		console.log(form.mainImg);
	
		
		var submitId = $("input[name=submitId]").val().trim();
		
		// 신청아이디가 없음 = 새로 신청, status를 1로 준다.
		if(submitId == "") {
			$("input[name=status]").prop("value", "1");
			console.log("신청 !!!");
		} else {
			$("input[name=status]").prop("value", "3");
			console.log("수정!!!");
		}

		$("input[name=submitId]").prop("value", Math.random().toString(36).substr(2,11));
		
		
		form.method = "POST";
		form.action = "<%=ctxPath%>/hpPanel/submitInfo.sd";
		form.submit();
		
	}
	
	function cancel(submitId){
		console.log(submitId);
		
		location.href="<%=ctxPath%>/hpPanel/cancelSubmission.sd?submitId="+submitId;
	}
	
	
</script>
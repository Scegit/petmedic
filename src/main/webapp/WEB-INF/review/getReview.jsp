<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../header.jsp"%>
<%
String sts = "";
if (session.getAttribute("users_id") == null) {
	sts = "disabled";
}
%>
<head>
<script>
//       블러처리 해제
      document.addEventListener("DOMContentLoaded", function () {
        var reviewContainer = document.getElementById("revDet");

        // Add the following code to check the user's login status
        var isLoggedIn = true; // Set this variable based on the user's login status

        if (isLoggedIn) {
          reviewContainer.style.filter = "none"; // Remove the blur effect
          reviewContainer.style.pointerEvents = "auto"; // Enable interaction with the review container
        }
      });
      
    //리뷰쓰기 이동
      function revIns(val) {
      	location.href = "getReserveForReview";
      }
      //나의리뷰 이동
      function getMyReviewPostList() {
      	location.href = "getMyReviewPostList";
      }


      //예약내역으로 이동 
      function getMyActionReserve(val) {
      	location.href = "myActionReserve";
      }
      //찜병원으로 이동	
      function getMyActionZzim(val) {
      	location.href = "myActionZzim";
      }     
    </script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<style>
.form-control {
	border: none !important;
}

.textareabordergray {
border: 1px solid lightgray;
}

</style>

</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>

	<div class="container-fluid">
		<%
		if (request.getParameter("error") != null) {
			out.println("<div class='alert alert-danger'>");
			out.println("해당 글은 작성자만이 수정할 수 있습니다.");
			out.println("</div>");
		}
		%>

		<div class="container structure">
			<div id="menuDiv">
				<div class="row" id="flex">
					<div class="col-md-8 leftDiv"><h2>리뷰상세보기</h2></div>
					<div class="col-md-4 rightDiv">
						<div class="wrapDiv">
							<div class="handDivR" onclick="location.href='/getUsers'"
								id="myinfo">
								<b>내정보</b>
							</div>
							<div class="oneDivR circleDiv"></div>
							<div class="twoDivR circleDiv"></div>
							<div class="threeDivR circleDiv"></div>
						</div>
						<div class="wrapDiv">
							<div class="handDivL" onclick="location.href='/mypetlist'">
								<b>마이펫</b>
							</div>
							<div class="oneDivL circleDiv"></div>
							<div class="twoDivL circleDiv"></div>
							<div class="threeDivL circleDiv"></div>
						</div>
						<div class="wrapDiv">
							<div class="handDivR" onclick="getMyActionZzim()">
								<b>찜병원</b>
							</div>
							<div class="oneDivR circleDiv"></div>
							<div class="twoDivR circleDiv"></div>
							<div class="threeDivR circleDiv"></div>
						</div>
						<div class="wrapDiv">
							<div class="handDivL" onclick="getMyActionReserve()">
								<b>예약내역</b>
							</div>
							<div class="oneDivL circleDiv"></div>
							<div class="twoDivL circleDiv"></div>
							<div class="threeDivL circleDiv"></div>
						</div>
						<div class="wrapDiv">
							<div class="handDivR" onclick="location.href='/getMyReviewPostList'">
								<b>나의리뷰</b>
							</div>
							<div class="oneDivR circleDiv"></div>
							<div class="twoDivR circleDiv"></div>
							<div class="threeDivR circleDiv"></div>
						</div>
					</div>
				</div>
			</div>
<!-- 반응형 메뉴 시작 -->
		<div class="container mobileMyMenu">
			<div class="row mobileMytitle">
				<div class="col"><h3><strong>마이페이지</strong></h3></div>
				<div class="col"><span><%=session.getAttribute("users_id")%>님! 어서오세요 </span></div>
			</div>
			<div class="row mobileMy_memu mobileMymemu1">
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/getUsers'">
						내정보
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/mypetlist'">
						마이펫
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionZzim()">
						찜병원
					</div>
				</div>
			</div>
			<div class="row mobileMy_memu mobileMymemu2">
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionReserve()">
						예약<br>내역
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/getMyReviewPostList'">
						나의<br>리뷰
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/tomypagemain'">
						마이<br>메인
					</div>
				</div>
			</div>
		</div>
		<!-- 반응형 메뉴 끝 -->

			<div class="container revDetailMargin">
				<c:set var="sti" value="0" />
				<form name="fm" action="updateReview" method="post" enctype="multipart/form-data">
						<input type="hidden" name="rev_hos_seq" value="${review.rev_hos_seq}"> 
						<input type="hidden"name="rev_userid" value="${review.rev_userid}"> 
						<input type="hidden" name="res_seq" value="${review.res_seq}"> 
						<input type="hidden" class="form-control innm" name="users_id" value="${users_name}"> 
						<input type="hidden" class="form-control innm" name="hos_name" value="${review.hos_name}"> 
						<input type="hidden" class="form-control innm" name="regDate" value="${review.res_date}">
							<div id="revDet" class="review-box">
								<div class="user-info">
									
									<div class="profileupper">
										<h5>${review.rev_userid}</h5>
										<div><img id="reviewUpButton" style="border-radius: 10px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAThJREFUSEvVle01BEEQRe9GgAgQASJABIgAESACZEAEyGBFgAjIABkQAec61XNmes32ztneH1u/pj+qXterVzUjFmyjBcdnCMAq8ARsx6OegSPga9ojhwCMgYMs2AVwUwPAIGfAd2RwHutr4GpegBPgLoLsAG/AB7AOpHUvRoki+X4N71PgPjJw7xPYKIlkGoDOBrK4t4C0aImu9t5MGewFFfmrHoHDVoRET19Qz81WlXVk2ue4lknRGmwVqDHWZg7wE06Jtnxdojudd/zaNVgKAOtotzcKq52BMj4GmgasCaCc30PWFthCd1Q0bw1Sx78AUvVnNTNQ97vRA1JVFcDmlB6Hod/NCK+VgRP1EngApKqxNoCoK7N2U8+9/TQi/qPIwsidY3ioSY1DcOLfUBrXQ4Em7i8/wC/AX0YZwIqJ7wAAAABJRU5ErkJggg=="/>
								 ${review.rev_up}</div>
										<div class="star-rating" id="st-${sti = sti+1}">
											<script>
						       $(function(){generateStarRating(${sti}, ${review.rev_star});}) ;
						       </script>
										</div>
									</div>

								</div>
								<div class="review-details">
									<div>
										<b>제목: </b><input type="text" class="review-details" style="border: none;" name="rev_title" placeholder="제목을 입력하세요." value="${review.rev_title}">
									</div>
									<div>
									<span><b>예약내역: </b> <span>${review.hos_name}</span> <span>${review.res_date} ${review.res_time}</span></span></div>
									<div>
									<b>사진등록</b><span class="review-details">(*이미지 등록시, 기존이미지와 대체)</span> <input type="file" style="border: none;" name="uploadFile" <%=sts%>>
									</div>
									<hr>
									<div>
										<textarea class="textareaWidth textareabordergray" rows="10" id="rev_content"
											name="rev_content" <%=sts%>>${review.rev_content}</textarea>
									</div>
								</div>
								<hr>
								<div>
									<input type="hidden" name="rev_pic" value="${review.rev_pic}">
									<img style="height: 400px; width: 300px;"
										src="${pageContext.request.contextPath}/img/${review.rev_pic}"
										alt="${review.rev_pic}" title="${review.rev_pic}" id="rev_pic"
										onerror="this.src='${pageContext.request.contextPath}/img/catdefault.png'" >
								</div>						
								<hr>
								<div class="text-center">
								<button type="submit" class="search-button" <%=sts%>>글수정</button>
								<button id="revDel" type="button" class="search-button-delete" <%=sts%>>글삭제</button>
								<button onclick="getMyReviewPostList()" type="button" class="search-button">글목록</button>
								</div>
							</div>
						<script>
								//이전별점
						          function generateStarRating(idx, starValue) {
						        	  	console.log('starValue', starValue);
						            for (var i = 1; i <= 5; i++) {
						            var starHtml = '';
						              starHtml += '<input type="radio" id="' + i + '-stars" name="rev_star" value="' + i + '"';
						             
						              if (i<= starValue) {
						            	  if(i== starValue) starHtml += ' checked';
							              starHtml += ' /><label for="' + i + '-stars" class="star starChk">&#9733;</label>';
						              }else{
							              starHtml += ' /><label for="' + i + '-stars" class="star">&#9733;</label>';
						              }
							         $("#st-"+idx).append(starHtml);
						            }
						          }
				 </script>
				</form>
			</div>
		</div>
	</div>

<%@ include file="../../footer.jsp"%>
</body>
</html>
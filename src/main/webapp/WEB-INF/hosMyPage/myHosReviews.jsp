<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
//       리뷰보이기 글자제한
      document.addEventListener("DOMContentLoaded", function () {
        var reviewElements = document.getElementsByClassName("review");
        for (var i = 0; i < reviewElements.length; i++) {
          var reviewText = reviewElements[i].textContent;
          if (reviewText.length > 100) {
            reviewElements[i].textContent = reviewText.substring(0, 100) + "...";
          }
        }
      });
//       리뷰목록 더보기
      document.addEventListener("DOMContentLoaded", function () {
        var reviewContainer = document.getElementById("reviewContainer");
        var showMoreButton = document.getElementById("showMoreButton");

        showMoreButton.addEventListener("click", function () {
          console.log("더보기 실행");
          reviewContainer.classList.remove("d-none"); // Remove the "d-none" class to show the review container
          showMoreButton.classList.add("d-none"); // Add the "d-none" class to hide the "Show More" button
        });
      });

//       블러처리 해제
      document.addEventListener("DOMContentLoaded", function () {
        var reviewContainer = document.getElementById("reviewContainer");
        var showMoreButton = document.getElementById("showMoreButton");

        // Add the following code to check the user's login status
        var isLoggedIn = true; // Set this variable based on the user's login status

        if (isLoggedIn) {
          reviewContainer.style.filter = "none"; // Remove the blur effect
          reviewContainer.style.pointerEvents = "auto"; // Enable interaction with the review container
          showMoreButton.style.display = "none"; // Hide the "Show More" button
        }
      });
    </script>


<style>
table{
border: 1px solid black;
text-align:left;
}

.container{
	width: 90%
}
</style>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>
<%
String sessionValue = (String)session.getAttribute("sessionName");
//sessionValue랑 sessionName은 통합 후 변경
%>
<div class="container structure">
	<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h3><strong>리뷰 조회</strong></h3></div>
			<div class="col-md-4 rightDiv">
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='myHos'" style="padding:15px;"><b>내<br>병원</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='toHosUpdate'" style="padding:15px;"><b>정보<br>수정</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='docList'" style="padding:12px;"><b>의사<br>관리</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='resList'" style="padding:15px;"><b>예약<br>보기</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='toHosReview'" style="padding:12px;"><b>리뷰<br>조회</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
			</div>
		</div>
	</div>
<!-- 	웹에서 보이는 메뉴 끝 -->
	
<!-- 	반응형 모바일 메뉴 시작 -->
	<div class="container mobileMyMenu">
         <div class="row mobileMytitle">
            <div class="col"><h3><strong>리뷰조회</strong></h3></div>
         </div>
         <div class="row mobileMy_memu mobileMymemu1">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='myHos'">
               <b>내 병원</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosUpdate'">
               <b>정보<br>수정</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='docList'">
               <b>의사<br> 관리</b>
               </div>
            </div>
         </div>
         <div class="row mobileMy_memu mobileMymemu2">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='resList'">
               <b>예약<br>보기</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosReview'">
               <b>리뷰<br>조회</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosMyPage'">
                  마이<br>메인
               </div>
            </div>
         </div>
      </div>
<!--       반응형 마이 메뉴 끝 -->
	<br>
	<div class="search-container-rev">
			<div class="search-box">
				<form action="searchHosRevList" method="post">
					<select class="search-select" id="searchCondition_rv"
						name="searchCondition">
						<option value="rev_name">제목</option>
						<option value="rev_star">별점</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요"
						class="search-input-rev" />
					<button type="submit" class="search-button">
						<i class="fa fa-search"></i>
					</button>
				</form>
			</div>		
		</div>
		<div class="text-center">
				<h4><b>리뷰목록&nbsp;&nbsp;</b></h4>
			</div>
	
		<div class="row" id="reviewContainer">
		<c:choose>
        <c:when test="${empty reviewList}">
            <div class="col-md-12 text-center">
                해당되는 리뷰가 없습니다.
            </div>
        </c:when>
        <c:otherwise>
			<c:set var="sti" value="0" />			
			<c:forEach items="${reviewList}" var="review">
				<div class="col-md-6 mt-sm-4"
					onclick="revDetail(${review.rev_hos_seq})">
					<div class="revShadow review-box">
					<div class="row">
					<div class="col-6">
						<div class="user-info">
							<div class="profileupper">
								<h5>${review.rev_userid}</h5>
								<div class="star-rating" id="st-${sti = sti+1}">
									<script>
						       $(function(){generateStarRating(${sti}, ${review.rev_star});}) ;
						       </script>
								</div>
							</div>
						</div>
						<div class="review-details-up">
						<div>${review.rev_title}</div>
							<span>${review.hos_name}</span>
							<span>${review.res_date} ${review.res_time}</span>
						</div>
					</div>
					<div class="col-6">
					<img src="${pageContext.request.contextPath}/img/${review.rev_pic}" alt="mdo"
								class=" profilepic"
								onerror="this.src='${pageContext.request.contextPath}/img/catdefault.png'" />
					</div>
					</div>				
						<div class="review-details">
							
							<hr>
							<div class="review">${review.rev_content}</div>
						</div>
					</div>
				</div>
			</c:forEach>
			</c:otherwise>
    </c:choose>
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
		</div>
		<button id="showMoreButton" class="revInsBtn">더보기</button>
	</div>
<!-- 	<div class="container"> -->
<%-- 	<c:choose> --%>
<%-- 		<c:when test="${empty revList}"> --%>
<!-- 			<h3>등록된 리뷰가 없습니다.</h3> -->
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
		
<%-- 			<c:forEach items="${revList}" var="rev"> --%>
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${rev.rev_Req ne 'B' }"> <!-- 나중에 ne로 바꿀것 --> --%>
<!-- 						<table> -->
<!-- 							<tr> -->
<%-- 								<td style="width:80px;">${rev.rev_UserId}님</td> --%>
<%-- 								<td>${rev.rev_Star}점</td> --%>
<%-- 								<c:if test="${sessionValue eq '${hos.hos_id'}"> --%>
<!-- 									<td><button type="button">신고버튼</button></td> -->
<%-- 								</c:if> --%>
<%-- 								<c:if test="${sessionValue eq 'admin'}"> --%>
<!-- 									<td><button type="button">삭제버튼</button></td> -->
<%-- 								</c:if> --%>
<!-- 							</tr> -->
<%-- 							<tr><td colspan="4">${rev.rev_Content}</td></tr> --%>
<!-- 						</table> -->
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<!-- 						<h3>등록된 리뷰가 없습니다.</h3> -->
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
<%-- 			</c:forEach> --%>
<%-- 		</c:otherwise> --%>
<%-- 	</c:choose> --%>
<!-- 	</div> -->
<!-- 	</div> -->
	<%@ include file="../../footer.jsp"%>
</body>
</html>
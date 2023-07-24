<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.spring.pet.commons.PageInfo"%>
<%@page import="com.spring.pet.users.UsersVO" %>
	<%
	PageInfo uvo = (PageInfo) request.getAttribute("paging");
	int startNUM = uvo.getStartNUM();
	int endNUM = uvo.getEndNUM();
	int pageNUM = uvo.getPageNUM();
	int totalPage = uvo.getTotalPage();
	int pageListCount = uvo.getPageListCount();
	%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<div id="adminUserReserveDiv" class="container-fluid">
	<form name="userReserveList">
	<div class="SearchResetBtnDiv">
		<button type="button" class="btn SearchResetBtn" onclick="resetSearchUserReserveList()">검색 초기화</button>
	</div>
	<div class="row adminUserReserveListSearchDiv">
		<div id="adminUserReserveCancelCheckBox" class="col-3">
		<c:set var="resCancel" value="${adminUserVO.res_cancel}" />
		<input type="checkbox" id="res_cancel" name="res_cancel" value="y" onchange="handleCheckboxChange()" ${resCancel eq 'y' ? 'checked' : ''} />
		<span>취소예약</span>
		</div>
		<div class="col-9 adminUserReserveListSearch">
		<select id="searchCondition" name="searchCondition" class="custom-select">
			<c:forEach items="${search_reserve_Map}" var="searchReserveMap">
				<option value="${searchReserveMap.key}" 
				<c:if test="${searchReserveMap.key eq adminUserVO.searchCondition}">selected</c:if>>${searchReserveMap.key}</option>
			</c:forEach>
		</select>
			<input type="text" class="form-control"
			id="ReserveSearchInsertDate1" name="searchInsertDate1" placeholder="검색 시작일" 
			value="${adminUserVO.searchInsertDate1}"> ~ <input type="text"
			class="form-control"id="ReserveSearchInsertDate2" name="searchInsertDate2" placeholder="검색 종료일"
			value="${adminUserVO.searchInsertDate2}">
		<button type="button" class="btn" onclick="SearchreserveUser()"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAVFJREFUSEvVleExBEEQRt9FQAoiQATIgAgQASJABIgAESACZEAEyIAIqKd6qub2Zmen7N4P/eu2dqdf99dfz81YcsyWnJ8+wCpwBOwCG1HEC3APXAGfrYWVAAfABSCkFCY/AW5aIF2Aya/j4ANwCTzF8zZwBmzF8150VOXkACt+i8oPKxUKOQ2Z1obkygHpoJWrfS3syk7Oo6veb3OAQ1wHdjJZ+g4q1yPgmc1aJTngOz5stW7T92MBXxW3/db7V4mc0R3wDChX0wzSkF0mLdgyZPdBKzcBtOk7sBLO0CGlSIV8xJZXt7o70NS6ibWiyZTBUAr9nyQZtGh3Bqlat9m27aQUDtb3wrSpv2/7NKpddsexcO6G8RpXgwmVJe2N77yX3P6FaPV86Wx+b/VCxgBS0v2MvtDJWMAgZApAFzJ3E08FSBCtPfdHNCWg6NT/D/gBeOVFGZeTouUAAAAASUVORK5CYII="/></button>
		</div>
		</div>
		</form>
	
		<div class="adminUserReserveListTableDiv">
		<%if(pageListCount>0){ %>
		<table class="table">
			<thead class="btn-primary">
				<tr>
					<th>예약번호</th>
					<th>병원명</th>
					<th>예약일자</th>
					<th>예약시간</th>
					<th>결제일자</th>
					<th>예약여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${adminUserReserve}" var="userReserve">
					<c:choose>
						<c:when test="${userReserve.res_cancel eq 'Y'}">
						<tr style="color:gray;">
							<td class="tdCenter">${userReserve.res_seq}</td>
							<td class="tdCenter">${userReserve.hos_name}</td>
							<td class="tdCenter"><fmt:formatDate value='${userReserve.res_date}' pattern='yyyy-MM-dd' /></td>
							<td class="tdCenter">${userReserve.res_time.substring(0,5)}</td>
							<td class="tdCenter"><fmt:formatDate value='${userReserve.res_cashdate}' pattern='yyyy-MM-dd' /></td>
							<td class="tdCenter">취소</td>	
						</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="tdCenter">${userReserve.res_seq}</td>
								<td class="tdCenter">${userReserve.hos_name}</td>
								<td class="tdCenter"><fmt:formatDate value='${userReserve.res_date}' pattern='yyyy-MM-dd' /></td>
								<td class="tdCenter">${userReserve.res_time.substring(0,5)}</td>
								<td class="tdCenter"><fmt:formatDate value='${userReserve.res_cashdate}' pattern='yyyy-MM-dd' /></td>
								<td class="tdCenter">-</td>
							</tr>
						</c:otherwise>
					</c:choose>
		
				</c:forEach>
			</tbody>
		</table>

<!-- 페이징 -->


	
		<%
			if (pageNUM <= 1) {
			%>
				<button type="button" class="pagingBefore">&lt;&nbsp;이전</button>
		<%
			} else {
			%>
		<button type="button" class="pagingBefore" onClick="SearchreserveUser(<%=pageNUM-1%>)">&lt;&nbsp;이전</button>
		<%
			}
			%>
			<%
			for (int a = startNUM; a <= endNUM; a++) {
			if (a == pageNUM) {
					%>
					<button type="button" class="paging_btn select">
					<%=a%>
					</button>
					<%
					} else {
					%>
					<button class="paging_btn" onClick="SearchreserveUser(<%=a%>)"><%=a%>
					</button>
					<%
					}
					%>
					<%
					}%>
		<%
			if (pageNUM == totalPage) {
			%>
				<button type="button" class="pagingAfter">다음&nbsp;&gt;</button>
		<%
			} else {
			%>
		<button type="button" class="pagingAfter" onClick="SearchreserveUser(<%=pageNUM + 1%>)">다음&nbsp;&gt;
		</button>
		<%
			}
		%>
		<%}else{ %>
		<section>예약 내역이 없습니다.</section>
			
		<%} %>
		</div>
	<button type="button" class="btn" onclick="userList()">목록으로</button>
</div>		
<script>


//날짜 박스 readonly로 변경
$("#ReserveSearchInsertDate1").attr("readonly", true);
$("#ReserveSearchInsertDate2").attr("readonly", true);


//첫날 선택날짜 기준으로 종료날짜 범위 변경됨
$(document).ready(
	function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$("#ReserveSearchInsertDate1").datepicker(
				{
					changeMonth : true,
					changeYear : true,
					nextText : '다음 달',
					prevText : '이전 달',
					dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
							'금요일', '토요일' ],
					dayNamesMin : [ '일', '월', '화', '수', '목', '금',
							'토' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월',
							'5월', '6월', '7월', '8월', '9월', '10월',
							'11월', '12월' ],
					monthNames : [ '1월', '2월', '3월', '4월', '5월',
							'6월', '7월', '8월', '9월', '10월', '11월',
							'12월' ],
					dateFormat : "yy-mm-dd",
					onClose : function(selectedDate) {
						$("#searchInsertDate2").datepicker(
								"option", "minDate", selectedDate);
					}

				});
		$("#ReserveSearchInsertDate2").datepicker(
				{
					changeMonth : true,
					changeYear : true,
					nextText : '다음 달',
					prevText : '이전 달',
					dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
							'금요일', '토요일' ],
					dayNamesMin : [ '일', '월', '화', '수', '목', '금',
							'토' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월',
							'5월', '6월', '7월', '8월', '9월', '10월',
							'11월', '12월' ],
					monthNames : [ '1월', '2월', '3월', '4월', '5월',
							'6월', '7월', '8월', '9월', '10월', '11월',
							'12월' ],
					dateFormat : "yy-mm-dd",
					onClose : function(selectedDate) {
						$("#ReserveSearchInsertDate1").datepicker(
								"option", "maxDate", selectedDate);
					}

				});
	});




</script>
</body>
</html>
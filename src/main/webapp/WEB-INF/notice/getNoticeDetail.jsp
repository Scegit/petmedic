<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../../petmedic_navbar.jsp"%>
	<div class="container noticeWrap">
		<div class="container noticeHeadWrap blurblur">
			<div class="row noticeTitle">
				<span><strong>펫메딕 공지사항</strong></span>
			</div>
		</div>

		<div class="container blurblur nodewrap">
			<div class="row noticeDetailCont">
				<div class="col noticeDetailtitle nodecont">
					<span><strong>제&nbsp;&nbsp;&nbsp;목&nbsp;: </strong></span>
					<span>&nbsp;&nbsp;${noticeList.notice_title}</span>
				</div>
			</div>
				
			<div class="row">
				<div class="col-6 noticeDetailadmin nodecont">
					<span><strong>작성자&nbsp;: </strong></span>
					<span>&nbsp;&nbsp;${noticeList.notice_admin}</span>
				</div>
				<div class="col-6 noticeDetaildate nodecont">
					<span><fmt:formatDate value="${noticeList.notice_date}" pattern="yyyy-MM-dd" /></span>
				</div>
			</div>
				
			<div class="row noticeDetailCont nodecont2">
				<div class="col noticeDetailcontents">
					<span>${noticeList.notice_cont}</span>
				</div>
				<div class="col noticeDetailimg nodecontimg">
					<c:if test="${noticeList.notice_realfile ne null}">
						<span><img src="${pageContext.request.contextPath}/resources/noticeupload/${noticeList.notice_realfile}" alt="${noticeList.notice_realfile}" title="${noticeList.notice_realfile}" id="noticecCont_img"></span>
					</c:if>
				</div>
			</div>
		</div>
		
		<div class="container">
			<div class="row goNolist">
				<label for="noticeListBtn"></label>
				<span onClick="location.href='toGetNoticeList'" style="cursor:pointer;">목록으로</span>
			</div>
		
		</div>
	</div>
	<%@ include file="../../footer.jsp"%>	
</body>
</html>
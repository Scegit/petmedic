<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<!DOCTYPE html>
<html>
<body>
	<div class="container noticeWrap_admin">
		<div class="container noticeHeadWrap_admin">
			<div class="row noticeTitle_admin">
				<h4>공지사항 관리</h4>
			</div>
		</div>
		
			<div class="container blurblur nodewrapde_admin">
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
			<div class="row goNolist goNolist_admin">
				<label for="noticeListBtn noticeListBtn_admin"></label>
				<span onclick="goNoticeModify(${noticeList.notice_int})" style="cursor:pointer;">수정</span>
				<span id="nlb_admin_del" onclick="goNoticeDel(${noticeList.notice_int}, '${noticeList.notice_realfile}')" style="cursor:pointer;">삭제</span>
				<span onClick="location.href='toAdmin_NoticeMain'" style="cursor:pointer;">목록으로</span>
			</div>
		</div>
	</div>
</body>
</html>
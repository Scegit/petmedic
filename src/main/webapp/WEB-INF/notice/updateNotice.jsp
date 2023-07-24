<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<script>
$(document).ready(function(){
   $("input[type='file']").on("change", function(e){
      $(this).next('.custom-file-label').html(e.target.files[0].name);
   });
});
</script>
<body>
<div class="container noticeWrap_admin">
      <div class="container noticeHeadWrap_admin">
         <div class="row noticeTitle_admin">
            <h4>공지사항 수정</h4>
         </div>
      </div>
      
      <div class="container blurblur nodewrapde_admin nodewrapup">
         <div class="container updatenot">
         <form action="/updateNotice?notice_int=${noticeList.notice_int}"; method="post" enctype="multipart/form-data" >
            <div class="row">
                  <label for="notice_title"></label>
                  <input type="text" class="form-control" id="notice_title" name="notice_title" value="${ noticeList.notice_title }">
            </div>
            <div class="row">
               <div class="input-group">
                  <div class="col col-none-pad">
                     <input type="text" aria-label="notice_admin" class="form-control" name="notice_admin" value="${ noticeList.notice_admin }" readonly>
                  </div>
                  <div class="col col-none-pad">
                     <input type="text" aria-label="notice_date" class="form-control" value="${noticeList.notice_date.toLocaleString().split("오")[0]}" readonly>
                  </div>
               </div>
            </div>
            
            <div class="row updatenotfilerow">
              <div class="col col-none-pad">
                <div class="input-group-prepend">
                  <span class="input-group-text" id="inputGroupFileAddon01">첨부파일</span>
                </div>
                <div class="custom-file">
                  <input type="file" class="custom-file-input" id="notice_file" name="notice_file" value="${noticeList.notice_file}" aria-describedby="inputGroupFileAddon01">
                  <label class="custom-file-label" for="notice_realfile">${noticeList.notice_realfile}</label>
                  <input type="hidden" name="notice_realfile" value="${noticeList.notice_realfile}">
                </div>
              </div>
            </div>
            
            <!-- 공지사항 고정pin -> 0:일반, 1:고정 -->
            <div class="row formRowform">
               <div class="form-check form-check-inline">
                  <label for="notice_pin"></label>
                  <div class="col">
                     <input type="radio" class="form-check-input" id="notice_pin1" name="notice_pin" value="1" ${noticeList.notice_pin == 1 ? 'checked' : ''}>중요공지</input>
                  </div>
                  <div class="col">
                     <input type="radio" class="form-check-input" id="notice_pin2" name="notice_pin" value="0" ${noticeList.notice_pin == 0 ? 'checked' : ''}>일반공지</input>
                  </div>
               </div>
               <div class="col">
                  <button type="button" class="notfileReset" onclick="resetFile()">파일삭제</button>
               </div>
            </div>
            
            <div class="row">
               <label for="notice_cont"></label>
               <textarea class="form-control" id="notice_cont" name="notice_cont" style="height: 300px; resize: none">${ noticeList.notice_cont }</textarea>
            </div>
            <div class="row noticeUpcenter">
                  <label for="noticeModiBtn"></label>
                  <button type="submit" id="noticeSubBtn" class="btn" onclick="modifyNotice()">수정</button>
                  <button type="reset" id="noticeResetBtn" class="btn">초기화</button>
                  <button type="button" id="returnNoticeListBtn" onclick="history.back()" class="btn">돌아가기</button>
            </div>
            </form>
         </div>
      </div>
   
   </div>
<
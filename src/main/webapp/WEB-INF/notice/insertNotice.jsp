<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<%@ include file="/header.jsp"%>
<head>
<script>
function noticeSubmit() {
   alert("공지를 등록하시겠습니까?");
   return true;
};

// input박스에 업로드한 파일이름으로 나오게 하기
$(document).ready(function(){
   $("input[type='file']").on("change", function(e){
      $(this).next('.custom-file-label').html(e.target.files[0].name);
   });
});

// 초기화버튼을 누르면 input박스에 업로드한 파일및 라벨 초기화해주기
$(document).on('click', '#noticeresetBtn', function(){
   $('.custom-file-label').text('업로드할 이미지 파일을 선택해주세요');
   $("input[type='file']").empty();
});
</script>
</head>
<body>
<div class="container noticeWrap_admin">
<div class="container blurblur nodewrapde_admin nodewrapin"> 
   <div class="container insert_Notice_container"> 
      <form action="/insertNotice" onsubmit="return noticeSubtmit()" method="post" enctype="multipart/form-data">
         <div class="row"> 
            <label for="notice_title"></label> 
            <input type="text" class="form-control" id="notice_title" name="notice_title" placeholder="제목을 입력해주세요"> 
         </div>      
         <div class="row">   
            <div class="input-group">
               <div class="col col-none-pad">
               <input type="text" aria-label="notice_admin" class="form-control" id="insertnotadmin" placeholder="관리자" name="notice_admin" value="관리자" readonly>
               </div>
               <div class="col col-none-pad">
               <input type="text" aria-label="insert_notice_date" class="form-control" id="insertnotdate" name="insert_notice_date" value="<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd" /> " readonly>
               </div>
            </div>
         </div>   
            <div class="row insertnotfilerow">
               <div class="col col-none-pad">
                  <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroupFileAddon01">첨부파일</span>
                  </div>
                  <div class="custom-file">
                     <input type="file" class="custom-file-input" id="notice_file" name="notice_file" aria-describedby="inputGroupFileAddon01">
                     <label class="custom-file-label" for="notice_realfile">업로드할 이미지 파일을 선택해주세요</label>
                     <input type="hidden" class="custom-file-input" id="notice_realfile" name="notice_realfile" aria-describedby="inputGroupFileAddon01">
                  </div>
                  
               </div>
            </div>
            
            <!-- 공지사항 고정pin -> 0:일반, 1:고정 -->
            <div class="row formRowform">
               <div class="form-check form-check-inline">
                  <label for="notice_pin"></label>
                  <div class="col">
                     <input type="radio" class="form-check-input" id="notice_pin1" name="notice_pin" value="1">중요공지</input>
                  </div>
                  <div class="col">
                     <input type="radio" class="form-check-input" id="notice_pin2" name="notice_pin" value="0" checked>일반공지</input>
                  </div>
               </div>
<!--                <div class="col"> -->
<!--                   <button type="button" class="notfileReset" onclick="resetFile()">파일삭제</button> -->
<!--                </div> -->
            </div>
            
            <div class="row">
               <label for="notice_cont"></label>
               <textarea class="form-control" id="notice_cont" name="notice_cont" style="height: 300px; resize: none">${ noticeList.notice_cont }</textarea>
            </div>      
            <div class="row noticeUpcenter">
               <label for="noticeSubBtn"></label>
               <button type="submit" id="noticeSubBtn" class="btn">등록</button>
               <button type="reset" id="noticeresetBtn" class="btn">초기화</button>
            </div>
      </form>
   </div>
   </div>

</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp"%>
<%-- <%@ include file="/menu.jsp"%> --%>
<%@ include file="../admin_user/adminPage.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script> -->
<%-- <script src="${ pageContext.request.contextPath }/js/faqjs.js"></script> --%>
<body>
<div class="container" id="faqWrap_admin">
   <div class="container faqHeadWrap_admin">
      <div class="row faqTitle_admin">
         <div class="col">
            <h4>자주 묻는 질문 등록하기</h4>
         </div>
      </div>
   </div>

   <div class="container blurblur" id="insertWriteFaq">
      <form action="/insertFAQ" onsubmit="return faqSubmit()" method="post">
         <div class="row writeFaqrow writeFaqTitle">
            <label for="faq_title"></label>
            <input type="text" class="form-control" id="faq_title" name="faq_title" placeholder="제목을 입력해주세요">
         </div>
         <div class="row writeFaqrow writeFaqCate">
             <label for="faq_cate"></label>
             <select class="form-control" id="exampleFormControlSelect1" name="faq_cate">
               <option>회원관련</option>
               <option>리뷰관련</option>
               <option>예약관련</option>
               <option>병원관련</option>
               <option>기타</option>
             </select>
           </div>
           <div class="row writeFaqrow writeFaqCont">   
            <label for="faq_cont"></label>
            <textarea class="form-control" id="faq_cont" name="faq_cont" placeholder="내용을 입력하시오"></textarea>
         </div>
         <div class="row writeFaqrow faq_SubReBtn">
            <input type="hidden" aria-label="faq_id" class="form-control" placeholder="관리자" name="faq_id" value="${ users_id }" >
            <label for="faqSubBtn"></label>
            <button type="submit" clss="SubReBtns">등록</button>
            <button type="reset" clss="SubReBtns">초기화</button>
            <button type="button" onClick="location.href='/togetFaqListAdmin'">돌아가기</button>
         </div>
         <!-- 로그인 후 세션에 저장된 아이디로 value가 넘어가게 해야한다 -->
   </form>
   </div>
</div>
</body>
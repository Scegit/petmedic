<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/header.jsp"%>
<%@ include file="../../petmedic_navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
var totalData; //총 데이터 수
var dataPerPage; //한 페이지에 나타낼 글 수
var pageCount = 5; //페이징에 나타낼 페이지 수
var globalCurrentPage= 1; //현재 페이지
var dataList; //표시하려하는 데이터 리스트

var faq_cate_btn = null;
var faqSearch = null;
var faqSearchKeyword = null;

// 맨처음에 목록조회를 해줘야됨
$(document).ready(function(){
   // input에 onkeyup 이벤트를 추가해준다
   $('#faqSearchKeyword').on("keyup", function(e){
      console.log(e);
      if(e.keyCode == 13){
//          alert('searchClick이 클릭된다');
         $('button.searchClick').click();
      }
   });
   
   // submit 기능을 막는다 (엔터키로 실행시 input이 하나면 submit이 실행되기 때문에 막아줘야함)
   faqfrm.addEventListener('submit', e => {
      e.preventDefault();
   });      
   
   // 페이징 여기부터 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
   dataPerPage = 5;  // 한 페이지에 나타낼 글 수 (10개) 
      
   $.ajax({ 
      method: "POST",
      url: "/getFaqList",   // 전체 목록 조회
      data: {'faq_cate_btn': '전체'},
      cache: false,
      success: function (res) {
         console.log("res값은? ",res);
         console.log("faq_cate_btn값:" , faq_cate_btn);
         totalData = res.length; // 방이 몇개냐 (리스트 길이)
            
         dataList = res;
         console.log("totalData값: " + totalData); 
            
         displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
            
         paging(totalData, dataPerPage, pageCount, 1);
         $(".faq_cont").hide();
      },
      error: function(request, status){
         console.log("으아아아에러다");
      }
   });    
});

var maxData;

//displayData 함수 수정
function displayData(currentPage, dataPerPage) {
   let faqHtml = "";
   currentPage = Number(currentPage); 
   dataPerPage = Number(dataPerPage); 
        
   console.log("현재 페이지?", currentPage); 
        
   maxData = Math.min(totalData, (currentPage - 1) * dataPerPage + dataPerPage); // i의 범위를 수정
   console.log('maxData 몇개냐 ' , maxData);
   if ( totalData > 0 ) {
      for (var i = (currentPage - 1) * dataPerPage; i < maxData; i++) {
         
    	  faqHtml += "<div class=\"faq_contents container\"><div class=\"row faq_title\">"
              + "<div class=\"col-3\">" + dataList[i].faq_cate + "</div>" 
              + "<div class=\"col-9\">" + dataList[i].faq_title + "</div></div>"
              + "<div class=\"row faq_cont\"><div class=\"col\">" + dataList[i].faq_cont + "</div></div></div> ";
      }
   } else {
      faqHtml += "<div class=\"emptyResult row\">해당하는 데이터가 없습니다</div>";
   }
   $("#faq_list_wrap").append(faqHtml);
}

// 페이지네이션
function paging(totalData, dataPerPage, pageCount, currentPage) {
   console.log("currentPage : " + currentPage);
   console.log("pageCount : " + pageCount);
   console.log("totalData : " + totalData);

   totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수
          
   if(totalPage<pageCount){
      pageCount=totalPage;
   }
          
   let pageGroup = Math.ceil(currentPage / pageCount); // 페이지 그룹
   let endPage = pageGroup * pageCount; //화면에 보여질 마지막 페이지 번호
          
   if (endPage > totalPage) {
      endPage = totalPage;
   }

   let startPage = endPage - (pageCount - 1); //화면에 보여질 첫번째 페이지 번호
   let next = Number(currentPage)+1;
   let prev = Number(currentPage)-1;

   let pageHtml = "";

   console.log("맥스 : "+ maxData);
   console.log("토탈 : "+ totalPage);
   console.log("엔드 : "+ endPage);
   console.log("지금 : "+ currentPage);
   console.log("다음 : "+ next);
         
   if (next <= totalPage) {
      pageHtml += '<span><a href="javascript:void(0);" id="next"> 더보기 </a></span>';
   } else if (maxData = totalData){ pageHtml += '<span id=\"faqfirst\"><a onClick=\"faqSearchfnc()\" id=\"entirelist\"> 전체목록 </a></span>'; }
   
   $("#faq_count").html(pageHtml);
   
   let displayCount = "";
   displayCount = "전체 " + totalData + "건";
   $("#displayCount").text(displayCount);

   //페이징 번호 클릭 이벤트 
   $("#faq_count span a").click(function () {
      let $id = $(this).attr("id");
      selectedPage = $(this).text();

      if ($id == "next") selectedPage = next;
            
      //전역변수에 선택한 페이지 번호를 담는다...
      globalCurrentPage = selectedPage;
         
      console.log("클릭시 글로벌 "+globalCurrentPage);
            
      //글 목록 표시 재호출
      displayData(globalCurrentPage, dataPerPage);
      $("div.faq_cont").hide();
      
      //페이징 표시 재호출
      paging(totalData, dataPerPage, pageCount, globalCurrentPage);
   });
}
   
   
//FAQ 제목 클릭시 해당하는 FAQ 내용을 toggle로 보여줌
$(document).on('click', 'div.faq_title', function() {
    var $this = $(this);
    var $cont = $this.next("div.faq_cont");
    // 클릭된 faq_title에서 해당하는 faq_cont를 찾음 faq_cont를 toggle로 보여주거나 숨김 처리
    $cont.toggle();
    // 클릭된 요소와 다른 모든 faq_title_admin 요소의 faq_cont_admin를 숨김 처리
    $('div.faq_title').not($this).next("div.faq_cont").hide();
});

// 카테고리 클릭시 css 적용하기
$(document).on('click', 'div.cate_btn', function(){
   // 처음 선택된 cate_selected 클래스는 지우고
   $("div.cate_btn").removeClass("cate_selected");
   // 셀렉티드된 div태그에 cate_selected 클래스를 추가
   $(this).addClass("cate_selected");
});

// 마우스 오버했을 때 클래스를 추가하고 css 적용한다
$(document).on('mouseover', 'div.faq_contents', function(){
   $("div.faq_contents").removeClass("faq_contents_selected");
   $(this).addClass("faq_contents_selected");
});
$(document).on('mouseleave', 'div.faq_contents', function(){
   $("div.faq_contents").removeClass("faq_contents_selected");
});


//카테고리 선택시 변경되는 값에 따라 리스트를 다시 가져온다
function faqSelect(val){
   console.log(val);   //'회원가입'
   
   $.ajax({
      method: "POST",
      url: "/getFaqList",
      data: {'faq_cate_btn': val},      
      cache: false,
      success: function(listpage){
         console.log("검색 성공");
         totalData = listpage.length;
         
         $('div.emptyResult').hide();
         
         dataList = listpage;
         console.log("totalData값: " + totalData); // 23
         
         $("#faq_list_wrap > div.faq_contents").remove();
         displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
         $("div.faq_cont").hide();
         paging(totalData, dataPerPage, pageCount, 1);
      },
      error: function(request, status){
         console.log('에러니?2');
      }
   });
}

function faqSearchfnc(val1, val2){
   console.log("val1 > 제목이냐 내용이야? ", val1);
   console.log("val2 > 검색어는 무엇이야? ", val2);
   faqSearch = val1; // "key_title"
   faqSearchKeyword = val2; //"배우고"
   
   console.log(faqSearch);
   console.log(faqSearchKeyword);
   $.ajax({
      method: "post",
      url: "/getFaqList",
      data: {"faqSearch": val1, "faqSearchKeyword": val2},  // {faqSearch : "key_title" , faqSearchKeyword: "배우고"}
      cache: false,
      success: function(res){
         console.log("검색 성공ㅋ");
         totalData = res.length;
         
         $('div.emptyResult').hide();
         dataList = res;
         console.log("검색시에 totalData값: " + totalData); // 23
         
         $("div.cate_btn").removeClass("cate_selected");
         if (val2 == null) {
            $('div.cate_btn:last-child').addClass("cate_selected");
         }
         
         $("#faq_list_wrap > div.faq_contents").remove();
         displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
         $("div.faq_cont").hide();
         paging(totalData, dataPerPage, pageCount, 1);
         
         window.scrollTo(0,0);
      },
      error: function(request,status){ 
         console.log("검색 에러임");
      }
   });
}
</script>
</head>
<body>
   <div class="container faqWrap" id="contents">
   
   <div class="container faqHeadWrap blurblur">
      <div class="row faqTitle" style="justify-content: center;">
         <p><strong>자주 묻는 질문</strong></p>
      </div>
      
      <div class="container" id="faqSearchDiv">
      <button type="button" class="btn btn-warning faqallList" onclick="faqSearchfnc()">전체목록</button>
         <!-- 검색창 추가 -->
         <form action="/getFaqList" method="post" name="faqfrm">
            <div class="input-group mb-3">
            <label for="faqSearch"></label> 
            <select class="custom-select" name="faqSearch" id="faqSearch">
               <option value="title_keyword">제목</option>
               <option value="cont_keyword">내용</option>
            </select>
               <input type="text" class="form-control searchinputclass" name="faqSearchKeyword" placeholder="검색할 내용을 입력하세요" aria-label="faqSearchKeyword" id="faqSearchKeyword">
               <button type="button" class="btn btn-warning searchClick" onclick="faqSearchfnc($('#faqSearch').val(), $('#faqSearchKeyword').val())">검색</button>
            </div>
         </form>
      </div>
   </div>   
         
      <div class="container faqCateSearch">
         <!-- 자주묻는 질문 카테고리 선택 -->
         <div id="categoryList">
            <div class="row row-cols-6 rowCateBtn" style="text-align: center;">
               <div class="col cate_btn" onclick="faqSelect('회원')">회원</div>
               <div class="col cate_btn" onclick="faqSelect('리뷰')">리뷰</div>
               <div class="col cate_btn" onclick="faqSelect('예약')">예약</div>
               <div class="col cate_btn" onclick="faqSelect('병원')">병원</div>
               <div class="col cate_btn" onclick="faqSelect('기타')">기타</div>
               <div class="col cate_btn cate_selected" onclick="faqSelect('전체')">전체</div>
            </div>
         </div>
      </div>
      <div class="faqContentsCon container">
         <!-- 리스트 출력될 div -->
         <div id="displayCount"> </div>
         
         
         <div id="faq_list_wrap"> </div>
      
         <div class="row faq_cnt_row">
            <div id="faq_count" class="col"> </div>
         </div>
      </div>   
      </div>
      <%@ include file="../../footer.jsp"%>   
</body>
</html>
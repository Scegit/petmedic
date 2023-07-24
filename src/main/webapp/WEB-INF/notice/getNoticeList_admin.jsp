<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ include file="/header.jsp"%> --%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> --%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> --%>
<head>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous"> -->
<%-- <link rel="stylesheet" href="${ pageContext.request.contextPath }/css/noticeCSS.css" /> --%>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script> moment.js 라이브러리 로드 -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script> -->
<%-- <script src="${ pageContext.request.contextPath }/js/noticejs.js"></script> --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<%@ include file="../admin_user/adminPage.jsp"%>
<script>
var totalData; //총 데이터 수
var dataPerPage; //한 페이지에 나타낼 글 수
var pageCount = 5; //페이징에 나타낼 페이지 수
var globalCurrentPage= 1; //현재 페이지
var dataList; //표시하려하는 데이터 리스트

var noticeSearch = null;				// 검색 셀렉트 타입(제목, 내용)
var noticeSearchKeyword = $("#noticeSearchKeyword").val();	// 입력한 검색어

// 검색함수
function noticeSearchfnc(val1, val2){
	console.log('val', val1);
	console.log('val', val2);
	$.ajax({
		method: "post",
		url: "/searchNotice",
		data: {noticeSearch: val1, noticeSearchKeyword: val2 },
		cache: false,
		success: function(res){
			console.log("검색 성공");
			totalData = res.length;
			
			if (totalData => 0){ $('div.emptyResult').hide(); }
			
			dataList = res;
			console.log("totalData값: " + totalData);
			
			$(".noticeallList").show();
			if (val1 == null) { $(".noticeallList").hide(); }
			
			$("div.dataTableBody").children(".noticeContList").remove();
			displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
			paging(totalData, dataPerPage, pageCount, 1);
			pagingMore(totalData, dataPerPage, pageCount, 1);
		},
		error: function(request, status){
			console.log("검색 실패");
		}
	});
}

// 엔터키로 검색되도록한다
function enterKey(){
	if(window.event.keyCode == 13){
// 		alert('searchClick이 클릭된다');
		$('button.searchClick').click();
	}
}

$(document).ready(function(){
	// 엔터키 이벤트 추가
	$('#noticeSearchKeyword').on("keyup", function(e){
		if(e.keyCode == 13) {
// 			alert('searchClick이 된다');
			$('button.searchClick').click();
		}
	});

	// form의 submit 기능을 막는다
	ntcfrm.addEventListener('submit', e => {
		e.preventDefault();
	});	
	
	dataPerPage = 7;  // 한 페이지에 나타낼 글 수(10개) 
// 	dataPerPage = 10;  // 한 페이지에 나타낼 글 수(10개) 
	
	$.ajax({ 
		method: "POST",
		url: "/getNoticeList1",	// 전체 목록 조회
		data: { noticeSearch: $("#noticeSearch").val() },	
// 		dataType: "json",
// 		async:false,
		cache:false,
		success: function (res) {
			console.log(res);
			console.log("noticeSearch값:" , noticeSearch);
			totalData = res.length;
			
			dataList = res;
			console.log("totalData값: " + totalData); // 23
			
// 			$("div#moreNoticeDiv").hide();
			
			displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
			paging(totalData, dataPerPage, pageCount, 1);
			
			// 더보기 호출 (dataPerPage = 5로 보낸다)
			pagingMore(totalData, dataPerPage, pageCount, 1);
		},
		error: function(request, status){
			console.log("으아아아에러다");
		}
	});    
});

//현재 페이지(currentPage)와 페이지당 글 개수(dataPerPage) 반영

// displayData 함수 수정
function displayData(currentPage, dataPerPage) {
  let chartHtml = "";
  currentPage = Number(currentPage);
  dataPerPage = Number(dataPerPage);
  
  console.log("현재 페이지?", currentPage); // 1
  
  var maxData = Math.min(totalData, (currentPage - 1) * dataPerPage + dataPerPage); // i의 범위를 수정
  
  if ( totalData > 0 ) {
	      
	  for (var i = (currentPage - 1) * dataPerPage; i < maxData; i++) {
		  if (dataList[i].notice_pin == 1) {
			  chartHtml += "<div class=\"row noticeContList blurblur1 pinnedNotice\" onclick=\"selTr("+ dataList[i].notice_int + ")\"style=\"cursor: pointer;\"><div class=\"col-lg-2 col_noticeInt\">[공지]</div>"
		  } 
		  else {
			  chartHtml += "<div class=\"row noticeContList blurblur1\" onclick=\"selTr("+ dataList[i].notice_int + ")\"style=\"cursor: pointer;\"><div class=\"col-lg-2 col_noticeInt\">" +
			  				dataList[i].notice_int + "</div>"
		  }
	    
		  chartHtml += "<div class=\"col-lg-5 col_noticeTitle\" id=\"notice_title\">" +
				      dataList[i].notice_title +
				      "</div><div class=\"col-lg-2 col_noticeAdmin\" id=\"notice_admin\">" +
				      dataList[i].notice_admin +
				      "</div><div class=\"col-lg-2 col_noticeDate\" id=\"notice_date\">" +
				      moment(dataList[i].notice_date).format("YYYY-MM-DD") + // moment 함수 사용
				      "</div><div class=\"col-lg-1 col_noticeCnt\" id=\"notice_readcount\">" +
				      dataList[i].notice_readcount +
				      "</div></div>";
	  }
  } else {
	  chartHtml += "<div class=\"row emptyResult\"><span> 공지사항이 없습니다 </span></div>";
  }
  $("div.dataTableBody").append(chartHtml);
}

// 페이징처리
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
    let next = Number(currentPage) + 1;
    let prev = Number(currentPage) - 1;

    let pageHtml = "";

    if (prev > 0) {
      pageHtml += "<div class=\"col ntcWebCnt\"><a href='javascript:void(0)' id='prev'> <이전 </a></div>";
    }

   //페이징 번호 표시 
    for (var i = startPage; i <= endPage; i++) {
      if (currentPage == i) {
        pageHtml +=
          '<div class="col ntcWebCnt notpagingNow"><a href="javascript:void(0)" id="' + i + '">' + i + '</a></div>';
      } else {
        pageHtml += "<div class=\"col ntcWebCnt\"><a href='javascript:void(0)' id='" + i + "'>" + i + "</a></div>";
      }
    }
   
      console.log("토탈 : "+ totalPage);
      console.log("엔드 : "+ endPage);
      console.log("지금 : "+ currentPage);
      console.log("다음 : "+ next);
   
    if (next <= totalPage) {
      pageHtml += '<div class="col ntcWebCnt"><a href="javascript:void(0);" id="next"> 다음> </a></div>';
    }

    $("#pagingul").html(pageHtml);
    let displayCount = "";
    displayCount = "현재 " + currentPage + "페이지 (총 " + totalPage + " 페이지 / " + totalData + "건)";
    $("#displayCount").text(displayCount);


    //페이징 번호 클릭 이벤트 
    $("#pagingul .ntcWebCnt a").click(function () {
      let $id = $(this).attr("id");
      selectedPage = $(this).text();

      if ($id == "next") selectedPage = next;
      if ($id == "prev") selectedPage = prev;
      
      $("div.dataTableBody").children(".noticeContList").remove();
      
      //전역변수에 선택한 페이지 번호를 담는다...
      globalCurrentPage = selectedPage;
   
      console.log("클릭시 글로벌 "+globalCurrentPage);
      
      //글 목록 표시 재호출
      displayData(globalCurrentPage, dataPerPage);
      //페이징 표시 재호출
      paging(totalData, dataPerPage, pageCount, globalCurrentPage);
    });
  }
  
// 모바일 반응형에서는 페이징이 아니라 [더보기] 처리하기
  function pagingMore(totalData, dataPerPage, pageCount, currentPage) {
	    console.log("currentPage : " + currentPage);
	    console.log("pageCount : " + pageCount);
	    console.log("totalData : " + totalData);

	    totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수
	    
	    if(totalPage < pageCount){
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
	   
	      console.log("토탈 : "+ totalPage);
	      console.log("엔드 : "+ endPage);
	      console.log("지금 : "+ currentPage);
	      console.log("다음 : "+ next);
	   
	    if (next <= totalPage) {
	      pageHtml += '<span><a href="javascript:void(0);" id="next"> 더보기 (총 ' + totalData + '건)</a></span>';
	    }

	    $("#moreNoticeDiv").html(pageHtml);

	    //페이징 번호 클릭 이벤트 
	    $("#moreNoticeDiv span a").click(function () {
	      let $id = $(this).attr("id");
	      selectedPage = $(this).text();

	      if ($id == "next") selectedPage = next;
// 	      if ($id == "prev") selectedPage = prev;
	      
	      //전역변수에 선택한 페이지 번호를 담는다...
	      globalCurrentPage = selectedPage;
	   
	      console.log("클릭시 글로벌 "+globalCurrentPage);
	      
	      //글 목록 표시 재호출
	      displayData(globalCurrentPage, dataPerPage);
	      //페이징 표시 재호출
	      pagingMore(totalData, dataPerPage, pageCount, globalCurrentPage);
	    });
	  }
  
</script>
</head>
<body>
	<div class="container noticeWrap">
	
	<div class="container noticeHeadWrap blurblur1">
<!-- 		<div class="row noticeTitle" style="justify-content: center;"> -->
<!-- 		</div> -->
		
		<!-- 검색창(select, input, button) -->
		<div class="container" id="noticeSearchDiv" style="text-align: center;">
<!-- 			<div class="row noticeallbutton"> -->
<!-- 				<button type="button" class="btn btn-warning noticeallList" onclick="location.reload()">전체목록</button> -->
<!-- 			</div> -->
			
			<form action="/searchNotice" method="post" name="ntcfrm">
				<div class="input-group mb-3">
					<label for="noticeSearch"></label> 
					<select class="custom-select" name="noticeSearch" id="noticeSearch">
						<option value="title_keyword">제목</option>
						<option value="cont_keyword">내용</option>
					</select>
					<input type="text" class="form-control searchinputclass" name="noticeSearchKeyword" placeholder="검색할 내용을 입력하세요" aria-label="noticeSearchKeyword" id="noticeSearchKeyword">
					<button type="button" class="btn searchClick" onclick="noticeSearchfnc($('#noticeSearch').val(), $('#noticeSearchKeyword').val() )">검색</button>
				</div>
			</form>
		</div>
	</div>
		
		<div class="noticeContents container">
			<!-- ajax로 페이징 처리 -->
			<!-- 페이지정보출력 -->
			<div class="row disNotiCount">
				<div class="col noticeallbutton">
					<button type="button" class="btn btn-warning noticeallList" onclick="location.reload()">전체목록</button>
				</div>
				<span id="displayCount"></span>
			</div>
			
			
			<div class="col">
				<div class="row noticeTh">
					<div class="col-lg-1 col_noticeInt">번호</div>
					<div class="col-lg-6 col_noticeTitle">글제목</div>
					<div class="col-lg-2 col_noticeAdmin">작성자</div>
					<div class="col-lg-2 col_noticeDate">게시일</div>
					<div class="col-lg-1 col_noticeCnt">조회수</div>
				</div>
			</div>
			<!-- 데이터 동적으로 추가 -->
			<div class="col dataTableBody" id="dataBodyNotice" >
			</div>
		</div>
		
		<!--  웹사이즈 페이징 -->
		<div class="row" id="pageNoticeDiv">
			<div class="row noticepaging" id="pagingul"> </div>
		</div>		
		
		<!--  반응형 페이징(더보기) -->
		<div class="container" id="moreNoticeDiv"></div>
	</div>

</body>

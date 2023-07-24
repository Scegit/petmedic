<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/header.jsp"%>
<%-- <%@ include file="/menu.jsp"%> --%>
<%@ include file="../admin_user/adminPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous"> -->
<%-- <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/faqCSS.css"> --%>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script> -->
<%-- <script src="${ pageContext.request.contextPath }/resources/js/faqjs.js"></script> --%>
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
	$('#faqSearchKeyword_admin').on("keyup", function(e){
		console.log(e);
		if(e.keyCode == 13){
// 			alert('searchClick이 클릭된다');
			$('button.searchClick').click();
		}
	});
	
	// submit 기능을 막는다 (엔터키로 실행시 input이 하나면 submit이 실행되기 때문에 막아줘야함)
	faqfrm.addEventListener('submit', e => {
		e.preventDefault();
	});		
	
	// 페이징 여기부터 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
	dataPerPage = 5;  // 한 페이지에 나타낼 글 수 
		
	$.ajax({ 
		method: "POST",
		url: "/getFaqList",	// 전체 목록 조회
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
			$(".faq_cont_admin").hide();
		},
		error: function(request, status){
			console.log("으아아아에러다");
		}
	});    
});

//displayData 함수 수정
function displayData(currentPage, dataPerPage) {
	let faqHtml = "";
	currentPage = Number(currentPage); 
	dataPerPage = Number(dataPerPage); 
		  
	console.log("현재 페이지?", currentPage); 
		  
	var maxData = Math.min(totalData, (currentPage - 1) * dataPerPage + dataPerPage); // i의 범위를 수정
		  console.log('users_role: ' , '${users_role}');
	if ( totalData > 0 ) {
		for (var i = (currentPage - 1) * dataPerPage; i < maxData; i++) {
			faqHtml += "<div class=\"faq_contents_admin container\"> <div class=\"row faq_title_admin\">"
	               + "<div class=\"col-2\">" + dataList[i].faq_cate + "</div>" 
	               + "<div class=\"col-9\">" + dataList[i].faq_title + "</div></div>"
	               + "<div class=\"row faq_cont_admin\"><div class=\"col faq_cont_cont\">" + dataList[i].faq_cont + "</div>";
				
	               if('${users_role}' == 'ADMIN' || '${users_role}' == 'SUPERADMIN'){
					faqHtml +="<div class=\"modi_del col\" id=\"modi_del\">"
					+ "<span onclick=\"goFaqModi("+ dataList[i].faq_int +")\" style=\"cursor:pointer;\">수정</span> &nbsp;&nbsp;&nbsp;"
					+ "<span onclick=\"faqDel("+ dataList[i].faq_int +")\" style=\"cursor:pointer;\">삭제</span></div></div>";
				}
				faqHtml +="</div>" ;
		}
	} else {
		faqHtml += "<div class=\"col emptyResult\">해당하는 데이터가 없습니다</div>";
	}
// 	$("#faq_list_wrap").prepend(faqHtml);
	$("#faq_list_wrap_admin").html(faqHtml);
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

	if (prev > 0) {
		pageHtml += "<div class=\"col adminNotCnt\"><a href='javascript:void(0)' id='prev'> <이전 </a></div>";
	}

	//페이징 번호 표시 
	for (var i = startPage; i <= endPage; i++) {
		if (currentPage == i) {
			pageHtml += '<div class="col adminNotCnt faqpagingNow"><a href="javascript:void(0)" id="' + i + '">' + i + '</a></div>';
		} else {
			pageHtml += "<div class=\"col adminNotCnt\"><a href='javascript:void(0)' id='" + i + "'>" + i + "</a></div>";
		}
	}
		   
	console.log("토탈 : "+ totalPage);
	console.log("엔드 : "+ endPage);
	console.log("지금 : "+ currentPage);
	console.log("다음 : "+ next);
		   
	if (next <= totalPage) {
		pageHtml += '<div class=\"col adminNotCnt\"><a href="javascript:void(0);" id="next"> 다음> </a></div>';
	}

	$("#faq_count_admin").html(pageHtml);
	let displayCount = "";
	displayCount = "현재 " + currentPage + "페이지 / 전체 1 -" + totalPage + " 페이지 / " + totalData + "건";
	$("#displayCount_admin").text(displayCount);


	//페이징 번호 클릭 이벤트 
	$("#faq_count_admin a").click(function () {
		let $id = $(this).attr("id");
		selectedPage = $(this).text();

		if ($id == "next") selectedPage = next;
		if ($id == "prev") selectedPage = prev;
		      
		$("#faq_list_wrap_admin > div#faq_contents_admin").remove();
		$(this).children("div.adminNotCnt").addClass("faqpagingNow");
		      
		//전역변수에 선택한 페이지 번호를 담는다...
		globalCurrentPage = selectedPage;
		   
		console.log("클릭시 글로벌 "+globalCurrentPage);
		      
		//글 목록 표시 재호출
		displayData(globalCurrentPage, dataPerPage);
		$("div.faq_cont_admin").hide();
		//페이징 표시 재호출
		paging(totalData, dataPerPage, pageCount, globalCurrentPage);
	});
}
	
// FAQ 제목 클릭시 해당하는 FAQ 내용을 toggle로 보여줌
$(document).on('click', 'div.faq_title_admin', function() {
    var $this = $(this);
    var $cont = $this.next("div.faq_cont_admin");
    // 클릭된 faq_title에서 해당하는 faq_cont를 찾음 faq_cont를 toggle로 보여주거나 숨김 처리
    $cont.toggle();
    // 클릭된 요소와 다른 모든 faq_title_admin 요소의 faq_cont_admin를 숨김 처리
    $('div.faq_title_admin').not($this).next("div.faq_cont_admin").hide();
});
	
// 카테고리 클릭시 css 적용하기
$(document).on('click', 'div.cate_btn_admin', function(){
	$("div.cate_btn_admin").removeClass("cate_selected");
	$(this).addClass("cate_selected");
});

//카테고리 선택시 변경되는 값에 따라 리스트를 다시 가져온다
function faqSelect(val){
	console.log(val);	//'회원가입'
	
	$.ajax({
		method: "POST",
		url: "/getFaqList",
		data: {'faq_cate_btn': val},		
		cache: false,
		success: function(listpage){
			console.log("검색 성공");
			totalData = listpage.length;
			
			dataList = listpage;
			console.log("totalData값: " + totalData); // 23
			
			$("#faq_list_wrap_admin > div#faq_contents").remove();
			displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
			$(".faq_cont_admin").hide();
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
			
			if (totalData => 0){ $('tr.emptyResult').hide(); }
			
			dataList = res;
			console.log("검색시에 totalData값: " + totalData); // 23
			
			$("#faq_list_wrap_admin > div#faq_contents").remove();
			displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
			$("div.faq_cont_admin").hide();
			paging(totalData, dataPerPage, pageCount, 1);
		},
		error: function(request,status){ 
			console.log("검색 에러임");
		}
	});
}

</script>
</head>
<body>
<div class="container" id="faqWrap_admin">
	<div class="container faqHeadWrap_admin">
		<div class="row faqTitle_admin">
			<div class="col">
				<h4>자주 묻는 질문 관리</h4>
			</div>
		</div>
	</div>

			<!-- 검색창 추가 -->
		<div class="container" id="faqAdminSearch_admin">
		<div class="row">
			<div class="col-2 intoWriteFaq">
				<a href="toInsertFAQ">등록하기</a>
			</div>
		
			<div class="col">
			<form action="/getFaqList" method="post" name="faqfrm">
				<div class="input-group">
					<label for="faqSearch"></label> 
					<select class="custom-select" name="faqSearch" id="faqSearch_admin">
						<option value="title_keyword">제목</option>
						<option value="cont_keyword">내용</option>
					</select>
					<input type="text" class="form-control" name="faqSearchKeyword" placeholder="검색어를 입력해라" aria-label="faqSearchKeyword" id="faqSearchKeyword_admin">
					<button type="button" class="btn btn-warning searchClick" onclick="faqSearchfnc($('#faqSearch_admin').val(), $('#faqSearchKeyword_admin').val())">검색</button>
				</div>
			</form>
		</div>
		</div>
		</div>
			
			<div class="container" id="into_insertfaq">
				<div class="row">
					
				</div>
			</div>
			
			
			<div class="container" id="faqContents_admin">
			<!-- 자주묻는 질문 카테고리 선택 -->
			<div id="categoryList_admin" class="row ">
				<div class="row rowCateBtn_admin">
					<div class="col cate_btn_admin" onclick="faqSelect('회원')">회원관련</div>
					<div class="col cate_btn_admin" onclick="faqSelect('리뷰')">리뷰관련</div>
					<div class="col cate_btn_admin" onclick="faqSelect('예약')">예약관련</div>
					<div class="col cate_btn_admin" onclick="faqSelect('병원')">병원관련</div>
					<div class="col cate_btn_admin" onclick="faqSelect('기타')">기타</div>
					<div class="col cate_btn_admin cate_selected" onclick="faqSelect('전체')">전체</div>
				</div>
			</div>
			
			<div id="displayCount_admin" class="row"> 
			</div>
			
			<!-- 리스트 출력될 div -->
			<div id="faq_list_wrap_admin" class="row">	<!-- 높이값주기? -->
			</div>
			
			<div  class="row faq_cntwrap_admin"> 
				<div id="faq_count_admin" class="row"> </div>
			</div>
		</div>
	</div>
			
</body>
</html>
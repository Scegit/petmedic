<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link rel="stylesheet" type="text/css" href="./css/getAllReportList.css">
<script>
//상세보기 controller 이동
function rv(val){
location.href="getReport?rev_hos_seq="+val;
}

</script>

</head>
<body>
	<div id="allcontainer">
		<div class="container reviewList">
			<h1 id="reviewh1">리뷰신고내역</h1>
			<div class="reviewContents">

				<form action="/getReportList" method="post">
					<div class="row allserch">
						<button class="btn" id="allListbtn"
							onclick="location.href='getReportList.jsp'">전체목록</button>
						<label for="searchCondition"> </label> 
						<select class="custom-select" id="searchCondition" name="searchCondition"
							style="display: inline-block !important; margin-right: 10px;">
							<c:forEach items="${searchMap}" var="searchMap">
								<option value="${searchMap.value}"
									<c:if test="${searchMap.value eq searchCondition}">selected</c:if>>${searchMap.key}
								</option>
							</c:forEach>
							<div class="searchKeyword_Div">
								<input type="text" class="form-control" id="searchKeyword" 
								name="searchKeyword" placeholder="병원명을 검색하세요.">
								<button class="btn" onclick="dateCheck()">
									<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAVFJREFUSEvVleExBEEQRt9FQAoiQATIgAgQASJABIgAESACZEAEyIAIqKd6qub2Zmen7N4P/eu2dqdf99dfz81YcsyWnJ8+wCpwBOwCG1HEC3APXAGfrYWVAAfABSCkFCY/AW5aIF2Aya/j4ANwCTzF8zZwBmzF8150VOXkACt+i8oPKxUKOQ2Z1obkygHpoJWrfS3syk7Oo6veb3OAQ1wHdjJZ+g4q1yPgmc1aJTngOz5stW7T92MBXxW3/db7V4mc0R3wDChX0wzSkF0mLdgyZPdBKzcBtOk7sBLO0CGlSIV8xJZXt7o70NS6ibWiyZTBUAr9nyQZtGh3Bqlat9m27aQUDtb3wrSpv2/7NKpddsexcO6G8RpXgwmVJe2N77yX3P6FaPV86Wx+b/VCxgBS0v2MvtDJWMAgZApAFzJ3E08FSBCtPfdHNCWg6NT/D/gBeOVFGZeTouUAAAAASUVORK5CYII=" />
								</button>


							</div>
						</select>
					</div>
				</form>
			</div>
			<span id="displayCount"> </span>
			<div class="container" id="reportListTableDiv">
				<table class="reportListTable" id="reportListTable">
					<tr>
						<th scope="col">번호</th>
						<th scope="col">병원명</th>
						<th scope="col">등록일</th>
						<th scope="col">삭제처리</th>
					</tr>
					<tbody id="dataTableBody"> </tbody>
				</table>
				<ul id="pagingul"> </ul>
			</div>
		</div>
	</div>
	<script>

var totalData; //총 데이터 수

// 230521 소미 수정
var dataPerPage = 10; //한 페이지에 나타낼 글 수


var pageCount = 10; //페이징에 나타낼 페이지 수
var globalCurrentPage= 1; //현재 페이지
var dataList; //표시하려하는 데이터 리스트
var searchKeyword;
var searchCondition;

$(document).ready(function(){
	searchKeyword = $("#searchKeyword").val();	// 입력한 검색어
	searchCondition = $("#searchCondition").val();//검색 셀렉트 타입(제목, 내용)
	
	dataList = ${rpl};
	
	totalData = dataList.length;
	
	displayData(1, dataPerPage);
	paging(totalData, dataPerPage, pageCount, 1);
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
	    chartHtml +=
	      "<tr class=\"listTr\" onclick=\"rv("+ dataList[i].rev_hos_seq + ")\"style=\"cursor: pointer;\"><td>" +
	      dataList[i].rev_hos_seq +
	      "</td><td>" +
	      dataList[i].hos_name +
	      "</td><td>" +
	      moment(dataList[i].rev_date).format("YYYY-MM-DD") + // moment 함수 사용
	      "</td><td>" +
	      (dataList[i].rev_req === "N" ? "접수" : (dataList[i].rev_req === "Y" ? "삭제" : "반려")) + // Conditional operator used here
	      "</td></tr>";
	  }
  } else {
	  chartHtml += "<tr><td colspan=\"4\"> 해당하는 데이터가 없습니다 </td></tr>";
  }
  $("#dataTableBody").append(chartHtml);
}

// paging(23, 10, 5, 1)
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
      pageHtml += "<li><a href='javascript:void(0)' id='prev'> < 이전 </a></li>";
    }

  //페이징 번호 표시 
    for (var i = startPage; i <= endPage; i++) {
      if (currentPage == i) {
        pageHtml +=
          '<li class="on"><a href="javascript:void(0)" id="' + i + '">' + i + '</a></li>';
      } else {
        pageHtml += "<li><a href='javascript:void(0)' id='" + i + "'>" + i + "</a></li>";
      }
    }
   
      console.log("토탈 : "+ totalPage);
      console.log("엔드 : "+ endPage);
      console.log("지금 : "+ currentPage);
      console.log("다음 : "+ next);
   
    if (next <= totalPage) {
      pageHtml += '<li><a href="javascript:void(0);" id="next"> 다음 > </a></li>';
    }

    $("#pagingul").html(pageHtml);
    let displayCount = "";
//     displayCount = "현재 " + currentPage + "페이지 / 전체 1 -" + totalPage + " 페이지 / " + totalData + "건";
    $("#displayCount").text(displayCount);


    //페이징 번호 클릭 이벤트 
    $("#pagingul li a").click(function () {
      let $id = $(this).attr("id");
      selectedPage = $(this).text();

      if ($id == "next") selectedPage = next;
      if ($id == "prev") selectedPage = prev;
      
      $("#dataTableBody").children(".listTr").remove();
      
      //전역변수에 선택한 페이지 번호를 담는다...
      globalCurrentPage = selectedPage;
   
      console.log("클릭시 글로벌 "+globalCurrentPage);
      
      //글 목록 표시 재호출
      displayData(globalCurrentPage, dataPerPage);
      //페이징 표시 재호출
      paging(totalData, dataPerPage, pageCount, globalCurrentPage);
    });
    
  }
</script>
</body>
</html>
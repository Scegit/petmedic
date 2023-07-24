<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 활동</title>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script> <!-- moment.js 라이브러리 로드 -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
   button:active, button:focus { outline: none!important; box-shadow:none !important; }
   button#resbtn { background-color:#B9BBDF; color:#fff; } 
   button#resbtn:hover { background-color:#878ECD; color:#fff; } 
   button#zzimbtn { background-color:#B9BBDF; color:#fff; }
   button#zzimbtn:hover { background-color:#878ECD; color:#fff; }
   button#resModiSubBtn { background-color:#B9BBDF; color:#fff; border:none;}
   button#resModiSubBtn:hover { background-color:#878ECD; color:#fff;  border:none;}
   button#resBackBtn { background-color:#B9BBDF; color:#fff;  border:none;}
   button#resBackBtn:hover { background-color:#878ECD; color:#fff;  border:none;}
   button#canceledBtn { background-color:white; color:#EF3333; cursor:default; }
   button#resbtnread { background-color:white; color:#fff; cursor:default; }
   
    div.flex-container { display:flex; flex-direction:row;}
    hr { margin-bottom:0; }
   div#actList { align-items: center; border-bottom: 1px solid #eee; padding:5px 8px;}
   div#actZzimList { align-items: center; border-bottom: 1px solid #eee; padding:5px 0; }
   div#actList > .row, div#actZzimList > .row { margin:0; }
   
   ul {
       text-align: center;
       display: inline-block;
       border: 1px solid #ccc;
       border-right: 0;
      padding-left :0;
   }
   ul li {
       text-align: center;
       float: left;
      list-style:none;
   }
   
   ul li a {
       display: block;
       font-size: 14px;
      color: black;
       padding: 9px 12px;
       border-right: solid 1px #ccc;
       box-sizing: border-box;
      text-decoration-line:none;
   }
   
   ul li.on {
       background: #DDE7F2;
   }
   
   ul li.on a {
       color: #fff;
   }
</style>
<script>
// 로그인된 유저의 아이디로 정보를 가져온다 이거야 
var uid = '<%= (String) session.getAttribute("users_id") %>'; 

$(document).ready(function(){
   // 페이지가 실행되자마자 실행해서 유저의 찜 목록을 가져온다이거야 [UsersController를 탄다]
   $.ajax({
      method: "post",
      url: "/getUsersHos",
      data: {"users_id": uid},
      dataType: "json", // 데이터 형식을 JSON으로 지정
      cache: false,
      success: function(res){               
         console.log('회원정보를 가져온다 이거야');
         console.log('로그인된 아이디', uid);
         var userList = res;                        // res 변수가 JSON 형식으로 변환됨
         
         // userList에서 저장하고있는 찜병원 아이디(목록)
         console.log("찜1 ", userList[0].users_pick1);
         console.log("찜2 ", userList[0].users_pick2);
         console.log("찜3 ", userList[0].users_pick3);
         console.log("찜4 ", userList[0].users_pick4);
         console.log("찜5 ", userList[0].users_pick5);
         
         getZzimHosName(userList[0].users_pick1, userList[0].users_pick2, userList[0].users_pick3, userList[0].users_pick4, userList[0].users_pick5, userList);
      },
      error: function(request, status){
         console.log('정보가져오기 에러');
         console.log('로그인된 아이디', uid);
      }
   });
   

   // 페이지를 열자마자 실행되어서 유저의 예약내역을 가져온다 이거야
   $.ajax({
      method: "post",
      url: "/getMyReserve",
      data: {"res_users_id": uid},
      dataType: "json",
      cache: false,
      success: function(res){
         
         $('#MyResModify').hide();
         
         console.log('데이터를 가져올 유저이름: ', uid)
         console.log('ajax > 유저 예약내역 가져오기 성공~~~');
//          console.log("예약내역1 : ", res[0].hos_name);
//          console.log("예약내역2 : ", res[0].res_date);
//          console.log("예약내역3 res_hos_id: ", res[0].res_hos_id);
//          console.log("예약내역3 의 취소여부 (y: 취소): ", res[0].res_cancel);
         
         // 데이터 동적쿼리로 추가할 함수 호출
         getMyResList(res);   // 리턴받은 List를 매개변수로 보냄
         
      }, error: function(request, status){
         console.log('ajax > 유저 예약내역 가져오기 오류');
      }
   });
});

// 예약목록 페이징 처리
var pageCount = 5;      // 나타낼 페이지의 개수 [이전][1][2][3][4][5][다음] > 5개
var dataPerPage = 5;   // 한 페이지에 보여질 글의 개수 
var dataList;

// 예약내역 목록 동적쿼리로 ".myactionReserve" div안에 추가하기
function getMyResList(val){ // 리턴받은 List를 매개변수로 보냄
   console.log("목록가져올 res: " , val);
   
   dataList = val;
   totalData = val.length;   // 총 리스트의 개수
   console.log("totalData 전체목록 개수", totalData);

   displayData(1, dataPerPage); // displayData 함수를 호출합니다.
   paging(totalData, dataPerPage, pageCount, 1);   // 페이징처리
}

//displayData 함수 수정
function displayData(currentPage, dataPerPage) {   
   var listHtml = "";
   currentPage = Number(currentPage); 
   dataPerPage = Number(dataPerPage); 
        
   console.log("현재 페이지?", currentPage); 
        
   var maxData = Math.min(totalData, (currentPage - 1) * dataPerPage + dataPerPage); // i의 범위를 수정
//    console.log("maxData값은? " , maxData);   
//    console.log("dataList에 담긴 0번 인덱스의 취소여부(y: 취소) : ", dataList[0].res_cancel);
   
   // 예약리스트 
   // 반복해서 화면에 출력해줄 i의 범위를 정함 => 2번 페이지를 눌렀을 때 : i = (2-1)*5 => 5; i<6; i++
   if(totalData > 0) {   
      for(var i = (currentPage - 1) * dataPerPage; i < maxData; i++){
         let date1 = new Date();   // 오늘날짜
         let date2 = new Date(dataList[i].res_date);   // 예약일자
         let cashdate = new Date(dataList[i].res_cashdate);   // 결제일자
         
         listHtml += "<div class=\"row\" id=\"actList\">" 
               + "<div class=\"col-sm\" style=\"display:none;\"><span>" + dataList[i].res_seq +"</span></div>" 
               + "<div class=\"col-sm\" style=\"display:none;\"><span>" + dataList[i].res_hos_id +"</span></div>" 
               + "<div class=\"col-sm\" style=\"text-align:center;\"><span>"+ moment(date2).format('YYYY-MM-DD') +"</span></div>" 
               + "<div class=\"col-sm\"><span>" + dataList[i].hos_name +"</span></div>" 
               + "<div class=\"col-sm\" style=\"text-align:center;\"><span>"+  moment(cashdate).format('YYYY-MM-DD') +"</span></div>" 
         if((dataList[i].res_cancel)=='Y'){   // 취소된 예약내역일 경우 출력
            listHtml += "<div class=\"col-sm\" style=\"text-align:center;\"><button type=\"button\" class=\"btn\" id=\"canceledBtn\"> 취소완료&nbsp;&nbsp; </button></div></div>"
         } else { // N일때 이거를 타는데
            if(date2 > date1) { // 예약일자가 오늘날짜보다 클 때 
               listHtml += "<div class=\"col-sm\" style=\"text-align:center;\">"
                     + "<button type=\"button\" class=\"btn resCancel\" id=\"resbtn\" onClick=\"resCancel("+ dataList[i].res_seq +")\">취소</button></div></div>" 
            } 
            if(date2 < date1){   // 예약일자가 오늘날짜보다 적을 때 > 공간유지를 위해 출력
               listHtml += "<div class=\"col-sm\" style=\"text-align:right;\"><button type=\"button\" class=\"btn\" id=\"resbtnread\">지난 예약&nbsp;&nbsp;&nbsp;</button></div></div>" 
            }
         }
         listHtml += "";
      }
   } else { 
         listHtml += "<div class=\"row\" id=\"emptyRes\" style=\"text-align:center; align-items:center;\"><span>예약내역이 없습니다</span></div>"; 
   }
   
   $('#actListPageDiv').before(listHtml);
}

// 페이지네이션
function paging(totalData, dataPerPage, pageCount, currentPage) { 
   console.log("currentPage : " + currentPage);
   console.log("pageCount : " + pageCount);
   console.log("totalData : " + totalData);

   totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수   [올림처리하는 함수]
          
   if(totalPage < pageCount){    
      pageCount = totalPage;      
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

   // [이전]버튼 만드는 if문
//    if (prev > 0) { 
//       pageHtml += "<li><a href='javascript:void(0)' id='prev'> 이전 </a></li>";
//    }

   // 페이징 번호 표시 
//    for (var i = startPage; i <= endPage; i++) { 
//       if (currentPage == i) {   
//          pageHtml += '<li class="on"><a href="javascript:void(0)" id="' + i + '">' + i + '</a></li>';
//       } else {
//          pageHtml += "<li><a href='javascript:void(0)' id='" + i + "'>" + i + "</a></li>";
//       }
//    }
         
   console.log("토탈 : "+ totalPage);
   console.log("엔드 : "+ endPage);
   console.log("지금 : "+ currentPage);
   console.log("다음 : "+ next);
         
//    if (next <= totalPage) {   
//       pageHtml += '<li><a href="javascript:void(0);" id="next"> 다음 </a></li>';
//    }
   if (next <= totalPage) {   
      pageHtml += '<li><a href="javascript:void(0);" id="next"> 더보기 </a></li>';
   }
   
//    if (next = (totalPage-1)){
//       pageHtml += '<li><a href="javascript:void(0);" id="prev"> 접기 </a></li>';
//    }

   $("#actListPage").html(pageHtml);
   
   // 현재 페이지, 토탈 페이지 등 정보를 텍스트로 출력
   let displayCount = "(" + totalData + "건" + ")";
   $(".reserveCnt").text(displayCount);

   //페이징 번호 클릭 이벤트 
   $("#actListPage li a").click(function () {
      let $id = $(this).attr("id");
      selectedPage = $(this).text();

      if ($id == "next") selectedPage = next;
      if ($id == "prev") selectedPage = prev;
            
//       $("div.myactionReserve > div#actList").remove();
            
      //전역변수에 선택한 페이지 번호를 담는다...   // 2페이지 클릭시 값은 2가 된다.
      globalCurrentPage = selectedPage;
         
      console.log("클릭시 글로벌 " + globalCurrentPage);
      console.log("클릭시 데이타퍼페이지" , dataPerPage);    
      //글 목록 표시 재호출
      displayData(globalCurrentPage, dataPerPage);
      //페이징 표시 재호출
      paging(totalData, dataPerPage, pageCount, globalCurrentPage);
   });
}

// 찜 목록 병원 이름가져오기 (매개변수: 병원의 아이디값)
function getZzimHosName(val1, val2, val3, val4, val5, userList){
   $.ajax({
      method: "post",
      url: "/getZzimHosName",
      dataType: "json",
      data:{"users_id": uid, "users_pick1": val1, "users_pick2": val2, "users_pick3": val3, "users_pick4": val4, "users_pick5": val5},
      cache: false,
      success: function(res){   
         console.log('찜병원 목록의 병원 이름을 가지고올거야');
         var zzim = res;
         
         console.log("res", res);
         
         delList(zzim, userList);
      }, error: function(request, status){
         console.log('에러에러');
      }
   });
}

// 찜한 병원 목록을 보여주기(동적코드) : 병원이름을 눌러서 상세페이지로 이동하거나 삭제버튼으로 찜삭제
function delList(zzim, userList){
   var zzimhtml = ""; 
   // 찜병원id를 가지고와서 버튼을 눌렀을때 delZzim(찜목록에서 삭제할 병원아이디, hos1 등 지정값)을 파라미터로 전송하여 함수호출
//    if(zzim == null) { 
//          zzimhtml += "<p>찜한 병원이 없습니다</p>"; 
//    } else {
   $.each(userList, function(index, item) {
	  if(item.users_pick1 == null &&  item.users_pick2 == null && item.users_pick3 == null && item.users_pick4 == null && item.users_pick5 == null) {
		  zzimhtml += "<p>찜한 병원이 없습니다</p>"; 
		 }
      if(item.users_pick1){ 
         zzimhtml += "<div class=\"row\" id=\"actZzimList\"><div class=\"col-sm-8\"><a onClick=\"getHosDetail('"+item.users_pick1+"')\">" 
         + zzim[0].users_hos_name1 + "</a></div>" + "<div class=\"col-sm-4\">" 
         + "<button type=\"button\" class=\"btn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick1 +"', 'hos1')\">삭제</button>" 
         + "</div></div>"; 
      }
      if(item.users_pick2){
         zzimhtml += "<div class=\"row\" id=\"actZzimList\"><div class=\"col-sm-8\"><a onClick=\"getHosDetail('"+item.users_pick2+"')\">" 
         + zzim[0].users_hos_name2 + "</a></div>" + "<div class=\"col-sm-4\">" 
         + "<button type=\"button\" class=\"btn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick2 +"', 'hos2')\">삭제</button>" 
         + "</div></div>"; 
      }
      if(item.users_pick3){
         zzimhtml += "<div class=\"row\" id=\"actZzimList\"><div class=\"col-sm-8\"><a onClick=\"getHosDetail('"+item.users_pick3+"')\">" 
         + zzim[0].users_hos_name3 + "</a></div>" + "<div class=\"col-sm-4\">" 
         + "<button type=\"button\" class=\"btn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick3 +"', 'hos3')\">삭제</button>" 
         + "</div></div>"; 
      }
      if(item.users_pick4){
         zzimhtml += "<div class=\"row\" id=\"actZzimList\"><div class=\"col-sm-8\"><a onClick=\"getHosDetail('"+item.users_pick4+"')\">" 
         + zzim[0].users_hos_name4 + "</a></div>" + "<div class=\"col-sm-4\">"  
         + "<button type=\"button\" class=\"btn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick4 +"', 'hos4')\">삭제</button>" 
         + "</div></div>"; 
      }
      if(item.users_pick5){
         zzimhtml += "<div class=\"row\" id=\"actZzimList\"><div class=\"col-sm-8\"><a onClick=\"getHosDetail('"+item.users_pick5+"')\">" 
         + zzim[0].users_hos_name5 + "</a></div>" + "<div class=\"col-sm-4\">" 
         + "<button type=\"button\" class=\"btn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick5 +"', 'hos5')\">삭제</button>" 
         + "</div></div>"; 
      }
   });
//       }
   
   $(".myactionZzim").append(zzimhtml);
}

// 찜목록에서 병원이름을 눌렀을 때 상세페이지로 이동하게 해주기
function getHosDetail(val){   
   console.log("상세정보를 볼 병원아이디 ",val);
   hos_id = val;
   location.href="/getHos?hos_id=" + hos_id;   // hosDetail.jsp 페이지를 열어준다
}

// 삭제버튼으로 찜목록에서 병원 삭제하기
function delZzim(del, hos){
   alert('삭제하시겠습니까? 삭제 후에는 취소할 수 없습니다.');
   console.log('찜삭제 함수호출 병원아이디', del);
   console.log('찜삭제 병원 번호 ', hos);
   
   if (hos == "hos1"){
      console.log('1로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick1=" + del + "&delZzim=" + hos ;
   } else if (hos == "hos2"){
      console.log('2로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick2=" + del + "&delZzim=" + hos ;
   } else if (hos == "hos3"){
      console.log('3으로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick3=" + del + "&delZzim=" + hos ;
   } else if (hos == "hos4") {
      console.log('4로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick4=" + del + "&delZzim=" + hos ;
   } else if (hos == "hos5") {
      console.log('5로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick5=" + del + "&delZzim=" + hos;
   }
}
   
// 취소버튼을 누르면 예약을 취소한다
function resCancel(val){
   alert('예약을 취소하시겠습니까?');
   $.ajax({
      method: "post",
      url: "/cancelMyReserve",
      data: {"res_seq": val },
      cache: false,
      success: function(res){
         console.log("res_seq : ", val);
         console.log('취소가 완료되었읍니다');
         
         location.href="/myActionPage";
      },
      error: function(request, status){
         console.log('취소에러');
      }
   });
}

</script>
</head>
<body>
<%@ include file="../../petmedic_navbar.jsp"%>
   <div class="container action_container">
      <div class="actiontitle container">
      <br>
         <h5>${ users_id } 님의 활동내역입니다.</h5>
      </div>
      <br><br>
      <div class="flex-container">
      
   <!-- 나의 찜 목록 -->
      <div class="myactionZzim container" style="width:30%;">
         <p><strong style="font-size:18px;"> 내가 찜한 병원</strong></p>
         <div class="row" id="zzimTitle" style="text-align:center;">
            <div class="col-sm"> ※ 찜은 5개까지 가능합니다. </div>
         </div>
         <hr>
      </div>
   
   <!-- 나의 예약내역 >> 누르면 조회, 수정 -->
      <div class="myactionReserve container" style="width:70%;" >
         <p><strong style="font-size:18px;"> 전체 예약내역</strong> <span class="reserveCnt"></span>
            &nbsp;&nbsp;&nbsp;<span style="font-size:13px; text-align:right;">예약은 취소 후 재예약만 가능하며, 당일은 취소 불가합니다.</span>
         </p>
         <div class="row" id="reserveTitle" style="text-align:center;">
            <div class="col-sm"> <strong>방문(예정)일</strong> </div>
            <div class="col-sm"> <strong>예약병원명</strong> </div>
            <div class="col-sm"> <strong>결제일</strong> </div>
            <div class="col-sm"> <strong>예약취소</strong> </div>
         </div>
         <hr>
         
         <!-- 페이지네이션 들어오는 div -->
         <div class="row" id="actListPageDiv" style="margin:10px 0;">
            <ul id="actListPage" style="margin:0 auto;"></ul>
         </div>

      </div>
      </div>
   </div>
   <%@ include file="../../footer.jsp"%>
</body>
</html>
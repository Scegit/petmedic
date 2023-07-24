//========리스트
//[관리자] 회원 리스트에서 검색,페이징 눌렀을 때
function dateCheck(val) {

	if ((document.getElementById("searchInsertDate1").value == "" && document
			.getElementById("searchInsertDate2").value != "")
			|| (document.getElementById("searchInsertDate2").value == "" && document
					.getElementById("searchInsertDate1").value != "")) {
		alert("날짜를 모두 선택해주세요.");
		return;
	}

	var users_role = $("#users_role").val();
	var searchKeyword = $("#searchKeyword").val();
	var date1 = $("#searchInsertDate1").val();
	var date2 = $("#searchInsertDate2").val();
	var searchCondition = $("#searchCondition").val();
	var pageNUM;

	if (val != null) {
		pageNUM = val;
	}
	console.log(pageNUM); //값 잘 찍는지 확인용
	var userListSearch = {
		searchInsertDate1 : date1,
		searchInsertDate2 : date2,
		searchCondition : searchCondition,
		pageNUM : pageNUM,
		searchKeyword : searchKeyword,
		users_role : users_role
	};
	$.ajax({
		method : "POST",
		url : "getUserList",
		data : userListSearch,
		cache : false,
		success : function(data) {
// 			document.documentElement.innerHTML = data;
			$("#adminUserList").html(data);
			
		},
		error : function(request, status) {
			alert("오류가 발생했습니다.");
		}
	});
}

//검색목록 초기화(처음상태로)
function resetSearchUserList() {
	location.href = "getUserList";
}


//해당 눌렀을 때 회원 상세
function uDtail(val) {
	location.href = "getUserPage?users_id=" + val;
}



//=============겟유저

//목록으로 버튼 함수
function userList(){
	location.href = "getUserList";
}


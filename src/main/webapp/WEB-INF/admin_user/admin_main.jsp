<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="./adminPage.jsp"%>
<%@ include file="../../header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- css -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css"
	rel="stylesheet">

<%--관리자가 사용하는 제이쿼리 3.6.0 버전 --%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>
	<div class="adminMainContainer">
		<!--  chart 시작 -->
		<div class="hospital_chart admin-chart">
			<h3 id="hospital_chart_title">병원 가입 현황</h3>
			<canvas id="hospital_chart"></canvas>
		</div>
		<br>
		<div class="pet_reserve_chart admin-chart">
			<h3 id="pet_reserve_chart_title">예약 현황</h3>
			<canvas id="pet_reserve_chart"></canvas>
		</div>
		<!--  chart 종료 -->
		<br> <br>
		<div class="recentIssue">
			<h2 class="recentIssueH2">최근 이슈 사항</h2>
		</div>

		<div class="recentJoinHospital">

			<div class="row">
				<div class="col">
					<h4 class="recentJoinHospitalH2">최근 병원 가입 현황</h4>
				</div>
				<div class="col rightCol">
					<a href="/getHospitalList">더보기 +</a>
				</div>
			</div>

			<div class="row recentHosRow recentHosTitle">
				<div class="col">가입일자</div>
				<div class="col">병원아이디</div>
				<div class="col">병원이름</div>
				<div class="col">승인여부</div>
			</div>

			<!--  데이터가져와서 반복해야하는 부분 (시작) -->
			<c:forEach items="${adminMainRecentJoinHospitalList }" var="hospital">
				<div class="row recentHosRow">
					<div class="col">${hospital.hos_new_date.toLocaleString().substring(0, hospital.hos_new_date.toLocaleString().lastIndexOf("."))}</div>
					<div class="col">${hospital.hos_id }</div>
					<div class="col">${hospital.hos_name }</div>
					<div class="col">
						<c:choose>
							<c:when test="${ hospital.hos_role == 'Y' }">승인완료</c:when>
							<c:otherwise>
								<span style="color: red;">승인대기</span>
							</c:otherwise>
						</c:choose>

					</div>
				</div>
			</c:forEach>
			<!--  데이터가져와서 반복해야하는 부분 (끝) -->
		</div>

		<div class="recentReserVeHospital">

			<div class="row">
				<div class="col">
					<h4 class="recentReserVeHospitalH2">최근 병원 예약 현황</h4>
				</div>
				<div class="col rightCol">
					<a href="/getReserveList">더보기 +</a>
				</div>
			</div>

			<div class="row recentHosRow recentHosTitle">
				<div class="col">예약일자</div>
				<div class="col">예약시간</div>
				<div class="col">병원이름</div>
				<div class="col">예약자ID</div>
				<div class="col">예약/취소여부</div>
			</div>

			<!--  데이터가져와서 반복해야하는 부분 (시작) -->
			<c:forEach items="${adminRecentReserveHospitalList }" var="reserve">
				<div class="row recentHosRow">
					<div class="col">${reserve.res_date.toLocaleString().substring(0, reserve.res_date.toLocaleString().lastIndexOf(".")) }</div>
					<div class="col">${reserve.res_time.substring(0, reserve.res_time.lastIndexOf(":"))}</div>
					<div class="col">${reserve.hos_name}</div>
					<div class="col">${reserve.users_name}</div>
					<div class="col">
						<c:choose>
							<c:when test="${ reserve.res_cancel == 'Y' }">
								<span style="color: red;">취소</span>
							</c:when>
							<c:otherwise>예약</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:forEach>
			<!--  데이터가져와서 반복해야하는 부분 (끝) -->
		</div>
		<br>


	</div>


	<%-- 병원가입수 차트 스크립트 시작--%>
	<script>
		$(function() {
			let today = new Date();
			let year = today.getFullYear();
			let month = ('0' + (today.getMonth() + 1)).slice(-2);
			let day = ('0' + today.getDate()).slice(-2);
			let dateString = year + '-' + month + '-' + day;

			$.ajax({
				url : '/currentDayInfo',
				type : 'post',
				data : {
					'today' : dateString
				},
				// 				data : { 'today' : '2023-06-05'},
				cache : false,
				success : function(res) {
					hosJoinCnt(res);
					reserveCntChart(res);
				},
				error : function(request, status) {
					alert('오류가 발생했습니다.');
				}
			});

		});

		function hosJoinCnt(data) {
			let labelArr = [];
			let dataArr = [];
			let str = '';
			for (let i = 1; i <= data.dateInfo.wk; i++) {
				if (i == data.dateInfo.wk) {
					str += '주 ' + i;
					dataArr[i - 1] = data.allJoinHosCnt['week_' + i];
				} else {
					str += '주 ' + i + ",";
					dataArr[i - 1] = data.allJoinHosCnt['week_' + i];
				}
			}
			labelArr = str.split(',');

			// 차트를 그릴 영역을 dom요소로 가져온다.
			var chartArea = document.getElementById('hospital_chart')
					.getContext('2d');
			// 차트를 생성한다.
			var myChart = new Chart(chartArea, {
				// ① 차트의 종류(String)
				type : 'line',
				// ② 차트의 데이터(Object)
				data : {
					// ③ x축에 들어갈 이름들(Array)
					labels : labelArr,
					// ④ 실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
					datasets : [ {
						// ⑤ dataset의 이름(String)
						label : '병원수',
						// ⑥ dataset값(Array)
						data : dataArr,
						// ⑦ dataset의 배경색(rgba값을 String으로 표현)
						backgroundColor : 'rgba(255, 99, 132, 0.2)',
						// ⑧ dataset의 선 색(rgba값을 String으로 표현)
						borderColor : 'rgba(255, 0, 255)',
						// ⑨ dataset의 선 두께(Number)
						borderWidth : 1,
					}, ],
				},
				// ⑩ 차트의 설정(Object)
				options : {
					// ⑪ 축에 관한 설정(Object)
					scales : {
						// ⑫ y축에 대한 설정(Object)
						y : {
							// ⑬ 시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)
							beginAtZero : true,
						},
					},
				},
			});
		}
	<%-- 병원가입수 차트 스크립트 끝 --%>
		
	<%-- 동물예약건수 차트 스크립트 시작--%>
		function reserveCntChart(data) {
			console.log('data.reserveWeeksum', data.reserveWeeksum);
			let labelArr = [];
			let dataArr = [];
			let str = '';
			for (let i = 1; i <= data.dateInfo.wk; i++) {
				if (i == data.dateInfo.wk) {
					str += '주 ' + i;
					dataArr[i - 1] = data.reserveWeeksum[i - 1]['week_' + i];
					labelArr[i - 1] = data.reserveWeeksum[i - 1]['hos_cate'];
				} else {
					str += '주 ' + i + ",";
					dataArr[i - 1] = data.reserveWeeksum[i - 1]['week_' + i];

					labelArr[i - 1] = data.reserveWeeksum[i - 1]['hos_cate'];
				}
			}

			let bgColorArr = [ 'rgba(128, 128, 128, 0.2)',
					'rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)',
					'rgba(75, 192, 192, 0.2)', 'rgba(255, 206, 86, 0.2)',
					'rgba(153, 102, 255, 0.2)' ];

			let bdColorArr = [ 'rgba(0, 0, 0)', 'rgba(255, 0, 255)',
					'rgba(0, 255, 0)', 'rgba(0, 0, 255)', 'rgba(255, 0, 0)',
					'rgba(255, 255, 0)' ];

			let objArr = [];

			$.each(data.reserveWeeksum, function(i, v) {
				let week_data = [];
				for (let i = 1; i <= data.dateInfo.wk; i++) {
					week_data[i - 1] = v['week_' + i];
				}
				objArr[i] = {
					// ⑤ dataset의 이름(String)
					label : v.hos_cate,
					// ⑥ dataset값(Array)
					data : week_data,
					// ⑦ dataset의 배경색(rgba값을 String으로 표현)
					backgroundColor : bgColorArr[i],
					// ⑧ dataset의 선 색(rgba값을 String으로 표현)
					borderColor : bdColorArr[i],
					// ⑨ dataset의 선 두께(Number)
					borderWidth : 1,
				};

			});

			// 차트를 그릴 영역을 dom요소로 가져온다.
			var chartArea = document.getElementById('pet_reserve_chart')
					.getContext('2d');
			// 차트를 생성한다.
			var myChart = new Chart(chartArea, {
				// ① 차트의 종류(String)
				type : 'line',
				// ② 차트의 데이터(Object)
				data : {
					// ③ x축에 들어갈 이름들(Array)
					labels : str.split(','),
					// ④ 실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
					datasets : objArr,
				},
				// ⑩ 차트의 설정(Object)
				options : {
					// ⑪ 축에 관한 설정(Object)
					scales : {
						// ⑫ y축에 대한 설정(Object)
						y : {
							// ⑬ 시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)
							beginAtZero : true,
						},
					},
				},
			});

		}

		// 차트 초기 설정
		// 		myChart.hide(1);
		// 		myChart.hide(2);
		// 		myChart.hide(3);
		// 		myChart.hide(4);
		// 		myChart.hide(5);
	</script>
	<%-- 동물예약건수 차트 스크립트 끝 --%>
</body>
</html>
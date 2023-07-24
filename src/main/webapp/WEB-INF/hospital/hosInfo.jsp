<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
td{
	text-align: center;
	border-bottom:1px solid #E8E2E2;
	padding: 5px;
}
table {
box-shadow: 0 0 0 1px #E8E2E2;
border-collapse: collapse;
border: none;
}
</style>
<body>
	<div class="blurblur" style = "width:70%; margin:0 auto;">
	<table style="border:none; width:100%; margin:0 auto;	">
		<tr>
			<td style="width:50%">
				<table style="width:100%; margin: 0">
				<tr><td style="width:50%">월</td><td>${hos.hos_start} - ${hos.hos_end}</td></tr>
				<tr><td>화</td><td>${hos.hos_start} - ${hos.hos_end}</td></tr>
				<tr><td>수</td><td>${hos.hos_start} - ${hos.hos_end}</td></tr>
				<tr><td>목</td><td>${hos.hos_start} - ${hos.hos_end}</td></tr>
				<tr><td>금</td><td>${hos.hos_start} - ${hos.hos_end}</td></tr>
				<tr><td>토</td><td>휴무일</td></tr>
				<tr><td>일</td><td>휴무일</td></tr>
				<tr><td>공휴일</td><td>휴무일</td></tr>
				<tr><td colspan="2">진료시간은 의사 개인사정등의 이유로 변경될 수 있습니다.</td></tr>
				</table>
			</td>
			<td style="width:15%">기본 진찰비: ${hos.hos_price}원<br><br>진찰과 및 증상등에 의해 추가 요금이 발생할 수 있습니다.</td>
		</tr>	
	</table>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>병원검색</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25731966bd6475ae2f7635d90222da92&libraries=services,clusterer,drawing"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:366px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:2px solid #878ECD;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
*, ::after, ::before {
    /* box-sizing: border-box; */
    box-sizing: initial!important;
}

.searchbox {
    padding-left: 18px;
    border: none;
    outline: none;
    inline: none;
    width: 216px;
    border: none;
}

#search-container {
    inline: none;
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100px;
    height: 50px;
    border-top-left-radius: 30px;
    border-bottom-left-radius: 30px;
    border-top-right-radius: 30px;
    border-bottom-right-radius: 30px;
    background-color: white;
    padding: 3px 10px;
    height: 50px;
    width: 326px;
    justify-content: space-between;
    align-items: center;
    display: flex;
    border: 4px solid #878ECD;
    /* box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2); */
    margin-top: 10px;
}
#search {
    margin-left: 35%;
    position: absolute;
    bottom: 12px;
}

.search-button {
	border-radius: 5px;
	background-color: white;
	border:none;
/* 	box-shadow: 0 .1rem 2rem rgba(0,0,0,.08); */
}

.srchbtn {
    border-radius: 5px;
    background-color: white;
    border: none;
    /* box-shadow: 0 3.1rem 2rem rgba(0,0,0,.08); */
    text-align: center;
    margin: 3px;
}

.collapse {
	 text-align: center;
}

.sbtn {
    color: #ccc;
    border: none;
    border-radius: 5px;
    padding: 2px 1px;
    margin-left: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

      .sbtn:hover {
        transform: scale(1.03); /* Increase the size by 10% */
        background-color: #fbbc04;
      }

      .sbtn:active {
        transform: scale(0.8); /* Decrease the size by 10% */
        background-color: #fbbc04;
      }


</style>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>
	<div class="container" style=" margin-top:100px;">
		<div class="map_wrap ">
			<div id="map" class="blurblur" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

			<div id="menu_wrap" class="bg_white">
				<form onsubmit="searchPlaces(); return false;">
				 <div id="search-container">
						<button type="button" class="search-button sbtn" onclick="geoLoc()"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAVVJREFUSEvFldsxBUEQhr8TgEsIRIAMiAABKLzyQCg88Io6CRABGSACQnAJgPpUj5paM7tnSw39cnbPTPf/9+XvndDYJo3jMxbgIwjN7DfzxQjcBGAV2AXWAZ+1B+AOuIrnaqX7MlgELoCtgT5dA/vAS+leDcDgT4C/mkxPMrZmchyZeW7w5RJIDUBWm8BrlMaSlEwgS7UA6LPdvVQC0Ok+Lq4N1Tj6Ur1fArAUR8BplCGROgN24mUKHGZsL6NcXZ+iDizHCpCzN/hBJ/3zDCRlra9+35ZnkGY8HeZnb8BcB+AdmM/+K/r/KUAi85sSPWZi/Ir3L01uPqZmloSmQjd6tCCZ21D8TWmt9K2K51CogM65M54UbWC1sheNU/FLY1aFfu4hA7sy+kzmAo1adnlA2RrAda0ANafFHSSB2p6qTlEf2yYfnBywOcBAO34ej/0mjwb4BBbRUBnf8oRkAAAAAElFTkSuQmCC"/>
						</button>
						 <button class= "search-button sbtn" type="button" data-toggle="collapse" data-target="#animal" aria-expanded="false" aria-controls="animal">
							     <img  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAFxJREFUSEtjZKAxYKSx+QyjFhAM4eEZRP8J+hu/ApRQwRZENLeAQg+gah/wSCY2uHA6lJAPaG4BxfFByAd0tQA9uIhyHFGKoN6guQVkBRcpPhi1gKwQIKhp6McBACZ4Bhljo5edAAAAAElFTkSuQmCC"/>
						</button>
							<input class="searchbox" type="text" id="keyword" placeholder="병원명 혹은 지역명을 검색하여주세요">
								
							<button class="search-button sbtn" type="submit">
								<img
									src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAVFJREFUSEvVleExBEEQRt9FQAoiQATIgAgQASJABIgAESACZEAEyIAIqKd6qub2Zmen7N4P/eu2dqdf99dfz81YcsyWnJ8+wCpwBOwCG1HEC3APXAGfrYWVAAfABSCkFCY/AW5aIF2Aya/j4ANwCTzF8zZwBmzF8150VOXkACt+i8oPKxUKOQ2Z1obkygHpoJWrfS3syk7Oo6veb3OAQ1wHdjJZ+g4q1yPgmc1aJTngOz5stW7T92MBXxW3/db7V4mc0R3wDChX0wzSkF0mLdgyZPdBKzcBtOk7sBLO0CGlSIV8xJZXt7o70NS6ibWiyZTBUAr9nyQZtGh3Bqlat9m27aQUDtb3wrSpv2/7NKpddsexcO6G8RpXgwmVJe2N77yX3P6FaPV86Wx+b/VCxgBS0v2MvtDJWMAgZApAFzJ3E08FSBCtPfdHNCWg6NT/D/gBeOVFGZeTouUAAAAASUVORK5CYII=" />
							</button>
						
							 
						</div>	
						 <div class="collapse" id="animal">
							  <p>전문카테고리 선택</p>

							      <input class="srchbtn " name="hos_cate" value="강아지" onclick="addId(this)">
							      <input class="srchbtn " name="hos_cate" value="고양이" onclick="addId(this)">
							      <input class="srchbtn " name="hos_cate" value="새" onclick="addId(this)">
							      <input class="srchbtn " name="hos_cate" value="파충류" onclick="addId(this)">
							      <input class="srchbtn " name="hos_cate" value="기타동물" onclick="addId(this)">
							      <input class="srchbtn " value="전체" onclick="addId(this)">

							  </div>
					</form>

				<ul id="placesList"></ul>
				<div id="pagination"></div>
			</div>
		</div>
	</div>
	<%@ include file="../../footer.jsp"%>
	<script>
	function hosDetail() {
		console.log(document.getElementById("placesList"));
		// 	  const address_name = $('#placelist').val; // 예시: 서울 노원구 상계동 318-2
		// 	  const road_address_name = places.road_address_name; //
		// 	  const category_group_code = places.category_group_code; //
		// 	  const category_name = places.category_name; //
		// 	  const phone = places.phone; //
		/*
		 address_name: "서울 노원구 상계동 318-2"
		 category_group_code: "HP8"
		 category_group_name: "병원"
		 category_name: "가정,생활 > 반려동물 > 동물병원"
		 distance: ""
		 id: "20646966"
		 phone: "02-919-0075"
		 place_name: "N동물의료센터 노원점"
		 place_url: "http://place.map.kakao.com/20646966"
		 road_address_name: "서울 노원구 노원로 408"
		 x: "127.06810390255956"
		 y: "37.65311494220056"

		 */
		const xhr = new XMLHttpRequest();
		xhr.open('GET', `getHos?&hos_name=${place_name}&`, true);
		xhr.onload = function() {
			// handle the response from the server here
		};
		xhr.send();
	}
	
		function addId(element) {
			var category = document.getElementById("category");
			element.classList.toggle('active');
			
			if (category) {
				category.removeAttribute("id");
			} else {

			}
			element.setAttribute("id", "category");
			console.log("카테고리 세팅완료")
		}
		
	    function initMap() {
	      var container = document.getElementById('map');
	      var options = {
	        center: new kakao.maps.LatLng(37.5665, 126.9780), // Set initial map center coordinates
	        level: 5 // Set initial zoom level
	      };

	    }

	    function showMap() {
	      var mapContainer = document.getElementById('map-container');
	      mapContainer.style.display = 'block'; // Show the map container
	      initMap(); // Initialize the map
	    }

	    var showMapButton = document.getElementById('showMapButton');
// 	    showMapButton.addEventListener('click', showMap);
		
	</script>
	<script>
		var hospitalList = []; //ArrayList 값을 받을 배열변수를 선언

		$(document).ready(function searchPlaces() {

			$.ajax({
				url : '/getHosList',
				type : 'post',
				data : hospitalList,
				dataType : 'json',
				async: false,
				success : function(result) {
					hospitalList = result;
					console.log("hospitalList가지고 요니" + hospitalList);

				},
				error : function(xhr, status, error) {
					// Handle error
					console.log('Error:', error);
				}
			});
		});

		
		function geoLoc(){
			console.log("geoLoc 실행")
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat = position.coords.latitude, // 위도
		            lon = position.coords.longitude; // 경도
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon) // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		        
		        // 마커 표시합니다
		        displayMarker(locPosition);
		            
		      });
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		    
		    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667)    
		        
		    displayMarker(locPosition);
		}
		
		}
		
		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition) {

		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({  
		        map: map, 
		        position: locPosition
		    }); 
		    
		    // 지도 중심좌표를 접속위치로 변경합니다
		    map.setCenter(locPosition);      
		}    
		
		
		
		
		// 마커를 담을 배열입니다
		var markers = [];

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		// 키워드로 장소를 검색합니다
		searchPlaces();

		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {

			var keyword = document.getElementById('keyword').value;

			if (!keyword.replace(/^\s+|\s+$/g, '')) {
				//         alert('키워드를 입력해주세요');
				return false;
			}

			// 장소검색 객체를 통해 키워드와 카테고리로 장소검색을 요청합니다
			ps.keywordSearch(keyword, placesSearchCB);
		}

		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		//data는 배열
		/*data의 있는 프로퍼티
		 * address_name: "서울 노원구 상계동 318-2"
		 category_group_code: "HP8"
		 category_group_name: "병원"
		 category_name: "가정,생활 > 반려동물 > 동물병원"
		 distance: ""
		 id:  "20646966"
		 phone: "02-919-0075"
		 place_name: "N동물의료센터 노원점"
		 place_url: "http://place.map.kakao.com/20646966"
		 road_address_name: "서울 노원구 노원로 408"
		 x: "127.06810390255956"
		 y: "37.65311494220056"
		 */
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {
				var filteredData = [];
				var categoryElement = document.getElementById('category');
				var cate = categoryElement ? categoryElement.value : "";
				var key = document.getElementById('keyword').value;

				console.log(data);
				console.log(data[0].address_name);
				console.log(hospitalList);
				console.log(key);

				if (data.length > hospitalList.length) {
					  // Filter out only the results from your database
					  for (var i = 0; i < data.length; i++) {
					    for (var y = 0; y < hospitalList.length; y++) {
					      if (
					        data[i].place_name === hospitalList[y].hos_name &&
					        data[i].address_name === hospitalList[y].hos_addr3 &&
					        data[i].road_address_name === hospitalList[y].hos_addr2 &&
					        [hospitalList[y].hos_name, hospitalList[y].hos_addr3, hospitalList[y].hos_addr2].includes(key)
					      ) {
					        if (cate === "" || hospitalList[y].hos_cate.includes(cate)) {
					          console.log("돌아보리게");
					          filteredData.push(data[i]);
					        }
					      }
					    }
					  }		
				} else if (data.length < hospitalList.length) {
					  for (var i = 0; i < data.length; i++) {
						    for (var y = 0; y < hospitalList.length; y++) {
						      if (
						        data[i].place_name === hospitalList[y].hos_name &&
						        data[i].address_name === hospitalList[y].hos_addr3 &&
						        data[i].road_address_name === hospitalList[y].hos_addr2 &&
						        [hospitalList[y].hos_name, hospitalList[y].hos_addr3, hospitalList[y].hos_addr2].includes(key)
						      ) {
						        if (cate === "" || hospitalList[y].hos_cate.includes(cate)) {
						          console.log("돌아보리게");
						          filteredData.push(data[i]);
						        }
						      }
						    }
						  }
				} else if (data.length = hospitalList.length) {
					for (var i = 0; i <= data.length; i++) {
						for (var i = 0; i < data.length; i++) {
						    for (var y = 0; y < hospitalList.length; y++) {
						      if (
						        data[i].place_name === hospitalList[y].hos_name &&
						        data[i].address_name === hospitalList[y].hos_addr3 &&
						        data[i].road_address_name === hospitalList[y].hos_addr2 &&
						        [hospitalList[y].hos_name, hospitalList[y].hos_addr3, hospitalList[y].hos_addr2].includes(key)
						      ) {
						        if (cate === "" || hospitalList[y].hos_cate.includes(cate)) {
						          console.log("돌아보리게");
						          filteredData.push(data[i]);
						        }
						      }
						    }
						  }
					}
				}

				// 정상적으로 검색이 완료됐으면
				// 검색 목록과 마커를 표출합니다
				displayPlaces(filteredData);

				// 페이지 번호를 표출합니다
// 				displayPagination(pagination);

			} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

				alert('검색 결과가 존재하지 않습니다.');
				return;

			} else if (status === kakao.maps.services.Status.ERROR) {

				alert('검색 결과 중 오류가 발생했습니다.');
				return;

			}
		}

		
		
		
		
		 
		// 검색 결과 목록과 마커를 표출하는 함수입니다
		// places : 검색 결과 정보가 있다
		function displayPlaces(places) {
			console.log(places);
			console.log(document.getElementById("placesList"))
			var listEl = document.getElementById('placesList'), 
			menuEl = document.getElementById('menu_wrap'), 
			fragment = document.createDocumentFragment(), 
			bounds = new kakao.maps.LatLngBounds(), 
			listStr = '';

			// 검색 결과 목록에 추가된 항목들을 제거합니다
			removeAllChildNods(listEl);

			// 지도에 표시되고 있는 마커를 제거합니다
			removeMarker();

				
			for (var i = 0; i < places.length; i++) {
			
			
				
				// 마커를 생성하고 지도에 표시합니다
				var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
						i, places[i]); // 검색 결과 항목 Element를 생성합니다

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가합니다
				bounds.extend(placePosition);

				// 마커와 검색결과 항목에 mouseover 했을때
				// 해당 장소에 인포윈도우에 장소명을 표시합니다
				// mouseout 했을 때는 인포윈도우를 닫습니다
				(function(marker, title) {
					kakao.maps.event.addListener(marker, 'mouseover',
							function() {
								displayInfowindow(marker, title);
							});

					kakao.maps.event.addListener(marker, 'mouseout',
							function() {
								infowindow.close();
							});

					itemEl.onmouseover = function() {
						displayInfowindow(marker, title);
					};

					itemEl.onmouseout = function() {
						infowindow.close();
					};
				})(marker, places[i].place_name);

				fragment.appendChild(itemEl);
			}

			// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
			listEl.appendChild(fragment);
			menuEl.scrollTop = 0;

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			map.setBounds(bounds);
		}

		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {

			var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
					+ (index + 1)
					+ '"></span>'
					+ '<div  class="info">'
					+ '<a href="/getHos?hos_addr2='
					+ places.road_address_name
					+ '&hos_addr3='
					+ places.address_name
					+ '&hos_name='
					+ places.place_name
					+ '">'
					+ places.place_name + '</a>'

			if (places.road_address_name) {
				itemStr += '    <span>' + places.road_address_name + '</span>'
						+ '   <span class="jibun gray">' + places.address_name
						+ '</span>';
			} else {
				itemStr += '    <span>' + places.address_name + '</span>';
			}

			itemStr += '  <span class="tel">' + places.phone + '</span>'
					+ '</div>';
					
			el.innerHTML = itemStr;
			el.className = 'item';

			return el;
		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
			var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
			imgOptions = {
				spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset : new kakao.maps.Point(13, 37)
			// 마커 좌표에 일치시킬 이미지 내에서의 좌표
			}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imgOptions), marker = new kakao.maps.Marker({
				position : position, // 마커의 위치
				image : markerImage
			});

			marker.setMap(map); // 지도 위에 마커를 표출합니다
			markers.push(marker); // 배열에 생성된 마커를 추가합니다

			return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
			var paginationEl = document.getElementById('pagination'), 
			fragment = document.createDocumentFragment(), 
			i;

			// 기존에 추가된 페이지번호를 삭제합니다
			while (paginationEl.hasChildNodes()) {
				paginationEl.removeChild(paginationEl.lastChild);
			}

			for (i = 1; i <= pagination.last; i++) {
				var el = document.createElement('a');
				el.href = "#";
				el.innerHTML = i;

				if (i === pagination.current) {
					el.className = 'on';
				} else {
					el.onclick = (function(i) {
						return function() {
							pagination.gotoPage(i);
						}
					})(i);
				}

				fragment.appendChild(el);
			}
			paginationEl.appendChild(fragment);
		}

		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
			var content = '<div style="padding:5px;z-index:1;">' + title
					+ '</div>';

			infowindow.setContent(content);
			infowindow.open(map, marker);
		}

		// 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {
			while (el.hasChildNodes()) {
				el.removeChild(el.lastChild);
			}
		}
	</script>

</body>
</html>
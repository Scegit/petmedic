<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Kakao Map Search</title>
  <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=25731966bd6475ae2f7635d90222da92&libraries=services,clusterer,drawing"></script>
  <script>
  $(document).ready(function() {
      // Create a Kakao Map instance
      var mapContainer = document.getElementById('map');
      var mapOptions = {
        center: new kakao.maps.LatLng(37.5665, 126.9780), // Set the center of the map
        level: 5 // Set the initial zoom level
      };
      var map = new kakao.maps.Map(mapContainer, mapOptions);

      // Function to convert address to latitude and longitude
      function geocodeAddress(address, callback) {
        var geocoder = new kakao.maps.services.Geocoder();

        geocoder.addressSearch(address, function(result, status) {
          if (status === kakao.maps.services.Status.OK) {
            var coordinates = {
              latitude: result[0].y,
              longitude: result[0].x
            };
            callback(coordinates);
          }
        });
      }

      // Function to search for places based on the selected condition
      function searchPlaces() {
        var keyword = $('#keyword').val();
        var searchCondition = $('#searchCondition').val();

        // Send an AJAX request to the server
        $.ajax({
          type: 'POST',
          url: '/locations', // Replace with your server-side endpoint URL
          data: { keyword: keyword, searchCondition: searchCondition },
          dataType: 'json',
          success: function(response) {
            // Clear previous markers from the map
            map.removeOverlayMapTypeId(kakao.maps.MapTypeId.KAKAO_OVERLAY);

            // Process the response and display markers on the map
            for (var i = 0; i < response.length; i++) {
              var place = response[i];

              // Convert address to latitude and longitude
              geocodeAddress(place.hos_addr2, function(coordinates) {
                var markerPosition = new kakao.maps.LatLng(coordinates.latitude, coordinates.longitude);
                var marker = new kakao.maps.Marker({
                  position: markerPosition
                });
                marker.setMap(map);
              });
            }
          },
          error: function(xhr, status, error) {
            console.log('An error occurred: ' + error);
          }
        });
      }

      // Bind the search function to the search button click event
      $('#searchButton').click(function() {
        searchPlaces();
      });
 });
  </script>
</head>
<body>
  <div id="map" style="width: 100%; height: 400px;"></div>
  <label for="keyword">Keyword:</label>
  <input type="text" id="keyword">
  <label for="searchCondition">Search Condition:</label>
  <select id="searchCondition">
    <option value="별점높은순">별점높은순</option>
    <option value="가격낮은순">가격낮은순</option>
  </select>
  <button id="searchButton">Search</button>
</body>
</html>


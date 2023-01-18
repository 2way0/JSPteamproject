<%@page import="user.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 헤더 부트스트랩 --> 
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" /> 
<link rel="stylesheet" href="style.css">
<!-- 글목록css -->
<style>
body{
	padding-top:87px;
}
a {
	color: black;
	text-decoration: none;
}


#centerLine2 {
	height: 100px;
}

#centerLine3 {
	height: 350px;
}

#centerLine4 {
	height: 350px;
}

#centerLine5 {
	height: 300px;
}

#search {
margin-top:30px;
border: 2px solid black;
}
</style>

</head>


<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.0.3/index.global.min.js"></script>

<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>
<!-- 헤더 -->
			<header class="p-3 text-bg-dark" style="position:fixed; top:0; width: 100%; z-index: 1; background-color: white !important;">
				<div class="container">
					<div class="row">
					<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
						<a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"></a>

					<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
						<li><a href="main.jsp"><img src="image/shelter.png"></a></li>
						<li><a href="#" class="nav-link px-2 text-secondary">인기글</a></li>
						<li><a href="anolist.jsp" class="nav-link px-2 text-secondary">익명 게시판</a></li>
						<li><a href="#" class="nav-link px-2 text-secondary">맛집 게시판</a></li>
						<li><a href="myPage.jsp" class="nav-link px-2 text-secondary fw-semibold">My Page</a></li>
						<li><%if(userID != null){%>
	                    <a href="write.jsp" class="btn btn-success offset-10" style="width: 75px; margin-right: 100px">
	                    	글쓰기</a>
						<% }%></li>
					</ul>
		<%--검색 --%>
					<form method="post" action="searchedList.jsp" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
						<input type="search"
							class="form-control form-control-dark text-bg-white"
							placeholder="Search..." aria-label="Search" name="searchWord">
					</form>

					<%
				if(userID == null){
			%>
					<div class="text-end">
						<button type="button" class="btn btn-outline-dark me-2"
							role="button" aria-haspopup="true" aria-expanded="false">
							<a href="login.jsp">로그인</a>
						</button>
						<button type="button" class="btn btn-warning" role="button"
							aria-haspopup="true" aria-expanded="false">
							<a href="join.jsp" id="sign-color">회원 가입</a>
						</button>
					</div>
					<%
				} else {
			%>
					<div class="text-end">
						<button type="button" class="btn btn-outline-light me-2"
							role="button" aria-haspopup="true" aria-expanded="false">
							<a href="logoutAction.jsp">LogOut</a>
						</button>

					</div>
					<%		
				}
			%>

				</div>
			</div>
		</div>
	</header>
	
	
	

<%-- 로그인하지않았을때 login버튼, 로그인했을때 logout버튼. --%>
	<section>
	<div class="container">
	  <div class="row" id="centerLine">
		  <div class="col-md-1" style="background-color:red;">
      		Column
    	  </div>
    	  <div class="col-md-10">
      		<div class="row" id="centerLine2">
      		  <div class="col-md-12" style="background-color:orange;">
      		  	<form method="post" action="searchedList.jsp" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search" id="search">
						<input type="search"
							class="form-control form-control-dark text-bg-white"
							placeholder="토픽 주제를 검색하세요" aria-label="Search" name="searchWord">
					</form>
      		  </div>
      		</div>
      		<div class="row" id="centerLine3">
      		 <div class="col-md-12" style="background-color:purple;">
      		  	d
      		  </div>	
      		</div>
      		<div class="row" id="centerLine4">
      		 <div class="col-md-6" style="background-color:black;">
      		  	d
      		  </div>
      		  <div class="col-md-6" style="background-color:blue;">
      		  	d
      		  </div>
      		</div>
      		<div class="row" id="centerLine5">
      		  <div class="col-md-12" style="background-color:aqua;">
      		  	<div id="calendar"></div>
      		  </div>
      		</div>
     	  </div>
    	  <div class="col-md-1" style="background-color:gray;">
      		Column
    	  </div>	
	  </div>
	 </div>
	</section>

   <script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth', //달별로 출력
          locale: 'ko', // 한글로 설정
          expandRows: true, // 화면에 맞게 높이 재설정
          nowIndicator: true, // 현재 시간 표시
          navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
          editable: true, // 수정 가능?
          selectable: true, // 달력 일자 드래그 설정가능
          eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
              console.log(obj);
            },
            eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
              console.log(obj);
            },
            eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
              console.log(obj);
            },
            select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
                var title = prompt('할 일을 적어주세요:');
                if (title) {
                  calendar.addEvent({
                    title: title,
                    start: arg.start,
                    end: arg.end,
                    allDay: arg.allDay
                  })
                }
                calendar.unselect()
              }
        });
        calendar.render();
      });

    </script>
</body>

</html>
<%@page import="user.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); //한글깨짐 방지
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<!-- 글목록css -->
<style>
#wrapper {
	border: 1px solid #333;
	max-width: 800px; /*800이하 시 줄어듦*/
	height: 100%;
	margin: 0 auto;
	padding: 0 auto;
}

#userInfo {
	/*border: 1px solid blue;*/
	max-width: 800px;
	background-color: rgb(243, 242, 242);
	padding: 20px;
	
}

#img{
	width: 100px;
	height: 100px;
	margin: auto;
	display: block;
	
}

#userID {
	margin: auto;
	text-align: center;
}

#nickName {
	margin: auto;
	text-align: center;
}

#content {
	border: 1px solid red;
	max-width: 800px;
	padding-top: 20px;
	padding-bottom: 20px;
	margin-top: 30px;
}
#myPageList {
	
	
	
}
#myPageList div{
	display: inline-block;
	border: 1px solid #333;
}

#content ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

#content li {
	/* border: 1px solid red; */
	margin-top: 10px;
	padding: 5px;
	background-color: rgb(243, 242, 242);
	overflow: hidden;
}

#content article {
	height: 100px;
}

#profile {
	/* border: 1px solid black; */
	height: 25px;
	margin: 3px 0;
	position: relative;
}

#profile img {
	width: 25px;
	height: 25px;
}

#profile #ano {
	/* border: 1px solid blue; */
	position: absolute;
	margin: 0;
	margin-left: 5px;
	padding: 0;
	display: inline-block;
	height: 25px;
	line-height: 25px;
}

#profile #date {
	/* border: 1px solid blue; */
	position: absolute;
	margin: 0;
	margin-left: 50px;
	padding: 0;
	display: inline-block;
	height: 25px;
	line-height: 25px;
	color: grey;
}

#content h1 {
	/* border: 1px solid blue; */
	font-size: 25px;
	margin-top: 10px;
	margin-bottom: 0px;
	padding: 0;
	display: block;
	max-width: 800px;
	white-space: nowrap; /*여러줄을 한줄로*/
	overflow: hidden; /*넘치는 글 숨김*/
	text-overflow: ellipsis; /*...*/
}

#content p {
	/* border: 1px solid black; */
	font-size: 15px;
	margin: 0;
	/*padding-top: 10px;
padding-bottom: 10px;*/
	padding: 0;
	height: 25px;
	display: block;
	max-width: 800px;
	white-space: nowrap; /*여러줄을 한줄로*/
	overflow: hidden; /*넘치는 글 숨김*/
	text-overflow: ellipsis; /*...*/
}

#like-comment {
	float: right; /*오른쪽 정렬*/
	font-size: 15px;
	height: 15px;
	margin: 3px;
}

#like-comment img {
	width: 15px;
	height: 15px;
}

#like {
	color: #FF0000;
}

#comment {
	color: #0055FF;
}
</style>

</head>

<body>
<%
	Dao dao = Dao.getInstance();
	
//임의로 studentNum 정함.
	int studentNum=1001;
	User user = dao.selectUserOne(studentNum);
	
%>
	<div>
		<div id="wrapper">
			<div id="userInfo">
				<img id="img" src="image/blankProfile.jpg" alt="프로필사진">
				<div id="userID"><a href="myinfoUpdate.jsp?studentNum=<%=user.getStudentNum() %>"><%=user.getUserID() %></a></div>
				<div id="nickName"><a href="myinfoUpdate.jsp?studentNum=<%=user.getStudentNum() %>"><%=user.getNickName() %></a></div>
				
			</div>
			
			<section id="content">
				<div>내정보</div>
				<div id="myPageList">
					<div>
						<button id="exePost">내가 쓴 글</button>
					</div>
					<div>
						<button id="exeComment">댓글 단 글</button>
					</div>
					<div>
						<button id="exeLike">좋아요 한 글</button>
					</div>
				</div>
				<div id="showList"></div>

			</section>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.0.0.min.js"></script>

	<script>
		$(function() {
			$("#exePost").click(function() {
				$.ajax({
					url : 'myPost.jsp',
					success : function(x) {
						$('#showList').html(x);
					}
				})
			});
			$("#exeComment").click(function() {
				$.ajax({
					url : 'myComment.jsp',
					success : function(x) {
						$('#showList').html(x);
					}
				})
			});
			$("#exeLike").click(function() {
				$.ajax({
					url : 'myLike.jsp',
					success : function(x) {
						$('#showList').html(x);
					}
				})
			});
		});
	</script>
</body>

</html>
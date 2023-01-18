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
</style>

</head>


<body>
	<%
		String userID = null;
		int loginStudentNum = 0;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			loginStudentNum = (int) session.getAttribute("studentNum");
		}
	%>
	<!-- 헤더 -->
	<header class="p-3 text-bg-dark"
		style="position: fixed; top: 0; width: 100%; z-index: 1;">
		<div class="container">
			<div class="row">
				<div
					class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
					<a href="/"
						class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"></a>

					<ul
						class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
						<li><a href="main.jsp"><img src="image/shelter.png"></a></li>
						<li><a href="#" class="nav-link px-2 text-white">카테고리</a></li>
						<li><a href="anolist.jsp" class="nav-link px-2 text-white">게시판</a></li>
						<li><a href="#" class="nav-link px-2 text-white">1:1 채팅</a></li>
						<li><a href="#" class="nav-link px-2 text-white">About</a></li>
						<li>
							<%
								if (userID != null) {
							%> <a href="write.jsp"
							class="btn btn-success offset-10"
							style="width: 75px; margin-right: 100px"> 글쓰기</a> <%
 	}
 %>
						</li>
					</ul>

					<form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
						<input type="search"
							class="form-control form-control-dark text-bg-dark"
							placeholder="Search..." aria-label="Search">
					</form>

					<%-- 로그인하지않았을때 login버튼, 로그인했을때 logout버튼. --%>

					<%
						if (userID == null) {
					%>
					<div class="text-end">
						<button type="button" class="btn btn-outline-light me-2"
							role="button" aria-haspopup="true" aria-expanded="false">
							<a href="login.jsp">Login</a>
						</button>
						<button type="button" class="btn btn-warning" role="button"
							aria-haspopup="true" aria-expanded="false">
							<a href="join.jsp" id="sign-color">Sign-up</a>
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






	<!-- 글목록 부분 -->
	<%
		//페이지 누르면 값 가져오기

		String postpg = request.getParameter("postpage");
		if (postpg == null) {
			postpg = "1";
		}
		int postpage = Integer.parseInt(postpg);
		//1->0 ; 2-> 10
		int index_no = (postpage - 1) * 10;

		//DB연결, post테이블정보 담은 리스트
		Dao dao = Dao.getInstance();
		List<Post> postlist = dao.selectPostAll(index_no);

		//총 게시물 개수
		int totalPost = dao.countPostAll();
		//
		int lastPostpage = (int) Math.ceil((double) totalPost / 10);
	%>
	<div id="wrapper">
		<section id="content">
			<ul>
				<%
					for (int i = 0; i<postlist.size(); i++) {
						Post p = postlist.get(i);
				%>
				<li>
					<article>
						<div id="profile">
							<img src="image/blankProfile.jpg" alt="프로필사진">
							<div id="ano">익명</div>
							<div id="date"><%=p.getDate()%></div>
						</div>
						<h1>
							<a href="view.jsp?postNum=<%=p.getPostNum()%>">
								<%=p.getTitle()%></a>
						</h1>
						<p>
							<a href="view.jsp?postNum=<%=postlist.get(i).getPostNum()%>">
								<%=p.getContent()%></a>
						</p>
						<div id="like-comment">
							<span id="like"> <%
 	int likeOnOff = dao.LikeOnOff(postlist.get(i).getPostNum(), loginStudentNum);
 		int countLike = dao.countLikePost(postlist.get(i).getPostNum());
 		int countComment = dao.countCommentPost(postlist.get(i).getPostNum());

 		if (likeOnOff == 0) {
 %> <img src="image/OFF.png" alt="좋아요 수">
								<%=countLike%> <%
 	} else {
 %> <img src="image/ON.png" alt="좋아요 수">
								<%=countLike%> <%
 	}
 %>
							</span> <span id="comment"> <img src="image/icon_comment.png"
								alt="댓글 수"> <%=countComment%>
							</span>
						</div>
					</article>
				</li>
				<%
					}
				%>

			</ul>
		</section>


		<!-- 페이징 -->
		<div>
			<center>
				<%
					//페이징
					for (int i = 1; i <= lastPostpage; i++) {
						//out.print("<a href='anolist2.jsp?postpage= "+i+"'>"+i+"</a> ");
						//위에처럼 해도 되고 아래처럼 해도 된다 - postpage 값 전달 되도록
				%>
				<button>
					<a href="anolist.jsp?postpage=<%=i%>"><%=i%></a>
				</button>
				<%
					}
				%>
			</center>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		
	</script>
</body>

</html>
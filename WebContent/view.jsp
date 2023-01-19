<%@page import="java.io.PrintWriter"%>
<%@ page import="java.io.File"%>
<%@page import="user.Post"%>
<%@page import="user.User"%>
<%@page import="user.Dao"%>
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
</style>

</head>


<body>
	<%
		String userID = null;
		int studentNum = 0;
		if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
		studentNum = (int) session.getAttribute("studentNum");
		}
		
		int postNum = 0;
		if(request.getParameter("postNum") != null){
			postNum = Integer.parseInt(request.getParameter("postNum"));
		}
		
		
		Post post = new Post();
		Dao dao = Dao.getInstance();
		post = dao.getPost(postNum);
		
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
							%> <a href="write.jsp" class="btn btn-success offset-10"
							style="width: 75px; margin-right: 100px">글쓰기</a> <%
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

<div class="container">
		<div class="row">
			<main style="padding: 15px">
				 <div id="wrapper">
      			 <section id="content">
           <ul>
               <li style="margin:10px">
                   <article>
                       <div id="profile">
                           <img src="image/blankProfile.jpg" alt="프로필사진">
                           <div id="ano">익명</div>
                           <div id="date"><%=post.getDate()%></div>
                       </div>
                       <h1><%=post.getTitle() %></h1>
                       <%
                       ServletContext context = this.getServletContext(); //절대경로를 얻는다.
               		   String realFolder = context.getRealPath("bbsUpload"); //saveFolder의 절대경로를 받는다.
                       
                       File oldFile = new File(realFolder+"\\"+"0사진.jpg");
                       File viewFile = new File(realFolder+"\\"+postNum+"사진.jpg");
                       oldFile.renameTo(viewFile);
                       System.out.println(viewFile);
                       
                        if(viewFile.exists()){
                    	%>
                    	<br>
                       <img src="bbsUpload\\<%=postNum%>사진.jpg" width="300px" height="300px">
                       <%}
                        
                        String content = post.getContent().replaceAll("\n", "<br/>");
                        %>
                       <h2 style="font-size: 15px;"><%=content%></h2>
                      	
                       <div id="like-comment">
                           <span id="like">
                                <button value=<%=postNum%> id="like_btn">
                                <%
	                				int countLike = dao.countLikePost(postNum);
									int countComment = dao.countCommentPost(postNum);
									int likeOnOff = dao.LikeOnOff(postNum, studentNum);
									if (likeOnOff == 0) {
	                            %>
	                               <img src="image/OFF.png" alt="좋아요 수" id="like_img">
	                        	<%
	                           		 } else {
	                        	 %>
	                               <img src="image/ON.png" alt="좋아요 수" id="like_img">
	                        	<%
	                          		 };
	                           %>
	                           </button> 
	                           <span id="likecount" value=""><%=countLike%></span>
                           </span>
                           <span id="comment">
                               <img src="image/icon_comment.png" alt="댓글 수"> <%=countComment %>
                           </span>
                       </div>
                   </article>
               </li>
           </ul>
       </section>
     		<a href="anolist.jsp" class="btn btn-success" style="width: 75px; margin: 15px;">목록</a>
			<%
				if (studentNum != 0 && studentNum == post.getStudentNum()) {
			%>
			<a href="update.jsp?postNum=<%=postNum%>"
				class="btn btn-primary offset-7" style="width: 75px;">수정</a> <a
				onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="deleteAction.jsp?postNum=<%=postNum%>" class="btn btn-primary"
				style="width: 75px; margin-left: 15px;">삭제</a>
			<%
			}
			%>
   			</div>
		</main>
		</div>
	</div>
	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		$("#like_btn").click(function() {
			var img = document.getElementById('like_img');
			var likecount = document.getElementById('likecount').innerText;
			
			if (img.src.match('OFF')) {
				img.src = 'image/ON.png';
				
				fetch("likeBtn.jsp?postNum="+$(this).val())
				  .then(a => {document.getElementById('likecount').innerText = ++likecount;});
				
			} else {
				img.src = 'image/OFF.png';
				
				fetch("likeBtn.jsp?postNum="+$(this).val())
				  .then(b => {document.getElementById('likecount').innerText = --likecount;});
			}
		});
	</script>
</body>

</html>
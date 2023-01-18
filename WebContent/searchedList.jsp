<%@page import="java.util.List"%>
<%@page import="user.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); //한글깨짐 방지
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

#content {
/*border: 1px solid red;*/
max-width: 800px;
padding-top: 20px;
padding-bottom: 20px;
margin-top: 100px;
}

#content ul{
list-style: none;
margin: 0;
padding: 0;
}
#content li{
/* border: 1px solid red; */
margin-top: 10px;
padding: 5px;
background-color: rgb(243, 242, 242);
overflow: hidden;
}
#content article{
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
#content h1{
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
#content p{
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
		String searchWord = null;
		if(request.getParameter("searchWord")!=null){
			searchWord = (String) request.getParameter("searchWord");
			System.out.println("searchword from parameter is :" + searchWord);
		}
		//페이지 넘어가도 검색어 유지되도록
		if(session.getAttribute("searchWord")!=null){
			searchWord = (String) session.getAttribute("searchWord");
			System.out.println("searchword from session is :" + searchWord);
		}
		String userID = null;
		int loginStudentNum = 0;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			loginStudentNum = (int) session.getAttribute("studentNum");
		}
%>
<%
	//DB연결, 검색한 게시글 목록 불러오기
	Dao dao = Dao.getInstance();
	List<Post> searchedList = dao.selectSearchedList(searchWord);

%>
<%-- header 부분 --%>
<header class="p-3 text-bg-dark" style="position:fixed; top:0; width: 100%; z-index: 1; background-color: #bddbd2 !important;">
		<div class="container-fluid">
			<div class="row">
				<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
					<a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"></a>

					<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
						<li><a href="main.jsp" class="nav-link px-2 text-dark fw-semibold">Home</a></li>
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
						<button type="button" class="btn btn-warning"
							role="button" aria-haspopup="true" aria-expanded="false">
							<a href="login.jsp">Login</a>
						</button>
						<button type="button" class="btn btn-outline-light me-2" role="button"
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



<%-- 실제 검색한 것이 나오는 장소 --%>
<div id="wrapper">
       <section id="content">
           <ul>
           <%
           		for (int i = 0; i <= searchedList.size() - 1; i++) {
           %>
               <li>
                   <article>
                       <div id="profile">     
                           <img src="image/blankProfile.jpg" alt="프로필사진">
                           <div id="ano">익명</div>
                           <div id="date"><%=searchedList.get(i).getDate() %></div>
                       </div>
                       <h1>
                       <a href="view.jsp?postNum=<%=searchedList.get(i).getPostNum()%>">
                       <%=searchedList.get(i).getTitle() %>
                       </a>
                       </h1>
                       <p>
                       <a href="view.jsp?postNum=<%=searchedList.get(i).getPostNum()%>">
                       <%=searchedList.get(i).getContent()%>
                       </a>
                       </p>
                       <div id="like-comment">
                           <span id="like">
                           <%
                           int likeOnOff = dao.LikeOnOff(searchedList.get(i).getPostNum(), loginStudentNum);
                           int countLike = dao.countLikePost(searchedList.get(i).getPostNum());
                    	   int countComment = dao.countCommentPost(searchedList.get(i).getPostNum());
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
               <%}%>
               
           </ul>
       </section>
   </div>

</body>
</html>
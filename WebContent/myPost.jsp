<%@page import="user.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
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
		int loginStudentNum = 1001; // 임의의 값 나중에 로그인 한 studentNum으로 바꿔주기
		Dao dao = Dao.getInstance();
		List<Post> postlist = dao.selectPostID(loginStudentNum, index_no);

		//내가 작성한 총 게시물 개수
		int totalPost = dao.countPostID(loginStudentNum);
		//
		int lastPostpage = (int) Math.ceil((double) totalPost / 10);
	%>
	
	<div id="showPage">
	<ul>
           <%
           for (int i = 0; i <= postlist.size() - 1; i++) {
           %>
               <li>
                   <article>
                       <div id="profile">     
                           <img src="image/blankProfile.jpg" alt="프로필사진">
                           <div id="ano">익명</div>
                           <div id="date"><%=postlist.get(i).getDate() %></div>
                       </div>
                       <h1>
                       <a href="view.jsp?postNum=<%=postlist.get(i).getPostNum()%>">
                       <%=postlist.get(i).getTitle() %></a>
                       </h1>
                       <p>
                       <a href="view.jsp?postNum=<%=postlist.get(i).getPostNum()%>">
                       <%=postlist.get(i).getContent() %></a>
                       </p>
                       <div id="like-comment">
                           <span id="like">
                           <%
                           int likeOnOff = dao.LikeOnOff(postlist.get(i).getPostNum(),loginStudentNum);
                           if	(likeOnOff == 0){
                           %>
                               <img src="image/OFF.png" alt="좋아요 수"> <%=postlist.get(i).getLikeCount()%>  
                        	<%
                           }else{
                        	 %>
                               <img src="image/ON.png" alt="좋아요 수"> <%=postlist.get(i).getLikeCount()%>  
                        	<%
                           }
                           %>
                           </span>
                           <span id="comment">
                               <img src="image/icon_comment.png" alt="댓글 수"> <%=postlist.get(i).getCommentCount()%>
                           </span>
                       </div>
                   </article>
               </li>
               <%} %>
               
           </ul>
		

		<!-- 페이징 -->
		<div style="width: 600px; text-align: center; margin-top: 10px;">
			<%
				//페이징
				int i;
				for (i = 1; i <= lastPostpage; i++) {
					//out.print("<a href='anolist2.jsp?postpage= "+i+"'>"+i+"</a> ");
					//위에처럼 해도 되고 아래처럼 해도 된다 - postpage 값 전달 되도록
			%>
			<%-- <button id="pageBtn<%=i%>"><%=i%></button> --%>
			<button class="pageBtn" value=<%=i %>><%=i%></button>
			<%
				}
			%>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
	
	$(function(){
			$(".pageBtn").click(function() {
				$.ajax({
					url : 'myPost.jsp?postpage='+ $(this).val(),
					success : function(x) {
						$('#showPage').html(x);
					}
				})
			});

	});
	</script>
</body>

</html>
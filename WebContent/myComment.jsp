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
	String userID = null;
	int studentNum = 0;
	if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
	studentNum = (int) session.getAttribute("studentNum");
	}
	
	//페이지 누르면 값 가져오기

	String commentpg = request.getParameter("commentpage");
	if (commentpg == null) {
		commentpg = "1";
	}
	int commentpage = Integer.parseInt(commentpg);
	//1->0 ; 2-> 10
	int index_no = (commentpage - 1) * 10;

	//DB연결, comment테이블정보 담은 리스트
	Dao dao = Dao.getInstance();
	List<Comment> commentList = dao.selectCommentID(studentNum, index_no);
	

	//내가 작성한 총 댓글 개수
	int totalComment = dao.countCommentID(studentNum);
	//
	int lastCommentpage = (int) Math.ceil((double) totalComment / 10);
	%>
	<div id="showPage">
	<ul>
           <%
           for (int i = 0; i <= commentList.size() - 1; i++) {
           %>
               <li>
                   <article>
                       <div id="profile"> 
                       <h1>
                       <a href="view.jsp?postNum=<%=commentList.get(i).getPostNum()%>">
                       <%=commentList.get(i).getTitle() %></a>
                       </h1>    
                       </div>
                       <div id="date"><%=commentList.get(i).getDate() %></div>
                       <p>
                       <a href="view.jsp?postNum=<%=commentList.get(i).getPostNum()%>">
                       <%=commentList.get(i).getCommentContent() %></a>
                       </p>
                   </article>
               </li>
               <%} %>
           </ul>
	

	<!-- 페이징 -->
	<div style="width: 600px; text-align: center; margin-top: 10px;">
		<%
		//페이징
		for (int i = 1; i <= lastCommentpage; i++) {
			//out.print("<a href='anolist2.jsp?commentpage= "+i+"'>"+i+"</a> ");
			//위에처럼 해도 되고 아래처럼 해도 된다 - commentpage 값 전달 되도록
		%>
		<button class="pageBtn" value=<%=i %>><%=i%></button>
		<%
		}
		%>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
	$(function(){
		$(".pageBtn").click(function() {
			$.ajax({
				url : 'myComment.jsp?postpage='+ $(this).val(),
				success : function(x) {
					$('#showPage').html(x);
				}
			})
		});

	});
	</script>
</body>

</html>
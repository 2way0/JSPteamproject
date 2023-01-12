<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>


<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initail-scale="1"> 
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP  게시판 웹 사이트</title>
</head>
<body>
	<%	
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		int postNum= 0;
		if(request.getParameter("postNum") !=null){
			postNum = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		System.out.println(postNum);
		
		
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 진행하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else{
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력이 안된 사항이 있습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						
						Dao dao = Dao.getInstance();
						int result = dao.write(request.getParameter("bbsTitle"), userID, request.getParameter("bbsContent"));
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패했습니다')");
							script.println("history.back()");
							script.println("</script>");
						} else{
							
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'anolist.jsp'");
							script.println("</script>");
						} 
					}
		}
	
		
		
	%>
</body>
</html>
<%@page import="user.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% int postNum = 0;
	if(request.getParameter("postNum") != null){
		postNum = Integer.parseInt(request.getParameter("postNum"));
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Dao dao = Dao.getInstance();
	dao.delete(postNum);
%>
<script>
		location.href = 'anolist.jsp';
</script>
</body>
</html>
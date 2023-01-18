<%@page import="java.io.PrintWriter"%>
<%@ page import="java.io.File"%>
<%@page import="user.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" href="./style.css" type="text/css">
<meta name="viewport" content="width=device-width" initail-scale="1">
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
<!-- 글목록css -->
<style>
html,
body {
  height: 100%;
}

body {
  display: flex;
  align-items: center;
  padding-top: 40px;
  padding-bottom: 40px;
  background-color: #f5f5f5;
}

.form-signin {
  max-width: 330px;
  padding: 15px;
}

.form-signin .form-floating:focus-within {
  z-index: 2;
}

.form-signin input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
</style>

</head>
<title>메인창</title>
</head>

<body>
	<% String userID=null; if(session.getAttribute("userID") !=null){ userID=(String)
                        session.getAttribute("userID"); } %>
	<header class="p-3 text-bg-dark"
		style="position: fixed; top: 0; width: 100%; z-index: 1;"">
		<div class=" container-fluid">
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
					</ul>

					<form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
						<input type="search"
							class="form-control form-control-dark text-bg-dark"
							placeholder="Search..." aria-label="Search">
					</form>
					<% if(userID==null){ %>
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
					<% } else { %>
					<div class="text-end">
						<button type="button" class="btn btn-outline-light me-2"
							role="button" aria-haspopup="true" aria-expanded="false">
							<a href="logoutAction.jsp">LogOut</a>
						</button>

					</div>
					<% } %>
				</div>
			</div>
		</div>
	</header>


	<main class="form-signin w-100 m-auto">
	  <form method="post" action="joinAction.jsp">
	    <img class="mb-4" src="image/shelter.png">
	
	    <div class="form-floating">
	      <input type="text" class="form-control" placeholder="아이디"
							name="userID" maxlength="20";>
	      <label for="floatingInput">아이디</label>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20">
	      <label for="floatingPassword">패스워드</label>
	    </div>
	    <div class="form-floating">
	      <input type="text" class="form-control" placeholder="닉네임 설정"
							name="userNicname" maxlength="20";>
	      <label for="floatingNickname">닉네임 설정</label>
	    </div>
	    <div class="form-floating">
	      <input type="email" class="form-control" placeholder="이메일"
							name="userEmail" maxlength="20">
	      <label for="floatingEmail">이메일</label>
	    </div>
	
	    <div class="checkbox mb-3">
	      <label>
	        <input type="checkbox" value="remember-me"> 이 내용을 저장하시겠습니까?
	      </label>
	    </div>
	    <button class="w-100 btn btn-lg btn-primary" type="submit">회원 가입</button>
	    <p class="mt-5 mb-3 text-muted">&copy; 2017–2023</p>
	  </form>
	 </main>

</body>

</html>
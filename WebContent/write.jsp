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

</style>

</head>
<title>메인창</title>
</head>

<body>
	<% String userID=null; if (session.getAttribute("userID") !=null) { userID=(String)
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
					<% if (userID==null) { %>
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




	<div class="container">
		<div class="row">
			<main style="margin-top: 90px">
			<div class="container">
				<div class="row">
					<form method="post" encType="multipart/form-data"
						action="writeAction.jsp" id="ActionBtn">
						<table class="table table-striped"
							style="text-align: center border:1px solid #dddddd">
							<thead>
								<tr>
									<th colspan="2"
										style="background-color: #eeeeee; text-align: center;">
										게시판 글쓰기 양식</th>

								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="text-align: center"><input type="text"
										class="form-control" placeholder="글 제목" name="bbsTitle"
										maxlength="50"></td>
								</tr>
								<tr>
									<td style="text-align: center"><textarea
											class="form-control" placeholder="글 내용" name="bbsContent"
											maxlength="2048" style="height: 350px;"></textarea></td>
								</tr>

								<tr>
									<td colspan="5"><label class="input-file-btn"
										for="input-file"><img src="image/camera2.png"
											id="input-btn-png"> </label> <input id="input-file" type="file"
										name="fileName" style="display: none"></td>
								</tr>
							</tbody>
						</table>
						<input type="submit" value="글쓰기" onclick="clickBtn()"
							class="btn btn-success offset-10" style="width: 75px;">
					</form>
				</div>
			</div>
			</main>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.6.3.js"
		integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
		crossorigin="anonymous"></script>
	<script>
                            function clickBtn() {
                                $('#actionBtn').submit();
                            }
                        </script>
</body>

</html>
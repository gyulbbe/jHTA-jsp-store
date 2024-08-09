<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>애플리케이션</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<div class="container-fluid">
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="/store/index.jsp">홈</a>
			</li>
			<li class="nav-item">
				<a class="nav-link active" href="/store/admin/product/home.jsp">상품관리</a>
			</li>
		</ul>
	</div>
</nav>
<div class="container mt-4 mt-5">
	<h1>상품 상세정보</h1>
	
	<table class="table table-bordered">
		<colgroup>
			<col width="15%">
			<col width="35%">
			<col width="15%">
			<col width="35%">
		</colgroup>
		<thead class="table-dark">
			<tr>
				<th>항목</th>
				<th>값</th>
				<th>항목</th>
				<th>값</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>이름</th>
				<td>LG그램 노트북</td>
				<th>번호</th>
				<td>10</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>컴퓨터/노트북</td>
				<th>제조회사</th>
				<td>LG전자</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>2,000,000 원</td>
				<th>할인가격</th>
				<td>1,800,000 원</td>
			</tr>
			<tr>
				<th>재고수량</th>
				<td>10</td>
				<th>상태</th>
				<td>판매중</td>
			</tr>
			<tr>
				<th>등록일자</th>
				<td>2024-07-01</td>
				<th>수정일자</th>
				<td>2024-07-01</td>
			</tr>
			<tr>
				<th>설명</th>
				<td colspan="3">짱 좋은 놋북!</td>
			</tr>
			<tr>
				<th>추가혜택</th>
				<td colspan="3">
					<span class="badge bg-success">무료배송</span>
					<span class="badge bg-success">당일배송</span>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="text-end">
		<a href="modifyForm.jsp" class="btn btn-warning">수정</a>
		<a href="delete.jsp" class="btn btn-danger">삭제</a>
		<a href="home.jsp" class="btn btn-primary">목록</a>
	</div>
</div>
</body>
</html>
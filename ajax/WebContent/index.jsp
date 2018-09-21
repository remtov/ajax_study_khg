<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 반응형웹 해상도관련 처리 -->

<link rel="stylesheet" href="css/bootstrap.css">
<!-- 기본 부트스트랩 매칭 -->
<title>JSP AJAX</title>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 제이쿼리 공식 버전링크 -->
<script src="js/bootstrap.js"></script>
<!-- 내부 부트스트랩 제이쿼리파일 링크 -->
<script>
	//2.타입택스트/자바스크립트는 없어도되지만 브라우저입장에서 안정적이므로 넣어주는 습관이좋다.
			window.onload =function(){
			searchFunction();//처음 페이지로딩이 끝났을때 해당함수를 실행할수있게 해서 아무것도 입력안됬을때도 결과가 출력될수 있게
		} 
	var request = new XMLHttpRequest();//3.웹사이트에 요청을보내는 인스턴스

	function searchFunction() {
		request.open("POST",
				"./UserSearchServlet?userName="
						+ encodeURIComponent(document
								.getElementById("userName").value), true);
		//4.파라메터를 username 입력한 내용이 UTF8으로 인코딩되서실제 파라미터로 넘어가게 된다. 서블릿은  유저네임을 받아서 처리후 제이슨으로 내보낸다. 우리는 그제이슨을 결과로 받아서 출력해주면된다.
		request.onreadystatechange = searchProcess;//성공적으로 요청한 동작이 끝났다면 서치프로세스를 실행한다.
		request.send();
	}

	function searchProcess() {
		var table = document.getElementById("ajaxTable");//5.서치펑션에서 수행한 내용을 바탕으로 티바디에 실행할 부분을 작성한다.
		table.innerHTML = "";//6.만든 table변수에 빈공간을 넣어줌으로써 tbody를 우선 비워준다. 
		if (request.readyState == 4 && request.status == 200) {//두개의 경우가 맞을때에만 실행하는 실행부 
			var object = eval('(' + request.responseText + ')');//제이슨을 받고
			var result = object.result;//서블릿클래스의 리절트 회원정보가 담긴 내용들을 가져오겠다는 뜻 //오브젝트의 리설트를 담는다.	
			for (var i = 0; i < result.length; i++) {//넘어온결과의 길이까지 반복한다.
				var row = table.insertRow(0);//튜플하나를 생성
				for (var j = 0; j < result[i].length; j++) {//한배열의 값이 끝날때까지 반복 컬럼내용의 키벨류를 탐색
					var cell = row.insertCell(j); //현행에 j번째에 셀을 생성
					cell.innerHTML = result[i][j].value;//셀의내용마다 인덱스의 값들을 넣어주도록한다. 사용자데이터의 내용만큼 행이만들어지고 값으로 정보가들어간다. 

				}
			}
		} else {
			console.log("잘못입력해따")
		}

	}
</script>
</head>

<body>
	<br>
	<div class="container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<!-- 전해상도에서 12중 8의 자리차지하는 div -->
				<input class="form-control" id="userName" onkeyup="searchFunction()"
					type="text" size="20">
				<!-- onkeyup설정은 우리가 입력할떄마다 서치펑션을 실행시켜 준다. //입력하는 공간의 아이디를 설정해준다. //20글자들어가는 검색창 -->

			</div>
			<div class="col-xs-2">
				<!-- 12중 2크기 -->
				<button class="btn btn-primary" onclick="searchFunction();"
					type="button">검색</button>
				<!-- onclick 클릭했을 때 펑션을 실행할 수 있도록 한다. //검색버튼  -->


			</div>
		</div>
		<table class="table"
			style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #fafafa; text-align: center;">이름</th>
					<th style="background-color: #fafafa; text-align: center;">나이</th>
					<th style="background-color: #fafafa; text-align: center;">성별</th>
					<th style="background-color: #fafafa; text-align: center;">이메일</th>
				</tr>
			</thead>
			<tbody id="ajaxTable">
				<!-- 1 서치펑션실행으로 인한 출력부로써의 역할을 하게될 티바디에 고유아이디를 부여하여준다. -->
				<tr>
					<td>null</td>
					<td>null</td>
					<td>null</td>
					<td>null</td>

				</tr>
			</tbody>

		</table>

	</div>
	<div class="container">
	<table class="table" style="text-align:center; border: 1px solid #dddddd">
	<thead>
	<tr>
	<th colspan="2" style="background-color:#fafafa; text-align:center;">회원 등록 양식</th>
	</tr>
	</thead>
	<tbody>
	<tr>
	<td style="background-color:#fafafa; text-align:center;"><h5>이름</h5></td>
	<td><input class ="form-control" type="text" id="registerName" size="20"></td>
	</tr>
	
	<tr>
	<td style="background-color:#fafafa; text-align:center;"><h5>나이</h5></td>
	<td><input class ="form-control" type="text" id="registerName" size="20"></td>
	</tr>
	
	<tr>
	<td style="background-color:#fafafa; text-align:center;"><h5>성별</h5></td>
	<td><div class="form-group" style="text-align:center; margin:0 auto;"><div class="btn-group" data</div></td>
	</tr>
	
	<tr>
	<td style="background-color:#fafafa; text-align:center;"><h5>이메일</h5></td>
	<td><input class ="form-control" type="text" id="registerName" size="20"></td>
	</tr>
	
	
	</tbody>
	</table>
	
	</div>

</body>
</html>
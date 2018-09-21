package user;
//요청에 의해 JSON을 만들어내는 역할을 서블릿이 한다.

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");// 넘어온 값을 UTF-8로 처리할것을 선언
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");// 요청에 담긴 파라매터값을 넣어준다.
		try {
			response.getWriter().write(getJSON(userName));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//사용자가 입력한내용을 토대로 데이터베이스 내요을 출력할수있도록하는 명령

	}

	public String getJSON(String userName) throws SQLException { // 특정한 입력한 이름을 토대로 데이터베이스에서 검색하여 결과를 제이슨형태로 출력해준다. //하나의 함수 제이슨 파싱하기 쉬운 형태로
												// 사용자에게 보여주는것을 만든다. 요청이 JSON형태의 결과로 보여진다.
		if (userName == null)
			userName = ""; // 유저네임이 널값이라면 유저네임에 공백을 넣어준다.
		StringBuffer result = new StringBuffer("");// 스트링버퍼에 공백문자열을 넣어준다.
		result.append("{\"result\":[");// 결과를 담을 수 있도록 한다.
		UserDAO userDAO = new UserDAO();// 데이터베이스에서 회원리스트를 가져오기위해 준비
		ArrayList<User> userList = userDAO.search(userName);// 서치라는 함수를 실행하는 것을 가져와서 넣어준다.
		for (int i = 0; i < userList.size(); i++) {// 리스트결과전체갯수만큼반복 개별사용자들은 그정보를 JSON으로 출력할 수 있도록 만들어준다.
			result.append("[{\"value\":\"" + userList.get(i).getUserName() + "\"},");
			result.append("{\"value\":\"" + userList.get(i).getUserAge() + "\"},");
			result.append("{\"value\":\"" + userList.get(i).getUserEmail() + "\"},");
			result.append("{\"value\":\"" + userList.get(i).getUserGender() + "\"}],");

		}
		result.append("]}");// 29라인에서 연것을 여기서 닫아주면 된다.
		return result.toString();// 마지막 그 결과를 반환해준다.

	}

}

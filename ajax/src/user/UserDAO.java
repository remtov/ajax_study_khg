package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAO {
	// 데이터베이스에서 꺼내는 역할을 하는 클래스 database access object
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
		// 클래스에서 인스턴스를 만들었을 때 자동으로 초기화 해줄 수 있도록 생성자를 만든다.
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";// 데이터베이스 url지정
			String dbID = "ictu";
			String dbPassword = "12345678";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<User> search(String userName) throws SQLException {// 데이터베이스안에 있는 회원정보들을 어레이리스트로 가져온다.
		String SQL = "SELECT * FROM USER_INFO WHERE userName LIKE '%' ||?|| '%'";//||기호는 홀따옴표의 위치를 쿼리상으로 연결해주는 역할을 한다. // ?에 해당하는 글자가 무엇인지에 따라 유저네임컬럼의 내용을 매칭하여 실시간으로
																		// 데이터베이스를
		// 조회한다.

		ArrayList<User> userList = new ArrayList<User>();// 메모리생성
		try {
			pstmt = conn.prepareStatement(SQL);// 프리페이스테이트먼트 인스턴트안에 연결된 데이터베이스 sql문장을 넣어준다. 넣어준다
			pstmt.setString(1,userName);// 물음표에 해당하는 내용에 유저네임이들어가니 파라미터로 넘어온 유저네임을 적어준다.

			rs = pstmt.executeQuery();// 결과가 나오면 실행을 해서 담아준다.

			while (rs.next()) {
				User user = new User();
				user.setUserName(rs.getString(1));
				user.setUserAge(rs.getInt(2));
				user.setUserGender(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				userList.add(user);
				// 결과로 무엇인가 나왔다면 하나씩 읽어들이면서 리스트안에 사용자정보를 담는다.
			}

		} catch (SQLException e) {
			e.printStackTrace();

		}finally {
			pstmt.close();
			rs.close();
			conn.commit();
			conn.close();
			
		}
		return userList;// 결과적으로 함수를 불러온쪽에 리스트에 담견 모든정보를 넘겨주는 역할을 한다.

	}
}

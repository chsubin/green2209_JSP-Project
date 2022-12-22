package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class GetConn {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String driver ="com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/green2209_20";
	private String user = "root";
	private String password = "1234";
	
	private static GetConn instance = new GetConn();
	
	private GetConn() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,user,password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패~~");
		} catch (SQLException e) {
			System.out.println("Database 연동실패~~");
		} 
	}
	
	public Connection getConn() {
		return conn;
	}

	//객체 소멸처리
	public void pstmtClose() {
		if(pstmt!=null) {
			try {
				pstmt.close();
			} catch (Exception e) {}
		}
	}
	public void rsClose() {
		if(rs!=null) {
			try {
				rs.close();
				pstmtClose();
			}catch (Exception e) {}
		}
	}
	
	public static GetConn getInstance() {
		return instance;
	}
	
	
}

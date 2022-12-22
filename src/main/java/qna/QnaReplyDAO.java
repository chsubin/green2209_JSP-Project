package qna;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import hotel.HotelVO;


public class QnaReplyDAO {
	//싱글톤을 활용한 DB연결
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn(); //conn은 스태틱으로 올라온 함수이므로 계속 같은 객체가 불리는것!
	private PreparedStatement pstmt =null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	QnaReplyVO vo = null;
	
	public ArrayList<QnaReplyVO> getQnAReplyList(int startIndexNo, int pageSize) {
		ArrayList<QnaReplyVO> vos = new ArrayList<>();
		try {
			System.out.println(startIndexNo+"  "+pageSize);
			sql= "select * from qnaReply order by qnaidx desc;";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(sql);
			
			while(rs.next()) {
				vo= new QnaReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setQnaIdx(rs.getInt("qnaidx"));
				vo.setMid(rs.getString("mid"));
				vo.setrDate(rs.getString("rDate"));
				vo.setContent(rs.getString("content"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql오류~~: "+e.getMessage());
		}finally {
			getConn.rsClose();
		}
		
		return vos;
	}
	public String qnaReplyInput(int qnaIdx, String mid, String content) {
		String res="0";
		try {
			sql ="insert into qnaReply values (default,?,?,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qnaIdx);
			pstmt.setString(2, mid);
			pstmt.setString(3, content);
			pstmt.executeUpdate();
			res="1";
		} catch (SQLException e) {
			System.out.println("sql오류~~: "+e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		
		return res;
	}

	
	public String qnaReplyDelete(int idx) {
		String res="0";
		try {
			sql="delete from qnaReply where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res="1";
		} catch (SQLException e) {
			System.out.println("sql오류 : "+e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		return res;
	}	
	
	
	
}

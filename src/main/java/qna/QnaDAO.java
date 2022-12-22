package qna;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import hotel.HotelVO;


public class QnaDAO {
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn(); //conn은 스태틱으로 올라온 함수이므로 계속 같은 객체가 불리는것!
	private PreparedStatement pstmt =null;
	private ResultSet rs = null;
	
	private String sql = "";
	QnaVO vo = null;
	
	
	//전체 개수 가져오기
	public int totRecCnt() {
		int totRecCnt=0;
		try {
			sql = "select count(*) as cnt from qna";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();			
			
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("sql오류~~");
		}finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}
	/*큐엔에이 리스트 불러오기*/
	public ArrayList<QnaVO> getQnaList(int startIndexNo, int pageSize) {
		ArrayList<QnaVO> vos = new ArrayList<>();
		try {
			sql="select * from qna order by idx desc limit ?,? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new QnaVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setMid(rs.getString("mid"));
				vo.setEmail(rs.getString("email"));
				vo.setDay(rs.getString("day"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("sql오류 : "+e.getMessage());
		}finally {
			getConn.rsClose();
		}
		return vos;
		
	}
	public int qnaInput(QnaVO vo) {
		int res=0;
		try {
			sql ="insert into qna values (default,?,?,?,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getMid());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getHostIp());
			pstmt.setString(5, vo.getContent());
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("sql오류 : "+e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		return res;
	}
	public String qnaDelete(int idx) {
		String res="0";
		try {
			sql="delete from qna where idx=?";
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
	public ArrayList<QnaVO> getQnaList(int su, String mid) {
		ArrayList<QnaVO> vos = new ArrayList<>();
		try {
			sql="select * from qna  where mid=? order by idx desc limit ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, su);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new QnaVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setMid(rs.getString("mid"));
				vo.setEmail(rs.getString("email"));
				vo.setDay(rs.getString("day"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				vos.add(vo);
			}
			
		} catch (SQLException e) {
			System.out.println("sql오류 : "+e.getMessage());
		}finally {
			getConn.rsClose();
		}
		return vos;
	}
}

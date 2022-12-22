package pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class PdsReplyDAO {
		//싱글톤을 활용한 DB연결
		GetConn getConn = GetConn.getInstance();
		
		private Connection conn = getConn.getConn(); //conn은 스태틱으로 올라온 함수이므로 계속 같은 객체가 불리는것!
		private PreparedStatement pstmt =null;
		private ResultSet rs = null;
		
		private String sql = "";
		PdsReplyVO vo = null;
		
		
		public ArrayList<PdsReplyVO> getReply(int idx) {
			ArrayList<PdsReplyVO> vos = new ArrayList<>();
			try {
				sql ="select r.* from pdsReply r,pds p where p.idx = r.pdsIdx and p.idx=?;";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					vo= new PdsReplyVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setPdsIdx(rs.getInt("pdsIdx"));
					vo.setMid(rs.getString("mid"));
					vo.setrDate(rs.getString("rDate"));
					vo.setContent(rs.getString("content"));
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("sql오류: "+e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return vos;
		}


		public String setReply(int pdsIdx, String mid, String content) {
			String res="0";
			try {
				sql ="insert into pdsReply values(default,?,?,default,?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pdsIdx);
				pstmt.setString(2, mid);
				pstmt.setString(3, content);
				pstmt.executeUpdate();
				res="1";
			} catch (SQLException e) {
				System.out.println("sql오류: "+e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}


		public String replyDelete(int idx) {
			String res = "0";
			try {
				sql ="delete from pdsReply where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
				res="1";
			} catch (SQLException e) {
				System.out.println("sql오류: "+e.getMessage());
			} finally {
				getConn.pstmtClose();
			}	return res;
		}
		
		
		
			
}

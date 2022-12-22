package pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class PdsDAO {
		//싱글톤을 활용한 DB연결
		GetConn getConn = GetConn.getInstance();
		
		private Connection conn = getConn.getConn(); //conn은 스태틱으로 올라온 함수이므로 계속 같은 객체가 불리는것!
		private PreparedStatement pstmt =null;
		private ResultSet rs = null;
		
		private String sql = "";
		PdsVO vo = null;
		
		public int totRecCnt(String searchfield, String search) {
			int totRecCnt=0;
			try {
				if(searchfield.equals("nickName")&&!search.equals("")) {
					sql = "select count(*) as cnt from pds where mid like ? or midName like ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
					pstmt.setString(2, "%"+search+"%");
				}
				else if(search.equals("")) {
					sql ="select count(*) as cnt from pds";
					pstmt = conn.prepareStatement(sql);
				}
				else {
					sql ="select count(*) as cnt from pds where "+searchfield+" like ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
				}
				rs = pstmt.executeQuery();
				
				rs.next();
				totRecCnt = rs.getInt("cnt");
				
			} catch (SQLException e) {
				System.out.println(sql);
				System.out.println("sql 오류: "+e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return totRecCnt;
		}

		public ArrayList<PdsVO> getPdsList(int startIndexNo, int pageSize, String searchfield, String search) {
			ArrayList<PdsVO> vos = new ArrayList<>();
			try {
				if(searchfield.equals("nickName")&&!search.equals("")) {
					sql = "SELECT 	*,datediff(now(), fDate) as day_diff, "
							+ "timestampdiff(hour, fDate, now()) as hour_diff, "
							+ " (select count(*)  from pdsReply r where pds.idx = r.pdsIdx) as replyCnt "
							+ "FROM pds where mid like ? or midName like ? order by idx desc "
							+ "limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
					pstmt.setString(2, "%"+search+"%");
					pstmt.setInt(3, startIndexNo);
					pstmt.setInt(4, pageSize);
				}
				else if(!search.equals("")) {
					sql = "SELECT 	*,datediff(now(), fDate) as day_diff, "
							+ "timestampdiff(hour, fDate, now()) as hour_diff, "
							+ " (select count(*)  from pdsReply r where pds.idx = r.pdsIdx) as replyCnt "
							+ "FROM pds where "+searchfield+" like ? order by idx desc "
							+ "limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
					pstmt.setInt(2, startIndexNo);
					pstmt.setInt(3, pageSize);
					
				}
				else{
					sql = "SELECT 	*,datediff(now(), fDate) as day_diff, "
							+ "timestampdiff(hour, fDate, now()) as hour_diff, "
							+ "(select count(*) from pdsReply r where pds.idx = r.pdsIdx) as replyCnt "
							+ "FROM pds order by idx desc "
							+ "limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, startIndexNo);
					pstmt.setInt(2,pageSize);
				}
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new PdsVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setMidName(rs.getString("midname"));
					vo.setRvIdx(rs.getString("rvIdx"));
					vo.setRoomIdx(rs.getInt("roomIdx"));
					vo.setRoomName(rs.getString("roomName"));
					vo.setCheckIn(rs.getString("checkIn"));
					vo.setCheckOut(rs.getString("checkOut"));
					vo.setfName(rs.getString("fName"));
					vo.setfSName(rs.getString("fSName"));
					vo.setTitle(rs.getString("title"));
					vo.setfDate(rs.getString("fDate"));
					vo.setContent(rs.getString("content"));
					vo.setHostIp(rs.getString("hostIp"));
					vo.setReadNum(rs.getInt("readNum"));
					vo.setDay_diff(rs.getInt("day_diff"));
					vo.setHour_diff(rs.getInt("hour_diff"));
					vo.setReplyCnt(rs.getInt("replyCnt"));;
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println(sql);
				System.out.println("sql 오류: "+e.getMessage());
			} finally {
				getConn.rsClose();
			}		
			return vos;
		}
		public ArrayList<PdsVO> getPdsList(int startIndexNo, int pageSize, String searchfield, String search,String main) {
			ArrayList<PdsVO> vos = new ArrayList<>();
			try {
				sql = "SELECT 	*,datediff(now(), fDate) as day_diff, "
						+ "timestampdiff(hour, fDate, now()) as hour_diff, "
						+ "(select count(*) from pdsReply r where pds.idx = r.pdsIdx) as replyCnt "
						+ "FROM pds where roomName!='' order by idx desc "
						+ "limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2,pageSize);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new PdsVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setMidName(rs.getString("midname"));
					vo.setRvIdx(rs.getString("rvIdx"));
					vo.setRoomIdx(rs.getInt("roomIdx"));
					vo.setRoomName(rs.getString("roomName"));
					vo.setCheckIn(rs.getString("checkIn"));
					vo.setCheckOut(rs.getString("checkOut"));
					vo.setfName(rs.getString("fName"));
					vo.setfSName(rs.getString("fSName"));
					vo.setTitle(rs.getString("title"));
					vo.setfDate(rs.getString("fDate"));
					vo.setContent(rs.getString("content"));
					vo.setHostIp(rs.getString("hostIp"));
					vo.setReadNum(rs.getInt("readNum"));
					vo.setDay_diff(rs.getInt("day_diff"));
					vo.setHour_diff(rs.getInt("hour_diff"));
					vo.setReplyCnt(rs.getInt("replyCnt"));;
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println(sql);
				System.out.println("sql 오류: "+e.getMessage());
			} finally {
				getConn.rsClose();
			}		
			return vos;
		}

		public PdsVO getPds(int idx) {
			vo = new PdsVO();
			try {
				sql="select * from pds where idx =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setMidName(rs.getString("midName"));
					vo.setRvIdx(rs.getString("rvIdx"));
					vo.setRoomIdx(rs.getInt("roomIdx"));
					vo.setRoomName(rs.getString("roomName"));
					vo.setCheckIn(rs.getString("checkIn"));
					vo.setCheckOut(rs.getString("checkOut"));
					vo.setfName(rs.getString("fName"));
					vo.setfSName(rs.getString("fSName"));
					vo.setTitle(rs.getString("title"));
					vo.setfDate(rs.getString("fDate"));
					vo.setContent(rs.getString("content"));
					vo.setHostIp(rs.getString("hostIp"));
					vo.setReadNum(rs.getInt("readNum"));
				}
				
			} catch (SQLException e) {
				System.out.println(sql);
				System.out.println("sql 오류: "+e.getMessage());
			} finally {
				getConn.rsClose();
			}					
			return vo;
		}

		public PdsVO getPreNextSearch(String str, int idx) {
			vo = new PdsVO();
			try {
				if(str.equals("pre")) {
					sql = "select * from pds where idx < ? order by idx desc limit 1";
				}
				else {
					sql = "select * from pds where idx > ? limit 1";				
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				if(str.equals("pre") && rs.next()) {
					vo.setPreIdx(rs.getInt("idx"));
					vo.setPreTitle(rs.getString("title"));
				}
				else if(str.equals("next") && rs.next()) {
					vo.setNextIdx(rs.getInt("idx"));
					vo.setNextTitle(rs.getString("title"));				
				}
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vo;
		}

		public int pdsInput(PdsVO vo) {
			int res =0;
			try {
				sql ="insert into pds values (default,?,?,?,?,?,?,?,?,?,?,default,?,?,default);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getMid());
				pstmt.setString(2, vo.getMidName());
				pstmt.setString(3, vo.getRvIdx());
				pstmt.setInt(4, vo.getRoomIdx());
				pstmt.setString(5, vo.getRoomName());
				pstmt.setString(6, vo.getCheckIn());
				pstmt.setString(7, vo.getCheckOut());
				pstmt.setString(8, vo.getfName());
				pstmt.setString(9, vo.getfSName());
				pstmt.setString(10, vo.getTitle());
				pstmt.setString(11, vo.getContent());
				pstmt.setString(12, vo.getHostIp());
				pstmt.executeUpdate();
				res=1;
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			
			return res;
		}

		public PdsVO getPds(String rvIdx) {
			vo = new PdsVO();
			try {
				sql="select * from pds where rvIdx=? order by idx desc limit 1";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, rvIdx);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setMidName(rs.getString("midName"));
					vo.setRvIdx(rs.getString("rvIdx"));
					vo.setRoomIdx(rs.getInt("roomIdx"));
					vo.setRoomName(rs.getString("roomName"));
					vo.setCheckIn(rs.getString("checkIn"));
					vo.setCheckOut(rs.getString("checkOut"));
					vo.setfName(rs.getString("fName"));
					vo.setfSName(rs.getString("fSName"));
					vo.setTitle(rs.getString("title"));
					vo.setfDate(rs.getString("fDate"));
					vo.setContent(rs.getString("content"));
					vo.setHostIp(rs.getString("hostIp"));
					vo.setReadNum(rs.getInt("readNum"));
				}
				
			} catch (SQLException e) {
				System.out.println(sql);
				System.out.println("sql 오류: "+e.getMessage());
			} finally {
				getConn.rsClose();
			}					
			return vo;
		}

		public int pdsUpdate(PdsVO vo) {
			int res = 0;
			try {
				sql="update pds set title=?, fName=?,fSName=?,content=?,hostIp=? where idx=?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setString(1, vo.getTitle());
				pstmt.setString(2, vo.getfName());
				pstmt.setString(3, vo.getfSName());
				pstmt.setString(4, vo.getContent());
				pstmt.setString(5, vo.getHostIp());
				pstmt.setInt(6, vo.getIdx());
				pstmt.executeUpdate();
				res=1;
			} catch (SQLException e) {
				System.out.println(sql);
				System.out.println("sql 오류: "+e.getMessage());
			} finally {
				getConn.rsClose();
			}		
			return res;
		}

		public int setPdsDelete(int idx) {
			int res = 0;
			try {
				sql ="delete from pds where idx = ?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
				res=1;
			} catch (SQLException e) {
				System.out.println(sql);
				System.out.println("sql 오류: "+e.getMessage());
			} finally {
				getConn.pstmtClose();
			}		
			return res;
		}

		public void setReadNumPlus(int idx) {
			try {
				sql = "update pds set readNum = readNum + 1 where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 에러 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
		}

		public int setPdsUpdateDelete(int idx) {
			int res = 0;
			try {
				sql ="update pds set mid='',midName='',rvIdx='',roomIdx=0,roomName='',fName='',fSname='',content='삭제된 게시글입니다.',title='삭제된 게시글입니다.' where idx = ?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
				res=1;
			} catch (SQLException e) {
				System.out.println(sql);
				System.out.println("sql 오류: "+e.getMessage());
			} finally {
				getConn.pstmtClose();
			}		
			return res;
		}

		public ArrayList<PdsVO> getPdsList(int startIndexNo, int pageSize) {
			ArrayList<PdsVO> vos = new ArrayList<>();
			try {
				sql = "SELECT 	*,datediff(now(), fDate) as day_diff, "
						+ "timestampdiff(hour, fDate, now()) as hour_diff, "
						+ "(select count(*) from pdsReply r where pds.idx = r.pdsIdx) as replyCnt "
						+ "FROM pds where fSName like '%jpg%' or  fSName like '%PNG%'  order by idx desc "
						+ "limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2,pageSize);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new PdsVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setMidName(rs.getString("midname"));
					vo.setRvIdx(rs.getString("rvIdx"));
					vo.setRoomIdx(rs.getInt("roomIdx"));
					vo.setRoomName(rs.getString("roomName"));
					vo.setCheckIn(rs.getString("checkIn"));
					vo.setCheckOut(rs.getString("checkOut"));
					vo.setfName(rs.getString("fName"));
					vo.setfSName(rs.getString("fSName"));
					vo.setTitle(rs.getString("title"));
					vo.setfDate(rs.getString("fDate"));
					vo.setContent(rs.getString("content"));
					vo.setHostIp(rs.getString("hostIp"));
					vo.setReadNum(rs.getInt("readNum"));
					vo.setDay_diff(rs.getInt("day_diff"));
					vo.setHour_diff(rs.getInt("hour_diff"));
					vo.setReplyCnt(rs.getInt("replyCnt"));;
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println(sql);
				System.out.println("sql 오류: "+e.getMessage());
			} finally {
				getConn.rsClose();
			}		
			return vos;
		}

		
}

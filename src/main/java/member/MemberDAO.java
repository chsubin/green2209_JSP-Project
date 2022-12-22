package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import qna.QnaVO;

public class MemberDAO {
		//싱글톤을 활용한 DB연결
		GetConn getConn = GetConn.getInstance();
		
		private Connection conn = getConn.getConn(); //conn은 스태틱으로 올라온 함수이므로 계속 같은 객체가 불리는것!
		private PreparedStatement pstmt =null;
		private ResultSet rs = null;
		
		private String sql = "";
		MemberVO vo = null;

		
			//아이디 체크(아이디가 있으면 vo를 데려온다.)
		public MemberVO getLoginCheck(String mid) {
			vo = new MemberVO();
			try {
				sql ="select *,datediff(now(), startDate) as day_diff from member where mid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				rs= pstmt.executeQuery();
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(mid);
					vo.setPwd(rs.getString("pwd"));
					vo.setNameKor(rs.getString("nameKor"));
					vo.setNameEng(rs.getString("nameEng"));
					vo.setGender(rs.getString("gender"));
					vo.setBirthday(rs.getString("birthday"));
					vo.setEmail(rs.getString("email"));
					vo.setPhoneNumber(rs.getString("phoneNumber"));
					vo.setHomeNumber(rs.getString("homeNumber"));
					vo.setAddress(rs.getString("address"));
					vo.setLevel(rs.getInt("level"));
					vo.setPoint(rs.getInt("point"));
					vo.setMemPoint(rs.getInt("memPoint"));
					vo.setStartDate(rs.getString("startDate"));
					vo.setLastDate(rs.getString("lastDate"));
					vo.setUserDel(rs.getString("userDel"));
					vo.setDay_diff(rs.getInt("day_diff"));
					}
				else {
					vo=null;
				}
			} catch (Exception e) {
				System.out.println("SQL오류:"+e.getMessage());
			}finally {
				getConn.rsClose();
			}
			return vo;
		}	// TODO Auto-generated method stub

		public String memJoinOk(MemberVO vo) {
			String res ="0";
			try {
				sql ="insert into member values (default,?,?,?,?,?,?,?,?,?,?,default,default,default,default,default,default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getMid());
				pstmt.setString(2, vo.getPwd());
				pstmt.setString(3, vo.getNameKor());
				pstmt.setString(4, vo.getNameEng());
				pstmt.setString(5, vo.getGender());
				pstmt.setString(6, vo.getBirthday());
				pstmt.setString(7, vo.getEmail());
				pstmt.setString(8, vo.getPhoneNumber());
				pstmt.setString(9, vo.getHomeNumber());
				pstmt.setString(10, vo.getAddress());
				pstmt.executeUpdate();
				res="1";
			} catch (Exception e) {
				System.out.println("SQL오류:"+e.getMessage());
			}finally {
				getConn.pstmtClose();
			}
			return res;
		}
//아이디 찾는 메솓,
		public MemberVO getIdSearch(String name, String email) {
			vo=new MemberVO();
			try {
				sql ="select * from member where nameKor=? and email=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, email);
				rs= pstmt.executeQuery();
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNameKor(name);
					vo.setNameEng(rs.getString("nameEng"));
					vo.setGender(rs.getString("gender"));
					vo.setBirthday(rs.getString("birthday"));
					vo.setEmail(email);
					vo.setPhoneNumber(rs.getString("phoneNumber"));
					vo.setHomeNumber(rs.getString("homeNumber"));
					vo.setAddress(rs.getString("address"));
					vo.setLevel(rs.getInt("level"));
					vo.setPoint(rs.getInt("memPoint"));
					vo.setPoint(rs.getInt("point"));
					vo.setStartDate(rs.getString("startDate"));
					vo.setLastDate(rs.getString("lastDate"));
					vo.setUserDel(rs.getString("userDel"));
					
				}
			} catch (Exception e) {
				System.out.println("SQL오류:"+e.getMessage());
			}finally {
				getConn.rsClose();
			}
			return vo;
		}

		public String getPwdReset(String mid, String resetPwd) {
			String res="0";
			try {
				sql ="update member set pwd=? where mid=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, resetPwd);
				pstmt.setString(2, mid);
				pstmt.executeUpdate();
				res="1";
			} catch (Exception e) {
				System.out.println("SQL오류:"+e.getMessage());
			}finally {
				getConn.pstmtClose();
			}
			return res;
		}

		public int getLoginUpdate(String mid) {
			int res=0;
			try {
				sql="update member set lastDate=now() where mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.executeUpdate();
				res=1;
			} catch (Exception e) {
				System.out.println("SQL오류:"+e.getMessage());
			}	finally {
				getConn.pstmtClose();
			}
			return res;
		}
//정보 수정
		public String memUpdateOk(MemberVO vo) {
			String res ="0";
			try {
				sql ="update member set nameKor=? , nameEng=? , gender=? , birthday=? , email=? , phoneNumber=? , homeNumber=? , address=?;";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getNameKor());
				pstmt.setString(2, vo.getNameEng());
				pstmt.setString(3, vo.getGender());
				pstmt.setString(4, vo.getBirthday());
				pstmt.setString(5, vo.getEmail());
				pstmt.setString(6, vo.getPhoneNumber());
				pstmt.setString(7, vo.getHomeNumber());
				pstmt.setString(8, vo.getAddress());
				pstmt.executeUpdate();
				res="1";
			} catch (Exception e) {
				System.out.println("SQL오류:"+e.getMessage());
			}finally {
				getConn.pstmtClose();
			}
			return res;
		}

		public void setUpdatePoint(String mid, int point) {
			try {
				if(point>=0) { //포인트 적립
					sql = "update member set point= point +? , memPoint=memPoint+? where mid=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, point);
					pstmt.setInt(2, point);
					pstmt.setString(3, mid);
				}
				else { //포인트 사용
					sql = "update member set point= point +? where mid=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, point);
					pstmt.setString(2, mid);
				}
						
				pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.pstmtClose();
			}
		}
		public void setUpdatePoint(String mid, int point,String sw) {
			try {
				sql = "update member set point= point +?, memPoint = memPoint+? where mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, point);
				pstmt.setInt(2, point);
				pstmt.setString(3, mid);
				
				pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.pstmtClose();
			}
		}

		public String memUnresister(String mid) {
			String res ="0";
			try {
				sql = "update member set userDel='OK'  where mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.executeUpdate();
				res="1";
				
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.pstmtClose();
			}
			

			return res;
		}

		public String memLevelUpdate(int idx, int level) {
			String res="0";
			try {
				sql = "update member set level=? where idx=?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, level);
				pstmt.setInt(2, idx);
				pstmt.executeUpdate();
				res="1";
				
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}

		public String memDelete(int idx) {
			String res="0";
			try {
				sql = "delete from member where idx=?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
				res="1";
				
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}

		public int totRecCnt() {
			int totRecCnt =0;
			try {
				sql ="select count(*) as cnt from coupon";
				pstmt= conn.prepareStatement(sql);
				rs =pstmt.executeQuery();
				rs.next();
				totRecCnt = rs.getInt("cnt");
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.pstmtClose();
			}
			return totRecCnt;
		}

		public ArrayList<CouponVO> getCouponList(int startIndexNo, int pageSize) {
			ArrayList<CouponVO> vos = new ArrayList<>();
			CouponVO cvo =null;
			try {
				sql="select * from coupon order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					cvo = new CouponVO();
					cvo.setIdx(rs.getInt("idx"));
					cvo.setMid(rs.getString("mid"));
					cvo.setStartDay(rs.getString("startDay"));
					cvo.setLastDay(rs.getString("lastDay"));
					cvo.setTitle(rs.getString("title"));
					cvo.setPrice(rs.getInt("price"));
					cvo.setContent(rs.getString("content"));
					cvo.setUseSw(rs.getString("useSw"));
					vos.add(cvo);
				}
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.rsClose();
			}
			return vos;
		}

		public int getTot() {
			int totRecCnt=0;
			try {
				sql ="select count(*) as cnt from member";
				pstmt= conn.prepareStatement(sql);
				rs =pstmt.executeQuery();
				rs.next();
				totRecCnt = rs.getInt("cnt");
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.rsClose();
			}
			return totRecCnt;
		}

		public MemberVO getCouponMid(int su) {
			MemberVO vo = new MemberVO();
			try {
				sql="select * from member order by idx desc limit ?,1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, su);
					rs= pstmt.executeQuery();
					if(rs.next()) {
						vo.setIdx(rs.getInt("idx"));
						vo.setMid(rs.getString("mid"));
						vo.setPwd(rs.getString("pwd"));
						vo.setNameKor(rs.getString("nameKor"));
						vo.setNameEng(rs.getString("nameEng"));
						vo.setGender(rs.getString("gender"));
						vo.setBirthday(rs.getString("birthday"));
						vo.setEmail(rs.getString("email"));
						vo.setPhoneNumber(rs.getString("phoneNumber"));
						vo.setHomeNumber(rs.getString("homeNumber"));
						vo.setAddress(rs.getString("address"));
						vo.setLevel(rs.getInt("level"));
						vo.setPoint(rs.getInt("memPoint"));
						vo.setPoint(rs.getInt("point"));
						vo.setStartDate(rs.getString("startDate"));
						vo.setLastDate(rs.getString("lastDate"));
						vo.setUserDel(rs.getString("userDel"));
				}
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.rsClose();
			}
			return vo;
		}

		public ArrayList<CouponVO> getCouponList(String mid) {
			ArrayList<CouponVO> vos = new ArrayList<>();
			CouponVO cvo =null;
			try {
				sql="select * from coupon where mid=? and useSw='미사용';";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					cvo = new CouponVO();
					cvo.setIdx(rs.getInt("idx"));
					cvo.setMid(rs.getString("mid"));
					cvo.setStartDay(rs.getString("startDay"));
					cvo.setLastDay(rs.getString("lastDay"));
					cvo.setTitle(rs.getString("title"));
					cvo.setPrice(rs.getInt("price"));
					cvo.setContent(rs.getString("content"));
					cvo.setUseSw(rs.getString("useSw"));
					vos.add(cvo);
				}
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.rsClose();
			}
			return vos;
		}

		public void couponUpdate(int couponIdx) {
			try {
				sql = "update coupon set useSw='사용' where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, couponIdx);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.rsClose();
			}
		}

		public ArrayList<CouponVO> getCouponList(int startIndexNo, int pageSize, String start, String last) {
			ArrayList<CouponVO> vos = new ArrayList<>();
			CouponVO cvo =null;
			try {
				sql="select * from coupon where lastDay>=now() order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					cvo = new CouponVO();
					cvo.setIdx(rs.getInt("idx"));
					cvo.setMid(rs.getString("mid"));
					cvo.setStartDay(rs.getString("startDay"));
					cvo.setLastDay(rs.getString("lastDay"));
					cvo.setTitle(rs.getString("title"));
					cvo.setPrice(rs.getInt("price"));
					cvo.setContent(rs.getString("content"));
					cvo.setUseSw(rs.getString("useSw"));
					vos.add(cvo);
				}
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.rsClose();
			}
			return vos;

		}

		public ArrayList<CouponVO> couponList(String mid) {
			ArrayList<CouponVO> vos = new ArrayList<>();
			CouponVO vo =null;
			try {
				sql="select *,datediff(now(), lastDay) as day_diff from coupon where datediff(now(), lastDay)<60 and mid=?;";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new CouponVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setStartDay(rs.getString("startDay"));
					vo.setLastDay(rs.getString("lastDay"));
					vo.setTitle(rs.getString("title"));
					vo.setPrice(rs.getInt("price"));
					vo.setContent(rs.getString("content"));
					vo.setUseSw(rs.getString("useSw"));
					vo.setDay_diff(rs.getInt("day_diff"));
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("sql 오류~");
				System.out.println(e.getMessage());
				System.out.println(sql);
			} finally {
				getConn.rsClose();
			}
			return vos;

		}
}
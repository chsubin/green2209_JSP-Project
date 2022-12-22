package admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;
import hotel.ReservationVO;
import member.CouponVO;
import member.MemberVO;
import qna.QnaVO;


public class AdminDAO {
	// 싱글톤을 이용한 DB연결 객체 연결하기...
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";


	// 회원 전체(조건) 카운트
	public int totRecCnt(String mid) {
		int totRecCnt = 0;
		try {
			if(mid.equals("")) {
				sql = "select count(*) as cnt from member";
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select count(*) as cnt from member where mid like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+mid+"%");
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}


	public ArrayList<MemberVO> getMemList(int startIndexNo, int pageSize, String mid) {
		ArrayList<MemberVO> vos = new ArrayList<>();
		MemberVO vo =null;
		try {
			if(!mid.equals("")){
				sql = "select * from member where mid like ?  order by idx desc limit ?,?;";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+mid+"%");
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
				
				
			}
			else {
				sql = "select * from member order by idx desc limit ?,? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
				
			} 
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new MemberVO();
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
				vo.setPoint(rs.getInt("point"));
				vo.setMemPoint(rs.getInt("memPoint"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setUserDel(rs.getString("userDel"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}


	public ArrayList<ReservationVO> getReserveList(String ym) {
		ReservationVO vo = null;
		ArrayList<ReservationVO> vos= new ArrayList<>();
		try {
			
			sql="select * from reservation where date_format(checkIn, '%Y-%m')=? or  date_format(checkOut, '%Y-%m')=? and rvSw='예약';";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ym);
			pstmt.setString(2, ym);
			rs= pstmt.executeQuery();
			while(rs.next()) {
				vo = new ReservationVO();
		  	vo.setIdx(rs.getInt("idx"));
		  	vo.setRvIdx(rs.getString("rvIdx"));
		  	vo.setRoomIdx(rs.getInt("roomIdx"));
		  	vo.setRoomName(rs.getString("roomName"));
		  	vo.setRvDay(rs.getString("rvDay"));
		  	vo.setNumOfCustom(rs.getInt("numOfCustom"));
		  	vo.setCheckIn(rs.getString("checkIn"));
		  	vo.setCheckOut(rs.getString("checkOut"));
		  	vo.setAdultF(rs.getInt("adultF"));
		  	vo.setChildF(rs.getInt("childF"));
		  	vo.setContent(rs.getString("content"));
		  	vo.setMid(rs.getString("mid"));
		  	vo.setName(rs.getString("name"));
		  	vo.setEmail(rs.getString("email"));
		  	vo.setPhoneNumber(rs.getString("phoneNumber"));
		  	vo.setCity(rs.getString("city"));
		  	vo.setCardName(rs.getString("cardName"));
		  	vo.setCardNumber(rs.getString("cardNumber"));
		  	vo.setExpiration(rs.getString("expiration"));
		  	vo.setRvSw(rs.getString("rvSw"));
		  	vo.setPrice(rs.getInt("price"));
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


	public ArrayList<ReservationVO> getReserveDayList(String yymmdd, String yymmdd2) {
		ReservationVO vo = null;
		ArrayList<ReservationVO> vos= new ArrayList<>();
		try {
			System.out.println(yymmdd);
			sql="select * from reservation"
					+ " where (checkIn<=? and checkOut>=?)"
					+ " or (checkIn<=? and checkOut>=?)"
					+ " or (checkIn>=? and checkOut<=?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, yymmdd);
			pstmt.setString(2, yymmdd2);
			pstmt.setString(3, yymmdd);
			pstmt.setString(4, yymmdd2);
			pstmt.setString(5, yymmdd);
			pstmt.setString(6, yymmdd2);
			rs= pstmt.executeQuery();
			while(rs.next()) {
				vo = new ReservationVO();
		  	vo.setIdx(rs.getInt("idx"));
		  	vo.setRvIdx(rs.getString("rvIdx"));
		  	vo.setRoomIdx(rs.getInt("roomIdx"));
		  	vo.setRoomName(rs.getString("roomName"));
		  	vo.setRvDay(rs.getString("rvDay"));
		  	vo.setNumOfCustom(rs.getInt("numOfCustom"));
		  	vo.setCheckIn(rs.getString("checkIn"));
		  	vo.setCheckOut(rs.getString("checkOut"));
		  	vo.setRcheckIn(rs.getString("rcheckIn"));
		  	vo.setRcheckOut(rs.getString("rcheckOut"));
		  	vo.setAdultF(rs.getInt("adultF"));
		  	vo.setChildF(rs.getInt("childF"));
		  	vo.setContent(rs.getString("content"));
		  	vo.setMid(rs.getString("mid"));
		  	vo.setName(rs.getString("name"));
		  	vo.setEmail(rs.getString("email"));
		  	vo.setPhoneNumber(rs.getString("phoneNumber"));
		  	vo.setCity(rs.getString("city"));
		  	vo.setCardName(rs.getString("cardName"));
		  	vo.setCardNumber(rs.getString("cardNumber"));
		  	vo.setExpiration(rs.getString("expiration"));
		  	vo.setRvSw(rs.getString("rvSw"));
		  	vo.setPrice(rs.getInt("price"));
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


	public ArrayList<ReservationVO> getReserveDayList(String startDate, String lastDate, String rvSw, String part,
			String searchName) {
		ReservationVO vo = null;
		ArrayList<ReservationVO> vos= new ArrayList<>();
		try {
			if(searchName.equals("")) {
				sql="select * from reservation"
						+ " where ((checkIn<=? and checkOut>=?)"
						+ " or (checkIn<=? and checkOut>=?)"
						+ " or (checkIn>=? and checkOut<=?))"
						+ " and (rvSw=? and roomName like ?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, startDate);
				pstmt.setString(2, lastDate);
				pstmt.setString(3, startDate);
				pstmt.setString(4, lastDate);
				pstmt.setString(5, startDate);
				pstmt.setString(6, lastDate);
				pstmt.setString(7, rvSw);
				pstmt.setString(8, "%"+part+"%");
			}
			else {
				sql="select * from reservation"
						+ " where ((checkIn<=? and checkOut>=?)"
						+ " or (checkIn<=? and checkOut>=?)"
						+ " or (checkIn>=? and checkOut<=?))"
						+ " and (rvSw=? and roomName like ? and name like ?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, startDate);
				pstmt.setString(2, lastDate);
				pstmt.setString(3, startDate);
				pstmt.setString(4, lastDate);
				pstmt.setString(5, startDate);
				pstmt.setString(6, lastDate);
				pstmt.setString(7, rvSw);
				pstmt.setString(8, "%"+part+"%");
				pstmt.setString(9, "%"+searchName+"%");
			}
			
			rs= pstmt.executeQuery();
			while(rs.next()) {
				vo = new ReservationVO();
		  	vo.setIdx(rs.getInt("idx"));
		  	vo.setRvIdx(rs.getString("rvIdx"));
		  	vo.setRoomIdx(rs.getInt("roomIdx"));
		  	vo.setRoomName(rs.getString("roomName"));
		  	vo.setRvDay(rs.getString("rvDay"));
		  	vo.setNumOfCustom(rs.getInt("numOfCustom"));
		  	vo.setCheckIn(rs.getString("checkIn"));
		  	vo.setCheckOut(rs.getString("checkOut"));
		  	vo.setRcheckIn(rs.getString("rcheckIn"));
		  	vo.setRcheckOut(rs.getString("rcheckOut"));
		  	vo.setAdultF(rs.getInt("adultF"));
		  	vo.setChildF(rs.getInt("childF"));
		  	vo.setContent(rs.getString("content"));
		  	vo.setMid(rs.getString("mid"));
		  	vo.setName(rs.getString("name"));
		  	vo.setEmail(rs.getString("email"));
		  	vo.setPhoneNumber(rs.getString("phoneNumber"));
		  	vo.setCity(rs.getString("city"));
		  	vo.setCardName(rs.getString("cardName"));
		  	vo.setCardNumber(rs.getString("cardNumber"));
		  	vo.setExpiration(rs.getString("expiration"));
		  	vo.setRvSw(rs.getString("rvSw"));
		  	vo.setPrice(rs.getInt("price"));
		  	vos.add(vo);
			}
			System.out.println(sql);
		} catch (SQLException e) {
			System.out.println("sql 오류~");
			System.out.println(e.getMessage());
			System.out.println(sql);
		} finally {
			getConn.rsClose();
		}
		return vos;
		
	}


	public String setCoupon(CouponVO vo) {
		String res="0";
		try {
			sql="insert into coupon values (default,?,?,?,?,?,?,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getStartDay());
			pstmt.setString(3, vo.getLastDay());
			pstmt.setString(4, vo.getTitle());
			pstmt.setInt(5, vo.getPrice());
			pstmt.setString(6, vo.getContent());
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


	public String couponDelete(int idx) {
		String res="0";
		try {
			sql="delete from coupon where idx=?";
			pstmt = conn.prepareStatement(sql);
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


	public ArrayList<ReservationVO> todayReserveList(String today, String tomorrow) {
		ArrayList<ReservationVO> vos = new ArrayList<>();
		ReservationVO vo =null;
		try {
			sql="select * from reservation  where checkIn>=? and checkIn<?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, today);
			pstmt.setString(2, tomorrow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new ReservationVO();
		  	vo.setIdx(rs.getInt("idx"));
		  	vo.setRvIdx(rs.getString("rvIdx"));
		  	vo.setRoomIdx(rs.getInt("roomIdx"));
		  	vo.setRoomName(rs.getString("roomName"));
		  	vo.setRvDay(rs.getString("rvDay"));
		  	vo.setNumOfCustom(rs.getInt("numOfCustom"));
		  	vo.setCheckIn(rs.getString("checkIn"));
		  	vo.setCheckOut(rs.getString("checkOut"));
		  	vo.setRcheckIn(rs.getString("rcheckIn"));
		  	vo.setRcheckOut(rs.getString("rcheckOut"));
		  	vo.setAdultF(rs.getInt("adultF"));
		  	vo.setChildF(rs.getInt("childF"));
		  	vo.setContent(rs.getString("content"));
		  	vo.setMid(rs.getString("mid"));
		  	vo.setName(rs.getString("name"));
		  	vo.setEmail(rs.getString("email"));
		  	vo.setPhoneNumber(rs.getString("phoneNumber"));
		  	vo.setCity(rs.getString("city"));
		  	vo.setCardName(rs.getString("cardName"));
		  	vo.setCardNumber(rs.getString("cardNumber"));
		  	vo.setExpiration(rs.getString("expiration"));
		  	vo.setRvSw(rs.getString("rvSw"));
		  	vo.setPrice(rs.getInt("price"));
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


	public ArrayList<MemberVO> getDelMemList() {
		ArrayList<MemberVO> vos = new ArrayList<>();
		MemberVO vo = null;
		try {
			sql = "select * from member where userDel='OK';";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				vo = new MemberVO();
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
				vo.setPoint(rs.getInt("point"));
				vo.setMemPoint(rs.getInt("memPoint"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setUserDel(rs.getString("userDel"));
				
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


	public ArrayList<QnaVO> qnaTodayList(String today, String tomorrow) {
		ArrayList<QnaVO> vos = new ArrayList<>();
		QnaVO vo = null;
		try {
			sql="select * from qna where day>=? and day<? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, today);
			pstmt.setString(2, tomorrow);
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


	public ArrayList<CouponVO> couponUnuseList(String today) {
		ArrayList<CouponVO> vos = new ArrayList<>();
		CouponVO vo =null;
		try {
			sql="select *,datediff(now(), lastDay) as day_diff from coupon where useSw='미사용' and datediff(now(), lastDay)>-7;";
			pstmt = conn.prepareStatement(sql);
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


	public String reserveDelete(int idx) {
		String res="0";
		try {
			sql="delete from reservation where idx=?";
			pstmt = conn.prepareStatement(sql);
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


	public ArrayList<MemberVO> getUpdateMemList() {
		ArrayList<MemberVO> vos = new ArrayList<>();
		MemberVO vo = null;
		try {
			sql = "select * from member where memPoint>=50000 and level=3;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				vo = new MemberVO();
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
				vo.setPoint(rs.getInt("point"));
				vo.setMemPoint(rs.getInt("memPoint"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setUserDel(rs.getString("userDel"));
				
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

package hotel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import org.apache.catalina.startup.RealmRuleSet;

import conn.GetConn;
import member.MemberVO;

public class ReservationDAO {
	//싱글톤을 활용한 DB연결
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn(); //conn은 스태틱으로 올라온 함수이므로 계속 같은 객체가 불리는것!
	private PreparedStatement pstmt =null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	ReservationVO vo = null;
	
	public int setReservation(ReservationVO vo) {
		int res=0;
		try {
			sql="insert into reservation values (default,?,?,?,default,?,?,?,null,null,?,?,?,?,?,?,?,?,?,?,?,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getRvIdx());
			pstmt.setInt(2, vo.getRoomIdx());
			pstmt.setString(3, vo.getRoomName());
			pstmt.setInt(4, vo.getNumOfCustom());
			pstmt.setString(5, vo.getCheckIn());
			pstmt.setString(6, vo.getCheckOut());
			pstmt.setInt(7, vo.getAdultF());
			pstmt.setInt(8, vo.getChildF());
			pstmt.setString(9, vo.getContent());
			pstmt.setString(10, vo.getMid());
			pstmt.setString(11, vo.getName());
			pstmt.setString(12, vo.getEmail());
			pstmt.setString(13, vo.getPhoneNumber());
			pstmt.setString(14, vo.getCity());
			pstmt.setString(15, vo.getCardName());
			pstmt.setString(16, vo.getCardNumber());
			pstmt.setString(17, vo.getExpiration());
			pstmt.setInt(18, vo.getPrice());
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("sql 오류~");
			System.out.println(e.getMessage());
			System.out.println(sql);
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	//예약번호로 예약내역 받아오기
	public ReservationVO getReserveConfirm(String rvIdx) {
		vo = new ReservationVO();
		try {
			sql="select * from reservation where rvIdx=?";
			System.out.println(rvIdx);
		  pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1, rvIdx);
		  rs = pstmt.executeQuery();
		  if(rs.next()) {
		  	vo.setIdx(rs.getInt("idx"));
		  	vo.setRvIdx(rvIdx);
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
	//아이디로 최근예약내역 3개를 받아올까?
	public List<ReservationVO> getReservationList(String mid, int cnt) {
		List<ReservationVO> vos= new ArrayList<>();
		try {
			sql="select r.*,(h.fSName) from reservation r,hotel h where mid=? and h.idx=r.roomIdx order by rvDay desc limit 0,"+cnt+";";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
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
		  	vo.setfSName(rs.getString("fSName"));
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
	public int deleteReservation(int idx) {
		int res=0;
		try {
			sql="update reservation set rvSw='취소' where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("sql 오류~");
			System.out.println(e.getMessage());
			System.out.println(sql);
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	public String getReserveCheck(int idx, String sw) {
		String res="0";
		try {
			sql="update reservation set "+sw+"=now() where idx=?";
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
	public String setChangeDate(int idx, String rcheckIn, String rcheckOut) {
		String res="0";
		try {
			if(rcheckIn.equals("")) {
				sql="update reservation set rcheckIn=null, rcheckOut=null where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
			}
			else {
				sql="update reservation set rcheckIn=?, rcheckOut=? where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, rcheckIn);
				pstmt.setString(2, rcheckOut);
				pstmt.setInt(3, idx);
			}
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
	public ArrayList<ReservationVO> getReservationList(String name, String phoneNumber) {
		ArrayList<ReservationVO> vos= new ArrayList<>();
		try {
			sql="select * from reservation where name=? and phoneNumber=?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phoneNumber);
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


	
	
}

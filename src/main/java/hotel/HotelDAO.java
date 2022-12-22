package hotel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import member.MemberVO;


public class HotelDAO {
	//싱글톤을 활용한 DB연결
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn(); //conn은 스태틱으로 올라온 함수이므로 계속 같은 객체가 불리는것!
	private PreparedStatement pstmt =null;
	private ResultSet rs = null;
	
	private String sql = "";
	HotelVO vo = null;
	
	
	/*객실 방 구해오기*/
	public ArrayList<HotelVO> getRoomList(int startIndexNo, int pageSize, String part) {
		ArrayList<HotelVO> vos = new ArrayList<>();
		try {
			sql="select * from hotel where part=? order by idx limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, part);
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo= new HotelVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setPart(rs.getString("part"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				vo.setContent(rs.getString("content"));
				vo.setRoomView(rs.getString("roomView"));
				vo.setBed(rs.getString("bed"));
				vo.setSize(rs.getString("size"));
				vo.setFormation(rs.getString("formation"));
				vo.setNumOfRoom(rs.getInt("numOfRoom"));
				vo.setNumOfCustom(rs.getInt("numOfCustom"));
				vo.setfName(rs.getString("fName"));
				vo.setfSName(rs.getString("fSName"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql오류~~");
		}finally {
			getConn.rsClose();
		}
		return vos;
	}
	//날짜에 따른 객실정보 찾아오기
	public ArrayList<HotelVO> getUnRoomList(String checkIn,String checkOut) {
		ArrayList<HotelVO> vos = new ArrayList<>();
		//객실정보 찾아오기
		try {
			sql="select * from hotel";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo= new HotelVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setPart(rs.getString("part"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				vo.setContent(rs.getString("content"));
				vo.setRoomView(rs.getString("roomView"));
				vo.setBed(rs.getString("bed"));
				vo.setSize(rs.getString("size"));
				vo.setFormation(rs.getString("formation"));
				vo.setNumOfRoom(rs.getInt("numOfRoom"));
				vo.setNumOfCustom(rs.getInt("numOfCustom"));
				vo.setfName(rs.getString("fName"));
				vo.setfSName(rs.getString("fSName"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("sql오류~~1");
		}finally {
			getConn.rsClose();
		}
		//마감된 객실정보 찾아오기
		ArrayList<HotelVO> vos1 = new ArrayList<>();
		try {
			if(checkIn.equals("")) return null;
			sql="select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx"
					+ " and ((r.checkIn<? and r.checkIn>=?)or(r.checkOut>? and r.checkOut<=?)or(r.checkIn<=? and r.checkOut>?))"
					+ "  and r.rvSw='예약' group by r.roomIdx having (cnt>=h.numofRoom);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, checkOut);
			pstmt.setString(2, checkIn);
			pstmt.setString(3, checkIn);
			pstmt.setString(4, checkOut);
			pstmt.setString(5, checkIn);
			pstmt.setString(6, checkOut);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo= new HotelVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setPart(rs.getString("part"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				vo.setContent(rs.getString("content"));
				vo.setRoomView(rs.getString("roomView"));
				vo.setBed(rs.getString("bed"));
				vo.setSize(rs.getString("size"));
				vo.setFormation(rs.getString("formation"));
				vo.setNumOfRoom(rs.getInt("numOfRoom"));
				vo.setNumOfCustom(rs.getInt("numOfCustom"));
				vo.setfName(rs.getString("fName"));
				vo.setfSName(rs.getString("fSName"));
				vos1.add(vo);
				for(int i=0; i<vos.size();i++) {  //마감이 된 정보들은 지운다!!!
					if(vos.get(i).getIdx()==vo.getIdx()) {
						vos.remove(i);
					}
				}
			}
		} catch (SQLException e) {
			System.out.println("sql오류: " +e.getMessage());
		}finally {
			getConn.rsClose();
		}
		return vos;
	}
	//인덱스번호로 호텔 찾아오기
	public HotelVO getRoom(int idx) {
		System.out.println(idx);
		vo = new HotelVO();
		//객실정보 찾아오기
		try {
			sql="select * from hotel where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo.setIdx(rs.getInt("idx"));
			vo.setPart(rs.getString("part"));
			vo.setName(rs.getString("name"));
			vo.setPrice(rs.getInt("price"));
			vo.setContent(rs.getString("content"));
			vo.setRoomView(rs.getString("roomView"));
			vo.setBed(rs.getString("bed"));
			vo.setSize(rs.getString("size"));
			vo.setFormation(rs.getString("formation"));
			vo.setNumOfRoom(rs.getInt("numOfRoom"));
			vo.setNumOfCustom(rs.getInt("numOfCustom"));
			vo.setfName(rs.getString("fName"));
			vo.setfSName(rs.getString("fSName"));
		} catch (SQLException e) {
			System.out.println("sql오류~~");
		}finally {
			getConn.rsClose();
		}
		return vo;
	}
	
	public int totRecCnt(String part) {
		int totRecCnt=0;
		try {
			sql = "select count(*) as cnt from hotel where part = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, part);
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
	public int roomInput(HotelVO vo) {
		int res =0;
		try {
			sql ="insert into hotel values(default,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPart());
			pstmt.setString(2, vo.getName());
			pstmt.setInt(3, vo.getPrice());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getRoomView());
			pstmt.setString(6, vo.getBed());
			pstmt.setString(7, vo.getSize());
			pstmt.setString(8, vo.getFormation());
			pstmt.setInt(9, vo.getNumOfRoom());
			pstmt.setInt(10, vo.getNumOfCustom());
			pstmt.setString(11, vo.getfName());
			pstmt.setString(12, vo.getfSName());
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("sql오류~~");
		}finally {
			getConn.pstmtClose();
		}
		return res;
	}
	//업데이트하기
	public int roomUpdate(HotelVO vo) {
		int res=0;
		try {
			if(vo.getfSName().equals("")) {
				sql ="update hotel set part=?, name=? , price=? , content=?,roomview=? ,bed=?,size=?,formation=?,numOfRoom=?,numOfCustom=? where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getPart());
				pstmt.setString(2, vo.getName());
				pstmt.setInt(3, vo.getPrice());
				pstmt.setString(4, vo.getContent());
				pstmt.setString(5, vo.getRoomView());
				pstmt.setString(6, vo.getBed());
				pstmt.setString(7, vo.getSize());
				pstmt.setString(8, vo.getFormation());
				pstmt.setInt(9, vo.getNumOfRoom());
				pstmt.setInt(10, vo.getNumOfCustom());
				pstmt.setInt(11, vo.getIdx());
				
			}
			else {
				sql ="update hotel set part=?, name=? , price=? , content=?,roomview=? ,bed=?,size=?,formation=?,numOfRoom=?,numOfCustom=?,fName=?,fSName=? where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getPart());
				pstmt.setString(2, vo.getName());
				pstmt.setInt(3, vo.getPrice());
				pstmt.setString(4, vo.getContent());
				pstmt.setString(5, vo.getRoomView());
				pstmt.setString(6, vo.getBed());
				pstmt.setString(7, vo.getSize());
				pstmt.setString(8, vo.getFormation());
				pstmt.setInt(9, vo.getNumOfRoom());
				pstmt.setInt(10, vo.getNumOfCustom());
				pstmt.setString(11, vo.getfName());
				pstmt.setString(12, vo.getfSName());
				pstmt.setInt(13, vo.getIdx());
				
			}
			pstmt.executeUpdate();
			res=1;
		} catch (SQLException e) {
			System.out.println("sql오류~~");
		}finally {
			getConn.pstmtClose();
		}
		
		return res;
	}
	public String setRoomDelete(int idx) {
		String res="0";
		try {
			sql="delete from hotel where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res="1";
			
		} catch (SQLException e) {
			System.out.println("sql오류~~"+e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		return res;
	}


	
	
	
}

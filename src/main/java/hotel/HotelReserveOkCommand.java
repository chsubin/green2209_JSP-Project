package hotel;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;

public class HotelReserveOkCommand implements HotelInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int roomIdx = request.getParameter("roomIdx")==null? 0 : Integer.parseInt(request.getParameter("roomIdx"));
		String roomName = request.getParameter("roomName")==null?"":request.getParameter("roomName");
		int numOfCustom = request.getParameter("numOfCustom")==null? 0 : Integer.valueOf(request.getParameter("numOfCustom"));
		String checkIn = request.getParameter("checkIn")==null?"":request.getParameter("checkIn");
		String checkOut = request.getParameter("checkOut")==null?"":request.getParameter("checkOut");
		int adultF = request.getParameter("adultF")==null? 0 : Integer.valueOf(request.getParameter("adultF"));
		int childF = request.getParameter("childF")==null? 0 : Integer.valueOf(request.getParameter("childF"));
		String content = request.getParameter("content")==null?"":request.getParameter("content");
		String mid = request.getParameter("mid")==null?"":request.getParameter("mid");
		String name = request.getParameter("name")==null?"":request.getParameter("name");
		String email = request.getParameter("email")==null?"":request.getParameter("email");
		String phoneNumber = request.getParameter("phoneNumber")==null?"":request.getParameter("phoneNumber");
		String city = request.getParameter("city")==null?"":request.getParameter("city");
		String cardName = request.getParameter("cardName")==null?"":request.getParameter("cardName");
		String cardNumber = request.getParameter("cardNumber")==null?"":request.getParameter("cardNumber");
		String expiration = request.getParameter("expiration")==null?"":request.getParameter("expiration");
		int price = request.getParameter("price")==null? 0 : Integer.valueOf(request.getParameter("price"));
		int usePoint = request.getParameter("usePoint")==null? 0: Integer.valueOf(request.getParameter("usePoint"));
		String coupon = request.getParameter("coupon")==null? "":request.getParameter("coupon");
		int couponIdx = Integer.parseInt(coupon.split("/")[0]) ; 
	
		ReservationVO vo = new ReservationVO();
		
		
		Date today = new Date();
		// 원하는 형태의 포맷으로 날짜, 시간을 표현하기 위해서는 SimpleDateFormat 클래스를 이용합니다.
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHH-mmss");
		String rvIdx = dateFormat.format(today)+("0"+roomIdx);

		vo.setRoomIdx(roomIdx);
		vo.setRoomName(roomName);
		vo.setRvIdx(rvIdx);
		vo.setNumOfCustom(numOfCustom);
		vo.setCheckIn(checkIn);
		vo.setCheckOut(checkOut);
		vo.setAdultF(adultF);
		vo.setChildF(childF);
		vo.setContent(content);
		if(mid.equals("")) {
			mid=null;
		}
		vo.setMid(mid);
		vo.setName(name);
		vo.setEmail(email);
		vo.setPhoneNumber(phoneNumber);
		vo.setCity(city);
		vo.setCardName(cardName);
		vo.setCardNumber(cardNumber);
		vo.setExpiration(expiration);
		vo.setPrice(price);
		
		ReservationDAO dao = new ReservationDAO();
		int res = dao.setReservation(vo);
		
		String url;
		String msg;
		
		if(res==1) {//예약 성공
			
			if(mid!=null) {
				MemberDAO memDAO = new MemberDAO();
				memDAO.setUpdatePoint(mid,(int) Math.round(price*0.01));
				if(usePoint!=0) {
					memDAO.setUpdatePoint(mid,-usePoint);
				}
				if(couponIdx!=0) {
					memDAO.couponUpdate(couponIdx);
				}
			}
			
			request.setAttribute("rvIdx", rvIdx);
			request.setAttribute("name", name);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/hotel/hotelReserveConfirm.tel");
			dispatcher.forward(request, response);
			
		}
		else { //예약 실패
			url=request.getContextPath()+"/hotelReserve1.tel";
			msg="hotelReserveNo";
			request.setAttribute("url", url);
			request.setAttribute("msg", msg);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/include/message.jsp");
			dispatcher.forward(request, response);
			
		}
		
		return;
		
		
	}
}

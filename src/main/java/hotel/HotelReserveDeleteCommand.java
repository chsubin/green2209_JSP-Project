package hotel;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

public class HotelReserveDeleteCommand implements HotelInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt((String) request.getParameter("idx"));
		String rvIdx = request.getParameter("rvIdx")==null?"":request.getParameter("rvIdx");
		
		ReservationDAO dao = new ReservationDAO();
		
		ReservationVO vo = dao.getReserveConfirm(rvIdx);
		if(vo.getMid()!=null) {
			String mid = vo.getMid();
			int price = vo.getPrice();
			MemberDAO memDao = new MemberDAO();
			memDao.setUpdatePoint(mid, -(int) Math.round(price*0.01),"");
		}
		
		int res = dao.deleteReservation(idx);
		
		String url;
		String msg;
		
		
		if(res==1) {//삭제 성공
			url= request.getContextPath()+"/hotelInfor.tel";
			msg="deleteReservationOk";
		}
		else { //삭제 실패
			url=request.getContextPath()+"/hotelInfor.tel";
			msg="deleteReservationNo";
			
		}
		request.setAttribute("url", url);
		request.setAttribute("msg", msg);
		
	}

}

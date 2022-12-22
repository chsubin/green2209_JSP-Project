package hotel;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class HotelReserveConfirmCommand implements HotelInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//비회원인 경우!!
		HttpSession session = request.getSession();
		String name = request.getAttribute("name")==null?(String)session.getAttribute("sName"):(String)request.getAttribute("name"); //예약한것이 있다면 예약한것으로 
		String rvIdx = request.getAttribute("rvIdx")==null?(String)session.getAttribute("sRvIdx"):(String)request.getAttribute("rvIdx"); //아니면 세션!
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid"); 
		
		
		
		ReservationDAO dao = new ReservationDAO();
		ReservationVO vo = dao.getReserveConfirm(rvIdx);
		
		
		if(vo!=null) {			//비밀번호와 이름가 같지않으면 null
			if(mid.equals(vo.getMid())) {
			}
			else if(!name.equals(vo.getName())){
				vo = null;
			}
		}
		
		request.setAttribute("vo",vo);
		
	}

}

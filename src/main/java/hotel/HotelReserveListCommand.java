package hotel;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class HotelReserveListCommand implements HotelInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		ReservationDAO dao = new ReservationDAO();
		List<ReservationVO> vos= dao.getReservationList(mid,20);
	
		request.setAttribute("vos",vos);
		
	}

}

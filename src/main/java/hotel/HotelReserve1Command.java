package hotel;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HotelReserve1Command implements HotelInterface {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String checkIn =request.getParameter("checkIn")==null?"":request.getParameter("checkIn");
		String checkOut =request.getParameter("checkOut")==null?"":request.getParameter("checkOut");
		
		HotelDAO dao = new HotelDAO();
		
		ArrayList<HotelVO> vos = dao.getUnRoomList(checkIn,checkOut);
		request.setAttribute("checkIn", checkIn);
		request.setAttribute("checkOut", checkOut);
		
		request.setAttribute("vos", vos);
	}

}

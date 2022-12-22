package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotel.HotelDAO;
import hotel.HotelVO;

public class AdRoomUpdateCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		
	  HotelDAO dao = new HotelDAO();
	  HotelVO vo = dao.getRoom(idx);
		
	  request.setAttribute("vo", vo);
	  
	}

}

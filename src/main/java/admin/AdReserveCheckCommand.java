package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotel.ReservationDAO;
import hotel.ReservationVO;

public class AdReserveCheckCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0 : Integer.parseInt(request.getParameter("idx"));
		String sw = request.getParameter("sw")==null?"" : request.getParameter("sw");		

		ReservationDAO dao = new ReservationDAO();
		String res = dao.getReserveCheck(idx,sw);
		
		response.getWriter().write(res);
	}

}

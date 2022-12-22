package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.session.StandardSession;

import hotel.ReservationDAO;
import hotel.ReservationVO;

public class pdsInputCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		String rvIdx = session.getAttribute("sRvIdx")==null?(String)request.getParameter("rvIdx"):(String)session.getAttribute("sRvIdx");
		
		
		ReservationDAO dao = new ReservationDAO();
		ReservationVO vo = dao.getReserveConfirm(rvIdx);

		request.setAttribute("vo", vo);
		
	}

}

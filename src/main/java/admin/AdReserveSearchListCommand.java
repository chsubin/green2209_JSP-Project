package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotel.ReservationVO;

public class AdReserveSearchListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String startDate  = request.getParameter("startDate")==null?"":request.getParameter("startDate");
		String lastDate  = request.getParameter("lastDate")==null?"":request.getParameter("lastDate");
		String rvSw = request.getParameter("rvSw")==null?"":request.getParameter("rvSw");
		String searchName = request.getParameter("searchName")==null?"":request.getParameter("searchName");
		String part = request.getParameter("part")==null?"":request.getParameter("part");
		
	
		
		AdminDAO dao = new AdminDAO();
		ArrayList<ReservationVO> vos = dao.getReserveDayList(startDate,lastDate,rvSw,part,searchName);
		
		System.out.println(searchName);
		
		request.setAttribute("startDate", startDate);
		request.setAttribute("lastDate", lastDate);
		request.setAttribute("rvSw", rvSw);
		request.setAttribute("searchName", searchName);
		request.setAttribute("part", part);
		request.setAttribute("vos", vos);
	}

}

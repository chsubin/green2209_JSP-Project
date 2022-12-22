package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotel.ReservationDAO;

public class AdChangeDateCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0 : Integer.parseInt(request.getParameter("idx"));
		String rcheckIn = request.getParameter("rcheckIn")==null?"" : request.getParameter("rcheckIn");		
		String rcheckOut = request.getParameter("rcheckOut")==null?"" : request.getParameter("rcheckOut");		
		
		System.out.println(rcheckIn);
		System.out.println(rcheckOut);
		
		ReservationDAO dao = new ReservationDAO();
		String res = dao.setChangeDate(idx,rcheckIn,rcheckOut);
		
		
		
		
		response.getWriter().write(res);
		
		
	}

}

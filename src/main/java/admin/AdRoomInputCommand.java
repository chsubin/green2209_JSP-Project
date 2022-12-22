package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdRoomInputCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String part = request.getParameter("part")==null ? "전체" : request.getParameter("part");
		int pag = request.getParameter("pag")==null ? 1 :  Integer.parseInt(request.getParameter("pag")) ;
		
		
		request.setAttribute("part", part);
		request.setAttribute("pag",pag);
	}

}

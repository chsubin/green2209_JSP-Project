package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsUpdateCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null?1:Integer.parseInt(request.getParameter("pag"));

		PdsDAO dao = new PdsDAO();
		PdsVO vo =  dao.getPds(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		
		
		
	}

}

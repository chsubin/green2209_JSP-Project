package pds;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.pds")
public class PdsController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String sMid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		PdsInterface command = null;
		String viewPage ="/WEB-INF/pds";

		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		if (com.equals("/pdsList")) {
			command = new PdsListCommand();
			command.execute(request, response);
			viewPage += "/pdsList.jsp";
		}
		else if (com.equals("/pdsContent")) {
			command = new PdsContentCommand();
			command.execute(request, response);
			viewPage += "/pdsContent.jsp";
		}
		else if (com.equals("/pdsInput")) {
			command = new pdsInputCommand();
			command.execute(request, response);
			viewPage += "/pdsInput.jsp";
		}
		else if (com.equals("/pdsInputOk")) {
			command = new PdsInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if (com.equals("/pdsUpdate")) {
			command = new PdsUpdateCommand();
			command.execute(request, response);
			viewPage += "/pdsUpdate.jsp";
		}
		else if (com.equals("/pdsUpdateOk")) {
			command = new PdsUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if (com.equals("/pdsDelete")) {
			command = new PdsDeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if (com.equals("/pdsReplyInput")) {
			command = new pdsReplyInputCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("/pdsReplyDelete")) {
			command = new pdsReplyDeleteCommand();
			command.execute(request, response);
			return;
		}


		
		RequestDispatcher dispatcher= request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}

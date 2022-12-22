package qna;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.qna")
public class QnaController extends HttpServlet {
		
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		QnaInterface command = null;
		String viewPage ="/WEB-INF/qna";

		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		if (com.equals("/qnaMain")) {
			command = new QnaMainCommand();
			command.execute(request, response);
			viewPage += "/qnaMain.jsp";
		}
		else if (com.equals("/qnaInput")) {
			command = new QnaInputCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if (com.equals("/qnaDelete")) {
			command = new QnaDeleteCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("/qnaReplyInput")) {
			command = new QnaReplyInputCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("/qnaReplyDelete")) {
			command = new QnaReplyDeleteCommand();
			command.execute(request, response);
			return;
		}
		
		
		RequestDispatcher dispatcher= request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}

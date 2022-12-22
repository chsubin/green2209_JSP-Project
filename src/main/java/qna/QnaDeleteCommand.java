package qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QnaDeleteCommand implements QnaInterface {

	@Override
public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
	
		QnaDAO dao = new QnaDAO();
		String res = dao.qnaDelete(idx);
		
		response.getWriter().write(res);
		
	}

}

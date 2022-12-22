package qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QnaReplyInputCommand implements QnaInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		int qnaIdx = request.getParameter("qnaIdx")==null?0:Integer.parseInt(request.getParameter("qnaIdx"));	
		String mid = request.getParameter("mid")==null?"":request.getParameter("mid");
		String content = request.getParameter("content")==null? "": request.getParameter("content");

		
		QnaReplyDAO dao = new QnaReplyDAO();
		String res = dao.qnaReplyInput(qnaIdx,mid,content);
		
		response.getWriter().write(res);
	}

}

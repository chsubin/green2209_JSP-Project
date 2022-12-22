package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class pdsReplyInputCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		int pdsIdx = request.getParameter("pdsIdx")==null?0:Integer.parseInt(request.getParameter("pdsIdx"));
		String mid = request.getParameter("mid")==null?"":request.getParameter("mid");
		String content = request.getParameter("content")==null?"":request.getParameter("content");
		
		PdsReplyDAO dao = new PdsReplyDAO();
		
		String res = dao.setReply(pdsIdx,mid,content);
		
		response.getWriter().write(res);
		
		
		
	}

}

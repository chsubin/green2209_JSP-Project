package qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QnaInputCommand implements QnaInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String nickName = request.getParameter("nickName")==null?"":request.getParameter("nickName");
		String mid = request.getParameter("mid")==null?"":request.getParameter("mid");
		String email = request.getParameter("email")==null?"":request.getParameter("email");
		String hostIp = request.getRemoteAddr()==null?"":request.getRemoteAddr();
		String content = request.getParameter("content")==null?"":request.getParameter("content");
		
		QnaVO vo = new QnaVO();
		
		vo.setNickName(nickName);
		vo.setMid(mid);
		vo.setEmail(email);
		vo.setHostIp(hostIp);
		vo.setContent(content);
		
		
		QnaDAO dao = new QnaDAO();
		int res=  dao.qnaInput(vo);
		
		String url;
		String msg;
		
		if(res==1) {//q&a 작성완료
			url= request.getContextPath()+"/qnaMain.qna";
			msg="qnaInputOk";
		}
		else {
			url= request.getContextPath()+"/qnaMain.qna";
			msg="qnaInputNo";
			

	}
		request.setAttribute("url", url);
		request.setAttribute("msg", msg);
	}
}

package pds;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PdsContentCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null?1:Integer.parseInt(request.getParameter("pag"));
		
		PdsDAO dao = new PdsDAO();
		PdsVO vo =  dao.getPds(idx);
		
		HttpSession session = request.getSession();
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "board" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			dao.setReadNumPlus(idx);
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		

		
		PdsReplyDAO pdsDao = new PdsReplyDAO();
		ArrayList<PdsReplyVO> rVos = pdsDao.getReply(idx);
		
//		이전글 다음글 처리
		PdsVO preVo  = dao.getPreNextSearch("pre", idx);
		PdsVO nextVo = dao.getPreNextSearch("next", idx);
		request.setAttribute("preVo", preVo);
		request.setAttribute("nextVo", nextVo);
		
		
		
		request.setAttribute("rVos", rVos);
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		
	}

}

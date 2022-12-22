package pds;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsDeleteCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		int idx = request.getParameter("idx")==null?0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null?0 : Integer.parseInt(request.getParameter("pag"));
		int pagSize = request.getParameter("pagSize")==null?0 : Integer.parseInt(request.getParameter("pagSize"));
		
		
		PdsDAO dao = new PdsDAO();
		
		PdsVO vo = dao.getPds(idx);
		
		String fSName_ = vo.getfSName();
		String[] fSNames = fSName_.split("/");
		
		String realPath = request.getServletContext().getRealPath("/data/pds/");
		
		for(String fSName : fSNames) {

			new File(realPath + fSName).delete();
		}
		
		int res = 0;
		
		PdsReplyDAO rDao = new PdsReplyDAO();
		ArrayList<PdsReplyVO> rvos = rDao.getReply(idx);
		if(rvos.size()!=0) {
			res =dao.setPdsUpdateDelete(idx);
		}
		else {
			res =dao.setPdsDelete(idx);
		}
				
		
		if(res==0) { 
			request.setAttribute("msg", "pdsDeleteNo");
		}
		else {
			request.setAttribute("msg", "pdsDeleteOk");
		}
		request.setAttribute("url", request.getContextPath()+"/pdsList.pds?pag="+pag);
		
	}

}

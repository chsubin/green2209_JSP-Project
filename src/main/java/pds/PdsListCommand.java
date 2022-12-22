package pds;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsListCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String searchfield = request.getParameter("searchfield")==null? "":request.getParameter("searchfield");
		String search = request.getParameter("search")==null? "":request.getParameter("search");
		int searchSw = request.getParameter("searchSw")==null? 0:Integer.parseInt(request.getParameter("searchSw")) ;
		
		
		PdsDAO dao = new PdsDAO();
		
		// 페이징처리 준비 시작
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		if (searchSw==1) {
			pag=1;
		}
		int pageSize = request.getParameter("pageSize")==null||request.getParameter("pageSize").equals("") ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = dao.totRecCnt(searchfield,search);
		System.out.println("totReccnt : "+totRecCnt);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		// 블록페이징처리.....(3단계) -> 블록의 시작번호를 0번부터 처리했다.
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		ArrayList<PdsVO> vos = dao.getPdsList(startIndexNo, pageSize, searchfield,search);
		
		
		
		request.setAttribute("searchfield", searchfield);
		request.setAttribute("search", search);
	  request.setAttribute("vos", vos); 
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
	}

}

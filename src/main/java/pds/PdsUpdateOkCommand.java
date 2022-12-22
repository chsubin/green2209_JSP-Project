package pds;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class PdsUpdateOkCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String realPath = request.getServletContext().getRealPath("data/pds");
		
		int maxSize = 1024 * 1024 * 30;
		String encoding ="UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		
		Enumeration fileNames = multipartRequest.getFileNames();
		String file = "";
		String originalFileName="";
		String filesystemName = "";
		
		
		while(fileNames.hasMoreElements()) {
			file = (String) fileNames.nextElement();
			 originalFileName += multipartRequest.getOriginalFileName(file)+"/";
			 filesystemName += multipartRequest.getFilesystemName(file)+"/";
		}
		originalFileName = originalFileName.substring(0, originalFileName.length()-1);
		filesystemName = filesystemName.substring(0, filesystemName.length()-1);
		
		if(request.getParameter("photo") != null) filesystemName = "noimage";
		
		System.out.println(multipartRequest.getParameter("fileSize"));
		
		int idx = multipartRequest.getParameter("idx")==null?0: Integer.parseInt(multipartRequest.getParameter("idx")) ;
		int pag = multipartRequest.getParameter("pag")==null?0: Integer.parseInt(multipartRequest.getParameter("pag")) ;
		String rvIdx = multipartRequest.getParameter("rvIdx")==null?"":multipartRequest.getParameter("rvIdx");
		String hostIp = request.getRemoteAddr()==null?"":request.getRemoteAddr();
		String title = multipartRequest.getParameter("title")==null?"":multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content")==null?"":multipartRequest.getParameter("content");
		//int fSize = multipartRequest.getParameter("fileSize")==null?0:Integer.parseInt(multipartRequest.getParameter("fileSize"));
		String fName = originalFileName;
		String fSName= filesystemName;
		
		PdsDAO dao = new PdsDAO();
		
		
		PdsVO vo = dao.getPds(idx);
		String fSName_ = vo.getfSName();
		String[] fSNames = fSName_.split("/");
		
			// 파일이 저장되어 있는 서버의 실제 경로를 찾아온다.
		realPath = request.getServletContext().getRealPath("/data/pds/");
			
			// 서버 파일시스템에 실제로 존재하는 파일들을 찾아서 삭제처리한다.
			for(String fSName__ : fSNames) {

				new File(realPath + fSName__).delete();
			}
			
		vo = new PdsVO();
		vo.setIdx(idx);
		vo.setRvIdx(rvIdx);
		vo.setfName(fName);
		vo.setfSName(fSName);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		
		int res = dao.pdsUpdate(vo);
		
		if(res==0) { 
			request.setAttribute("msg", "pdsUpdateNo");
		}
		else {
			request.setAttribute("msg", "pdsUpdateOk");
		}
		request.setAttribute("url", request.getContextPath()+"/pdsContent.pds?idx="+idx+"&pag="+pag);
	}
		

}

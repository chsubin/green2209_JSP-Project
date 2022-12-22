package pds;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import hotel.ReservationDAO;
import member.MemberDAO;
import member.MemberVO;

public class PdsInputOkCommand implements PdsInterface {

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
		
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		String midName = session.getAttribute("sName")==null?"":(String)session.getAttribute("sName");
		String rvIdx = multipartRequest.getParameter("rvIdx")==null?"":multipartRequest.getParameter("rvIdx");
		String checkIn = multipartRequest.getParameter("checkIn")==null?"":multipartRequest.getParameter("checkIn");
		String checkOut = multipartRequest.getParameter("checkOut")==null?"":multipartRequest.getParameter("checkOut");
		String roomName= multipartRequest.getParameter("roomName")==null?"":multipartRequest.getParameter("roomName");
		String hostIp = request.getRemoteAddr()==null?"":request.getRemoteAddr();
		String title = multipartRequest.getParameter("title")==null?"":multipartRequest.getParameter("title");
		int roomIdx = multipartRequest.getParameter("roomIdx")==null?0:Integer.parseInt(multipartRequest.getParameter("roomIdx"));
		String content = multipartRequest.getParameter("content")==null?"":multipartRequest.getParameter("content");
		//int fSize = multipartRequest.getParameter("fileSize")==null?0:Integer.parseInt(multipartRequest.getParameter("fileSize"));
		String fName = originalFileName;
		String fSName= filesystemName;
		
		PdsDAO dao = new PdsDAO();
		
		
		
		int res2=0;
		if(!mid.equals("")&& dao.getPds(rvIdx).getCheckIn()==null) {
			MemberDAO memDao = new MemberDAO();
			memDao.setUpdatePoint(mid, 1000);
			res2=1;
		}
			
		PdsVO vo = new PdsVO();
		vo.setMid(mid);
		vo.setMidName(midName);
		vo.setRvIdx(rvIdx);
		vo.setRoomIdx(roomIdx);
		vo.setRoomName(roomName);
		vo.setCheckIn(checkIn);
		vo.setCheckOut(checkOut);
		vo.setfName(fName);
		vo.setfSName(fSName);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		
		int res = dao.pdsInput(vo);
		
		vo = dao.getPds(rvIdx);
		int idx = vo.getIdx();
		
		if(res==0) { 
			request.setAttribute("msg", "pdsInputNo");
		}
		else if(res2==1) {
			request.setAttribute("msg", "pdsInputOkOk");
		}
		else {
			request.setAttribute("msg", "pdsInputOk");
		}
		request.setAttribute("url", request.getContextPath()+"/pdsContent.pds?idx="+idx);
	}
		
		

}

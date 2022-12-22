package admin;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import hotel.HotelDAO;
import hotel.HotelVO;

public class AdRoomUpdateOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//사진처리
		String realPath = request.getServletContext().getRealPath("/data/room");
		int maxSize = 1024 * 1024 * 30; //서버에 저장할 최대 용량을 30Byte로 한다. (1회 저장)
		String encoding ="UTF-8";
		
		
		//파일 업로드.. 처리... 끝
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath,maxSize,encoding, new DefaultFileRenamePolicy());
	
		//업로드 된 파일의 정보를 추출해보자...
		Enumeration fileNames = multipartRequest.getFileNames();
		String file="";
		String originalFileName="";
		String filesystemName = "";
		
		while(fileNames.hasMoreElements()) { //반복문으로 돌리겠다....
			 file = (String)fileNames.nextElement(); //업로드시의 폼태그안의 필드네임(name)
			 originalFileName += multipartRequest.getOriginalFileName(file)+"/";
			 filesystemName += multipartRequest.getFilesystemName(file)+"/";
		}
		originalFileName = originalFileName.substring(0, originalFileName.length()-1);
		filesystemName = filesystemName.substring(0, filesystemName.length()-1);
		
		
		// 전송한 값 모두 받아오기
		int idx = multipartRequest.getParameter("idx")==null?0:Integer.parseInt(multipartRequest.getParameter("idx")) ;
		String part = multipartRequest.getParameter("part")==null?"스탠다드":(String)multipartRequest.getParameter("part");
		String name = multipartRequest.getParameter("name")==null?"":(String)multipartRequest.getParameter("name");
		String content = multipartRequest.getParameter("content")==null?"":(String)multipartRequest.getParameter("content");
		int price = multipartRequest.getParameter("price")==null?0:Integer.parseInt(multipartRequest.getParameter("price")) ;
		String roomView = multipartRequest.getParameter("roomView")==null?"":(String)multipartRequest.getParameter("roomView");
		String bed = multipartRequest.getParameter("bed")==null?"":(String)multipartRequest.getParameter("bed");
		String size = multipartRequest.getParameter("size")==null?"":(String)multipartRequest.getParameter("size");
		String formation = multipartRequest.getParameter("formation")==null?"":(String)multipartRequest.getParameter("formation");
		int numOfRoom = multipartRequest.getParameter("numOfRoom")==null?0:Integer.parseInt(multipartRequest.getParameter("numOfRoom")) ;
		int numOfCustom = multipartRequest.getParameter("numOfCustom")==null?0:Integer.parseInt(multipartRequest.getParameter("numOfCustom")) ;

		if(!multipartRequest.getParameter("photo").equals("")) {filesystemName = "";originalFileName = "";}
		else {
			HotelDAO dao = new HotelDAO();
			HotelVO vo = dao.getRoom(idx);
			String fSName_ = vo.getfSName();
			String[] fSNames = fSName_.split("/");
			// 파일이 저장되어 있는 서버의 실제 경로를 찾아온다.
			
			// 서버 파일시스템에 실제로 존재하는 파일들을 찾아서 삭제처리한다.
			for(String fSName : fSNames) {
				new File(realPath + fSName).delete();
			}
		}
		
		HotelVO vo = new HotelVO();
		HotelDAO dao = new HotelDAO();
		//vo에 넣기
		vo.setIdx(idx);
		vo.setPart(part);
		vo.setName(name);
		vo.setPrice(price);
		vo.setContent(content);
		vo.setRoomView(roomView);
		vo.setBed(bed);
		vo.setSize(size);
		vo.setFormation(formation);
		vo.setNumOfRoom(numOfRoom);
		vo.setNumOfCustom(numOfCustom);
		vo.setfName(originalFileName);
		vo.setfSName(filesystemName);
		
		int res = dao.roomUpdate(vo);
		
		
		if(res==0) { 
			request.setAttribute("msg", "roomUpdateNo");
		}
		else {
			request.setAttribute("msg", "roomUpdateOk");
		}
		request.setAttribute("url", request.getContextPath()+"/adRoom.ad");
	}

		

}

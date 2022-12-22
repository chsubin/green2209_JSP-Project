package admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotel.HotelDAO;
import hotel.HotelVO;

public class DeleteRoomCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		
		HotelDAO dao = new HotelDAO();
		HotelVO vo = dao.getRoom(idx);
		String fSName_ = vo.getfSName();
		String[] fSNames = fSName_.split("/");
		// 파일이 저장되어 있는 서버의 실제 경로를 찾아온다.
		String realPath = request.getServletContext().getRealPath("/data/room");
		// 서버 파일시스템에 실제로 존재하는 파일들을 찾아서 삭제처리한다.
		for(String fSName : fSNames) {
			new File(realPath + fSName).delete();
		}
		
		String res = dao.setRoomDelete(idx);
		
		
		response.getWriter().write(res);
	}

}

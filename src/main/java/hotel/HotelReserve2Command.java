package hotel;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import member.CouponVO;
import member.MemberDAO;
import member.MemberVO;

public class HotelReserve2Command implements HotelInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx =request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		System.out.println("mid= " +mid);
		
		MemberDAO memdao = new MemberDAO();
		MemberVO memVO = memdao.getLoginCheck(mid);
		
		
		request.setAttribute("memVO", memVO);
		
		
		System.out.println(memVO);
		
		HotelDAO dao = new HotelDAO();
		
		HotelVO vo = dao.getRoom(idx);
		request.setAttribute("vo", vo);
		
		//쿠폰 찾아오기
		ArrayList<CouponVO> cVos = memdao.getCouponList(mid);
		request.setAttribute("cVos", cVos);
		
		
		
	}

}

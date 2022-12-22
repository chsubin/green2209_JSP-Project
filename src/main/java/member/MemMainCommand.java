package member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hotel.ReservationVO;
import pds.PdsDAO;
import pds.PdsVO;
import qna.QnaDAO;
import qna.QnaVO;
import hotel.ReservationDAO;

public class MemMainCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String sMid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getLoginCheck(sMid);
		
		//아이디로 최근예약내역 3개를 받아올까?
		ReservationDAO rvDAO = new ReservationDAO();
		List<ReservationVO> rvVOS= rvDAO.getReservationList(sMid,3);
		
		//아이디로 최근 Q&A 내역 3개를 받아오기
		QnaDAO qnaDao = new QnaDAO();
		ArrayList<QnaVO> qnaVos = qnaDao.getQnaList(5,sMid);
		
		//아이디로 후기내역!
		PdsDAO pdsDao = new PdsDAO();
		ArrayList<PdsVO> pdsVos = pdsDao.getPdsList(0, 5, "mid", sMid);

		//아이디로 쿠폰내역
		ArrayList<CouponVO> couVos = dao.couponList(sMid);
		request.setAttribute("couVos", couVos);
		request.setAttribute("couCnt", couVos.size());
		
		
		

		if(vo==null) {
			return;
		}
		else {
			request.setAttribute("vo", vo);
			request.setAttribute("rvVOS", rvVOS);
			request.setAttribute("qnaVos", qnaVos);
			request.setAttribute("pdsVos", pdsVos);
			
		}
		
		
		
		
		
		
	}

}

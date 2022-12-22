package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.mem")
public class MemberController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String sMid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		MemberInterface command = null;
		String viewPage ="/WEB-INF/member";

		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		if (com.equals("/memJoin")) {
			viewPage += "/memJoin.jsp";
		}
		else if (com.equals("/memLogin")) {
			viewPage += "/memLogin.jsp";
		}
		else if (com.equals("/memLoginOk")) {
			command = new MemLoginOkCommand();
			command.execute(request, response);
			viewPage ="/include/message.jsp";
		}
		else if (com.equals("/memLogout")) {
			command = new MemLogoutCommand();
			command.execute(request, response);
			viewPage ="/include/message.jsp";
		}
		else if (com.equals("/memJoinOk")) {
			command = new MemJoinOkCommand();
			command.execute(request, response);
			viewPage ="/include/message.jsp";
		}
		//멤버 수정
		else if (com.equals("/memUpdate")) {
			command = new MemUpdateCommand();
			command.execute(request, response);
			viewPage += "/memUpdate.jsp";
		}
		//중복 아이디 체크
		else if(com.equals("/memIdCheck")) {
			command = new MemIdCheckCommand();
			command.execute(request, response);
			viewPage +="/memIdCheck.jsp";
		}
		else if(com.equals("/memIdSearch")) {
			viewPage +="/memIdSearch.jsp";
		}
		//아이디 찾기
		else if(com.equals("/memIdSearchOk")) {
			command = new MemIdSearchOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/memPwdSearch")) {
			viewPage +="/memPwdSearch.jsp";
		}
		//비밀번호 찾기
		else if(com.equals("/memPwdSearchOk")) {
			command = new MemPwdSearchOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/memRvIdxSearchOk")) {
			command = new MemRvIdxSearchOkCommand();
			command.execute(request, response);
			return;
		}
		//멤버쉽
		else if(com.equals("/memMemberShip")) {
			command = new MemMemberShipCommand();
			command.execute(request, response);
			viewPage +="/memMemberShip.jsp";
		}
		else if(com.equals("/memCoupon")) {
			command = new MemCouponCommand();
			command.execute(request, response);
			viewPage +="/memCoupon.jsp";
		}
		else if(sMid.equals("")) {
			viewPage+="/";
		}
		//멤버 메인화면(최근예약내역꺼내와야함)
		else if(com.equals("/memMain")) {
			command = new MemMainCommand();
			command.execute(request, response);
			viewPage +="/memMain.jsp";
		}
		//멤버 정보 수정
		else if(com.equals("/memUpdateOk")) {
			command = new MemUpdateOkCommand();
			command.execute(request, response);
			viewPage ="/include/message.jsp";
		}
		//회원의 예약내역 삭ㄷ제
		else if(com.equals("/memReserveDelete")) {
			command = new MemReserveDeleteCommand();
			command.execute(request, response);
			return;
		}
		//pwd 업데이트
		else if(com.equals("/memPwdUpdate")) {
			viewPage +="/memPwdUpdate.jsp";
		}
		//pwd 업데이트
		else if(com.equals("/memPwdUpdateOk")) {
			command = new MemPwdUpdateOkCommand();
			command.execute(request, response);
			return;
		}
		//탈퇴
		else if(com.equals("/memUnresister")) {
			command = new MemUnresisterCommand();
			command.execute(request, response);
			return;
		}



		
		
		RequestDispatcher dispatcher= request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}

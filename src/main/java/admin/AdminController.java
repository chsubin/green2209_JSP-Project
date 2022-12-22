package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hotel.HotelInforCommand;

@WebServlet("*.ad")
public class AdminController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		AdminInterface command = null;
		String viewPage ="/WEB-INF/admin";

		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		//세션을 끊어준다
		HttpSession session = request.getSession();
		int sLevel= session.getAttribute("sLevel")==null?99:Integer.parseInt(String.valueOf(session.getAttribute("sLevel")) );
		String sMid = session.getAttribute("sMid")==null?"":(String)session.getAttribute("sMid");
		
		if(sLevel>1||sMid.equals("")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
		}
		
		if (com.equals("/adMain")) {
			command = new AdMainCommand();
			command.execute(request, response);
			viewPage += "/adMain.jsp";
		}
		else if(com.equals("/adRoom")) {
			command = new AdRoomCommand();
			command.execute(request, response);
			viewPage+= "/adRoom.jsp";
		}
		else if(com.equals("/adRoomInput")) {
			command = new AdRoomInputCommand();
			command.execute(request, response);
			viewPage+= "/adRoomInput.jsp";
		}
		else if(com.equals("/adRoomInputOk")) {
			command = new AdRoomInputOkCommand();
			command.execute(request, response);
			viewPage= "/include/message.jsp";
		}
		else if(com.equals("/adMemList")) {
			command = new AdMemListCommand();
			command.execute(request, response);
			viewPage+= "/adMemList.jsp";
		}
		else if(com.equals("/adReserveSearchList")) {
			command = new AdReserveSearchListCommand();
			command.execute(request, response);
			viewPage+= "/adReserveList.jsp";
		}
		else if(com.equals("/adReserveList")) {
			command = new AdReserveListCommand();
			command.execute(request, response);
			viewPage+= "/adReserveList.jsp";
		}
		//멤버 삭제
		else if(com.equals("/adMemberDel")) {
			command = new AdMemberDelCommand();
			command.execute(request, response);
			return;
		}
		//멤버 삭제
		else if(com.equals("/adMemLevelUpdate")) {
			command = new AdMemLevelUpdateCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/adReserveCheck")) {
			command = new AdReserveCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/adChangeDate")) {
			command = new AdChangeDateCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/adRoomUpdate")) {
			command = new AdRoomUpdateCommand();
			command.execute(request, response);
			viewPage+= "/adRoomUpdate.jsp";
		}
		else if(com.equals("/adRoomUpdateOk")) {
			command = new AdRoomUpdateOkCommand();
			command.execute(request, response);
			viewPage ="/include/message.jsp";
		}
		else if(com.equals("/deleteRoom")) {
			command = new DeleteRoomCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/adCoupon")) {
			command = new adCouponCommand();
			command.execute(request, response);
			viewPage+= "/adCoupon.jsp";
		}
		else if(com.equals("/adCouponMidSearch")) {
			command = new adCouponMidSearchCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/adCouponInput")) {
			command = new AdCouponInputCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/adCouponDelete")) {
			command = new AdCouponDeleteCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/adReserveDelete")) {
			command = new AdReserveDeleteCommand();
			command.execute(request, response);
			return;
		}
		
		
		RequestDispatcher dispatcher= request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}

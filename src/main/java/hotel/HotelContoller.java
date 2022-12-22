package hotel;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.tel")
public class HotelContoller extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HotelInterface command = null;
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		String viewPage ="/WEB-INF/hotel";
		
		//메인화면
		if(com.equals("/main")) {
			command = new MainCommand();
			command.execute(request, response);
			viewPage+="/main.jsp";
		}
		if(com.equals("/hotelInfor")) {
			command = new HotelInforCommand();
			command.execute(request, response);
			viewPage+="/hotelInfor.jsp";
		}
		else if(com.equals("/hotelReserve1")) {
			command = new HotelReserve1Command();
			command.execute(request, response);
			viewPage+="/hotelReserve1.jsp";
		}
		//예약하는곳! idx로 받아와ㅑㅎ함.
		else if(com.equals("/hotelReserve2")) {
			command = new HotelReserve2Command();
			command.execute(request, response);
			viewPage+="/hotelReserve2.jsp";
		}
		else if(com.equals("/hotelReserveOk")) {
			command = new HotelReserveOkCommand();
			command.execute(request, response);
			return;
		}
		//예약번호와 이름으로 예약내역 받아오기
		else if(com.equals("/hotelReserveConfirm")) {
			command = new HotelReserveConfirmCommand();
			command.execute(request, response);
			viewPage+="/hotelReserveConfirm.jsp";
		}
		//회원의 예약 리스트 받아오기
		else if(com.equals("/hotelReserveList")) {
			command = new HotelReserveListCommand();
			command.execute(request, response);
			viewPage+="/hotelReserveList.jsp";
		}
		//예약 삭제
		else if(com.equals("/hotelReserveDelete")) {
			command = new HotelReserveDeleteCommand();
			command.execute(request, response);
			viewPage ="/include/message.jsp";
		}

		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}

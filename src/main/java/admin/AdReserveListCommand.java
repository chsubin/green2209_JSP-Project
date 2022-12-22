package admin;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotel.HotelDAO;
import hotel.HotelVO;
import hotel.ReservationVO;

public class AdReserveListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(request.getParameter("yy")!=null){
			String yy = request.getParameter("yy")==null?"":request.getParameter("yy");
			String mm = request.getParameter("mm")==null?"":request.getParameter("mm");
			String dd = request.getParameter("dd")==null?"":request.getParameter("dd");
			String yymmdd = yy+mm+dd;
			
			if(!yymmdd.equals("")) {
				//월,일 처리
				mm = ("0"+mm);
				mm = mm.substring(mm.length()-2);
				dd = ("0"+dd);
				dd = dd.substring(dd.length()-2);
				yymmdd = yy+"-"+mm+"-"+dd;
			}
			else {
				//월,일 처리
				Date today = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				
				yymmdd = dateFormat.format(today);
			}
			
			AdminDAO dao = new AdminDAO();
			ArrayList<ReservationVO> vos = dao.getReserveDayList(yymmdd,yymmdd);
			request.setAttribute("yymmdd", yymmdd);
			request.setAttribute("vos", vos);
		}
		else {
			String startDate  = request.getParameter("startDate")==null?"":request.getParameter("startDate");
			String lastDate  = request.getParameter("lastDate")==null?"":request.getParameter("lastDate");
			
			
			AdminDAO dao = new AdminDAO();
			ArrayList<ReservationVO> vos = dao.getReserveDayList(startDate,lastDate);
			
			request.setAttribute("startDate", startDate);
			request.setAttribute("lastDate", lastDate);
			request.setAttribute("vos", vos);
			
		
			
		}
			
	}

}

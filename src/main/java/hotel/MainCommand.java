package hotel;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import pds.PdsDAO;
import pds.PdsVO;
import qna.QnaDAO;
import qna.QnaVO;

public class MainCommand implements HotelInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PdsDAO pdsDao = new PdsDAO();
		QnaDAO qnaDao = new QnaDAO();
		
		ArrayList<PdsVO> pdsVos = pdsDao.getPdsList(0, 3);
		ArrayList<QnaVO> qnaVos = qnaDao.getQnaList(0, 10);
		
		request.setAttribute("pdsVos", pdsVos);
		request.setAttribute("qnaVos", qnaVos);
		
		
		
		// 오늘 날짜처리(저장)
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		
		// 화면에 보여줄 해당 '년/월'을 셋팅
		Calendar calView = Calendar.getInstance();
		int yy = request.getParameter("yy")==null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
		
		// 앞에서 넘어온 변수(yy, mm)값이 '1월'이거나, '12월'이라면 아래와 같이 편집한다.(1월은 '0', 12월은 '11'로 넘어온다.)
		if(mm < 0) {
			yy--;
			mm = 11;
		}
		if(mm > 11) {
			yy++;
			mm = 0;
		}
		
		// 해당 '년/월'의 1일을 기준으로 셋팅시켜준다.
		calView.set(yy, mm, 1);
		
		// 앞에서 셋팅한 해당 '년/월'의 1일에 대당하는 요일값을 숫자로 가져온다.(일:1, 월:2, 화:3,~~)
		int startWeek = calView.get(Calendar.DAY_OF_WEEK);
		//System.out.println("해당월의 첫번째 1의 요일을 숫자로 반환 : " + startWeek);
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);
		//System.out.println("해당월의 마지막 날짜 : " + lastDay);
		
		// 출력된 달력의 '앞쪽/뒷쪽'의 빈공간에 해당월 '이전/다음'의 날짜를 채워보자..(준비)
		int prevYear = yy;
		int prevMonth = (mm) - 1;
		int nextYear = yy;
		int nextMonth = (mm) + 1;
		
		if(prevMonth == -1) {
			prevYear--;
			prevMonth = 11;
		}
		if(nextMonth == 12) {
			nextYear++;
			nextMonth = 0;
		}
		
		// 현재월(11월)의 이전월(10월)의 마지막 날짜를 구한다.
		Calendar calPre = Calendar.getInstance();
		calPre.set(prevYear, prevMonth, 1);
		int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		// 다음월의 1일에 해당하는 요일의 숫가값을 가져온다.
		Calendar calNext = Calendar.getInstance();
		calNext.set(nextYear, nextMonth, 1);
		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);
		
		
		// 화면에 보여줄 달력의 해당 내역을 저장소에 저장한다.
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		// 오늘 날짜를 저장소에 담아서 넘겨준다.
		request.setAttribute("toYear", toYear);
		request.setAttribute("toMonth", toMonth);
		request.setAttribute("toDay", toDay);
		
		// 현재달의 '전월/다음월'의 날짜 표시를 위한 변수를 저장소에 저장한다.
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("preLastDay", preLastDay);
		request.setAttribute("nextStartWeek", nextStartWeek);
		
		// 해당월을 가져오기위한 편집처리(2022-12)
		
		// 2023-1  -> 2023-01
		String ym = "";
		if((mm + 1) < 10) {
			ym = yy + "-0" + (mm + 1);
		}
		else {
			ym = yy + "-" + (mm + 1);
		}
		
		//reservation vos가져오기
		AdminDAO dao = new AdminDAO();
		
		ArrayList<ReservationVO> vos = dao.getReserveList(ym);
		
		request.setAttribute("vos", vos);
		
		
	}
}

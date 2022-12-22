package admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotel.ReservationDAO;
import hotel.ReservationVO;
import member.CouponVO;
import member.MemberVO;
import qna.QnaVO;

public class AdMainCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		
		//reservation 오늘 예약된 vos 체크인현황 가져오기
		
		String today=toYear+"-"+(toMonth+1)+"-"+toDay;
		String tomorrow=toYear+"-"+(toMonth+1)+"-"+(toDay+1);
		
		ArrayList<ReservationVO> tVos = dao.todayReserveList(today,tomorrow);
		request.setAttribute("tVos", tVos);
		request.setAttribute("tCnt", tVos.size());
		
		//탈퇴 신청 가져오기
		ArrayList<MemberVO> memVos = dao.getDelMemList();
		request.setAttribute("memVos", memVos);
		request.setAttribute("memCnt", memVos.size());
	
		//오늘 올라온 Q&A가져오기
		ArrayList<QnaVO> qVos = dao.qnaTodayList(today,tomorrow);
		request.setAttribute("qVos", qVos);
		request.setAttribute("qCnt", qVos.size());
		
		//쿠폰리스트
		ArrayList<CouponVO> couVos = dao.couponUnuseList(today);
		request.setAttribute("couVos", couVos);
		request.setAttribute("couCnt", couVos.size());
		
		//등급올려야할 회원 가져오기
		ArrayList<MemberVO> uVos = dao.getUpdateMemList();
		request.setAttribute("uVos", uVos);
		request.setAttribute("uCnt", uVos.size());
	}

}

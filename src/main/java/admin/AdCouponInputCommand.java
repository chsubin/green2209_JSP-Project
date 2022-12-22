package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.CouponVO;

public class AdCouponInputCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title")==null?"":request.getParameter("title");
		String mid = request.getParameter("mid")==null?"":request.getParameter("mid");
		String startDay = request.getParameter("startDay")==null?"":request.getParameter("startDay");
		String lastDay = request.getParameter("lastDay")==null?"":request.getParameter("lastDay");
		int price = request.getParameter("price")==null?0:Integer.parseInt(request.getParameter("price")) ;
		String content = request.getParameter("content")==null?"":request.getParameter("content");
		
		AdminDAO dao = new AdminDAO();
		
		CouponVO vo = new CouponVO();
		vo.setTitle(title);
		vo.setMid(mid);
		vo.setStartDay(startDay);
		vo.setLastDay(lastDay);
		vo.setPrice(price);
		vo.setContent(content);
		
		String res = dao.setCoupon(vo);
		
		response.getWriter().write(res);
		
	}

}

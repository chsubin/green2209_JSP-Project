package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;

public class adCouponMidSearchCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberDAO dao = new MemberDAO();
		
		int ans = dao.getTot();
		int i = (int)(Math.random()*ans);
	
		MemberVO vo = dao.getCouponMid(i);
		
		String mid = vo.getMid();
		
		response.getWriter().write(mid);
	}

}

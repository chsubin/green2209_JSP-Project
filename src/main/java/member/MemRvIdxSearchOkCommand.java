package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotel.ReservationDAO;
import hotel.ReservationVO;

public class MemRvIdxSearchOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null?"":request.getParameter("name");
		String phoneNumber = request.getParameter("phoneNumber")==null?"":request.getParameter("phoneNumber");
		
		ReservationDAO dao = new ReservationDAO();
		ArrayList<ReservationVO> vos = dao.getReservationList(name, phoneNumber);
		
		String res="";
		if(vos.size()==0) {res="0";}
		else {
			for(int i=0;i<vos.size();i++) {
				res += vos.get(i).getRvIdx()+"/";
			}
			res= res.substring(0,res.length()-2);
		}
		
		response.getWriter().write(res);
		
		
	}

}

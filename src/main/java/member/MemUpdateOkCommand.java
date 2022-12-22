package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class MemUpdateOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nameKor = request.getParameter("nameKor")==null? "":request.getParameter("nameKor");
		String nameEng = request.getParameter("nameEng")==null? "":request.getParameter("nameEng");
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthday")==null? "":request.getParameter("birthday");
		String email = request.getParameter("email")==null? "":request.getParameter("email");
		String phoneNumber = request.getParameter("tel")==null? "":request.getParameter("tel");
		String homeNumber = request.getParameter("hometel")==null? "":request.getParameter("hometel");
		String address = request.getParameter("address")==null? "":request.getParameter("address");
		
		
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = new MemberVO();
		vo.setNameKor(nameKor);
		vo.setNameEng(nameEng);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setEmail(email);
		vo.setPhoneNumber(phoneNumber);
		vo.setHomeNumber(homeNumber);
		vo.setAddress(address);
		
		
		String res = dao.memUpdateOk(vo);
		String url;
		String msg;
		
		if(res.equals("1")) {//정보 수정 완료
			url=request.getContextPath()+"/member/memUpdate.mem";
			msg="memUpdateOk";
		}
		else { //정보 수정 완료
			url=request.getContextPath()+"/member/memUpdate.mem";
			msg="memUpdateNo";
			
		}
		
		request.setAttribute("url", url);
		request.setAttribute("msg", msg);

	}

}

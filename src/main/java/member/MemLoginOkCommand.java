package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;
import hotel.ReservationVO;
import hotel.ReservationDAO;

public class MemLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String loginSw = request.getParameter("loginSw")==null?"":request.getParameter("loginSw");
		
			if(loginSw.equals("0")) { //회원로그인
			
			String mid = request.getParameter("mid")==null?"":request.getParameter("mid");
			String pwd = request.getParameter("pwd")==null?"":request.getParameter("pwd");
			String containId = request.getParameter("containId")==null?"":request.getParameter("containId");
			MemberDAO dao = new MemberDAO();
			MemberVO vo =dao.getLoginCheck(mid);
			
			
			//입력되어 넘어온 비밀번호를 암호화 시킨 후 DB에 저장된 pw와 비교한다.
			SecurityUtil security = new SecurityUtil();
			pwd = security.encryptSHA256(pwd);
			
			if(vo==null||vo.getUserDel().equals("OK")||!pwd.equals(vo.getPwd())) { //로그인 아이디,비밀번호 비교
				request.setAttribute("msg", "loginNo");
				request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
				return;
			}
			
			/*마지막 방문일 업데이트 하기*/
			int res= dao.getLoginUpdate(mid);
			if(res!=1) {
				System.out.println("로그인 업데이트 오류~");
			}
			

			//세션에 저장한다. 쿠키처리 하여야 함..... 
			HttpSession session = request.getSession();
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sLevel", vo.getLevel());
			request.setAttribute("msg", "loginOk");
			request.setAttribute("url", request.getContextPath()+"/");
			
			// 쿠키를 클라이언트에 저장하기(즉, 사용자 컴퓨터에 저장된다.)
			Cookie cookieMid = new Cookie("cMid", mid);
			if(containId.equals("on")) {
				cookieMid.setMaxAge(60*60*24*7);  // 쿠키 만료시간을 7일..
			}
			else {
				cookieMid.setMaxAge(0);
			}
			response.addCookie(cookieMid);
		
		}
		//비회원 로그인
			else if(loginSw.equals("1")) { 
				String name = request.getAttribute("name")==null?"":(String)request.getAttribute("name"); 
				String rvIdx = request.getAttribute("rvIdx")==null?"":(String)request.getAttribute("rvIdx");
				
				
				
				if(name.equals("")) { 
					name = request.getParameter("name")==null?"":(String)request.getParameter("name");
					rvIdx = request.getParameter("rvIdx")==null?"":(String)request.getParameter("rvIdx");
				}
				
				
				ReservationDAO dao = new ReservationDAO();
				ReservationVO vo = dao.getReserveConfirm(rvIdx);
				
				if(vo==null||!name.equals(vo.getName())) { //로그인 아이디,비밀번호 비교
					request.setAttribute("msg", "loginNone");
					request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
					return;
				}

				HttpSession session = request.getSession();
				
				if(vo.getMid()!=null) { //아이디가 있을떄
					request.setAttribute("msg", "loginMem");
					request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
					return;
				}
				else { //비회원으로 로그인 되었다.
					session.setAttribute("sName", vo.getName());
					session.setAttribute("sRvIdx", vo.getRvIdx());
					session.setAttribute("sLevel", 4);
					request.setAttribute("val",vo.getName());
				}
				
				
				request.setAttribute("msg", "loginOk");
				request.setAttribute("url", request.getContextPath()+"/hotelReserveConfirm.tel");
				
			}
				
				
	}

}

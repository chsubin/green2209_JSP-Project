package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemIdSearchOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null?"":request.getParameter("name");
		String email = request.getParameter("email")==null?"":request.getParameter("email");
		
		MemberDAO dao = new MemberDAO();
	  MemberVO vo = dao.getIdSearch(name,email);
	  
	  String mid =vo.getMid();
	  String res;
	  
	  System.out.println(mid);
	  if(mid==null) {
	  	res="0";
	  }
	  else {
	  	int i = (int) (Math.random()*mid.length());
	  	int j = (int) (Math.random()*mid.length());
	  	int k = (int) (Math.random()*mid.length());
	  	String arrayMid [] = mid.split("");
	  	String strMid="";
	  	for(int x=0;x<mid.length();x++) {
	  		if(x==i) {
	  			strMid+="*";
	  		}
	  		else if(x==j) {
	  			strMid+="*";
	  		}
	  		else if(x==k) {
	  			strMid+="*";
	  		}
	  		else {
	  			strMid+=arrayMid[x];
	  		}
	  	}
	  	
	  	res=strMid;
	  }
	  
	  response.getWriter().write(res);
	}

}

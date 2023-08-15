package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ReplyDao;
import vo.Reply;

@WebServlet("/replyadd")
public class ReplyAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		String uid = (String)session.getAttribute("id");
		String reply = request.getParameter("reply");
		String ppno = request.getParameter("pno");
		int pno = Integer.parseInt(ppno);
		
		
		Reply rp = new Reply();
		rp.setUid(uid);
		rp.setContent(reply);
		rp.setPno(pno);
		
		ReplyDao rdao = new ReplyDao();
		rdao.regReply(rp);
		
		int result = rdao.reCnt(pno);
		out.print(result);
		
		
	}

}

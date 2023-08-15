package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostDao;
import dao.ReplyDao;
import dao.UserDao;
import vo.Post;
import vo.Reply;
import vo.User;

@WebServlet("/postlist")
public class PostListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		//String page = request.getParameter("p");
		//if (page == null) {
		//	page = "1"; 
		//}
		//int p = Integer.parseInt(page);
		ReplyDao rdao = new ReplyDao();
		PostDao pdao = new PostDao();
		ArrayList<Post> plist = pdao.followPost(id);
		ArrayList<Post> mylist = pdao.getPost(id);
		
		
		int[] pno = new int[plist.size()];
		for (int i = 0; i < plist.size(); i++) {
			pno[i] = plist.get(i).getPno();
		}
		
		ArrayList<Reply> reply = rdao.getReply(0);
		
		//int postCnt = pdao.getCnt();
		//int pageCnt = 10;
		//int lastNum = (int)Math.ceil(postCnt/(pageCnt*1.0));
		//int startNum = p-((p-1)%5);
		//int endNum = lastNum+4;
		
		//request.setAttribute("cnt", postCnt);
		//request.setAttribute("lastNum", lastNum);
		//request.setAttribute("startNum", startNum);
		//request.setAttribute("endNum", endNum);

		UserDao udao = new UserDao();
		User user = udao.getUser(id);
		
		session.setAttribute("user", user);
		session.setAttribute("plist", plist);
		session.setAttribute("mylist", mylist);

		response.sendRedirect("main.jsp");
		
	}

}

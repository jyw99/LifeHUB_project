package servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.PostDao;
import vo.Post;
import vo.User;

@WebServlet("/registpost")
public class RegistPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		ServletContext ctx = request.getServletContext();
		MultipartRequest multi = new MultipartRequest(request, 
				ctx.getRealPath("/files"),
				100*1024*1024,
				"utf-8",
				new DefaultFileRenamePolicy()
				);
		
		File file = multi.getFile("postImg");
		
		String id = (String)session.getAttribute("id");
		User user = (User)session.getAttribute("user");
		String pfImg = user.getPfImg();
		String postImg = file.getName();
		String content = multi.getParameter("postContent");		
				
		Post post = new Post();
		post.setUid(id);
		post.setPostImg(postImg);
		if (pfImg==null) {
			post.setPfImg("pfImg/nullpfImg.png");
		}else {
			post.setPfImg(pfImg);			
		}
		post.setPostContent(content);
		
		PostDao dao = new PostDao();
		dao.registPost(post);
		
		response.sendRedirect("postlist");
		
	}

}

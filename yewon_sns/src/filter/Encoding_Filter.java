package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;


@WebFilter("/*")
public class Encoding_Filter implements Filter {
	
	private String charset;
	private String charset2;
	
    public Encoding_Filter() {
        // TODO Auto-generated constructor stub
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding(charset);
		response.setContentType(charset2);
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		ServletContext sctx = fConfig.getServletContext();
		charset = sctx.getInitParameter("charset");
		charset2 = sctx.getInitParameter("charset2");
	}

}

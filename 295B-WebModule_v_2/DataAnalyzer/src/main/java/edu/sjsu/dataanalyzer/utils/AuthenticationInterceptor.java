package edu.sjsu.dataanalyzer.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import edu.sjsu.dataanalyzer.bean.User;

public class AuthenticationInterceptor implements HandlerInterceptor{

	private static final Logger logger = LoggerFactory.getLogger(AuthenticationInterceptor.class);

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {


	}	

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("Interceptor: Pre-handle Authentication check "+request.getRequestURI());

		// Avoid a redirect loop for some urls
		if( !request.getRequestURI().equals("/dataanalyzer/registrationpage") &&
				!request.getRequestURI().equals("/dataanalyzer/register") &&
				!request.getRequestURI().equals("/dataanalyzer/loginpage") &&
				!request.getRequestURI().equals("/dataanalyzer/login")){
			User userData = (User) request.getSession().getAttribute("user");
			if(userData == null)
			{
				logger.info("session not set: redirect to login page");
				response.sendRedirect("./loginpage/");
				return false;
			}   
		}
		return true;
	}

}

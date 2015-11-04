package edu.sjsu.dataanalyzer;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import edu.sjsu.dataanalyzer.bean.User;
import edu.sjsu.dataanalyzer.service.UserService;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired(required=true)
    @Qualifier(value="userService")
	private UserService userService;
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	@RequestMapping(value = "/loginpage", method = RequestMethod.GET)
	public String userLogin(Locale locale, Model model) {
		logger.info("user login page");
		model.addAttribute("userAttribute", new User());
		return "userlogin";
	}
	
	@RequestMapping(value = "/registrationpage", method = RequestMethod.GET)
	public String userRegistration(Locale locale, Model model) {
		logger.info("user registration page");
		model.addAttribute("userAttribute", new User());
		return "userregistration";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(@ModelAttribute("userAttribute") User user, Model model) {
		logger.info("authentic user");
		User dbUserObj = userService.get(user.getEmail()); 
		if(dbUserObj!=null){
			if(dbUserObj.getPassword().equals(user.getPassword())){
				logger.info("user successfully authenticated");
				return "home";
			}else{
				model.addAttribute("error", "username | password incorrect");
				return "userlogin";
			}
		}else{
			logger.info("username | password incorrect");
			model.addAttribute("error", "username | password incorrect");
			return "userregistration";
		}
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@ModelAttribute("userAttribute") User user, Model model) {
		logger.info("register user");
		if(userService.get(user.getEmail())==null){
			userService.add(user);
			logger.info("user successfully added");
			return "userlogin";
		}else{
			logger.info("user exists in the databse");
			model.addAttribute("error", "user exists");
			return "userregistration";
		}
	}
}

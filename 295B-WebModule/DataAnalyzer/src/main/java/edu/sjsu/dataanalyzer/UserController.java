package edu.sjsu.dataanalyzer;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

import com.mongodb.DBObject;

import edu.sjsu.dataanalyzer.bean.User;
import edu.sjsu.dataanalyzer.service.ExperimentService;
import edu.sjsu.dataanalyzer.service.UserService;

@Controller
@SessionAttributes("user")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired(required=true)
	@Qualifier(value="userService")
	private UserService userService;
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	@Autowired(required=true)
	@Qualifier(value="experimentService")
	private ExperimentService experimentService;
	public void setExperimentService(ExperimentService experimentService){
		this.experimentService = experimentService;
	}

	@RequestMapping(value = "/registrationpage", method = RequestMethod.GET)
	public String userRegistration(Locale locale, Model model) {
		logger.info("user registration page");
		model.addAttribute("userAttribute", new User());
		return "userregistration";
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
	
	@RequestMapping(value = "/loginpage", method = RequestMethod.GET)
	public String userLogin(Locale locale, Model model) {
		logger.info("user login page");
		model.addAttribute("userAttribute", new User());
		return "userlogin";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("userAttribute") User user, Model model) {
		logger.info("authentic user");
		User dbUserObj = userService.get(user.getEmail()); 
		if(dbUserObj!=null){
			if(dbUserObj.getPassword().equals(user.getPassword())){
				logger.info("user successfully authenticated");
				//model.addAttribute("userAttribute", dbUserObj);
				model.addAttribute("user", dbUserObj);
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

	@RequestMapping(value = "/newexperiment", method = RequestMethod.POST)
	public String getNewExperiment(@RequestParam("experiment_name") String exname, Model model, HttpSession session) {
		/*if(session.getAttribute("exid") != null){
			String msg = "One more experiment is open with current user session!!";
			msg += "<br> Please close other experiment sessions or logout and try re login.";
			logger.info(msg);
			model.addAttribute("Error", msg);
			return "Error";
		}*/
		
		logger.info("new experiemnt page request "+exname);
		User user = (User) session.getAttribute("user");
		session.setAttribute("exid", experimentService.pushNewExperiement(user.getEmail(), exname));
		model.addAttribute("experiment_name", exname);
		return "experiment";
	}
		
	@RequestMapping(value = "/experiment/id", method = RequestMethod.POST)
	public String getExperimentById(@RequestParam("experiment_id") String exid, Model model, HttpSession session) {
		if(session.getAttribute("exid") != null){
			String msg = "One more experiment is open with current user session!!";
			msg += "<br> Please close other experiment sessions or logout and try re login.";
			logger.info(msg);
			model.addAttribute("Error", msg);
			return "Error";
		}
		
		logger.info("get saved experiment by id "+exid);
		session.setAttribute("exid", exid);
		DBObject dbOject = experimentService.getExperimentDetails(exid);
		
		//get experiments details and set all the model attributes
		model.addAttribute("experiment_name", dbOject.get("experiment_name"));
		if(dbOject.get("metadata") != null){
			logger.info("meatadata set");
			model.addAttribute("metadata", dbOject.get("metadata"));
		}
		if(dbOject.get("parameters") != null){
			logger.info("parameters set");
			model.addAttribute("parameters", dbOject.get("parameters"));
		}
		if(dbOject.get("process_flow") != null){
			logger.info("process flow set ");
			model.addAttribute("process_flow", dbOject.get("process_flow"));
		}
		return "experiment";
	}
	
<<<<<<< HEAD
	 @RequestMapping(value="/upload", method=RequestMethod.GET)
	    public @ResponseBody String provideUploadInfo() {
		 System.out.println("In Provide Upload Info \n");
	        return "You can upload a file by posting to this same URL.";
	    }
	 	//@RequestParam("name") String name,@RequestParam("file") MultipartFile file
	 @RequestMapping(value="/upload", method=RequestMethod.POST)
	   public String handleFileUpload(@RequestParam("file") MultipartFile file, @RequestParam("name") String name, @RequestParam("experiment_name") String experiment_name){
	       //System.out.println(file.getName() + name);
	    	 if (!file.isEmpty()) {
	            try {
	                byte[] bytes = file.getBytes();
	                String fullFileName= file.getOriginalFilename();

	                BufferedOutputStream stream =new BufferedOutputStream(new FileOutputStream(new File("/Users/ruchas/Desktop/"+fullFileName)));
	                //C://Users//Shubham//Desktop//Karuna//files/
	                stream.write(bytes);
	                stream.close();
	                System.out.println("Handle File Upload \n");
	                
	                return "analysis";
	            } catch (Exception e) {
	                return "Error";
	            }
	        } else {
	        	return "Error";
	        }
	    	
	    }
=======
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(WebRequest request, SessionStatus status, HttpSession session) {
		logger.info("end user session");
		session.removeAttribute("exid");
		status.setComplete();
	    request.removeAttribute("user", WebRequest.SCOPE_SESSION);
	    return "userlogin";
	}
>>>>>>> b984448b2b9f2870ee563d8a11896ec7a129a0f5
}

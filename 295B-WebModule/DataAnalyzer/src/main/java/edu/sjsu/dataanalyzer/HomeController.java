package edu.sjsu.dataanalyzer;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mongodb.DBObject;

import edu.sjsu.dataanalyzer.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/lam", method = RequestMethod.GET)
	public ModelAndView lam(Locale locale, Model model) {		
		
		UserService us = new UserService();
		DBObject values = us.getLAM();
		return new ModelAndView("LAM","json",values);
		//return "LAM";
	}
	
	@RequestMapping(value = "/lam/date", method = RequestMethod.GET)
	public @ResponseBody String getDates(@RequestParam("chamber_id") String chamber_id) {		
		String success = "success";
		System.out.println("success -- "+chamber_id);
		
		UserService us = new UserService();
		String values = us.getLAMdate(chamber_id);
		System.out.println("Dates: "+values);
		return values;
	}
	
	@RequestMapping(value = "/lam/date/file", method = RequestMethod.GET)
	public String getFiles(Locale locale, Model model) {		
		
		
		return "LAM";
	}
	
	@RequestMapping(value = "/lam/date/file/attribute", method = RequestMethod.GET)
	public String getAttributes(Locale locale, Model model) {		
		
		
		return "LAM";
	}
}

package edu.sjsu.dataanalyzer;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.DBObject;

import edu.sjsu.dataanalyzer.service.UserService;

@Controller
public class LamController {
	private static final Logger logger = LoggerFactory.getLogger(LamController.class);
	
	@RequestMapping(value = "/lam", method = RequestMethod.GET)
	public String lam(Locale locale, Model model) {		
		logger.info("lam visualization page requested");
		return "lamvisualization";
	}
	
	@RequestMapping(value = "/lam/date", method = RequestMethod.GET)
	public @ResponseBody String getDates(@RequestParam("chamber_id") String chamber_id) {		
		logger.info("success :: "+chamber_id);
		UserService us = new UserService();
		List values = us.getLAMdate(chamber_id);
		logger.info("Dates: "+values);
		return values.toString();
	}
	
	@RequestMapping(value = "/lam/date/file", method = RequestMethod.GET)
	public @ResponseBody String getFiles(@RequestParam("chamber_id") String chamber_id, @RequestParam("date_id") String date_id) {		
		logger.info(chamber_id+" << chamber, date>>"+date_id);
		UserService us = new UserService();
		List values = us.getLamDateAndFile(chamber_id,date_id);
		logger.info("File names: "+values);
		return values.toString();
	}
	
	@RequestMapping(value = "/lam/date/file/attribute", method = RequestMethod.GET)
	public @ResponseBody String getAttributes(@RequestParam("chamber_id") String chamber_id, @RequestParam("date_id") String date_id, @RequestParam("file_id") String file_id) {		
		logger.info(chamber_id+" << chamber, date>>"+date_id+" >> file id >> "+file_id);
		UserService us = new UserService();
		List values = us.getLamDateFileAndAtribute(chamber_id,date_id,file_id);
		return values.toString();
	}
	
	@RequestMapping(value = "/lam/graphs", method = RequestMethod.GET)
	public @ResponseBody String getGraphs(@RequestParam("chamber_id") String chamber_id, @RequestParam("date_id") String date_id, @RequestParam("file_id") String file_id, @RequestParam("attribute_id") String attribute_id) {		
		logger.info(chamber_id+" << chamber, date>>"+date_id+" >> file id >>" +file_id+" >> attribute_id >> "+attribute_id);
		UserService us = new UserService();
		DBObject values = us.getLAM(chamber_id,date_id,file_id,attribute_id);
		return values.toString();
	}
}

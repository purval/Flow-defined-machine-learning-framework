package edu.sjsu.dataanalyzer.service;

import java.util.List;

import com.mongodb.DBObject;

import edu.sjsu.dataanalyzer.bean.User;

public interface IUserService {
	
	public User get(String email);
	
	public boolean add(User user);
	
	public boolean delete(String email);
	
	public boolean modifyUserDetails(User user);
		
	/*
	 * Mongo to LAM
	 */

	public DBObject getLAM(String chamber, String date,String fileName,String Attribute);
	
	public List getLAMdate(String chamber);
	public List getLamDateAndFile(String chamber, String date);
	public List getLamDateFileAndAtribute(String chamber, String date, String fileName);

	public List getExperimentList(String email);
}

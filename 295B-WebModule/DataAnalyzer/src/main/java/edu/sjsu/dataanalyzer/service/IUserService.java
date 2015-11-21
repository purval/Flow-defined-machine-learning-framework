package edu.sjsu.dataanalyzer.service;

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
	public DBObject getLAM();
	
	public String getLAMdate(String chamber);
	public DBObject getLamDateAndFile(String chamber, String date);
	public DBObject getLamDateFileAndAtribute(String chamber, String date, String fileName);

}

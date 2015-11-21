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
}

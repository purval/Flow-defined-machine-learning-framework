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
<<<<<<< HEAD
	public DBObject getLAM();
	
	public String getLAMdate(String chamber);
	public DBObject getLamDateAndFile(String chamber, String date);
	public DBObject getLamDateFileAndAtribute(String chamber, String date, String fileName);
=======
	public DBObject getLAM(String chamber, String date,String fileName,String Attribute);
	
	public List getLAMdate(String chamber);
	public List getLamDateAndFile(String chamber, String date);
	public List getLamDateFileAndAtribute(String chamber, String date, String fileName);
>>>>>>> d79ba8da98b7315353fac8a8ce7921ea7195b427

}

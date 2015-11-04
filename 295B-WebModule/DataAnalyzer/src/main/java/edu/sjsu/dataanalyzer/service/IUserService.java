package edu.sjsu.dataanalyzer.service;

import edu.sjsu.dataanalyzer.bean.User;

public interface IUserService {
	
	public User get(String email);
	
	public boolean add(User user);
	
	public boolean delete(String email);
	
	public boolean modifyUserDetails(User user);
}

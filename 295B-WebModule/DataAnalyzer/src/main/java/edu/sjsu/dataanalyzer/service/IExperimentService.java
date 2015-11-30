package edu.sjsu.dataanalyzer.service;

import com.mongodb.DBObject;

public interface IExperimentService {
	
	public String pushNewExperiement(String email, String experimentName);

	public DBObject getExperimentDetails(String uuid);

	public void insertMetaData(String metajson, String filepath, String uuid);

	public void deleteExperiment(String uuid, String email);

	public void addProcess(String uuid, String processjson);
}

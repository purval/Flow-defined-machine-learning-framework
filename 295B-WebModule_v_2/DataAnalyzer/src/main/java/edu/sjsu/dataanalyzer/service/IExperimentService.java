package edu.sjsu.dataanalyzer.service;

import java.util.ArrayList;

import com.mongodb.DBObject;

public interface IExperimentService {
	
	public String pushNewExperiement(String email, String experimentName);

	public DBObject getExperimentDetails(String uuid);

	public void insertMetaData(ArrayList<String> metajson, String filepath, String uuid);

	public void deleteExperiment(String uuid, String email);

	public void addProcess(String uuid, String processjson);

	public void addMetadata(String uuid, String metadata);

	public void addParameters(String uuid, String parameters);

	public void addExclusionList(String exid, String exclusionList);
}

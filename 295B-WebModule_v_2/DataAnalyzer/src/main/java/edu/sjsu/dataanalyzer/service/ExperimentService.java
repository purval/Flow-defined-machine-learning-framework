package edu.sjsu.dataanalyzer.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;

import edu.sjsu.dataanalyzer.dbutils.MongoConnector;

public class ExperimentService implements IExperimentService{

	private static final Logger logger = LoggerFactory.getLogger(UserService.class);
	private MongoConnector connector = new MongoConnector();

	public void setMongoConnector(MongoConnector connector){
		this.connector = connector;
	}
	
	@Override
	public String pushNewExperiement(String email, String experimentName) {
		DBCollection coll = connector.getCollection("cmpedb","user");
		
		UUID uuid = UUID.randomUUID();
		String timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
		logger.info("uuid : "+uuid+" timestamp : "+timeStamp);
		//insert new experiment into user collection 
		try{
			DBObject listItem = new BasicDBObject("experiments", new BasicDBObject("uuid",uuid).append("experiment_name", experimentName).append("timestamp",timeStamp));
			DBObject updateQuery = new BasicDBObject("$push", listItem);
			DBObject findQuery = new BasicDBObject("id",email);
			coll.update(findQuery, updateQuery);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		logger.info("user collection updated");
		DBCollection experimentColl = connector.getCollection("cmpedb","experiments");
		//insert new experiments into user experiments details 
		try{
			BasicDBObject doc = new BasicDBObject();
			doc.put("id", uuid ); 
			doc.put("experiment_name", experimentName);
			doc.put("timestamp", timeStamp);
			experimentColl.insert(doc);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		logger.info("experiment collection updated");
		return uuid.toString();
	}
	
	@Override
	public DBObject getExperimentDetails(String uuid) {
		logger.info("Retrieving experiment details "+uuid);

		DBCollection coll = connector.getCollection("cmpedb","experiments");
		DBObject doc = new BasicDBObject();
		doc.put("id", UUID.fromString(uuid));
		DBObject dbObject = coll.findOne(doc);
		if(dbObject==null){
			return null;
		}
		return dbObject;
	}
	
	@Override
	public void insertMetaData(ArrayList<String> metajson, String filepath, String uuid){
		logger.info("insert metajson and file path");
		
		DBCollection coll = connector.getCollection("cmpedb","experiments");
		DBObject adddoc = new BasicDBObject("$set", new BasicDBObject("filepath", filepath));
		DBObject finddoc = new BasicDBObject("id",UUID.fromString(uuid));
		coll.update(finddoc, adddoc);
		adddoc = new BasicDBObject("$set", new BasicDBObject("metadata", metajson));
		coll.update(finddoc, adddoc);
	}
	
	@Override
	public void deleteExperiment(String uuid, String email){
		logger.info("delete experiment deatils from experiments and user collection");
		
		DBCollection coll = connector.getCollection("cmpedb","experiments");
		BasicDBObject document = new BasicDBObject("id", UUID.fromString(uuid));
		coll.remove(document);
		logger.info("experiment document removed from experiments collection");
		
		DBCollection collUser = connector.getCollection("cmpedb","user");
		BasicDBObject match = new BasicDBObject("id", email); 
		BasicDBObject update = new BasicDBObject("experiments", new BasicDBObject("uuid", UUID.fromString(uuid)));
		collUser.update(match, new BasicDBObject("$pull", update));
		logger.info("experiment details removed from user collection");
	}
	
	@Override
	public void addProcess(String uuid, String processjson){
		logger.info("process flow modification for experiment "+uuid);
		
		DBCollection coll = connector.getCollection("cmpedb","experiments");
		DBObject adddoc = new BasicDBObject("$set", new BasicDBObject("process_flow", processjson));
		DBObject finddoc = new BasicDBObject("id",UUID.fromString(uuid));
		coll.update(finddoc, adddoc);
	}
	
	@Override
	public void addMetadata(String uuid, String metadata){
		logger.info("metadata modification for experiment "+uuid);
		
		DBCollection coll = connector.getCollection("cmpedb","experiments");
		DBObject adddoc = new BasicDBObject("$set", new BasicDBObject("metadata", metadata));
		DBObject finddoc = new BasicDBObject("id",UUID.fromString(uuid));
		coll.update(finddoc, adddoc);
	}
	
	@Override
	public void addParameters(String uuid, String parameters){
		logger.info("parameters modification for experiment "+uuid);
		
		DBCollection coll = connector.getCollection("cmpedb","experiments");
		DBObject adddoc = new BasicDBObject("$set", new BasicDBObject("parameters", parameters));
		DBObject finddoc = new BasicDBObject("id",UUID.fromString(uuid));
		coll.update(finddoc, adddoc);
	}
	
	@Override
	public void addExclusionList(String exid, String exclusionList) {
		logger.info("excluding columns for experiment: "+exid);
		
		DBCollection coll = connector.getCollection("cmpedb","experiments");
		DBObject adddoc = new BasicDBObject("$set", new BasicDBObject("excludeList", exclusionList));
		DBObject finddoc = new BasicDBObject("id",UUID.fromString(exid));
		coll.update(finddoc, adddoc);
	}
}

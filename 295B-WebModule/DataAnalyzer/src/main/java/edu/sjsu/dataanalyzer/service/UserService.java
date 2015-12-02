package edu.sjsu.dataanalyzer.service;

import java.util.List;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import edu.sjsu.dataanalyzer.bean.User;
import edu.sjsu.dataanalyzer.dbutils.MongoConnector;

@Service
public class UserService implements IUserService{

	private static final Logger logger = LoggerFactory.getLogger(UserService.class);
	private MongoConnector connector = new MongoConnector();
	//private ConfigProperties config;

	public void setMongoConnector(MongoConnector connector){
		this.connector = connector;
		//this.config = config;
	}

	@Override
	public User get(String email) {
		logger.info("Retrieving an existing user");

		// Retrieve collection
		DBCollection coll = connector.getCollection("cmpedb","usercollection");

		DBObject doc = new BasicDBObject();
		doc.put("id", email);

		DBObject dbObject = coll.findOne(doc);
		if(dbObject==null){
			return null;
		}
		User user = new User();
		user.setEmail(dbObject.get("id").toString());
		user.setDisplayName(dbObject.get("displayname").toString());
		user.setPassword(dbObject.get("password").toString());

		return user;
	}

	@Override
	public boolean add(User user) {
		logger.info("Adding a new user");

		try {
			DBCollection coll = connector.getCollection("cmpedb","usercollection");
			BasicDBObject doc = new BasicDBObject();
			doc.put("id", user.getEmail() ); 
			doc.put("displayname", user.getDisplayName());
			doc.put("password", user.getPassword());
			coll.insert(doc);

			return true;

		} catch (Exception e) {
			logger.error("An error has occurred while trying to add new user", e);
			return false;
		}
	}

	private DBObject getDBObject( String email ) {
		logger.info("Retrieving an existing mongo object");

		DBCollection coll = connector.getCollection("cmpedb","usercollection");
		DBObject doc = new BasicDBObject();
		doc.put("id", email);

		return coll.findOne(doc);
	}

	@Override
	public boolean delete(String email) {
		logger.info("Deleting existing person");

		try {
			BasicDBObject item = (BasicDBObject) getDBObject(email);
			DBCollection coll = connector.getCollection("cmpedb","usercollection");
			coll.remove(item);

			return true;

		} catch (Exception e) {
			logger.error("An error has occurred while trying to delete new user", e);
			return false;
		}
	}

	@Override
	public boolean modifyUserDetails(User user) {
		logger.info("Modifying user details");

		try {
			BasicDBObject existing = (BasicDBObject) getDBObject( user.getEmail() );

			DBCollection coll = connector.getCollection("cmpedb","usercollection");
			BasicDBObject edited = new BasicDBObject();
			edited.put("id", user.getEmail()); 
			edited.put("displayname", user.getDisplayName());
			edited.put("password", user.getPassword());

			coll.update(existing, edited);

			return true;

		} catch (Exception e) {
			logger.error("An error has occurred while trying to edit existing user", e);
			return false;
		}
	}

	@Override
	public DBObject getLAM(String chamber, String date,String fileName,String Attribute){
		
		logger.info("Retrieving an existing user");

		JSONObject json = null;
		// Retrieve collection
		DBCollection coll = connector.getCollection("LAMDA","fullData");
		
		
		BasicDBObject query = new BasicDBObject();
		query.put("PM",chamber);
		query.put("Date", date);
		query.put("Attribute", Attribute);
		query.put("fileName", fileName);
		//query.put(key, val);
		//query.put("contents.historicalData", "AverageIBValue");
		DBCursor cur = coll.find(query);
		//DBCursor temp = cur;
		//System.out.println(cur);
//		DBObject fullData,content,historicalData,BiasMatchSeriesCapPosition_AI;//,values = null;
//		BasicDBList values=null;
		
		//System.out.println("CP1");
//		while(cur.hasNext()){
//			fullData= cur.next();
//			//System.out.println("CURSOR QUERY: "+fullData);
//			//content= (BasicDBObject) fullData.get("contents");
//			System.out.println("CP2");
//			//historicalData= (BasicDBObject) content.get("historicalData");
//			//System.out.println("HISTORICAL DATA ONLY::: "+historicalData);
//			System.out.println("CP3");
//			BiasMatchSeriesCapPosition_AI= (BasicDBObject) fullData.get("BiasMatchSeriesCapPosition_AI");
//			values = (BasicDBList) BiasMatchSeriesCapPosition_AI.get("Values");
//			System.out.println("VALUES::: "+values);
//
//		}
		
		//BasicDBObject dat = (BasicDBObject) temp.next();
		//return dat;
		DBObject fullData = null;
		//BasicDBList values=null;
		//System.out.println("got data: "+cur);
		while(cur.hasNext()){
			fullData= cur.next();
			 //values = (BasicDBList) fullData.get("Values");
			System.out.println("got data::: "+fullData);
		}
		
		return fullData;

	}

	@Override
	public List getLAMdate(String chamber) {
		// TODO Auto-generated method stub
		DBCollection coll = connector.getCollection("LAMDA","fullData");
		
		BasicDBObject query = new BasicDBObject();
		query.put("PM",chamber);

		//DBCursor cur = coll.find(query);
		List distDates = coll.distinct("Date", query);
		System.out.println("distinct dates list: "+distDates);
//		DBObject fullData=null;
//		StringBuilder dates = new StringBuilder();;
//		while(cur.hasNext()){
//			 fullData = cur.next();
//			 //values = (BasicDBList) fullData.get("Values");
//			System.out.println("dates data::: "+fullData);
//			dates.append(fullData.get("Date")+",");
//		}
		
		System.out.println("Sending dates list in json: "+ distDates);
		return distDates;
	}

	@Override
	public List getLamDateAndFile(String chamber, String date) {
		// TODO Auto-generated method stub
		DBCollection coll = connector.getCollection("LAMDA","fullData");
		
		BasicDBObject query = new BasicDBObject();
		query.put("PM",chamber);
		query.put("Date",date);
		//DBCursor cur = coll.find(query);
		List distFiles = coll.distinct("fileName", query);
		System.out.println("distinct file Names list: "+distFiles);
		return distFiles;
	}

	@Override
	public List getLamDateFileAndAtribute(String chamber, String date,String fileName) {
		// TODO Auto-generated method stub
		DBCollection coll = connector.getCollection("LAMDA","fullData");
		BasicDBObject query = new BasicDBObject();
		query.put("PM",chamber);
		query.put("Date",date);
		query.put("fileName",fileName);
		//DBCursor cur = coll.find(query);
		List distAttributes = coll.distinct("Attribute", query);
		System.out.println("distinct Attributes list: "+distAttributes);
		return distAttributes;
	}

	@Override
	public boolean new_experiment(String filename, String filepath,String experiment_name) {
		// TODO Auto-generated method stub
		DBCollection coll = connector.getCollection("CMPE295","saved_experiments");
		BasicDBObject query = new BasicDBObject();
		query.put("file_name",filename);
		query.put("file_path",filepath);
		query.put("experiment_name",experiment_name);
		//DBCursor cur = coll.find(query);
		return true;
	}
	
	

}

package edu.sjsu.dataanalyzer.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
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
}

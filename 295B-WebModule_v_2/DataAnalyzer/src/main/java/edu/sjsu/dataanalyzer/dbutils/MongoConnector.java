package edu.sjsu.dataanalyzer.dbutils;

import java.net.UnknownHostException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.Mongo;
import com.mongodb.MongoException;

public class MongoConnector {

	private static final Logger logger = LoggerFactory.getLogger(MongoConnector.class);

	private Mongo mongo;
	//private ConfigProperties config;

	public MongoConnector() {}

	/*public void setConfigurations(ConfigProperties config){
		this.config = config;
	}*/

	public Mongo getMongo() {
		logger.debug("Retrieving MongoDB");
		if (mongo == null) {
			try {
				mongo = new Mongo( "localhost" , 27017 );
			} catch (UnknownHostException e) {
				logger.error(e.getMessage());
			} catch (MongoException e) {
				logger.error(e.getMessage());
			}
		}
		return mongo;
	}

	public DB getDB(String dbname) {
		logger.debug("Retrieving db: " + dbname);
		return getMongo().getDB(dbname);
	}

	public DBCollection getCollection(String dbname, String collection) {
		logger.debug("Retrieving collection: " + collection);
		return getDB(dbname).getCollection(collection);
	}
}

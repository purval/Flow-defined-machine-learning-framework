package edu.sjsu.dataanalyzer.bean;

public class ConfigProperties {
	String mongodUrl;
	String mongodPort;
	String db;

	public ConfigProperties(){}

	public String getMongodUrl() {
		return mongodUrl;
	}
	public void setMongodUrl(String mongodUrl) {
		this.mongodUrl = mongodUrl;
	}
	public String getMongodPort() {
		return mongodPort;
	}
	public void setMongodPort(String mongodPort) {
		this.mongodPort = mongodPort;
	}
	public String getDb() {
		return db;
	}
	public void setDb(String db) {
		this.db = db;
	}
}	

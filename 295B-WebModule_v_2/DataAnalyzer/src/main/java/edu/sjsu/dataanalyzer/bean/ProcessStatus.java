package edu.sjsu.dataanalyzer.bean;

public class ProcessStatus {	

	String type;
	String message;
	String timestamp;

	public ProcessStatus() {
	}

	public ProcessStatus(String type, String message, String timestamp) {
		this.type = type;
		this.message = message;
		this.timestamp = timestamp;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	@Override
	public String toString() {
		return "{\"type\":\"" + type + "\",\"message\":\"" + message + "\", \"timestamp\":\"" + timestamp + "\"}";
	}
}

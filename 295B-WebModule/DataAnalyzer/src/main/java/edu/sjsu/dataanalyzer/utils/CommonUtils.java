package edu.sjsu.dataanalyzer.utils;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.Calendar;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;

import edu.sjsu.dataanalyzer.dbutils.MongoConnector;

public class CommonUtils {
	private static final Logger logger = LoggerFactory.getLogger(CommonUtils.class);
	
	private static final String filepath = System.getProperty("user.home");
	
	public static String storeToFileSystem(MultipartFile file){	
		long timeStamp = Calendar.getInstance().getTimeInMillis();
		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
				BufferedOutputStream stream =
						new BufferedOutputStream(new FileOutputStream(new File(filepath+"/"+timeStamp+"_"+file.getOriginalFilename())));
				stream.write(bytes);
				stream.close();
				
				logger.info("file successfully uploaded");
				return filepath+"/"+timeStamp+"_"+file.getOriginalFilename();
			} catch (Exception e) {	
				e.printStackTrace();
				return "error";
			}
		} else {
			return "error";
		}
	}
	
	public static boolean isNumeric(String str){  
		try{  
			Double.parseDouble(str);  
		}  
		catch(NumberFormatException nfe){  
			logger.info("metadata field is a valid string");
			return false;  
		}
		logger.info("metadata field is a number / create dummy fields");
		return true;  
	}
	
	public static String iterateForMetadata(String[] metadata, boolean metadataAvailable){
		StringBuilder builder = new StringBuilder();
		builder.append("{");
		int counter = 0;
		logger.info("iterate over metadata arr : "+metadata.length);
		while(counter < metadata.length){
			if(!metadataAvailable){
				if(counter == metadata.length-1){
					builder.append("\"feature"+counter+"\":\"false\"");
				}else{
					builder.append("\"feature"+counter+"\":\"false\",");
				}
			}else{
				if(counter == metadata.length-1){
					builder.append("\""+metadata[counter]+"\":\"false\"");
				}else{
					builder.append("\""+metadata[counter]+"\":\"false\",");
				}
			}
			counter++;
		}
		builder.append("}");
		return builder.toString();
	}
	
	public static String generateMetadata(File file){
		String metadataStr = "";
		try {
			BufferedReader br = new BufferedReader(new FileReader(file));
			String line = "";
			while((line = br.readLine()) != null){
				String[] metadata = line.split(" ");
				if(metadata.length < 1){
					logger.info("split by space failed");
					return "error";
				}else{
					if(isNumeric(metadata[0])){
						metadataStr = iterateForMetadata(metadata, false);
					}else{
						metadataStr = iterateForMetadata(metadata, true);
					}
				}
				break;
			}
			br.close();
			return metadataStr;
		} catch (IOException e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	public static void main(String[] args) {
		//76faa9bf-4565-4f27-b520-79ae26309606
		//8d77aef3-caec-4148-8dde-742be981fbfb
		String uuid = "76faa9bf-4565-4f27-b520-79ae26309606";
		MongoConnector connector = new MongoConnector();
		DBCollection coll = connector.getCollection("cmpedb","experiments");
		BasicDBObject document = new BasicDBObject("id", UUID.fromString(uuid));
		coll.remove(document);
		
		DBCollection collUser = connector.getCollection("cmpedb","user");
		BasicDBObject match = new BasicDBObject("id", "purval@gmail.com"); 
		BasicDBObject update = new BasicDBObject("experiments", new BasicDBObject("uuid", UUID.fromString(uuid)));
		collUser.update(match, new BasicDBObject("$pull", update));
	}
}

package edu.sjsu.dataanalyzer.utils;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import edu.sjsu.dataanalyzer.bean.ProcessStatus;

public class CommonUtils {
	private static final Logger logger = LoggerFactory.getLogger(CommonUtils.class);
	
	private static final String filepath = System.getProperty("user.home");
	private static Map<String, Queue<ProcessStatus>> logstore = new HashMap<String, Queue<ProcessStatus>>(); 
	
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
	
	public static ArrayList<String> iterateForMetadata(String[] metadata, boolean metadataAvailable){
		ArrayList<String> build = new ArrayList<String>();
		int counter = 0;
		logger.info("iterate over metadata arr : "+metadata.length);
		while(counter < metadata.length){
			if(!metadataAvailable){
				if(counter == metadata.length-1){
					//builder.append("\"feature"+counter+"\":\"true\"");
					build.add("feature"+counter);
				}else{
					build.add("feature"+counter);
				}
			}else{
				if(counter == metadata.length-1){
					build.add(metadata[counter]);
				}else{
					build.add(metadata[counter]);
				}
			}
			counter++;
		}
		return build;
	}
	
	public static ArrayList<String> generateMetadata(File file){
		ArrayList<String> metadataStr2 = new ArrayList<String>();
		try {
			BufferedReader br = new BufferedReader(new FileReader(file));
			String line = "";
			while((line = br.readLine()) != null){
				String[] metadata = line.split(" ");
				if(metadata.length < 2){
					metadata = line.split(",");
				}
				if(metadata.length < 1){
					logger.info("split by space failed");
					ArrayList<String> metadataError = new ArrayList<String>();
					metadataError.add("ERROR");
					return metadataError;
				}else{
					if(isNumeric(metadata[0])){
						metadataStr2 = iterateForMetadata(metadata, false);
					}else{
						metadataStr2 = iterateForMetadata(metadata, true);
					}
				}
				break;
			}
			br.close();
			return metadataStr2;
		} catch (IOException e) {
			ArrayList<String> metadataError = new ArrayList<String>();
			metadataError.add(e.toString());
			e.printStackTrace();
			return metadataError;
		}
	}
	
	public static void setConsoleLog(String uuid, String type, String message){
		ProcessStatus ps= new ProcessStatus(type, message, new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime()));
		if(logstore.containsKey(uuid)){
			Queue<ProcessStatus> logQ = logstore.get(uuid);
			logQ.add(ps);
		   logstore.put(uuid, logQ);	
		}else{
			Queue<ProcessStatus> logQ = new LinkedList<ProcessStatus>();
			logQ.add(ps);
			logstore.put(uuid, logQ);
		}
	}
	
	public static List<String> getConsoleLog(String uuid){
		if(logstore.containsKey(uuid)){
			Queue<ProcessStatus> logQ = logstore.get(uuid);
			List<String> logs = new ArrayList<String>();
			while(!logQ.isEmpty()){
				logs.add(logQ.remove().toString());
			}	
			return logs;
		}
		return null;
	}
}

package edu.sjsu.dataanalyzer;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mongodb.BasicDBList;
import com.mongodb.DBObject;

import edu.sjsu.dataanalyzer.bean.User;
import edu.sjsu.dataanalyzer.service.ExperimentService;
import edu.sjsu.dataanalyzer.service.UserService;
import edu.sjsu.dataanalyzer.utils.CommonUtils;

@Controller
public class RestController {
	private static final Logger logger = LoggerFactory.getLogger(RestController.class);

	@Autowired(required=true)
	@Qualifier(value="userService")
	private UserService userService;
	public void setUserService(UserService userService){
		this.userService = userService;
	}

	@Autowired(required=true)
	@Qualifier(value="experimentService")
	private ExperimentService experimentService;
	public void setExperimentService(ExperimentService experimentService){
		this.experimentService = experimentService;
	}

	@RequestMapping(value = "/uploaddataset", method = RequestMethod.POST)
	public @ResponseBody String uploadLogo(MultipartHttpServletRequest request, HttpSession session) {
		try {
			String uuid = (String) session.getAttribute("exid");
			Iterator<String> itr = request.getFileNames();
			MultipartFile file = request.getFile(itr.next());
			logger.info("filename : "+file.getOriginalFilename());
			//save file to local system
			String filepath = CommonUtils.storeToFileSystem(file);
			if(filepath.equalsIgnoreCase("error")){
				logger.info("upload failed / file save fail");
				return "{'status':400,'msg':'upload failed'}";
			}
			logger.info("filepath : "+filepath);

			// generate metadata
			File metafile = new File(filepath);
			if(!metafile.exists()){
				logger.info("upload failed / file does not exists");
				return "{'status':400,'msg':'metadata generation failed / file not found'}";
			}
			ArrayList<String> metajson = CommonUtils.generateMetadata(metafile);
			if(metajson.get(0).equalsIgnoreCase("ERROR")){
				logger.info("upload failed / metadata generation failed");
				return "{'status':400,'msg':'metadata generation failed / file not found'}";
			}
			logger.info("metadata json : "+metajson);

			//save metadata with file path into mongodb
			logger.info("uuid : "+uuid);
			experimentService.insertMetaData(metajson, filepath, uuid);

			//return metadata json
			return metajson.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "{'status':400,'msg':'upload failed'}";
	}

	@RequestMapping(value = "/experimentlist", method = RequestMethod.GET)
	public @ResponseBody String getExperimentList(HttpSession session) {
		User user = (User) session.getAttribute("user");
		logger.info("get experiment list for user "+user.getEmail());
		List list = userService.getExperimentList(user.getEmail());
		return list.toString();
	}

	@RequestMapping(value = "/experiment/id/{exid}", method = RequestMethod.DELETE)
	public @ResponseBody String deleteExperimentById(@PathVariable String exid, HttpSession session) {
		logger.info("delete experiment by id "+exid);
		User user = (User) session.getAttribute("user");
		experimentService.deleteExperiment(exid, user.getEmail());
		return "{'status':200,'msg':'experiement deleted'}";
	}

	@RequestMapping(value = "/experiment", method = RequestMethod.DELETE)
	public @ResponseBody String deleteExperiment(HttpSession session) {
		logger.info("delete current experiment");
		String exid = (String) session.getAttribute("exid");
		User user = (User) session.getAttribute("user");
		experimentService.deleteExperiment(exid, user.getEmail());
		return "{'status':200,'msg':'experiement deleted'}";
	}

	@RequestMapping(value = "/processflow", method = RequestMethod.POST)
	public @ResponseBody String addProcessFlow(@RequestBody String processjson, HttpSession session) {
		logger.info("add or update process flow json "+ processjson);
		String exid = (String) session.getAttribute("exid");
		experimentService.addProcess(exid, processjson);
		return "{'status':200,'msg':'process flow added'}";
	}

	@RequestMapping(value = "/exclude", method = RequestMethod.POST)
	public @ResponseBody String addMetaData(@RequestBody String exclusionList, HttpSession session) {
		logger.info("add or update excluded column list "+ exclusionList);
		String exid = (String) session.getAttribute("exid");
		experimentService.addExclusionList(exid, exclusionList);
		return "{'status':200,'msg':'process flow added'}";
	}

	@RequestMapping(value = "/parameters", method = RequestMethod.POST)
	public @ResponseBody String addParameters(@RequestBody String parameters, HttpSession session) {
		logger.info("add or update metadata json "+ parameters);
		String exid = (String) session.getAttribute("exid");
		experimentService.addParameters(exid, parameters);
		return "{'status':200,'msg':'process flow added'}";
	}

	@RequestMapping(value = "/consolelog", method = RequestMethod.GET)
	public @ResponseBody String returnConsoleLog(HttpSession session) {
		logger.info("poll for process status logs");
		String exid = (String) session.getAttribute("exid");
		List<String> logs = CommonUtils.getConsoleLog(exid); 
		if(logs != null){
			return logs.toString();
		}
		return "[]";
	}

	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public void download(HttpServletResponse response, HttpSession session) throws IOException {
		String exid = (String) session.getAttribute("exid");
		logger.info("retrive output result file for experiment : "+exid);

		String resultFilePath = experimentService.getOutputDataPath(exid);
		if(resultFilePath == null){
			response.sendError(400, "result output not available");
		}else{
			File file = new File(resultFilePath);
			InputStream is = new FileInputStream(file);
			// MIME type of the file
			response.setContentType("application/octet-stream");
			// Response header
			response.setHeader("Content-Disposition", "attachment; filename=\""
					+ file.getName() + "\"");
			// Read from the file and write into the response
			OutputStream os = response.getOutputStream();
			byte[] buffer = new byte[1024];
			int len;
			while ((len = is.read(buffer)) != -1) {
				os.write(buffer, 0, len);
			}
			os.flush();
			os.close();
			is.close();
		}
	}

	@RequestMapping(value = "/execute", method = RequestMethod.POST)
	public @ResponseBody String executeFlow(@RequestBody String flow, HttpSession session) throws InterruptedException {
		logger.info("validated process flow "+ flow);
		String exid = (String) session.getAttribute("exid");

		//String replacFlow = flow.replaceAll("(?=[]\\[+&|!(){}^\"~*?:\\\\-])", "");
		//String[] flowSteps = replacFlow.split(",");

		DBObject runTimeDetails =  experimentService.getExperimentDetails(exid);
		BasicDBList inputCols =  (BasicDBList) runTimeDetails.get("metadata");
		String parameters = (String) runTimeDetails.get("parameters");
		//String train_data_path = "/Users/ruchas/Desktop/eclipse/Eclipse.app/Contents/MacOS/secom_train.csv";//(String) runTimeDetails.get("train_data_path");
		//String test_data_path = "/Users/ruchas/Desktop/eclipse/Eclipse.app/Contents/MacOS/secom_test.csv";//(String) runTimeDetails.get("test_data_path");
		String excludeColumns =  (String) runTimeDetails.get("excludeList");
		String original_data_path =  (String) runTimeDetails.get("filepath");

		JSONObject paramJson = new JSONObject(parameters);


		String NUMBER_OF_FEATURES = (String) paramJson.getString("bestfeatures");//"50"; // BRING FROM DB LATER.
		String SPLIT_TYPE=(String) paramJson.getString("splittype");//"SHUFFLE_SPLIT";
		String TRAIN_SPLIT_RATIO=(String) paramJson.getString("split");//"0.7"; OR a number like 1500 i.e. first 1500 samples as train data.
		String OUTPUT_TYPE=(String) paramJson.getString("outputtype");//"EXACT_OUTPUT","ROUNDED_OUTPUT";
		String TARGET=(String) paramJson.getString("target");//"SHUFFLE_SPLIT";

		String replacExclude = excludeColumns.replace("\\[", "").replace("\\]", "").replace("\"", "");
		String replacExclude1 = replacExclude.substring(1, replacExclude.length()-1);
		String[] excludeCols = replacExclude1.split(",");
		HashMap<Integer,Integer> excludeColumnsMap = new HashMap();
		for(int i=0;i<excludeCols.length;i++){
			excludeColumnsMap.put(Integer.parseInt(excludeCols[i]), 1);
			System.out.print(excludeCols[i]+" ");
		}
		StringBuilder inputColumns =new StringBuilder();
		for(int i=0;i<inputCols.size();i++){
			if(!excludeColumnsMap.containsKey(i)){
				inputColumns.append(inputCols.get(i)+",");
			}
		}

		logger.info("Features:"+NUMBER_OF_FEATURES);
		logger.info("Split type:"+SPLIT_TYPE);
		logger.info("Train split ratio:"+TRAIN_SPLIT_RATIO);
		logger.info("Output type:"+OUTPUT_TYPE);
		logger.info("Target:"+TARGET);

		//System.out.println(parameters);
		//String tar = parameters.substring(parameters.indexOf("target")+9, parameters.length()-2);
		//System.out.println(tar);
		CommonUtils.runFlow(flow, exid, inputColumns.toString().substring(0, inputColumns.length()-1), TARGET,original_data_path,NUMBER_OF_FEATURES,SPLIT_TYPE,TRAIN_SPLIT_RATIO, OUTPUT_TYPE);
		return "{'status':200,'msg':'process flow added'}";
	}
}

TO DO:

pull the directory using 
git pull https://295B........
git submodule udpate
git submodule init 

PARSE & LOAD LAM DATASET INTO MONGO
1. Download and extract the LAM Dataset
2. copy the lamconvert.jar & mongo-java-driver-2.13.3.jar from github.
3. turn on your mongo db.
3. Use the below command where you have stored lamconvert.jar.
java -cp "lamconvert.jar:/path/to/mongo-java.jar” lam2mongo.AllFlatAttributes LAM_data/LDE_08172015130820_bundle/LamData/Tripod02/data
4. database: cmpedb collection: fullData

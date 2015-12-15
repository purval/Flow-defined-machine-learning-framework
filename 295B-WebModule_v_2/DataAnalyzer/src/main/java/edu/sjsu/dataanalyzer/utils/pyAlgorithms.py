import numpy as np
import pandas as pd
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import AdaBoostRegressor
from django.core.files.storage import default_storage
from sklearn import ensemble
from sklearn.cross_validation import train_test_split
import sys
import os
import datetime
#from pymongo import MongoClient
#print os.path.join(os.path.expanduser('~'),"test_output.csv")
outputFilePath = os.path.join(os.path.expanduser('~'),sys.argv[2]+datetime.datetime.now().strftime('%Y%m%d%H%M%S')+".csv")
print ">>>>>",outputFilePath,"<<<<<"
#client = MongoClient()
#client = MongoClient('localhost', 27017)
#db = client.cmpedb

#path1 = open(sys.argv[2]) #train data
#path2 = open(sys.argv[3]) #test data
#train_data = pd.read_csv(path1, parse_dates=[0])
#test_data = pd.read_csv(path2, parse_dates=[0])
pd.options.mode.chained_assignment = None  # default='warn'
path1 = open(sys.argv[2]) #FULL data
full_data = pd.read_csv(path1, parse_dates=[0])
if(sys.argv[3]=="shuffle"):
    train_data, test_data = train_test_split(full_data, train_size=float(sys.argv[6]))
elif(sys.argv[3]=="fixed"):
    train_data, test_data = train_test_split(full_data, train_size=float(sys.argv[6]),random_state=1)
elif(sys.argv[3]=="custom"):
    train_data=full_data[:int(sys.argv[6])]
    test_data=full_data[int(sys.argv[6]):]
inputColumns= sys.argv[4].split(',')
outputColumns=sys.argv[5]
#with pd.option_context('display.max_rows', 10000, 'display.max_columns', 5000):
    #print "Your TEST dataset-->",test_data, "<--TEST data ends here."
outputCol="Predicted_"+sys.argv[5]


if(sys.argv[1]=='BOOSTED_DECISION_TREE'):
    # BOOSTED DECISION TREE
    rng = np.random.RandomState(1)
    regr_2 = AdaBoostRegressor(DecisionTreeRegressor(max_depth=4), n_estimators=300, random_state=rng)
    trained2=regr_2.fit(train_data[inputColumns].values, train_data[outputColumns].values)
    y_2 = trained2.predict(test_data[inputColumns])
    if sys.argv[7]=="exact":
        print y_2
        test_data[outputCol]=y_2
    elif sys.argv[7]=="rounded":
        print(y_2.astype(np.int64))
        test_data[outputCol]=y_2.astype(np.int64)
elif(sys.argv[1]=='DECISION_TREE'):
    # DECISION TREE
    regr_1 = DecisionTreeRegressor(max_depth=4)
    trained1=regr_1.fit(train_data[inputColumns].values, train_data[outputColumns].values)
    y_1 = trained1.predict(test_data[inputColumns])
    if(sys.argv[7]=="exact"):
        print y_1
        test_data[outputCol]=y_1
    elif(sys.argv[7]=="rounded"):
        print(y_1.astype(np.int64))
        test_data[outputCol]=y_1.astype(np.int64)
elif(sys.argv[1]=='GRADIENT_BOOSTING'):
    # GRADIENT BOOSTING
    regr_3 = ensemble.GradientBoostingRegressor(n_estimators=80, learning_rate = .05, max_depth = 10,min_samples_leaf = 20)
    trained3= regr_3.fit(train_data[inputColumns].values, train_data[outputColumns].values)
    y_3 = trained3.predict(test_data[inputColumns])
    #y_4 = regr_3.score(train_data[inputColumns].values, train_data[outputColumns].values,sample_weight=None)
    if(sys.argv[7]=="exact"):
        print y_3
        test_data[outputCol]=y_3
    elif(sys.argv[7]=="rounded"):
        print(y_3.astype(np.int64))
        test_data[outputCol]=y_3.astype(np.int64)
test_data.to_csv(outputFilePath)
## os.path.join(os.path.expanduser('~'),sys.argv[2]+datetime.datetime.now().strftime('%Y%m%d%H%M%S')+".csv")

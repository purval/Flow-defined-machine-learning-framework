import numpy as np
import pandas as pd
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import AdaBoostRegressor
from django.core.files.storage import default_storage
from sklearn import ensemble
import sys
#from pymongo import MongoClient

#client = MongoClient()
#client = MongoClient('localhost', 27017)
#db = client.cmpedb

path1 = open(sys.argv[2]) #train data
path2 = open(sys.argv[3]) #test data

train_data = pd.read_csv(path1, parse_dates=[0])
test_data = pd.read_csv(path2, parse_dates=[0])

inputColumns= sys.argv[4].split(',')
outputColumns=sys.argv[5]


if(sys.argv[1]=='BOOSTED_DECISION_TREE'):
	# BOOSTED DECISION TREE
	rng = np.random.RandomState(1)
	regr_2 = AdaBoostRegressor(DecisionTreeRegressor(max_depth=4), n_estimators=300, random_state=rng)
	trained2=regr_2.fit(train_data[inputColumns].values, train_data[outputColumns].values)
	y_2 = trained2.predict(test_data[inputColumns])
	print(y_2.astype(np.int64))
elif(sys.argv[1]=='DECISION_TREE'):
	# DECISION TREE
	regr_1 = DecisionTreeRegressor(max_depth=4)
	trained1=regr_1.fit(train_data[inputColumns].values, train_data[outputColumns].values)
	y_1 = trained1.predict(test_data[inputColumns])
	print(y_1.astype(np.int64))
elif(sys.argv[1]=='GRADIENT_BOOSTING'):
	# GRADIENT BOOSTING
	regr_3 = ensemble.GradientBoostingRegressor(n_estimators=80, learning_rate = .05, max_depth = 10,min_samples_leaf = 20)
	trained3= regr_3.fit(train_data[inputColumns].values, train_data[outputColumns].values)
	y_3 = trained3.predict(test_data[inputColumns])
	#y_4 = regr_3.score(train_data[inputColumns].values, train_data[outputColumns].values,sample_weight=None)
	print(y_3.astype(np.int64))
	#print("Yield score using gradient boosting: ",y_4)
import numpy as np
import pandas as pd
from sklearn import ensemble
import sys
from sklearn.feature_selection import RFE
from sklearn.linear_model import LogisticRegression

from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import chi2

from sklearn import metrics
from sklearn.ensemble import ExtraTreesClassifier
#from pymongo import MongoClient

#client = MongoClient()
#client = MongoClient('localhost', 27017)
#db = client.cmpedb

path1 = open(sys.argv[2]) #Full Data
full_data = pd.read_csv(path1, parse_dates=[0])

inputColumns= sys.argv[3].split(',')
outputColumns=sys.argv[4]
number_of_features=int(sys.argv[5])

if(sys.argv[1]=='EXTRA_TREE_CLASSIFIER'):
	# Extra Trees model
	print "........ STARTING EXTRA TREE CLASSIFIER FEATURE SELECTOR......."
	model = ExtraTreesClassifier(n_estimators=250,random_state=0)
	model.fit(full_data[inputColumns].values, full_data[outputColumns].values)
	# display the relative importance of each attribute
	print(model.feature_importances_)
	#makeArr = np.array(model.feature_importances_)
	importances = model.feature_importances_ #array with importances of each feature
	print "Reducing to ",number_of_features," features"
	sorted_lastN_features = np.argsort(importances)[::-1][:number_of_features]
	#print sorted_idx
	print sorted_lastN_features
elif(sys.argv[1]=='SELECT_K_BEST'):
	# TESTING SELCT K BEST USING CHI SQUARED MODEL
	print "........ STARTING K-BEST FEATURE SELECTOR USING CHI SQUARED AS MODEL........"
	print "NOTE: CHI SQUARED BASED K-BEST SELECTOR WORKS ONLY WITH NON-NEGATIVE VALUES"
	featureSelector = SelectKBest(score_func=chi2,k=number_of_features)
	featureSelector.fit(full_data[inputColumns].values, full_data[outputColumns].values)
	assumed_to_be_the_feature_ids_of_the_top_k_features = list(featureSelector.get_support(indices=True)) #indices=False just gives me a list of True,False etc...
	print "Reducing to ",number_of_features," features"
	print assumed_to_be_the_feature_ids_of_the_top_k_features
elif(sys.argv[1]=='RFE'):
	#RFE MODEL FOR FEATURE SELECTION
	print "........ STARTING RFE FEATURE SELECTOR USING LOGISTIC REGRESSION AS MODEL........."
	model = LogisticRegression()
	rfe = RFE(model, number_of_features)
	rfe = rfe.fit(full_data[inputColumns].values, full_data[outputColumns].values)
	# summarize the selection of the attributes
	print(rfe.support_)
	print "Reducing to ",number_of_features," features"
	print(rfe.ranking_)
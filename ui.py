# For reference:
# https://askubuntu.com/questions/70883/how-do-i-install-python-pandas
# https://datascience-enthusiast.com/R/AWS_RDS_R_Python.html

# Dependencies:
# sudo apt-get install python-pip
# sudo pip install numpy
# sudo pip install pandas
# pip install PyMySQL

import pandas as pd
import pymysql

host='videogamedb.coollmbh4cdk.us-west-2.rds.amazonaws.com'
port=3306
dbname='VideoGameDB'
user='admin'
password='teamkelvin4'
        
mydb = pymysql.connect(host, user=user, port=port, passwd=password, db=dbname)

# Testing print of Mob table
test = pd.read_sql('SELECT * FROM MOB', con=mydb)
print(test)

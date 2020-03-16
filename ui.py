# For reference:
# https://askubuntu.com/questions/70883/how-do-i-install-python-pandas
# https://datascience-enthusiast.com/R/AWS_RDS_R_Python.html

# Dependencies:
#
# For Linux (bash):
# sudo install python
# sudo apt-get install python-pip
# sudo pip install numpy
# sudo pip install pandas
# pip install PyMySQL
#
#
# For Windows (PowerShell):
# python (should redirect to windows store to download python)
# pip install numpy
# pip install pandas
# pip install PyMySQL
# python -m pip install --upgrade pip
#
#
#
# To Run:
# python ui.py

import pandas as pd
import pymysql

# Database connection
host='videogamedb.coollmbh4cdk.us-west-2.rds.amazonaws.com'
port=3306
dbname='VideoGameDB'
user='admin'
password='teamkelvin4'
        
mydb = pymysql.connect(host, user=user, port=port, passwd=password, db=dbname)

# UI (Dashboard)
print("\nDashboard:")
print("1: testprint")
print("2: ")
print("3: ")
print("4: ")
print("5: ")
print("6: ")
print("Use Cases:")
print("7: Show all players currently at LOCATION: Skyrim")
print("8: Show all characters for EMAIL: adiviney35@time.com")
print("9: ")
print("0: Exit")

def testprint():
    test = pd.read_sql('SELECT* FROM MOB', con=mydb)
    print(test)

# Get all players at Skyrim
def skyrim():
    retVal = pd.read_sql('SELECT ACC_Email, Character_Name FROM PLAYER_CHARACTER, LOCATION WHERE LOC_Location_ID="Skyrim"', con=mydb)
    print(retVal)

# Show all characters for email
def account():
    print("SELECT * FROM PLAYER_CHARACTER WHERE ACC_Email='adiviney35@time.com'")
    retVal = pd.read_sql('SELECT * FROM PLAYER_CHARACTER WHERE ACC_Email="adiviney35@time.com"', con=mydb)
    print(retVal)

# Dictionary for switch
switcher = {
    1: testprint,
    7: skyrim,
    8: account,
    0: exit
}

# Getting user input
while True:
    value = int(input('---> '))
    switcher[value]()

# Testing print of Mob table
# test = pd.read_sql('SELECT * FROM MOB', con=mydb)
# print(test)

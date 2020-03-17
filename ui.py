# For reference:
# https://askubuntu.com/questions/70883/how-do-i-install-python-pandas
# https://datascience-enthusiast.com/R/AWS_RDS_R_Python.html

# Dependencies / Getting Started:
#
# For Linux (bash):
# sudo install python
# sudo apt-get install python-pip
# sudo pip install numpy
# sudo pip install pandas
# pip install PyMySQL
#
# For Windows (PowerShell):
# python (should redirect to windows store to download python)
# pip install numpy
# pip install pandas
# pip install PyMySQL
# python -m pip install --upgrade pip

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

# Allows for custom SQL statement through command line input
def customSQL():
    retVal = input('Enter SQL ---> ')
    test = pd.read_sql(retVal, con=mydb)
    print(test)

# Get all players at Skyrim
def skyrim():
    print("\nSELECT ACC_Email, Character_Name FROM PLAYER_CHARACTER, LOCATION WHERE LOC_Location_ID='Skyrim'\n")
    retVal = pd.read_sql('SELECT ACC_Email, Character_Name FROM PLAYER_CHARACTER, LOCATION WHERE LOC_Location_ID="Skyrim"', con=mydb)
    print(retVal)

# Show all characters for email
def account():
    print("\nSELECT * FROM PLAYER_CHARACTER WHERE ACC_Email='adiviney35@time.com'\n")
    retVal = pd.read_sql('SELECT * FROM PLAYER_CHARACTER WHERE ACC_Email="adiviney35@time.com"', con=mydb)
    print(retVal)

# Show all characters for email
def classType():
    # Print SQL Statements
    print("\nSELECT COUNT(Character_Name) FROM PLAYER_CHARACTER WHERE Class='Thief'\n")
    print("\nSELECT COUNT(Character_Name) FROM PLAYER_CHARACTER WHERE Class='Mage'\n")
    print("\nSELECT COUNT(Character_Name) FROM PLAYER_CHARACTER WHERE Class='Warrior'\n")

    # Execute SQL 
    retVal = pd.read_sql('SELECT COUNT(Character_Name) FROM PLAYER_CHARACTER WHERE Class="Thief"', con=mydb)
    retVal1 = pd.read_sql('SELECT COUNT(Character_Name) FROM PLAYER_CHARACTER WHERE Class="Mage"', con=mydb)
    retVal2 = pd.read_sql('SELECT COUNT(Character_Name) FROM PLAYER_CHARACTER WHERE Class="Warrior"', con=mydb)
    
    # Print Results
    print("Thief")
    print(retVal)
    print("\nMage")
    print(retVal1)
    print("\nWarrior")
    print(retVal2)

# Show all fights for character name
def kills():
    print("\nSELECT * FROM KILL_COUNTER WHERE CHAR_Name='rertelt23'\n")
    retVal = pd.read_sql('SELECT * FROM KILL_COUNTER WHERE CHAR_Name="rertelt23"', con=mydb)
    print(retVal)

# Show quest record for character name cmiche13
def quest():
    print("\nSELECT QUEST_ID, Completed FROM QUEST_COUNTER WHERE CHAR_Name='cmiche13'\n")
    retVal = pd.read_sql('SELECT QUEST_ID, Completed FROM QUEST_COUNTER WHERE CHAR_Name="cmiche13"', con=mydb)
    print(retVal)

# Dictionary for switch
switcher = {
    1: customSQL,
    2: skyrim,
    3: account,
    4: classType,
    5: kills,
    6: quest,
    0: exit
}

# Getting user input
while True:
    # UI Dashboard
    print("\nDashboard:")
    print("1: Enter custom SQL Statement")
    print("2: Show all players currently at LOCATION: Skyrim")
    print("3: Show all characters for EMAIL: adiviney35@time.com")
    print("4: Show how many player are of each CLASS: (Thief, Mage, Warrior)")
    print("5: Show all fights that CHARACTER: rertelt23 has been in")
    print("6: Show quest record for CHARACTER: cmiche13")
    print("0: Exit")

    value = int(input('---> '))
    switcher[value]()


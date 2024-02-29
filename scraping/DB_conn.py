import mysql.connector

db_name = "robotics"
user_name = "root"
password = "qdHscF74&"
host = "localhost"  

def getConn():
    try:
        # Connect to the database
        connection = mysql.connector.connect(
            database=db_name, user=user_name, password=password, host=host
        )

        return connection
    except mysql.connector.Error as err:
        print(f"Error: Failed to connect to database: {err}")
    return None
  

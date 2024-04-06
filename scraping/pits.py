from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors
from random import choice

IMAGE_API_URL = "https://picsum.photos/v2/list"

def insertPits(conn):
    insert_query = """
    INSERT INTO `robotics`.`Pits`
    (`image`)
    VALUES
    (%s);
    """

    cur = conn.cursor()
    try:
        for i in range(100):
            response = requests.get(IMAGE_API_URL)
            response.raise_for_status()
            data = response.json()

            image = requests.get(choice(data)["download_url"], stream=True).content
            
            cur.execute(insert_query, (image,))

            
    except requests.exceptions.RequestException as e:
            print(f"Error: An error occurred while making the request: {e}")
    finally:
        cur.close()


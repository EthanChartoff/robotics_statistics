from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors


def dumbInsertGroups(conn):
    insert_groups_query = """
    INSERT INTO `robotics`.`groups`
    (`name`)
    VALUES
    (%s);
    """

    try:
        cur = conn.cursor()
        for g in ["blue", "red"]:
            cur.execute(insert_groups_query, (g,))

    except requests.exceptions.RequestException as e:
        print(f"Error: An error occurred while making the request: {e}")
    except mysql.connector.errors.IntegrityError as e:
        print(f"Error: {e}")
    
    finally:
        cur.close()
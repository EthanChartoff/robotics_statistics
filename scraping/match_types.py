from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors

def insertMatchTypes(conn): 
    code_query = "SELECT `code` FROM robotics.Competitions;"
    insert_types_query = """
    INSERT INTO `robotics`.`Match_Type`
    (`type`)
    VALUES
    (%s);
    """
    match_types = set()

    try:
        cur = conn.cursor()
        cur.execute(code_query)
        codes = cur.fetchall()


        for code in codes:
            page_url = f"/event/{code[0]}/matches/simple"
            response = requests.get(base_url + page_url, headers=headers)
            response.raise_for_status()
            data = response.json()

            for match in data:
                match_types.add(match["comp_level"])
        
        for mt in match_types:
            values = (mt)
            cur.execute(insert_types_query, values)


    except requests.exceptions.RequestException as e:
        print(f"Error: An error occurred while making the request: {e}")
    except mysql.connector.errors.IntegrityError as e:
        print(f"Error: {e}")   
    
    finally:
        cur.close()

def dumbInsertMatchTypes(conn):
    insert_types_query = """
    INSERT INTO `robotics`.`Match_Type`
    (`type`)
    VALUES
    (%s);
    """

    try:
        cur = conn.cursor()

        
        for val in ["qf", "ef", "sf", "f", "qm"]:
            cur.execute(insert_types_query, (val,))
        

    except requests.exceptions.RequestException as e:
        print(f"Error: An error occurred while making the request: {e}")
    except mysql.connector.errors.IntegrityError as e:
        print(f"Error: {e}")
    
    finally:
        cur.close()
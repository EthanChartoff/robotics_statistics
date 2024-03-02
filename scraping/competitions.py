from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors

def insertCompetitions(conn):
    sql = """
    INSERT INTO `robotics`.`Competitions`
    (`Cities_id`,
    `code`,
    `start_date`,
    `end_date`,
    `name`,
    `website`,
    `address`)
    VALUES
    ((SELECT Cities.id FROM `robotics`.`Cities` WHERE Cities.name = %s LIMIT 1),
    %s,
    %s,
    %s,
    %s,
    %s,
    %s);
    """

    year = min_year
    cur = conn.cursor()

    try:
        while year <= datetime.now().year:
            page_url = f"/events/{year}"
            response = requests.get(base_url + page_url, headers=headers)
            response.raise_for_status()
            data = response.json()

            for comp in data:
                values = (comp["city"], comp["key"], comp["start_date"], comp["end_date"], comp["name"], comp["website"], comp["address"])
                cur.execute(sql, values)

            year = year + 1

    except requests.exceptions.RequestException as e:
        print(f"Error: An error occurred while making the request: {e}")
    except mysql.connector.errors.IntegrityError as e:
        print(f"Error: {e} \nTable: {comp}")
    
    finally:
        cur.close()
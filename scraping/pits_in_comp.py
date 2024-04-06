from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors
import random

def pitsInComp(conn):
    pits_query = "SELECT id FROM robotics.Pits;"
    teams_in_comp_query = "SELECT `Competitions_id`,`Teams_id` FROM `robotics`.`Teams_in_Competitions`;"

    insert_query = """
    INSERT INTO `robotics`.`Pits_in_Competitions`
    (`Pits_id`,
    `Competitions_id`,
    `Teams_id`)
    VALUES
    (%s,
    %s,
    %s);
    """

    cur = conn.cursor()
    try:
        cur.execute(pits_query)
        pits_ids = cur.fetchall()

        cur.execute(teams_in_comp_query)
        teams_in_comp = cur.fetchall()  

        for pit in pits_ids:
            random_team = random.choice(teams_in_comp)

            cur.execute(insert_query, (pit[0], random_team[0], random_team[1]))

    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        cur.close()
from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors


def insertAwardsInCompetitions(conn):
    teams_query = "SELECT id, team_number FROM robotics.Teams;"
    match_code_query = "SELECT id, `code` FROM robotics.Matches;"
    comp_code_query = "SELECT id, `code` FROM robotics.Competitions;"

    insert_query = """
        INSERT INTO `robotics`.`Awards_in_Competitions`
        (`Awards_id`,
        `Competitions_id`,
        `Teams_id`)
        VALUES
        (%s,
        %s,
        %s);
    """

    cur = conn.cursor()
    try:
        cur.execute(teams_query)
        teams = {int(team[1]): team[0] for team in cur.fetchall()}  

        cur.execute(match_code_query)
        match_codes = cur.fetchall()
        
        cur.execute(comp_code_query)
        comp_codes = cur.fetchall()

        for comp_code in comp_codes:
            print(comp_code[1])

            page_url = f"/event/{comp_code[1]}/awards"
            response = requests.get(base_url + page_url, headers=headers)
            response.raise_for_status()
            data = response.json()

            for award in data:
                for team in award["recipient_list"]:
                    try:
                        team_id = teams.get(int(team["team_key"][3:]), None)  
                        if team_id is None or team_id == 9999: 
                            continue

                        values = (int(award["award_type"]) + 1, comp_code[0], team_id)
                        cur.execute(insert_query, values)

                    except mysql.connector.errors.IntegrityError as e:  
                        print(f"Error: {e}\n code: {award['award_type']}")
                        continue
                    except TypeError as e:
                        print(f"Error: {e}")
                        continue
                    except ValueError as e:
                        print(f"Error: {e}")
                        continue

    except requests.exceptions.RequestException as e:
        print(f"Error: An error occurred while making the request: {e}")
    finally:
        cur.close()                    

                
        
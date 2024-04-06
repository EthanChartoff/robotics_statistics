from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors


def insertAlliances(conn):
    get_alliance_query = "SELECT * FROM robotics.Alliances WHERE id = %s"

    comp_code_query = "SELECT id, `code` FROM robotics.Competitions;"
    teams_query = "SELECT id, team_number FROM robotics.Teams;"
    
    insert_alliance_query = """
    INSERT INTO `robotics`.`Alliances`
    (`Competitions_id`)
    VALUES
    (%s);
    """

    insert_alliance_team_query = """
    INSERT INTO `robotics`.`Teams_in_Alliance`
    (`Alliances_id`,
    `Teams_id`)
    VALUES
    (%s,
    %s);
    """

    cur = conn.cursor()

    try:
        cur.execute(teams_query)
        teams = {int(team[1]): team[0] for team in cur.fetchall()}  
        
        cur.execute(comp_code_query)
        comp_codes = cur.fetchall()
        
        for comp_code in comp_codes:
            print(comp_code[1])

            page_url = f"/event/{comp_code[1]}/alliances"
            response = requests.get(base_url + page_url, headers=headers)
            response.raise_for_status()
            data = response.json()

            if data is None:
                continue

            for alliance in data:
                cur.execute(insert_alliance_query, (comp_code[0],))

                cur.execute(get_alliance_query, (cur.lastrowid,))
                inserted_alliance = cur.fetchone()
                print(inserted_alliance)

                for team in alliance["picks"]:
                    try:
                        team_id = teams.get(int(team[3:]), None)  
                        if team_id is None or team_id == 9999: 
                            continue
                        
                        teams_values = (inserted_alliance[0], team_id)
                        cur.execute(insert_alliance_team_query, teams_values)

                    except mysql.connector.errors.IntegrityError as e:  
                        print(f"Error: {e}\n code: {teams_values}")
                        continue
                    except KeyError as e:
                        print(f"Error: {e}\n code: {teams_values}")
                        continue
                    except ValueError as e:
                        print(f"Error: {e}\n code: {teams_values}")
                        continue

    except requests.exceptions.RequestException as e:
        print(f"Error: An error occurred while making the request: {e}")
    finally:
        cur.close()
    
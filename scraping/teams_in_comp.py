from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors


def insertTeamsInComp(conn):
    teams_query = "SELECT id, team_number FROM robotics.Teams;"
    code_query = "SELECT id, `code` FROM robotics.Competitions;"
    insert_query = """
    INSERT INTO `robotics`.`Teams_in_Competitions`
    (`Competitions_id`,
    `Teams_id`,
    `ranking`)
    VALUES
    (%s,
    %s,
    %s);
    """

    cur = conn.cursor()
    try:
        cur.execute(code_query)
        comp_codes = cur.fetchall()
        
        cur.execute(teams_query)
        teams = {int(team[1]): team[0] for team in cur.fetchall()} 

        for code in comp_codes:
            print(code[1])

            page_url = f"/event/{code[1]}/rankings"
            response = requests.get(base_url + page_url, headers=headers)
            response.raise_for_status()
            data = response.json()

            for ranking in data["rankings"]:
                try:
                    team_id = teams.get(int(ranking["team_key"][3:]), None)
                    if team_id is None or team_id == 9999:
                        continue

                    values = (code[0], team_id, ranking["rank"])
                    cur.execute(insert_query, values)
                except mysql.connector.errors.IntegrityError as e:  
                    print(f"Error: {e}\n code: {ranking}")
                    continue
                except KeyError as e:
                    print(f"Error: {e}\n code: {ranking}")
                    continue
                except ValueError as e:
                    print(f"Error: {e}\n code: {ranking}")
                    continue
                

    except requests.exceptions.RequestException as e:
        print(f"Error: An error occurred while making the request: {e}")
    finally:
        cur.close()
        conn.commit()
from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors


def insertMatchesHasTeams(conn):
    code_query = "SELECT id, `code` FROM robotics.Matches;"
    groups_query = "SELECT id, name FROM robotics.groups;"  # Use `name` instead of `*` for clarity
    teams_query = "SELECT id, team_number FROM robotics.Teams;"
    insert_query = """
    INSERT INTO `robotics`.`Matches_has_Teams`
        (`Matches_id`, `groups_id`, `Teams_id`, `did_win`, `score`)
        VALUES (%s, %s, %s, %s, %s);
    """

    cur = conn.cursor()
    try:
        cur.execute(code_query)
        match_codes = cur.fetchall()
        
        cur.execute(groups_query)
        groups = {group[1]: group[0] for group in cur.fetchall()}  # Create a mapping for efficient lookup

        cur.execute(teams_query)
        teams = {int(team[1]): team[0] for team in cur.fetchall()}  

        for code in match_codes:
            print(code[1])

            page_url = f"/match/{code[1]}/simple"
            response = requests.get(base_url + page_url, headers=headers)
            response.raise_for_status()
            data = response.json()

            group1_name, group2_name = list(data["alliances"].keys())
            group1_id = groups.get(group1_name, 1)  
            group2_id = groups.get(group2_name, 2)  
            group_won_id = groups.get(data["winning_alliance"], 1)  

            group1_score = int(data["alliances"][group1_name]["score"])
            group2_score = int(data["alliances"][group2_name]["score"])

            for team in data["alliances"][group1_name]["team_keys"]:
                team_id = teams.get(int(team[3:]), None)
                if team_id is None or team_id == 9999:
                    continue


                did_win = int(group_won_id == group1_id)
                try:
                    values = (code[0], group1_id, team_id, did_win, group1_score)
                    cur.execute(insert_query, values)
                except mysql.connector.errors.IntegrityError as e:  
                    print(f"Error: {e}\n code: {code}")
                    continue

            for team in data["alliances"][group2_name]["team_keys"]:
                team_id = teams.get(int(team[3:]), None)  
                if team_id is None or team_id == 9999:  
                     continue

                did_win = int(group_won_id == group2_id)
                try:
                    values = (code[0], group2_id, team_id, did_win, group2_score)
                    cur.execute(insert_query, values)
                except mysql.connector.errors.IntegrityError as e:  
                    print(f"Error: {e}\n code: {code}")
                    continue

    except requests.exceptions.RequestException as e:
        print(f"Error: An error occurred while making the request: {e}")
    finally:
        cur.close()
        conn.commit()

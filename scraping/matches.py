from TBA_conn import *
from datetime import datetime

import requests
import mysql.connector.errors


def insertMatches(conn):
    code_query = "SELECT `code` FROM robotics.Competitions;"
    groups_query = "SELECT * FROM robotics.groups;"
    query = """
    INSERT INTO `robotics`.`Matches`
    (`Competitions_id`,
    `Match_Type_id`,
    `code`,
    `group1_score`,
    `group2_score`,
    `group_won`,
    `match_number`,
    `start_datetime`,
    `end_datetime`,
    `group1_rp`,
    `group2_rp`)
    VALUES
    ((SELECT robotics.Competitions.id FROM robotics.Competitions WHERE robotics.Competitions.code = %s),
    (SELECT robotics.Match_Type.id FROM robotics.Match_Type WHERE robotics.Match_Type.type = %s),
    %s,
    %s,
    %s,
    %s,
    %s,
    %s,
    %s,
    %s,
    %s);
    """

    datetime_format = "%Y-%m-%d %H:%M:%S"

    try:
        cur = conn.cursor()
        cur.execute(code_query)
        codes = cur.fetchall()
        cur.execute(groups_query)
        groups = cur.fetchall()


        for code in codes:
            page_url = f"/event/{code[0]}/matches"
            response = requests.get(base_url + page_url, headers=headers)
            response.raise_for_status()
            data = response.json()

            for match in data:
                group_names = list(match["alliances"].keys())

                for group in groups:
                    if group_names[0] == group[1]:
                        group1 = group
                    if group_names[1] == group[1]:
                        group2 = group
                    if match["winning_alliance"] == group[1]:
                        group_won = group
                  
                # i do not care about integraty
                if group1 is None:
                    group1 = (1, "blue")
                if group2 is None:
                    group2 = (2, "red")
                if group_won is None:
                    group_won = (1, "blue")
                    
                try:
                    rp1 = match["score_breakdown"][str(group1[1])]["rp"]
                    rp2 = match["score_breakdown"][str(group2[1])]["rp"]
                except TypeError:
                    rp1 = None
                    rp2 = None
                except KeyError:
                    rp1 = None
                    rp2 = None


                if match["actual_time"] is not None:
                    timestamp = match["actual_time"]
                    datetime_obj = datetime.fromtimestamp(timestamp)
                    actual_time = datetime_obj.strftime("%Y-%m-%d %H:%M:%S")
                else:
                    actual_time = None

                if match["post_result_time"] is not None:
                    timestamp = match["post_result_time"]
                    datetime_obj = datetime.fromtimestamp(timestamp)
                    post_result_time = datetime_obj.strftime("%Y-%m-%d %H:%M:%S")
                else:
                    post_result_time = None

                try:
                    values = (
                        match["event_key"], 
                        match["comp_level"], 
                        match["key"],
                        match["alliances"][str(group1[1])]["score"],
                        match["alliances"][str(group2[1])]["score"],
                        group_won[0],
                        match["match_number"],
                        actual_time,
                        post_result_time,
                        rp1,
                        rp2
                    )
                    cur.execute(query, values)

                except mysql.connector.errors.DataError as e:
                    print(f"Error: {e}")
                    continue 

    except requests.exceptions.RequestException as e:
        print(f"Error: An error occurred while making the request: {e}")
    except mysql.connector.errors.IntegrityError as e:
        print(f"Error: {e} \nTable: {match}")
    except mysql.connector.errors.DataError as e:
        print(f"Error: {e}")
    
    finally:
        cur.close()



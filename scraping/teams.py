from TBA_conn import *
import requests
import mysql.connector.errors


def insertTeams(conn):
  sql = """
  INSERT INTO `robotics`.`Teams`
  (`Cities_id`,
  `address`,
  `name`,
  `nickname`,
  `rookie_year`,
  `team_number`,
  `website`)
  VALUES
  ((SELECT Cities.id FROM `robotics`.`Cities` WHERE Cities.name = %s LIMIT 1),
  %s,
  %s,
  %s,
  %s,
  %s,
  %s);
  """

  page_num = 0
  cur = conn.cursor()

  try:
    while page_num <= max_team / 500:    
      page_url = f"/teams/{page_num}"
      response = requests.get(base_url + page_url, headers=headers)
      response.raise_for_status()
      data = response.json()     

      for team in data:
        values = (team["city"], team["address"], team["name"], team["nickname"], team["rookie_year"], team["team_number"], team["website"])
        cur.execute(sql, values)

      page_num = page_num + 1
  
  except requests.exceptions.RequestException as e:
    print(f"Error: An error occurred while making the request: {e}")
  except mysql.connector.errors.IntegrityError as e:
    print(f"Error: {e} \nTable: {team}")

  finally:
    cur.close()
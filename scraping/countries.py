from DB_conn import *

import json


def insertCountries(conn):
    sql = """
        INSERT INTO `robotics`.`Countries`
        (`name`,
        `code`)
        VALUES
        (%s,
        %s);
    """

    with open("countries-states-cities-database/countries.json", 'r') as file:
        data = json.load(file)
    
    # insert
    cur = conn.cursor()
    for country in data:
        values = (country["name"], country["iso2"])
        cur.execute(sql, values)

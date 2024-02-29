import json
import mysql.connector

def insertDistrict(conn):
    sql = """
        INSERT INTO `robotics`.`Districts`
        (`Countries_id`,
        `numeric_code`,
        `code`,
        `name`)
        VALUES
        ((SELECT Countries.id FROM `robotics`.`Countries` WHERE Countries.code = %s),
        %s,
        %s,
        %s);
    """

    with open("countries-states-cities-database/states.json", 'r') as file:
        data = json.load(file)

    # insert
    cur = conn.cursor()
    for d in data:
        values = (d["country_code"], d["id"] ,d["state_code"], d["name"])
        cur.execute(sql, values)

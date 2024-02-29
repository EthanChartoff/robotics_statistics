import json
import mysql.connector


def insertCities(conn):
    sql = """
        INSERT INTO `robotics`.`Cities`
        (`Districts_id`,
        `numeric_code`,
        `name`)
        VALUES
        ((SELECT Districts.id FROM `robotics`.`Districts` WHERE Districts.numeric_code = %s),
        %s,
        %s);
    """

    with open("countries-states-cities-database/cities.json", 'r') as file:
        data = json.load(file)

    # insert
    cur = conn.cursor()

    try:
        for c in data:
            values = (c["state_id"], c["id"], c["name"])
            cur.execute(sql, values)
    except mysql.connector.errors.IntegrityError as e:
        print(f"Error: {e} \nTable: {c}")


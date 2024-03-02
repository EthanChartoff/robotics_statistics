from DB_conn import *
from countries import *
from districts import *
from cities import *
from teams import *
from competitions import *
from matches import *
from match_types import *
from groups import *

def main():
    conn = getConn()

    insertCountries(conn)
    insertDistrict(conn)
    insertCities(conn)
    insertTeams(conn)
    insertCompetitions(conn)
    dumbInsertMatchTypes(conn)
    dumbInsertGroups(conn)
    print("\nmatches\n")
    insertMatches(conn) 

    conn.commit()

    conn.close()

if __name__ == "__main__":
  main()

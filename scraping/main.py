from DB_conn import *
from countries import *
from districts import *
from cities import *
from teams import *
from competitions import *
from matches import *
from match_types import *
from groups import *
from matches_has_teams import *
from teams_in_comp import *
from awards import *
from awards_in_competition import *
from alliances import *
from pits import *
from pits_in_comp import *


def main():
    conn = getConn()

    # insertCountries(conn)
    # insertDistrict(conn)
    # insertCities(conn)
    # insertTeams(conn)
    # insertCompetitions(conn)
    # dumbInsertMatchTypes(conn)
    # dumbInsertGroups(conn)
    # insertMatches(conn) 
    # insertTeamsInComp(conn)
    # insertAwards(conn)
    # insertAwardsInCompetitions(conn)
    # conn.commit()
    # insertAlliances(conn)

    # insertPits(conn)
    # pitsInComp(conn)
    # conn.commit()

    # print("insertMatchesHasTeams")
    # insertMatchesHasTeams(conn)

    conn.commit()

    conn.close()

if __name__ == "__main__":
  main()

from DB_conn import *
from districts import *
from countries import *
from cities import *

def main():
    conn = getConn()
    insertCountries(conn)
    insertDistrict(conn)
    insertCities(conn)
    conn.commit()
    conn.close()

if __name__ == "__main__":
  main()

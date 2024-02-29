import requests

# Replace with the actual URL you want to fetch data from
url = "https://www.thebluealliance.com/api/v3/teams/0"
api_key = "oV4Iu80aeCFWxA78W5HcBA8kjBStuSRhtVOwQYhJXaXvBopfnRKFh1R02REGNoAS"

headers = {"X-TBA-Auth-Key": api_key}

try:
  # Send the GET request and store the response
  response = requests.get(url)

  # Check if request was successful (status code 200)
  if response.status_code == 200:
    # Parse the JSON data from the response
    data = response.json()
    
    # Print the data (or use it for further processing)
    print(data)
  else:
    print(f"Error: Request failed with status code {response.status_code}")
except requests.exceptions.RequestException as e:
  print(f"Error: An error occurred while making the request: {e}")
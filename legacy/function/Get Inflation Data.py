import requests

def get_trade_event():
	url = "https://economic-trading-forex-events-calendar.p.rapidapi.com/fxstreet"
	querystring = {"countries":"US"}

	headers = {
		"x-rapidapi-key": "a4e3133687msh7df0b05a67dbff8p12b0e6jsnd54285da6449",
		"x-rapidapi-host": "economic-trading-forex-events-calendar.p.rapidapi.com"
	}

	response = requests.get(url, headers=headers, params=querystring)

	return response.json()

get_trade_event()
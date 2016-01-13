require 'yelp'
require 'csv'
require 'uri'
require 'json'

#create and configure yelp client with API keys
Yelp.client.configure do |config| #enter yelp developer credentials here
  config.consumer_key = "" 
  config.consumer_secret = ""
  config.token = ""
  config.token_secret = ""
end

CSV.open("YelpHVAC.csv", "wb") do |csv| #creates and names the csv files
	csv <<["name","url","phone","rating","review_cont","address","city","state","postal_code"] #adds column headers
	        
	#make a request to the search API
	response = Yelp.client.search('Boston', { category_filter: 'hvac' }) #selects all hvac companies in Boston
	limit = 15 #enter a limit here -- the maximum is 2000 per day
	(0...limit).each do |i|
		busname = response.businesses[i].name
		busurl = response.businesses[i].url
		busphone = response.businesses[i].phone
		busrating = response.businesses[i].rating
		busreviewcount = response.businesses[i].review_count
		busaddress = response.businesses[i].location.address
		buscity = response.businesses[i].location.city
		busstate = response.businesses[i].location.state_code
		buspostal = response.businesses[i].location.postal_code
		csv << [busname, busurl, busphone, busrating, busreviewcount, busaddress, buscity, busstate, buspostal]
		sleep (0.5)
	end
end



  

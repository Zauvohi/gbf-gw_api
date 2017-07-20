# GBF GW API

This API exposes the top 80k ranking data from Granblue Fantasy's event Unite and Fight (also known as GW).

## Endpoints

Currently, there are 3 endpoints exposing the players' data and 2 for the _editions_ (each iteration of this event).

### Rankings Endpoints

* GET /rankings/list/:edition_id/:player_id

This will respond with an object containing basic information about the player and a nested object containing the ranking info for each day (from 0 to 5, with 0 being the prelims). In list, each key is the day. Here's an example:

```
  # GET /rankings/list/5/78
  {
  	"name": "Player1",
  	"id": 78,
  	"rank": 165,
  	"list": {
  		"0": {
  			"position": 12472,
  			"points": 13493792,
  			"total_battles": 233
  		},
  		"1": {
  			"position": 14856,
  			"points": 26873526,
  			"total_battles": 428
  		},
  		"2": {
  			"position": 20300,
  			"points": 33158149,
  			"total_battles": 450
  		},
  		"3": {
  			"position": 23982,
  			"points": 39409929,
  			"total_battles": 484
  		},
  		"4": {
  			"position": 26423,
  			"points": 51488725,
  			"total_battles": 522
  		},
  		"5": {
  			"position": 5347,
  			"points": 129371349,
  			"total_battles": 774
  		}
  	}
  }
```

* GET /rankings/global/:player_id

Similar to /list, global responds with all the last standings, which are the day 5, of a given player. This time around each key in list is the edition's number. Example:

```
  # GET /rankings/global/78
  {
    "name": "Player1",
    "id": 78,
    "rank": 165,
    "list": {
      "27": {
        "position": 1261,
        "points": 114800686,
        "total_battles": 611
      },
      "28": {
        "position": 1493,
        "points": 132300195,
        "total_battles": 730
      },
      "29": {
        "position": 18219,
        "points": 91141943,
        "total_battles": 652
      },
      "30": {
        "position": 9972,
        "points": 115700472,
        "total_battles": 551
      },
      "31": {
        "position": 5347,
        "points": 129371349,
        "total_battles": 774
      }
    }
  }
```

* GET /rankings/:edition_id/:player_id

This is the simplest endpoint and only brings the ranking data plus some basic player info of a single day, if no day is given via the query parameter 'day', then it'll respond with the data of day 5 if available. Example with day:

```
 # GET /rankings/5/78?day=4
  {
    "name": "Player1",
    "id": 78,
    "rank": 165,
    "position": 26423,
    "points": 51488725,
    "total_battles": 522
  }
```

**NOTES**
* I'm only saving the data from the prelims and from day 1 through 5, I keep no data from the interlude as I don't see the point of it.
* I can't keep track of all the players data so there might be instances where the name of a player is not updated or isn't displayed at all. Same deal with the ranks, I just take the last one from the most recent rankings where the player is.
* The "last standings" are taken from day 5 since it's the last day of the event and thus a player's lastest position in the rankings.
* Most of the data was taken from [here](https://drive.google.com/drive/folders/0B2NyM2kaI7pRX3pyNWxfSDVUYzQ). Most of the data from the 31st edition was taken by me and will do it from that edition onwards.
* The data is taken every day during the event at 1:40am JST to ensure it's accuracy.
* The data for each day *may* be available and ready at 4am JST of the next day (i.e. day 1's data will be available during day 2 at 4am).

### Editions Endpoints

* GET /editions

Retrieve a collection with all the editions available in the database. Example:

```
  # GET /editions
  [{
  	"id": 1,
  	"number": 27,
  	"element": "Earth",
  	"start_date": "2017-01-23 19:00:00 +0000",
  	"end_date": "2017-01-30 23:59:00 +0000"
  }, {
  	"id": 2,
  	"number": 28,
  	"element": "Wind",
  	"start_date": "2017-03-18 19:00:00 +0000",
  	"end_date": "2017-03-25 23:59:00 +0000"
  }, {
  	"id": 3,
  	"number": 29,
  	"element": "Fire",
  	"start_date": "2017-04-22 19:00:00 +0000",
  	"end_date": "2017-04-29 23:59:00 +0000"
  }, {
  	"id": 4,
  	"number": 30,
  	"element": "Light",
  	"start_date": "2017-05-17 19:00:00 +0000",
  	"end_date": "2017-05-24 23:59:00 +0000"
  }, {
  	"id": 5,
  	"number": 31,
  	"element": "Dark",
  	"start_date": "2017-06-22 19:00:00 +0000",
  	"end_date": "2017-06-29 23:59:59 +0000"
  }]

```

* GET /editions/:number

Retrieve the data of an edition by its number. Example:

```
 # GET /editions/31
  {
    "id": 5,
    "number": 31,
    "element": "Dark",
    "start_date": "2017-06-22 19:00:00 +0000",
    "end_date": "2017-06-29 23:59:59 +0000"
  }

```

This will be updated as soon as the dates for the next event are revealed.

### TODO

* Create an endpoint to search players by name.
* Improve performance.
* Maybe create a way to save collections of IDs for guilds.
* Create en endpoint for cutoffs.
* Create an endpoint for the bets points.

Right now, the API is public and hosted on Heroku (you can make your calls using [this URL](https://serene-spire-95459.herokuapp.com)), also this is a free tier dyno, please don't abuse it!

Also, if you have any issues/suggestions, open a new issue or PM me on discord (sied#6507), I'm available in the public servers of Radiance and GBF.int.

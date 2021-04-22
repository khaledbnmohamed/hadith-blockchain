# hlf1.4-hadith-chain
Hadith blockchain proof of concept in Hyperledger Fabric. Network with four companies and a specific chaincode exposed as rest API

# Installation instructions

1. Install Hyperledger fabric dependencies:
https://hyperledger-fabric.readthedocs.io/en/release-1.4/prereqs.html

2. Donwload fabric binaries and samples:
`curl -sSL http://bit.ly/2ysbOFE | bash -s 1.4.3`

3. Go to fabric samples:
`cd fabric-samples`

4. Install node-js dependencies
`./network.sh install`



# Start the network
1. Generate the crypto material and start the network
`./network.sh start`
This will create the crypto material for all the orgs, start the network and register it's admins and users. Then will start the API at localhost:3000


# Re-start the API server
`npm start`

# Stop the network
`./network.sh stop`


# API Doc
**AddHadith**
----
  Add new Hadith to the blockchain network

* **URL**

  `/api/AddHadith`

* **Method:**
  
	`POST` 

* **Data Params**

```
  "id":integer,
  "latitude":string,
  "longitude":string,
  "length":integer,
  "weight":integer
 ``` 

* **Success Response:**
  
``` 
{	
  "status":"OK - Transaction has been submitted",
  "txid":"7f485a8c3a3c7f982aed76e3b20a0ad0fb4cbf174fbeabc792969a30a3383499"
} 
```
 
* **Sample Call:**

 ``` 
 curl --request POST \
  --url http://localhost:3000/api/AddHadith \
  --header 'content-type: application/json' \
  --data '{
			"id":10001,
			"latitude":"43.3623",
			"longitude":"8.4115",
			"length":34,
			"weight":50
		   }' 
 ```
            
**getHadith**
----
  Get Hadith from the blockchain with the actual status

* **URL**

  `/api/getHadith/:id`

* **Method:**
  
	`GET` 

* **URL Params**
    `"id":integer`

* **Success Response:**
  
 ``` 
 {
    "result": {
        "id": integer
        "latitude": string
        "longitude": string
        "length": integer
        "weight": integer
    } 
 }
 ```
 
* **Sample Call:**

``` 
curl --request GET \
  --url 'http://localhost:3000/api/getHadith/<HadithId>' \
  --header 'content-type: application/json' \ 
```


**setPosition**
----
  Sets the position (latitude and longitud) for the specified id, could be sushiId or HadithId

* **URL**

  `/api/getHadith/setPosition`

* **Method:**
  
	`POST` 

* **Data Params**
``` 
"id":10001,
"latitude":"43.3623",
"longitude":"8.4115"
``` 

* **Success Response:**
  
 ``` 
{	
	status":"OK - Transaction has been submitted",
	"txid":"7f485a8c3a3c7f982aed76e3b20a0ad0fb4cbf174fbeabc792969a30a3383499"
}
 ```
 
* **Sample Call:**

``` 
curl --request POST \
  --url http://localhost:3000/api/setPosition \
  --header 'content-type: application/json' \
  --data '{
            "id":10001,
            "latitude":"43.3623",
            "longitude":"8.4115"
			}'
```

**addSushi**
----
   Add new Sushi to the blockchain network with the related HadithId

* **URL**

  `/api/getHadith/addSushi`

* **Method:**
  
	`POST` 

* **Data Params**
 ```   
"id":integer,
"latitude":string,
"longitude":string,
"type":string,
"hadithId":integer
 ``` 
* **Success Response:**
  
 ``` 
{	
	status":"OK - Transaction has been submitted",
	"txid":"7f485a8c3a3c7f982aed76e3b20a0ad0fb4cbf174fbeabc792969a30a3383499"
}
 ```
 
* **Sample Call:**

``` 
curl --request POST \
  --url http://localhost:3000/api/addSushi \
  --header 'content-type: application/json' \
  --data '{
			"id":200001,
            "latitude":"42.5987",
            "longitude":"5.5671",
            "type":"sashimi",
            "hadithId":10001
			}'
```

**getSushi**
----
  Get s from the blockchain with the actual status

* **URL**

  `/api/getSushi/:id`

* **Method:**
  
	`GET` 

* **URL Params**
    `"id":integer`

* **Success Response:**
  
 ``` 
  {
    "result": {
            "id":"200001",
            "latitude":"42.5987",
            "longitude":"5.5671",
            "type":"sashimi",
            "hadithId":10001
			}'
}
 ```
 
* **Sample Call:**
 
``` 
curl --request GET \
  --url 'http://localhost:3000/api/getSushi/<SushiId>' \
  --header 'content-type: application/json' \
```



**getSushiHistory**
----
  Get sushi history, from the HadithId that started the hadith-chain, getting all the history positions, until the sushi is delivered, with the sushi history too

* **URL**

  `/api/getHistorySushi/:id`

* **Method:**
  
	`GET` 

* **URL Params**
    `"id":integer`

* **Success Response:**
  
 ``` 
{
    "historySushi": [
        {
            "id": "200001",
            "latitude":"42.5987",
            "longitude":"5.5671",
            "type": "sashimi",
            "hadithId": 10004
        },
        {
            "id": "200001",
            "latitude":"43.3623",
            "longitude":"8.4115",
            "type": "sashimi",
            "hadithId": 10004
        }
    ],
    "historyHadith": [
        {
            "id": "10004",
            "latitude":"43.3623",
            "longitude":"8.4115",
            "length": 34,
            "weight": 50
        }
    ]
}
 ```
 
* **Sample Call:**
 
 ``` 
curl --request GET \
  --url 'http://localhost:3000/api/getHistorySushi/<SushiId>' \
  --header 'content-type: application/json' \
```

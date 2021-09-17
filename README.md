# hlf1.4-hadith-chain
Hadith blockchain proof of concept in Hyperledger Fabric. Network with four companies and a specific chaincode exposed as rest API

# Installation instructions

Install node-js dependencies
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
  "chain":string,
  "wording":string,
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
			"chain":"43.3623",
			"wording":"8.4115",
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
        "chain": string
        "wording": string
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
  Sets the position (chain and longitud) for the specified id, could be blockId or HadithId

* **URL**

  `/api/getHadith/setPosition`

* **Method:**
  
	`POST` 

* **Data Params**
``` 
"id":10001,
"chain":"43.3623",
"wording":"8.4115"
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
            "chain":"43.3623",
            "wording":"8.4115"
			}'
```

**addBlock**
----
   Add new Block to the blockchain network with the related HadithId

* **URL**

  `/api/getHadith/addBlock`

* **Method:**
  
	`POST` 

* **Data Params**
 ```   
"id":integer,
"chain":string,
"wording":string,
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
  --url http://localhost:3000/api/addBlock \
  --header 'content-type: application/json' \
  --data '{
			"id":200001,
            "chain":"42.5987",
            "wording":"5.5671",
            "type":"sashimi",
            "hadithId":10001
			}'
```

**getBlock**
----
  Get s from the blockchain with the actual status

* **URL**

  `/api/getBlock/:id`

* **Method:**
  
	`GET` 

* **URL Params**
    `"id":integer`

* **Success Response:**
  
 ``` 
  {
    "result": {
            "id":"200001",
            "chain":"42.5987",
            "wording":"5.5671",
            "type":"sashimi",
            "hadithId":10001
			}'
}
 ```
 
* **Sample Call:**
 
``` 
curl --request GET \
  --url 'http://localhost:3000/api/api/getAllAhadithTesting' \
  --header 'content-type: application/json' \
```



**getBlockHistory**
----
  Get block history, from the HadithId that started the hadith-chain, getting all the history positions, until the block is delivered, with the block history too

* **URL**

  `/api/getHistoryBlock/:id`

* **Method:**
  
	`GET` 

* **URL Params**
    `"id":integer`

* **Success Response:**
  
 ``` 
{
    "historyBlock": [
        {
            "id": "200001",
            "chain":"42.5987",
            "wording":"5.5671",
            "type": "sashimi",
            "hadithId": 10004
        },
        {
            "id": "200001",
            "chain":"43.3623",
            "wording":"8.4115",
            "type": "sashimi",
            "hadithId": 10004
        }
    ],
    "historyHadith": [
        {
            "id": "10004",
            "chain":"43.3623",
            "wording":"8.4115",
            "length": 34,
            "weight": 50
        }
    ]
}
 ```
 
* **Sample Call:**
 
 ``` 
curl --request GET \
  --url 'http://localhost:3000/api/getHistoryBlock/<BlockId>' \
  --header 'content-type: application/json' \
```


# Benchamarking

`ab -k -n 100 -c 1 -e Example1001.txt http://localhost:3000/api/getHadith/1 >ExampleResult1001.txt 2>&1`
`ab -k -n 100 -c 2 -e Example1002.txt http://localhost:3000/api/getHadith/1 >ExampleResult1002.txt 2>&1`
`ab -k -n 100 -c 3 -e Example1003.txt http://localhost:3000/api/getHadith/1 >ExampleResult1003.txt 2>&1`
`ab -k -n 100 -c 4 -e Example1004.txt http://localhost:3000/api/getHadith/1 >ExampleResult1004.txt 2>&1`
`ab -k -n 100 -c 5 -e Example1005.txt http://localhost:3000/api/getHadith/1 >ExampleResult1005.txt 2>&1`
`ab -k -n 100 -c 10 -e Example10010.txt http://localhost:3000/api/getHadith/1 >ExampleResult10010.txt 2>&1`


`ab -k -n 200 -c 10 -e Example20010.txt http://localhost:3000/api/getHadith/1 >ExampleResult20010.txt 2>&1`
`ab -k -n 300 -c 10 -e Example30010.txt http://localhost:3000/api/getHadith/1 >ExampleResult30010.txt 2>&1`
`ab -k -n 400 -c 10 -e Example40010.txt http://localhost:3000/api/getHadith/1 >ExampleResult40010.txt 2>&1`
`ab -k -n 500 -c 10 -e Example50010.txt http://localhost:3000/api/getHadith/1 >ExampleResult50010.txt 2>&1`
`ab -k -n 1000 -c 10 -e Example100010.txt http://localhost:3000/api/getHadith/1 >ExampleResult100010.txt 2>&1`

`ab -k -n 2000 -c 10 -e Example200010.txt http://localhost:3000/api/getHadith/1 >ExampleResult200010.txt 2>&1`
`ab -k -n 3000 -c 10 -e Example300010.txt http://localhost:3000/api/getHadith/1 >ExampleResult300010.txt 2>&1`
`ab -k -n 4000 -c 10 -e Example400010.txt http://localhost:3000/api/getHadith/1 >ExampleResult400010.txt 2>&1`
`ab -k -n 5000 -c 10 -e Example500010.txt http://localhost:3000/api/getHadith/1 >ExampleResult500010.txt 2>&1`

```
ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 1 -e Post1100.txt  -n 100 http://localhost:3000/api/AddHadith/ >Post1100Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 2 -e Post2100.txt  -n 100 http://localhost:3000/api/AddHadith/ >Post2100Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 3 -e Post3100.txt  -n 100 http://localhost:3000/api/AddHadith/ >Post3100Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 4 -e Post4100.txt  -n 100 http://localhost:3000/api/AddHadith/ >Post4100Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 5 -e Post5100.txt  -n 100 http://localhost:3000/api/AddHadith/ >Post5100Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 10 -e Post1010.txt  -n 10 http://localhost:3000/api/AddHadith/ >Post1010Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 10 -e Post10100.txt  -n 100 http://localhost:3000/api/AddHadith/ >Post10100Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 10 -e Post10200.txt  -n 200 http://localhost:3000/api/AddHadith/ >Post10200Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 10 -e Post10300.txt  -n 300 http://localhost:3000/api/AddHadith/ >Post10300Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 10 -e Post10400.txt  -n 400 http://localhost:3000/api/AddHadith/ >Post10400Result.txt 2>&1

ab -p /media/khaled/Khaled/hyperledger/fabric-samples/hlf1.4-hadith-chain/post.txt -T application/json -c 10 -e Post10500.txt  -n 500 http://localhost:3000/api/AddHadith/ >Post10500Result.txt 2>&1

```

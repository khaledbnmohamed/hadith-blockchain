var express = require('express');
var bodyParser = require('body-parser');
var app = express();
const fabricNetwork = require('./fabricNetwork')
const fs = require('fs');
const axios = require('axios');



app.set('view engine', 'ejs');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));

app.use(express.json());

// TODOs:
// 1) Frontend -> ReactJS (getHadith, AddHadith) (till next friday, only conusming 2 endpoints)
// 2) Finish 2 endpoints
// 3) Maybe add couchDB
// 4) Organization and channel Configuration
// 5) Force admin policies ( only admins can consume endpoints)
// 6) Tokens for authorizations
// 7) Have a login page with crendetials for admins and cycle goes on from there
// 8)

app.post('/api/AddHadith', async function (req, res) {

  try {
    // const contract = await fabricNetwork.connectNetwork('connection-omelkorrauniversity.json', 'wallet/wallet-omelkorrauniversity');

    const contract = await fabricNetwork.connectNetwork('connection-islamicuniveristy.json', 'wallet/wallet-islamicuniveristy');
    let hadith = {
      id: req.body.id,
      hadith: req.body.hadith,
      isnad: req.body.isnad,
      matn: req.body.matn,
      ekhrag: req.body.ekhrag
    }
    // call hadith nlp enpoint
    // based on result ,submit transaction ( status الصحة) or discard
    // based on private network, prefedined organization,
    // credetinals admin, if yo yuhave cerd amdin, you can submit

    let tx = await contract.submitTransaction('addAsset', JSON.stringify(hadith));
    res.json({
      status: 'OK - Transaction has been submitted',
      txid: tx.toString()
    });
  } catch (error) {
    console.error(`Failed to evaluate transaction: ${error}`);
    res.status(500).json({
      error: error
    });
  }

});

app.get('/api/getHadith/:id', async function (req, res) {
  try {
    // const contract = await fabricNetwork.connectNetwork('connection-islamicuniveristy.json', 'wallet/wallet-islamicuniveristy');

    const contract = await fabricNetwork.connectNetwork('connection-omelkorrauniversity.json', 'wallet/wallet-omelkorrauniversity');
    const result = await contract.evaluateTransaction('queryAsset', req.params.id.toString());
    let response = JSON.parse(result.toString());
    res.json({result:response});
  } catch (error) {
    console.error(`Failed to evaluate transaction: ${error}`);
    res.status(500).json({
      error: error
    });
  }
})

app.get('/api/getAllAhadithTesting', async function (req, res) {
    try {
      // const contract = await fabricNetwork.connectNetwork('connection-islamicuniveristy.json', 'wallet/wallet-islamicuniveristy');
      const contract = await fabricNetwork.connectNetwork('connection-omelkorrauniversity.json', 'wallet/wallet-omelkorrauniversity');

      let response_array = [];
      for(let id = 1; id <= 5; id++) {
        const result = await contract.evaluateTransaction('queryAsset', id.toString());
        let json_result = JSON.parse(result.toString());
        response_array.push(json_result)
      }

      res.json({result:response_array});
    } catch (error) {
      console.error(`Failed to evaluate transaction: ${error}`);
      res.status(500).json({
        error: error
      });
    }
  })


app.post('/api/setPosition', async function (req, res) {

  try {
    const contract = await fabricNetwork.connectNetwork('connection-islamicuniveristy.json', 'wallet/wallet-islamicuniveristy');
    let tx = await contract.submitTransaction('setPosition', req.body.id.toString(), req.body.chain.toString(), req.body.wording.toString());
    res.json({
      status: 'OK - Transaction has been submitted',
      txid: tx.toString()
    });
  } catch (error) {
    console.error(`Failed to evaluate transaction: ${error}`);
    res.status(500).json({
      error: error
    });
  }

});


app.get('/api/getHistoryBlock/:id', async function (req, res) {
  try {
    const contract = await fabricNetwork.connectNetwork('connection-producer.json', 'wallet/wallet-producer');
    const historyBlock = JSON.parse((await contract.evaluateTransaction('getHistory', req.params.id.toString())).toString());
    const actualBlock = JSON.parse((await contract.evaluateTransaction('queryBlock', req.params.id.toString())).toString());
    historyBlock.unshift(actualBlock);
    const historyHadith = JSON.parse((await contract.evaluateTransaction('getHistory', actualBlock.hadithId.toString())).toString());
    const actualHadith = JSON.parse((await contract.evaluateTransaction('queryHadith', actualBlock.hadithId.toString())).toString());
    historyHadith.unshift(actualHadith);
    res.json({
      historyBlock: historyBlock,
      historyHadith: historyHadith
    });
  } catch (error) {
    console.error(`Failed to evaluate transaction: ${error}`);
    res.status(500).json({
      error: error
    });
  }
})

app.get('/api/getBlock/:id', async function (req, res) {
  try {
    const contract = await fabricNetwork.connectNetwork('connection-omelkorrauniversity.json', 'wallet/wallet-omelkorrauniversity');
    const result = await contract.evaluateTransaction('queryAsset', req.params.id.toString());
    let response = JSON.parse(result.toString());
    res.json(response);
  } catch (error) {
    console.error(`Failed to evaluate transaction: ${error}`);
    res.status(500).json({
      error: error
    });
  }
})


app.post('/api/addBlock', async function (req, res) {
  try {
    const contract = await fabricNetwork.connectNetwork('connection-alazhar-university.json', 'wallet/wallet-alazhar-university');
    let block = {
      id: req.body.id,
      chain: req.body.chain,
      wording: req.body.wording,
      type: req.body.type,
      hadithId: req.body.hadithId
    }
    let tx = await contract.submitTransaction('addAsset', JSON.stringify(block));
    res.json({
      status: 'OK - Transaction has been submitted',
      txid: tx.toString()
    });
  } catch (error) {
    console.error(`Failed to evaluate transaction: ${error}`);
    res.status(500).json({
      error: error
    });
  }

})


function add_hadith_data() {
    let raw_ahadith = fs.readFileSync(process.cwd() + "/src/" +'ahadith.json');
    let json_ahadith = JSON.parse(raw_ahadith);
    for(var index in json_ahadith["data"]){
      axios({
        method: 'post',
        url: 'http://localhost:3000/api/AddHadith',
        data: json_ahadith["data"][index],
        headers: {'Content-Type': 'application/json'}
      });
    }
  }


app.listen(3000, ()=>{
  add_hadith_data()
  console.log("***********************************");
  console.log("API server listening at localhost:3000");
  console.log("***********************************");
});

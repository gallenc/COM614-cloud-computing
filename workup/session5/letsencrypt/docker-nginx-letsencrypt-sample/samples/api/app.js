//var express = require('express');
//var cors = require('cors');
//
//var app = express();
//app.use(cors());
//
//app.get('/api/hello', function (req, res) {
//  res.send('Hello World!');
//});
//
//app.listen(3001, function () {
//  console.log('Listening on port 3000.');
//});


var express = require('express');
var app = express();
app.use(cors());

var router = express.Router();

// simple logger for this router's requests
// all requests to this router will first hit this middleware
router.use(function(req, res, next) {
  console.log('%s %s %s', req.method, req.url, req.path);
  next();
});

// this will only be invoked if the path ends in /bar
router.use('/api', function(req, res, next) {
  res.send('Hello World!');
  next();
});

// always invoked
//router.use(function(req, res, next) {
//  res.send('Hello World');
//});

app.use('/', router);

app.listen(3001, function () {
   console.log('Listening on port 3000.');
});
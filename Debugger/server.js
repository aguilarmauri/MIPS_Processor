const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 9090
const fs = require('fs');
var gm = require('gm');
var dir = './';

// --------------------------------- Parseo ------------------------------------
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
var multer = require('multer'); // v1.0.5
// Configuración del tamaño del buffer de metodos post
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.raw({limit: '50mb', extended: true}));
app.use(bodyParser.text({limit: '50mb', extended: true}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true}));
// app.use(bodyParser.read({limit: '50mb', extended: true}));
var upload = multer(); // for parsing multipart/form-data
// -----------------------------------------------------------------------------

app.use(express.static('./'));

app.listen(port, () => {
 port += 80;
 console.log('API REST corriendo en http://localhost:'+port)
})

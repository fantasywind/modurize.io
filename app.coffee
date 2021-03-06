express = require('express')
SessionSockets = require('session.socket.io')
http = require('http')
path = require('path')
staticFile = require('./routes/static')
main = require('./routes/main')

app = express()
cookieParser = express.cookieParser 'screct'
sessionStore = new express.session.MemoryStore()

app.configure ->
  app.set 'port', process.env.PORT or 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use cookieParser
  app.use express.session()
  app.use app.router
  app.use require('stylus').middleware(__dirname + '/public')
  app.use express.static(path.join(__dirname, 'public'))

app.configure 'development', ->
  app.use express.errorHandler()

app.get '/', main.index
app.get '/init/js', staticFile.js
app.get '/init/css', staticFile.css

server = http.createServer(app)
server.listen app.get('port'), ->
  console.log("Modurize.IO server listening on port " + app.get('port'))

io = require('socket.io').listen server
sessionSockets = new SessionSockets io, sessionStore, cookieParser

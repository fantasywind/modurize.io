config =
  third_party: require(__dirname + '/../config/third_party.json')
fs = require 'fs'
jsfile = ''

# Load Dependencies
jsfile += fs.readFileSync(__dirname + '/../' + config.third_party.path + file, {encoding: 'utf-8'}) for file in config.third_party.js
jsfile += fs.readFileSync(__dirname + '/../lib/modurize.io.js', {encoding: 'utf-8'})

exports.js = (req, res)->
  # Add Socket.IO Connection
  res.end(jsfile + 'io.connect("//' + req.headers.host + '");')
exports.css = (req, res)->
  res.end('')

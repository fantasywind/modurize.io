config =
  third_party: require(__dirname + '/../config/third_party.json')
fs = require 'fs'
jsfile = ''
jsfile += fs.readFileSync(__dirname + '/../' + config.third_party.path + file, {encoding: 'utf-8'}) for file in config.third_party.js

exports.js = (req, res)->
  res.end(jsfile)
exports.css = (req, res)->
  res.end('')

# MtGox Bitcoin Menubar App

## Description

This program shows the current average MtGox exchange rate on your menu bar at the top of your screen. It updates every 90 seconds.

## Screenshot

![screenshot](http://i.imgur.com/JVNL7.png)

## Notes

This app does require internet access, but it only accesses one URL: https://mtgox.com/api/0/data/ticker.php

If you use Little Snitch, you may see this, but you can just click "Forever" and "Allow":

![little snitch preview](http://i.imgur.com/DIAhN.png)

## Other Software

This app uses Stig Brautaset's [SBJSON library](https://github.com/stig/json-framework/) for parsing the JSON in MtGox's response. It's BSD licensed; check his project for full details.

## License

BSD

# Coupons - For VORPCore (A REDM framework)
Create coupons for items, money or weapons so players can redeem them, or tie it to tebex for automation

## Setup
1. SQL file should be run. This will create a CODES table in the DB.
2. Put the Script in your resources, and start it in cfg file. 

# Commands ingame 
- `/createcode [type] [amount]` - Creates a Code for money or items (Only for ADMIN group) - Where [type] can be `money` or `item-name`
- `/createcodew [weapon_hash] [amount]` - Creates a Code for weapons (Only for ADMIN group)
- `/redeem [code]` - Redeem a Given Code for money or items
- `/redeemw [code]` - Redeem a Given Code for weapons

# Examples ingame
`/createcode money 50000` // returns code with Rewards as 50K

`/createcode electronic_kit 15` // returns code with Rewards 15 Electronic Kits

`/createcodew WEAPON_MELEE_KNIFE_JAWBONE 1` // returns code with weapon

`/redeem un$i9KuZmV` // redeems code

Original code from OSM: https://github.com/OsmiumOP/OSM-QBUS-Scripts/tree/main/osm-coupons

Eve Ranch Fleet Tracker
----------------------

This is a lightweight application that augments Eve Online's fleet
handlng by automatically tracking the locations of members in the fleet
and displaying their whereabouts, as well as summary information and
recon reports.

Getting Started
---------------

Requires sqlite3, haml, jquery-rails, hashtrain-acts_as_random_id, and rails3-jquery-autocomplete.

Usage
-----

1) Use your in-game browser and set the site to trusted so it can grab your user info and location. Reload after setting it trusted.

2) Create a fleet, setting up permissions as you like. 

3) Tell your fleet-mates to hit the same site and join your fleet.

4) Everyone must leave the web site open, although it can be minimized.

You can use the hosted version at www.everanch.com/tracker.

Additional Notes
----------------

You can make the fleet open to corp or alliance members, completely private or completely open. If you name an FC and XO, they'll be able to admin the fleet as well. Just type their character names exactly as used in-game.

If you've set the fleet to be private, or you want to invite pilots not in your alliance, you can copy the direct randomized fleet URL (either from the URL bar or the link at the top-right). Paste it to fleet chat and have them go there directly.

You can use that same direct URL to view the fleet info in your out-of-game browser. No tracking will be reported there, but you'll be able to see the automatic updates.

If your fleet mates don't want the updates, they can go back to the main fleet page, or any page on the site, and it'll still keep the server updated with their locations, but take less CPU. They can minimize the window, but it needs to still be active in order for the web browser to keep feeding location information to the server. If they close it, they'll be kicked out of the Fleet Tracker system after several minutes. Unfortunately there's no Eve Online fleet API, so you have to duplicate some effort.

If all pilots in a fleet drop out (manually or through timeout), the fleet will be deleted as well.

The fleet creator, FC, or XO can tag pilots with phrases such as "Scout", "Bait Squad", etc. Then they'll be highlighted in the fleet summary so the FC can quickly see where key pilots are. I'm intending that squad leaders might be tagged, but not all squad members otherwise it's information overload. But this is a key area of usability I'd like feedback on.

Scouts and other pilots can also do a quick recon report by clicking the number of reds and neutrals in the system they're currently in. It'll get added to a recon summary. I don't expect this will replace verbal recon reports for important information, but could be used to mark a bunch of systems as clear, or not worth pursuing without breaking battlecoms.

That's it! Hope you enjoy.

Todo
----

Obviously, the location information could be more useful if it were
displayed graphically, say, overlayed onto a Dotlan map of the region
you're currently flying in.

Recon reports can currently be submitted even if you're not in the fleet.

Fleets should have option to force people to join before viewing the fleet. (But this is tricky with out-of-game viewing.)

Change Log
----------
Users and Fleets now disappear on their own if they're inactive. When the last user drops the fleet, it's destroyed.
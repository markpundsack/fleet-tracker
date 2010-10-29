Eve Ranch Fleet Tracker
----------------------

This is a lightweight application that augments Eve Online's fleet
handlng by automatically tracking the locations of members in the fleet
and displaying their whereabouts, as well as summary information and
recon reports.

Getting Started
---------------

Requires sqlite3, haml, and jquery-rails, but that should be it.

Using
-----

Unfortunately there's no Eve Online fleet API, so you have to duplicate
some effort.

1. The FC or XO should go to Fleet Tracker, from within Eve Online,
using the in-game-browser (IGB) and create a new fleet.

2. Each fleet pilot then joins that fleet. If all your fleet-mates are
within the same corp or alliance, or if you've set it up as an open
fleet, they'll be able to see the fleet automatically. For private
fleets, copy the fleet's direct URL and give it to the other pilots (via
fleet chat, for example).

3. Everyone needs to leave the IGB browser open with one of the fleet
pages. The window can be minimized, but it's very important that the
browser is still active since the pages are set to automatically report
each pilots location.

4. The FC/XO (or any other pilot for that matter) can copy the fleet URL
to an out-of-game browser for better viewing.

5. Pilots can also give quick recon reports via the fleet interface.
These recon reports will automatically show up for everyone viewing the
fleet screen.

That's it! Hope you enjoy.

Todo
----

Obviously, the location information could be more useful if it were
displayed graphically, so overlayed onto a Dotlan map of the region
you're currently flying in.

Recon reports can currently be submitted even if you're not in the fleet.

Fleets should have option to force people to join before viewing the fleet. (But this is tricky with out-of-game viewing.)

Fleets should automatically disappear after some time, or after the last person leaves the fleet. Maybe if pilot purging were automatic too, then this would work well. Could do a purge once an hour...

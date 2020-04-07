# Skyrim-Scaled-Uncapped
xEdit Script - Skyrim Scaled Uncapped
FO4Edit - Also works for Fallout 4 (without races changes)

Note: Still need high end game testing to define which values would be the best for the mult math. 0.8 might sound easy at the beggining and/or 1.0 might get insane high end. Need moar testing.

This is an xEdit script that grabs every NPC old level and turns it into a multiplier value. This means every NPC will scale to/around of 0.80 and up to 1.5 times (or more) of what PC level is. It sets a whole new difficulty curve and an extremely balanced and challenging play through. Also encounter zones are uncapped.

What does it do?

1) By itself it looks for Encounter zones and sets min to 1, max to 0, and removes Never Reset flags if any.

2) Then it looks for NPCs and checks, if NPC has a level mult flag, its skipped. If NPC has a Level, then it does this math:
﻿800 + (Old Level * 10) = X
﻿X gets divided by 1000 (this is how the level mult flag works in xEdit, 1000 = 1.0)
﻿So the result will be a fraction.
﻿E.g. 800 + (32 * 10) = 1120 / 1000 = 1.12
﻿﻿This means that if the player is level 1 and he encounters this NPC (supposed to be lvl32), the NPC will scale 1.12 times PC level. So it'll be level 1.
﻿﻿Sorry did that sound crappy? How about if you were level 80 and you encounter said npc? Then it would spawn as lvl 89. Cool now?

3) Optionaly: it'll also look for all Races Starting HP and do: (Starting HP / 2) + Starting HP.
(2 options are provided, 1 with no races changes in case you want to use something like NPC Stat Rescaler﻿ which i HIGHLY recommend)
﻿This change is necessary because when you set an NPC's level mult flag the game will not use some fixed values. (This is how the game leveling mechanic works, it selectively chooses determined stats for Leveled NPCs or it calculates everything from other stats. Kind of.)


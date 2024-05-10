pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- moonbreak
-- made by kevin

-- utilities
#include scripts/utilities/globals.lua
#include scripts/utilities/debug.lua
#include scripts/utilities/class.lua
#include scripts/utilities/async.lua
#include scripts/utilities/gameobject.lua
#include scripts/utilities/helpers.lua

-- scenes
#include scripts/scenes/scene.lua
#include scripts/scenes/splash.lua
#include scripts/scenes/title.lua
#include scripts/scenes/game.lua

-- entities
#include scripts/entities/entity.lua
#include scripts/entities/player.lua
#include scripts/entities/bot.lua
#include scripts/entities/objective.lua
#include scripts/entities/energy.lua
#include scripts/entities/terminal.lua
#include scripts/entities/particle.lua
#include scripts/entities/rover.lua
#include scripts/entities/pod.lua
#include scripts/entities/cursor.lua

-- main
#include scripts/main.lua
__gfx__
00000000000000005557777088800330033333005506600000000000000000000011110000000000001111000000000000000000000000000000000000000000
00000000000000000006000028200b5033b9b9300070000006666600000000000111111000666600011111100000000000000000000000000000000000000000
0070700000000000007770000200000036333b30076700006b111160000000001111111106000060111111110000000000000000000000000000000000000000
0007000000000000077677000000000033bb3b300070000061111160000000001199991160000006119999110000000000000000000000000000000000000000
00707000000000000766670006660000363355300000000061111160000000001999999160000006199999910000000000000000000000000000000000000000
00000000000000000776770061170000333b55b00000000061111160050000051999999969999996999999910000000000000000000000000000000000000000
00000000000000000077700061110000033bbb000000000066555660050505050999999994444449999999900000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066666660050005050999999999444499999999900000000000000000000000000000000000000000
000000000000000000000000088888800bbbbbb00000000077666677000000000911119999666699991111900000000000000000000000000000000000000000
00777700007777000000000088887888bbb77bbb0000000076511567000000000111111999555599911111100000000000000000000000000000000000000000
007fff00007fff000077770088877888bb7bb7bb000000006511115600000000111111119e6666e9111111110000000000000000000000000000000000000000
007fff00007fff00007fff0088887888bbbb7bbb00000000651111560000000011116111ee5555ee111611110000000000000000000000000000000000000000
0099790000997900007fff0088887888bb7bb7bb00000000651111560000000011161111eeeeeeee111161110000000000000000000000000000000000000000
00f57500005f75000f5575f088877788bbb77bbb00000000651111560000000011111111e000000e111111110000000000000000000000000000000000000000
009909000099010000190900288888823bbbbbb30000000065111156000000000111111e00000000e11111100000000000000000000000000000000000000000
00100100001000000000010002222220033333300000000000666600000000000011110000000000001111000000000000000000000000000000000000000000
000000000000000000000000099999900cccccc00000000000555500000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000099977999ccc7c7cc0000000000666600000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000099799799ccc7c7cc0000000000555500000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000099997999ccc777cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000099979999ccccc7cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000099777799ccccc7cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000a999999a1cccccc10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000aaaaaa0011111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000766666676666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000577777756666666600665000666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00066600555555556666666600666500666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00600050555555556666666606656650666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00600050e55555556666666606566650666666660005000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00055500e555555e6666666666666665666666660066500000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000e555555e66666666066666e0555555550666ee0000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000eeeeee0666666660eeeee0000000000006e000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
57666666666666750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
57666666666666750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666670777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666677666666700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
00000000000000000000002424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
00000000000000000000002424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
00000000000000000000002424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
00000000000000000000002424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
00000000000000000000002424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
00000000000000000000002424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424000000
__gff__
0000000000000000808080000000000000000000000000000101010000000000000000000000000000000000000000000000000000000000000000000000000000010101000000000000000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4242424242510000504242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4251414141414343414141414141415042424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5141000000000000000000000000004141504242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5100400000000000000000000000000000504242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4100010000000000000013000000000000415042424242424251414141424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
43070708090a0000000000000000000000004141414141414141000000415042424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
43070718191a0000000000000040000000002400000000000000000000005042424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5100000000000000400000000000000000002452525252525200000000005042424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5100400000000000000000000000000000525042424242425100000000005042424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5100000000000000000000525200000000504242424242514100000000004150424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5152000000000000000000505100000000415042424242510000000000005250424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4251000000000000000000414100000000005042424242515252000000525042424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4251000000400000000000400000000000005042424242424242525252504242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4251520000000000000000000000000000405042424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242510000000000000000000014000000525042424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242510000000000000000000000000052504242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4251410000000023000000005252525250424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4251525252000000000000525042424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424251525252525252504242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
__sfx__
000100001a650186501a6001760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00020000220502b0502705024050240001f0002a00029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000800000705001000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00080000050500a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000605000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000905000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000f05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000000200182001d20024200272002b2002b20029200272001f2001d2001b2001820000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010300001f1311f13518100181051010010100101011b1511b1311b13504100181001010010100301003810027130271322713127132221222212122120221202212122121221112211500100001000010000100

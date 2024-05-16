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
#include scripts/utilities/autotile.lua

-- scenes
#include scripts/scenes/scene.lua
#include scripts/scenes/splash.lua
#include scripts/scenes/title.lua
#include scripts/scenes/game.lua

-- entities
#include scripts/entities/entity.lua
#include scripts/entities/player.lua
#include scripts/entities/bot.lua
#include scripts/entities/supply.lua
#include scripts/entities/terminal.lua
#include scripts/entities/particle.lua
#include scripts/entities/rover.lua
#include scripts/entities/pod.lua
#include scripts/entities/cursor.lua
#include scripts/entities/obstacle.lua
#include scripts/entities/enemy.lua
#include scripts/entities/collector.lua
#include scripts/entities/spawner.lua

-- main
#include scripts/main.lua
__gfx__
0000000000000000555777708880033000000000550660000000000000000000001111000000000000000000000655e500000000000000000999990000000000
00000000000000000006000028200b500000000000700000066666000000000001111110006666000000000000655e5200007666566700009000009000665000
0070700000000000007770000200000000000000076700006b1111600000000011111111060000600000000000555e5500077766656670009007009000666500
0007000000000000077677000000000000000000007000006111116000000000119999116000000600000000066555e500777777777777009000009006656650
0070700000000000076667000666000000000000000000006111116000000000199999916000000600000000666ee06607777777777777700999990006566650
000000000000000007767700611700000000000000000000611111600500000519999999699999960000000006e0005507777777777777700000000066666665
000000000000000000777000611100000000000000000000665556600505050509999999944444490000000000000066077777777777777000000000066666e0
0000000000000000000000000000000000000000000000006666666005000505099999999944449900000000000000550777776666677770000000000eeeee00
000000000000000000000000066666000666660000000000776666770000000009111199996666990000000000000000077776b1111677706611567000000000
00777700007777000000000066777660667776600000000076511567000000000111111999555599000000000000000007777611111677707661156700000000
007fff00007fff00007777006767776067677760000000006511115600000000111111119e6666e9000000000000000007777611111677706111157000000000
007fff00007fff00007fff00677677606776776000000000651111560000000011116111ee5555ee000000000000000000777611111677007611115700000000
0099790000997900007fff00677767606777676000000000651111560000000011161111eeeeeeee000000000000000011577665556675000000000000000000
00f57500005f75000f5575f0667776606677766000000000651111560000000011111111e000000e000000000000000006657766666756600000000000000000
00990900009901000019090006666600066666000000000065111156000000000111111e000000000000000000000000666ee000000ee6660000000000000000
00100100001000000000010000000000000000000000000000666600000000000011110000000000000000000000000006e0000000000e600000000000000000
0000000000000000000000000eeeee00055555000000000000555500000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000ee999ee0551115500000000000666600000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000e9e999e0515111500000000000555500000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000e99e99e0511511500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000e999e9e0511151500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000ee999ee0551115500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000eeeee00055555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777770077777700777777007777770
00000000000000000000000000665000000000000000000000000000000000000000000000000000000000000000000076666667766666677666666776666667
00000000000000000000000000666500000000000000000000000000000000000000000000000000000000000000000076666666666666666666666776666667
00000000000000000000000006656650000000000000000000000000000000000000000000000000000000000000000057666666666666666666667557666675
00000000000000000000000006566650000000000005000000000000000000000000000000000000000000000000000057666666666666666666667557666675
00000000000000000000000066666665000000000066500000000000000000000000000000000000000000000000000076666666666666666666666776666667
000000000000000000000000066666e0000000000666ee0000000000000000000000000000000000000000000000000076666666666666666666666776666667
0000000000000000000000000eeeee0000000000006e000000000000000000000000000000000000000000000000000076666666666666666666666776666667
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000076666666666666666666666776666667
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000076666666666666666666666776666667
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000076666666666666666666666776666667
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000057666666666666666666667557666675
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000057666666666666666666667557666675
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000076666666666666666666666776666667
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000076666666666666666666666776666667
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000076666666666666666666666776666667
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000766666670000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000577777750000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555550000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555550000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e55555550000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e555555e0000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e555555e0000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeee00000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d524242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
24242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424
__gff__
0000000000000000808000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010101000000000000000000000000010101010000000000000000000000000001000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d000000000000000000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d004000000000000000000000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d000000000000000000000000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4307070000000000000000000000000000005d5d5d5d5d5d5d5d0000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4307070000000000000000000040000000004300000000000000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d00000000000000400000000000000000004300000000000000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d004000000000000000000000000000005d5d5d5d5d5d5d5d00000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d000000000000000000000000000000005d5d5d5d5d5d5d5d00000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d0000130000000013000000000000005d5d5d5d5d5d5d0000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d000000000000000000000000000000005d5d5d5d5d5d5d5d0000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d000000400000000000000000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d0000000000000000000000000000405d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d00000000000000000000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d000000000000000000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d0000000000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d0000000000005d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d5d4242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
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

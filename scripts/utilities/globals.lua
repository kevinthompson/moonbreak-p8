-- store global environment
g = _ENV

-- enable custom font
poke(0x5600,unpack(split"6,6,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31,31,31,31,0,0,0,31,31,31,0,0,0,0,0,31,27,31,0,0,0,0,0,27,4,27,0,0,0,0,0,27,0,27,0,0,0,0,0,27,27,27,0,0,0,0,8,12,14,12,8,0,0,0,2,6,14,6,2,0,0,15,1,1,1,1,0,0,0,0,0,16,16,16,16,30,0,17,10,4,31,4,31,4,0,0,0,0,14,0,0,0,0,0,0,0,0,0,6,12,0,0,0,0,0,0,12,12,0,0,0,10,10,0,0,0,0,0,4,10,4,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,0,4,0,10,10,0,0,0,0,0,0,0,10,31,10,10,31,10,0,8,62,11,62,104,62,8,0,0,51,24,12,6,51,0,0,6,9,9,30,9,9,22,0,8,4,0,0,0,0,0,0,8,4,4,4,4,4,8,0,2,4,4,4,4,4,2,0,0,4,21,14,21,4,0,0,0,4,4,31,4,4,0,0,0,0,0,0,0,4,4,2,0,0,0,31,0,0,0,0,0,0,0,0,0,4,4,0,16,16,8,4,2,1,1,0,14,17,25,21,19,17,14,0,4,6,4,4,4,4,31,0,14,17,16,8,4,2,31,0,14,17,16,12,16,17,14,0,18,18,17,31,16,16,16,0,31,1,1,15,16,16,15,0,14,1,1,15,17,17,14,0,31,16,16,8,4,4,4,0,14,17,17,14,17,17,14,0,14,17,17,30,16,16,14,0,0,4,4,0,0,4,4,0,0,4,4,0,0,4,4,2,0,24,6,1,6,24,0,0,0,0,31,0,31,0,0,0,0,3,12,16,12,3,0,0,14,17,16,8,4,0,4,0,14,25,21,21,25,1,14,0,0,0,30,17,17,17,30,0,1,1,15,17,17,17,15,0,0,0,14,17,1,17,14,0,16,16,30,17,17,17,30,0,0,0,14,17,31,1,14,0,12,18,2,15,2,2,2,0,0,0,30,17,17,30,16,14,1,1,15,17,17,17,17,0,4,0,6,4,4,4,31,0,16,0,24,16,16,16,17,14,1,1,17,9,7,9,17,0,3,2,2,2,2,2,28,0,0,0,15,21,21,21,21,0,0,0,15,17,17,17,17,0,0,0,14,17,17,17,14,0,0,0,15,17,17,15,1,1,0,0,30,17,17,30,16,16,0,0,13,19,1,1,1,0,0,0,30,1,14,16,15,0,2,2,15,2,2,2,28,0,0,0,17,17,17,17,30,0,0,0,17,17,17,10,4,0,0,0,17,17,21,21,10,0,0,0,17,10,4,10,17,0,0,0,17,17,17,30,16,14,0,0,31,8,4,2,31,0,12,4,4,4,4,4,12,0,1,1,2,4,8,16,16,0,12,8,8,8,8,8,12,0,4,10,17,0,0,0,0,0,0,0,0,0,0,0,31,0,2,4,0,0,0,0,0,0,14,17,17,17,31,17,17,0,15,17,17,15,17,17,15,0,14,17,1,1,1,17,14,0,15,17,17,17,17,17,15,0,31,1,1,15,1,1,31,0,31,1,1,15,1,1,1,0,14,17,1,29,17,17,14,0,17,17,17,31,17,17,17,0,31,4,4,4,4,4,31,0,16,16,16,16,17,17,14,0,17,9,5,3,5,9,17,0,1,1,1,1,1,1,31,0,17,27,21,17,17,17,17,0,17,17,19,21,25,17,17,0,14,17,17,17,17,17,14,0,15,17,17,15,1,1,1,0,14,17,17,17,21,9,22,0,15,17,17,15,17,17,17,0,14,17,1,14,16,17,14,0,31,4,4,4,4,4,4,0,17,17,17,17,17,17,14,0,17,17,17,17,17,10,4,0,17,17,17,17,21,27,17,0,17,17,10,4,10,17,17,0,17,17,10,4,4,4,4,0,31,16,8,4,2,1,31,0,8,4,4,2,4,4,8,0,4,4,4,0,4,4,4,0,4,8,8,16,8,8,4,0,0,0,18,13,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31,31,31,31,0,21,10,21,10,21,10,21,0,0,17,31,21,21,14,0,0,14,31,17,27,14,17,14,0,17,4,17,4,17,4,17,0,2,6,30,14,15,12,8,0,0,14,19,19,31,23,14,0,0,27,31,31,14,4,0,0,4,17,14,27,27,14,17,4,0,14,14,0,31,14,10,0,0,4,14,31,21,29,0,0,14,27,25,27,14,17,14,0,0,14,31,21,31,17,14,0,4,12,20,20,4,7,3,0,14,17,21,17,14,17,14,0,0,4,14,27,14,4,0,0,0,0,0,21,0,0,0,0,14,27,19,27,14,17,14,0,0,0,4,31,14,27,0,0,31,17,10,4,10,17,31,0,14,27,17,31,14,17,14,0,0,5,2,0,20,8,0,0,8,21,2,0,8,21,2,0,14,21,27,21,14,17,14,0,31,0,31,0,31,0,31,0,21,21,21,21,21,21,21,0"))

-- enable extended palette
poke(0x5f2e,1)
pal({129,2,3,4,5,6,7,8,9,137,11,12,13,133,15,0},1)

-- camera setup
cx = 0
cy = 0

-- sprite flags
flags = {
  collision = 0,
  foreground = 7
}

-- empty function
_noop = function()end

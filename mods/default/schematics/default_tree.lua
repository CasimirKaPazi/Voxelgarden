local _ = {name = "air", prob = 0}
local L = {name = "default:leaves"}
local T = {name = "default:tree", force_place = true}
local t = {name = "default:tree", force_place = false}

return {
	yslice_prob = {
		{ypos = 2, prob = 127},
		{ypos = 3, prob = 127},
		{ypos = 9, prob = 127},
	},
	size = {
		y = 9,
		x = 5,
		z = 5
	},
	data = {
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
L, L, L, _, _, 
L, L, L, _, _, 
_, _, _, _, _, 

_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, L, L, L, _, 
L, L, L, L, _, 
L, L, L, L, _, 
_, L, L, L, _, 

_, _, t, _, _, 
_, _, T, _, _, 
_, _, T, _, _, 
_, _, T, _, _, 
_, _, T, _, _, 
_, L, T, L, L, 
_, L, T, L, L, 
_, L, L, L, _, 
_, L, L, L, _, 

_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, L, L, L, L, 
_, L, L, L, L, 
_, L, L, L, _, 
_, L, L, L, _, 

_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, _, _, 
_, _, _, L, L, 
_, _, _, L, L, 
_, _, _, _, _, 
_, _, _, _, _, 
}
}

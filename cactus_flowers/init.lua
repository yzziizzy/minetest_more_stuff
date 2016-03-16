


-- Add everything:
local modname = "cactus_flowers"

local modpath = minetest.get_modpath(modname)



minetest.register_node(modname..":pink", {
	description = "Pink Cactus Flower",
	drawtype = "plantlike",
	visual_scale = 0.80,
	tiles = {modname.."_pink.png"},
	inventory_image = modname.."_pink.png",
	wield_image = modname.."_pink.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 2, attached_node = 1, bird_nest = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})
minetest.register_node(modname..":red", {
	description = "Red Cactus Flower",
	drawtype = "plantlike",
	visual_scale = 0.80,
	tiles = {modname.."_red.png"},
	inventory_image = modname.."_red.png",
	wield_image = modname.."_red.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 2, attached_node = 1, bird_nest = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})


local growaction = function(pos, node)
	pos.y = pos.y + 1
	local over = minetest.get_node(pos)
	if over.name ~= "air" then
		return
	end
	
	local r = math.random(1, 100)
	
	if r <= 50 then
		minetest.set_node(pos, {name=modname..":pink"})
	else
		minetest.set_node(pos, {name=modname..":red"})
	end
end



minetest.register_abm({
	nodenames = {"default:cactus"},
	interval = 2,
	chance = 1,
	catch_up = true,
	action = growaction,
})



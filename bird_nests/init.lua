


-- Add everything:
local modname = "bird_nests"

local modpath = minetest.get_modpath(modname)



minetest.register_node(modname..":empty_nest", {
	description = "Empty bird nest",
	drawtype = "plantlike",
	visual_scale = 0.80,
	tiles = {modname.."_empty_nest.png"},
	inventory_image = modname.."_empty_nest.png",
	wield_image = modname.."_empty_nest.png",
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

minetest.register_node(modname..":full_nest", {
	description = "Bird nest with eggs",
	drawtype = "plantlike",
	visual_scale = 0.8,
	tiles = {modname.."_full_nest.png"},
	inventory_image = modname.."_full_nest.png",
	wield_image = modname.."_full_nest.png",
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
	drops = {
		items = {
			max_items = 1,
			{
				items = {modname..":small_egg 3", modname..":empty_nest"},
				rarity = 5,
			},
			{
				items = {modname..":small_egg 2", modname..":empty_nest"},
			},
		}
	},
})


minetest.register_craftitem(modname..":small_egg", {
	description = "Small Egg",
	inventory_image = modname.."_small_egg.png",
	stack_max = 99,
})


local growaction = function(pos, node)
	pos.y = pos.y + 1
	local over = minetest.get_node(pos)
	if over.name ~= "air" then
		return
	end

	local r = 15
	local pos0 = {x = pos.x - r, y = pos.y - r, z = pos.z - r}
	local pos1 = {x = pos.x + r, y = pos.y + r, z = pos.z + r}
	if #minetest.find_nodes_in_area(pos0, pos1, "group:bird_nest") > 0 then
		return
	end
	
	local r = math.random(1, 100)
	
	if r <= 15 then
		minetest.set_node(pos, {name=modname..":full_nest"})
	else
		minetest.set_node(pos, {name=modname..":empty_nest"})
	end
end



minetest.register_abm({
	nodenames = {"default:leaves", "default:pine_needles"},
	interval = 120,
	chance = 10,
	catch_up = true,
	action = growaction,
})



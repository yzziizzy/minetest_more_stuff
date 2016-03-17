


-- Add everything:
local modname = "truffles"

local modpath = minetest.get_modpath(modname)

minetest.register_craftitem(modname..":truffle", {
	description = "Truffle",
	inventory_image = modname.."_truffle.png",
	stack_max = 99,
})

minetest.register_node(modname..":dirt_with_truffles", {
	description = "Dirt with Truffles",
	tiles = {"default_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
	drop = {
		items = {
			max_items = 1,
			{
				items = {"default:dirt", modname..":truffle 3"},
				rarity = 8,
			},
			{
				items = {"default:dirt", modname..":truffle 2"},
				rarity = 3,
			},
			{
				items = {"default:dirt", modname..":truffle"},
				rarity = 1,
			},
		}
	},
})





minetest.register_abm({
	nodenames = {"default:dirt"},
	interval = 120,
	chance = 100,
	catch_up = true,
	action = function(pos, node)
		minetest.set_node(pos, {name=modname..":dirt_with_truffles"})
	end,
})

-- propagation abm, looks for water, wood, etc

-- spawning abm, random with perlin noise


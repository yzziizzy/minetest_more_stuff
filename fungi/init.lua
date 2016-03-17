


-- Add everything:
local modname = "fungi"

local modpath = minetest.get_modpath(modname)
--[[
minetest.register_node(modname..":oyster_mushroom", {
	description = "Oyster Mushroom",
	drawtype = "nodebox",
	tiles = {modname.."oyster_mushroom.png"},
	inventory_image = modname.."oyster_mushroom_inv.png",
	wield_image = modname.."oyster_mushroom_inv.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
		wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
		wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
	},
	groups = {choppy = 2, attached_node = 1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

--]]

minetest.register_node(modname..":morel", {
	description = "Morel Mushroom",
	drawtype = "plantlike",
	visual_scale = 0.80,
	tiles = {modname.."_morels.png"},
	inventory_image = modname.."_morel_inv.png",
	wield_image = modname.."_morel_inv.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 2, attached_node = 1, mushroom = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

minetest.register_node(modname..":stinkhorn", {
	description = "Lattice Stinkhorn Mushroom",
	drawtype = "plantlike",
	visual_scale = 0.60,
	tiles = {modname.."_stinkhorn.png"},
	inventory_image = modname.."_stinkhorn.png",
	wield_image = modname.."_stinkhorn.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 2, attached_node = 1, mushroom = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

minetest.register_node(modname..":puffball", {
	description = "Puffball Mushroom",
	drawtype = "plantlike",
	visual_scale = 0.80,
	tiles = {modname.."_puffball.png"},
	inventory_image = modname.."_puffball.png",
	wield_image = modname.."_puffball.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 2, attached_node = 1, mushroom = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

minetest.register_node(modname..":giant_puffball", {
	description = "Giant Puffball Mushroom",
	drawtype = "plantlike",
	visual_scale = 1.10,
	tiles = {modname.."_giant_puffball.png"},
	inventory_image = modname.."_giant_puffball.png",
	wield_image = modname.."_giant_puffball.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 2, attached_node = 1, mushroom = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

minetest.register_node(modname..":jack_o_lantern", {
	description = "Jack O'Lantern Mushroom",
	drawtype = "plantlike",
	visual_scale = 0.90,
	tiles = {modname.."_jackolantern.png"},
	inventory_image = modname.."_jackolantern.png",
	wield_image = modname.."_jackolantern.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	light_source = 1,
	buildable_to = true,
	groups = {snappy = 3, flammable = 2, attached_node = 1, mushroom = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})




local growaction = function(pos, node)
	pos.y = pos.y + 1
	local over = minetest.get_node_or_nil(pos)
	if over == nil or over.name ~= "air" then
		return
	end
	
	local r = math.random(1, 100)
	
	if r <= 2 then
		minetest.set_node(pos, {name=modname..":stinkhorn"})
	elseif r <= 10 then
		minetest.set_node(pos, {name=modname..":jack_o_lantern"})
	elseif r <= 55 then
		minetest.set_node(pos, {name=modname..":puffball"})
	else
		minetest.set_node(pos, {name=modname..":morel"})
	end
end



minetest.register_abm({
	nodenames = {"default:dirt", "default:dirt_with_grass"},
	interval = 120,
	chance = 50,
	catch_up = true,
	action = function(pos, node)
		pos.y = pos.y + 1
		local over = minetest.get_node_or_nil(pos)
		if over == nil or over.name ~= "air" then
			return
		end
		
		local r = math.random(1, 100)
		
		if r <= 2 then
			minetest.set_node(pos, {name=modname..":stinkhorn"})
		elseif r <= 10 then
			minetest.set_node(pos, {name=modname..":jack_o_lantern"})
		elseif r <= 55 then
			minetest.set_node(pos, {name=modname..":puffball"})
		else
			minetest.set_node(pos, {name=modname..":morel"})
		end
	end,
})

minetest.register_abm({
	nodenames = {modname..":puffball"},
	interval = 120,
	chance = 50,
	catch_up = true,
	action = function(pos, node)
		minetest.set_node(pos, {name=modname..":giant_puffball"})
	end,
})

-- propagation abm, looks for water, wood, etc

-- spawning abm, random with perlin noise


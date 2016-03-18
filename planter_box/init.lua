
local modname = "planter_box"

local modpath = minetest.get_modpath(modname)

planter_box = {}

minetest.register_node(modname..":planter_box", {
	description = "Planter Box",
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {{-3/8, -1/2, -3/8, 3/8, 1/2, 3/8}},
		-- connect_bottom =
		connect_front = {{-3/8, -1/2, -1/2,  3/8, 1/2, -1/4}},
		connect_left = {{-1/2, -1/2, -3/8, -1/4, 1/2,  3/8}},
		connect_back = {{-3/8, -1/2,  1/4,  3/8, 1/2,  1/2}},
		connect_right = {{ 3/8, -1/2, -3/8,  1/2, 1/2,  3/8}},
	},
	connects_to = { modname..":planter_box" },
	paramtype = "light",
	is_ground_content = true,
	tiles = { 
		"default_dirt.png", "default_wood.png","default_wood.png",
		"default_wood.png", "default_wood.png","default_wood.png",
	},
	walkable = true,
	groups = { choppy = 3 },
})

-- crafting recipe
minetest.register_craft({
	output = modname .. ":planter_box 2",
	recipe = {
		{ '', '', '' },
		{ "default:wood", "default:dirt", "default:wood"},
		{ "default:wood", "default:wood", "default:wood"},
	}
})


local duplicates = {
	["default:tree"]="default:sapling",
	
	
}

local hybrids = {
	["default:tree"] = {
		["default:jungletree"] = {"default:leaves"},
		["default:stone"] ={"default:cobble"}
	},
	
}

planter_box.register_hybrid = function(p1, p2, baby)
	local a = hybrids[p1]
	local b = hybrids[p2]
	
	local top
	
	if hybrids[p1] == nil then 
		if hybrids[p2] == nil then
			hybrids[p1] = {}
		else
			local t = p1
			p1 = p2
			p2 = t
		end
	end
	
	if hybrids[p1][p2] == nil then
		hybrids[p1][p2] = {}
	end
	
	table.insert(hybrids[p1][p2], baby) 
end



minetest.register_abm({
	nodenames = {modname..":planter_box"},
	interval = 5,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		pos.y = pos.y + 1
		local over = minetest.get_node(pos)
		
		if over.name ~= "air" then
			return
		end

		function try_hybrids(n1, n2)
			if n1 == nil or n2 == nil then
				return false
			end
			local h = hybrids[n1.name]
			local h2n = n2.name
			if h == nil then
				h = hybrids[h2n]
				h2n = n1.name
			end
			
			if h == nil then
				return false
			end
				
			local baby = h[h2n] 
			if baby ~= nil then 
				minetest.set_node(pos, {name=baby})
				return true
			end
			
			return false
		end
		
		local x1 = minetest.get_node_or_nil({x=pos.x - 1, y=pos.y, z=pos.z})
		local x2 = minetest.get_node_or_nil({x=pos.x + 1, y=pos.y, z=pos.z})
		
		local z1 = minetest.get_node_or_nil({x=pos.x, y=pos.y, z=pos.z - 1})
		local z2 = minetest.get_node_or_nil({x=pos.x, y=pos.y, z=pos.z + 1})
		
		if try_hybrids(x1, x2) or try_hybrids(z1, z2) then
			return
		end
		
--[[		
			
		local r = math.random(1, 100)
	
		if r <= 15 then
			minetest.set_node(pos, {name=modname..":full_nest"})
		else
			minetest.set_node(pos, {name=modname..":empty_nest"})
		end, ]]
	end,
})



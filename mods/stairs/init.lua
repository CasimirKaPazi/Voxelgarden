stairs = {}

function stairs.register_stair(subname, recipeitem, groups, images, description, sounds)
	stairsplus.register_stair(
		"stairsplus", subname, recipeitem, groups, images, description, subname, sounds, false
	)
end

function stairs.register_slab(subname, recipeitem, groups, images, description, sounds)
	stairsplus.register_slab(
		"stairsplus", subname, recipeitem, groups, images, description, subname, sounds, false
	)
end

function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab, sounds)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair, sounds)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab, sounds)
end

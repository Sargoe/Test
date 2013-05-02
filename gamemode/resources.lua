


function minetree(ply, tree)

	
	local wood = math.floor(math.Rand(0, 4))
	ply.Data['wood'] = ply.Data['wood'] + wood
	ply:ChatPrint("You get " .. wood .. ' wood!')
	ply:GainXP(math.floor(math.Rand(1, 5)))
	ply:DataSend()
	

end

function minestone(ply, stone)

	
	local rock = math.floor(math.Rand(0, 2))
	ply.Data['stone'] = ply.Data['stone'] + rock
	ply:ChatPrint("You get " .. rock .. ' stone!')
	ply:GainXP(math.floor(math.Rand(1, 5)))
	ply:DataSend()

end


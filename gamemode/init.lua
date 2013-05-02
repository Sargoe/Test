GM.Version = "0.0.1"
GM.Name = "CNRPG"
GM.Author = "Sargoe85"


DeriveGamemode('sandbox')


this 
is j
ust
to
fuck
with 
you
i've done this everywhere, don't bother trying to run this script






util.AddNetworkString("StartMenu")
util.AddNetworkString("DataSend")
s
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
include("player.lua")
include("resources.lua")



// Table Stuff \\
cnrpg = {}
cnrpg.Models = {}
cnrpg.Noclip = false



function LoadTables()
	Msg('loading Tables\n')
	local data = file.Read("cnrpg/models.txt", "DATA")
	cnrpg.Models = util.KeyValuesToTable(data)
	


end
concommand.Add('lt', LoadTables)

function GM:Initialize()
timer.Simple(3, function ()LoadTables() end)


end

function GM:PlayerInitialSpawn(ply)

	ply:Start()
	timer.Create( ply:Name().." Save", 30, 0, function() ply:Save() end )
	


end


s

 



function GM:PlayerLoadout(ply)

	ply:Give("Hands")
	ply:Give("Pickaxe")
	ply:Give("gmod_tool")
	ply:Give("weapon_physgun")
	local agi = ply.Data['agility']
	local walk = 250 + agi*2
	local run = 350 + agi*2.2

	GAMEMODE:SetPlayerSpeed(ply, walk, run)

end
s
function GM:PlayerDisconnected(ply)


	timer.Destroy(ply:Name().." Save")



end
s
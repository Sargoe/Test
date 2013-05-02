local meta = FindMetaTable("Player")

lvlxp = {0, 100, 200, 350, 500, 750, 1000, 1250, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000}
lvlextra = {0, 2, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75}

function meta:GainXP(am)

	local nl = self.Data['level'] + 1
	local level = self.Data['level']
	self.Data['xp'] = self.Data['xp'] + am
	
	if self.Data['xp'] >= lvlxp[nl] then
		self.Data['level'] = nl
		self.Data['strength'] = 10 + lvlextra[level]
		self.Data['agility'] = 10 + lvlextra[level]
		self.Data['stamina'] = 10 + lvlextra[level]
		self.Data['intellect'] = 10 + lvlextra[level]
		local level = self.Data['level']
		self:ChatPrint('Congratulations, you have reached level ' .. level)	
		self:EmitSound('lvlup.mp3')
	end

end

function meta:Save()
	Msg('saving\n')
	local plydata = self.Data
	local data = util.TableToKeyValues(plydata)
	file.Write("cnrpg/" .. self:Name()..".txt", data)


end

function meta:Load()
	Msg('loading\n')
	local name = string.lower(self:Name())
	local data = file.Read("cnrpg/"..name..".txt", "DATA")
	local ptable = util.KeyValuesToTable(data)
	self.Data = {}
	self.Data = ptable


end

function SaveTables()

	Msg('saving Tables\n')
	local data = util.TableToKeyValues(cnrpg.Models)
	file.Write("cnrpg/models.txt", data)


end
concommand.Add('cnrpg_SaveTables', SaveTables)


function LoadTable()

	LoadTables()


end
concommand.Add('cnrpg_LoadTables', LoadTable)

function meta:Start()

	local name = string.lower(self:Name())
	if file.Exists("cnrpg/"..name..".txt", "DATA") then 
		Msg('exists\n')
		self:Load()
		self:ChatPrint("[CNRPG]: welcom back " .. self:Name() .. ", it's been too long.")
		self:DataSend()
	else
		Msg('Setting Player Table for ' .. name ..'\n')
		self.Data = {}
		self.Data['name'] = self:GetName()
		self.Data['xp'] = 0
		self.Data['level'] = 1
		self.Data['strength'] = 10
		self.Data['agility'] = 10
		self.Data['stamina'] = 10
		self.Data['intellect'] = 10
		self.Data['wood'] = 0
		self.Data['stone'] = 0
		self.Data['copper'] = 0
		self:Save()
		Msg('Player Table Set\n')
		self:ChatPrint("[CNRPG]: Hey " .. self:Name() .. ", nice to meet you.")
		self:DataSend()
	end
		
	self:Startshit()

end

function meta:Startshit()

	self:SetNWInt('hunger', 100)
	self:SetNWInt('thirst', 100)
	self:SetNWInt('tired', 100)
	timer.Create(self:Name().. " doshit", 10,0, function() self:needs() end)


end

function meta:needs()

	local h = self:GetNWInt('hunger') - 1
	local t = self:GetNWInt('thirst') - 1
	local ti = self:GetNWInt('tired') - 1
	self:SetNWInt('hunger', h)
	self:SetNWInt('thirst', t)
	self:SetNWInt('tired', ti)


end

function meta:DataSend()

	net.Start('DataSend')
	net.WriteTable(self.Data)
	net.Send(self)


end

function SavePlayer(ply, cmd, args)

	ply:Save()

	ply:Load()


end
concommand.Add('cnrpg_save', SavePlayer)

function kk(p,c,a)

PrintTable(p.Data)
p:Give("weapon_gravitygun")
end
concommand.Add("kk", kk)


function ss(p,c,a)

	p:Start()
	
end
concommand.Add("ss", ss)
function GM:PlayerNoClip(ply)

	if !ply:IsAdmin() and cnrpg.Noclip == false then
		ply:ChatPrint("You must be admin to noclip!")
		return false
	else
		return true
	
	end


end

function kkk(p,c,a)
 local stat = a[1]
 local val = a[2]
 p.Data[tostring(stat)] = val
 p:ChatPrint( stat .. " has been changed to " .. val )

end
concommand.Add("kkk", kkk)

function kkk(p,c,a)
local tr = p:GetEyeTrace()
local t = tr.HitPos
local button = ents.Create( "Crate" )
button:SetPos( Vector(t.x, t.y, t.z +10))
button.Owner = p
button:Spawn()
	  undo.Create( "Testies" )
    undo.AddEntity( button )
    undo.SetPlayer( p )
	undo.Finish()
end
concommand.Add("sd", kkk)
 water = {'ambient/water/water_splash1.wav',
						'ambient/water/water_splash2.wav',
						'ambient/water/water_splash3.wav'}
// local IDSteam = string.gsub(ply:SteamID(), ":", "")
function GM:KeyPress (ply, key)
	
	local t = ply:GetNWInt('thirst') + 10
	if t > 100 then t = 100 end
	local sound = math.floor(math.Rand(1,4))
	if key == 32 and ply:WaterLevel() > 0 then
		ply:SetNWInt('thirst', t)
		ply:ChatPrint(water[sound])
		ply:EmitSound(water[sound])
	end
end


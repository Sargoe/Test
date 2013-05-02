DeriveGamemode('sandbox')
IO = false

Data = {}
Data['wood'] = 0
Data['copper'] = 0
Data['stone'] = 0
Data['strength'] = 10
Data['agility'] = 10
Data['stamina'] = 10
Data['intellect'] = 10
Data['xp'] = 0
Data['level'] = 1

lvlxp = {0, 100, 200, 350, 500, 750, 1000, 1250, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000}
lvlextra = {0, 2, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75}
if lvlxp[Data['level'] + 1] == nil then
	lvlxp = MAX

end

surface.CreateFont( "Font", {
 font = "Open Sans",
 size = 50,
 weight = 1000,
 blursize = 0,
 scanlines = 0,
 antialias = true,
 underline = false,
 italic = false,
 strikeout = false,
 symbol = false,
 rotary = false,
 shadow = false,
 additive = false,
 outline = false
} )

net.Receive('DataSend', function() Data = net.ReadTable()   end)
function hud() -- Consider functions like a cyber button, and everything INSIDE the function turns on when this cyber button is pressed.
// BG
	draw.RoundedBox(4, 2, ScrH() - 86.5, 206, 85, Color(0,0,0,200))
// HEALTH	
	local health = LocalPlayer():Health()
	draw.RoundedBox(4, 5, ScrH() - 25, health * 2, 20, Color(255,0,0,255))
	draw.RoundedBox(4, 5, ScrH() - 25, 200, 20, Color(0,0,0,120))
	//draw.SimpleText(health, "default", 10, ScrH() - 22, Color(255,255,255,255))
	draw.SimpleText("Health", "default", 80, ScrH() - 22, Color(255,255,255,255))
// HUNGER
	local hunger = LocalPlayer():GetNWInt('hunger')
	draw.RoundedBox(4, 5, ScrH() - 45, hunger * 2, 18, Color(250,255,0,255))
	draw.RoundedBox(4, 5, ScrH() - 45, 200, 18, Color(0,0,0,120))
	//draw.SimpleText(hunger, "default", 10, ScrH() - 42, Color(255,255,255,255))
	draw.SimpleText("Hunger", "default", 80, ScrH() - 42, Color(255,255,255,255))
// THIRST
	local thirst = LocalPlayer():GetNWInt('thirst')
	draw.RoundedBox(4, 5, ScrH() - 63, thirst * 2, 16, Color(0,0,255,255))
	draw.RoundedBox(4, 5, ScrH() - 63, 200, 16, Color(0,0,0,120))
	//draw.SimpleText(thirst, "default", 10, ScrH() - 61, Color(255,255,255,255))
	draw.SimpleText("Thirst", "default", 80, ScrH() - 61, Color(255,255,255,255))
// FATIGUE
	local tired = LocalPlayer():GetNWInt('tired')
	draw.RoundedBox(4, 5, ScrH() - 81, tired * 2, 16, Color(180,0,255,255))
	draw.RoundedBox(4, 5, ScrH() - 81, 200, 16, Color(0,0,0,120))
	//draw.SimpleText(tired, "default", 10, ScrH() - 79, Color(255,255,255,255))
	draw.SimpleText("Sleep", "default", 80, ScrH() - 79, Color(255,255,255,255))
	PHud()

end 
hook.Add("HUDPaint", "MyHudName", hud) -- I'll explain hooks and functions in a second

function PHud()


draw.RoundedBox(4, 5, 7, 150, 88, Color(0,0,0,120))
draw.SimpleText("Wood    = " .. Data['wood'], "default", 10, 10, Color(255,255,255,255))
draw.SimpleText("Stone    = " .. Data['stone'], "default", 10, 20, Color(255,255,255,255))
draw.SimpleText("Copper  = " .. Data['copper'], "default", 10, 30, Color(255,255,255,255))
draw.SimpleText("Agility  = " .. Data['agility'], "default", 10, 40, Color(255,255,255,255))
draw.SimpleText("Strength  = " .. Data['strength'], "default", 10, 50, Color(255,255,255,255))
draw.SimpleText("Stamina  = " .. Data['stamina'], "default", 10, 60, Color(255,255,255,255))
draw.SimpleText("Intellect  = " .. Data['intellect'], "default", 10, 70, Color(255,255,255,255))
draw.SimpleText("Experience  = " .. Data['xp'] .. "/" .. lvlxp[Data['level'] + 1], "default", 10, 80, Color(255,255,255,255))
draw.SimpleText("Level " .. Data['level'] , "Font", ScrW()/2 - 50, 10, Color(255,255,255,255))


end


function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideOurHud:D", hidehud)

function BindPress(ply, bind, press) // For F1 F2 F3 F4
	if string.find(bind, 'gm_showspare1') then
		Mouse()
	end
end
hook.Add('PlayerBindPress', 'pbp', BindPress)

function Mouse() // Show cursor function

	IO = not IO 
	if IO == true then 
	RestoreCursorPosition( )
	else 
	RememberCursorPosition( )
	end
	gui.EnableScreenClicker(IO) 

end


include('shared.lua')
function ENT:Draw()
		local ply = self
	local own = self:GetNWEntity('owner')
	local P = ply:GetPos()
	local Ang = ply:GetAngles()
	local ang = Angle(Ang.p, Ang.y, Ang.r + 90)
	surface.SetFont("HUDNumber5")
	local TextWidth = surface.GetTextSize(own:Nick())
	local TextWidth2 = surface.GetTextSize("hey it works")

	Ang:RotateAroundAxis(Ang:Forward(), 90)
	local TextAng = Ang

	TextAng:RotateAroundAxis(TextAng:Right(), CurTime() * -180)

	cam.Start3D2D(Vector(P.x, P.y, P.z ) , TextAng, 0.1)
		draw.WordBox(2, -TextWidth*0.5 + 5, -30, own:Nick(), "HUDNumber5", Color(0, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth2*0.5 + 5, 18, "hey it works", "HUDNumber5", Color(0, 0, 0, 100), Color(255,255,255,255))
	cam.End3D2D()
self:DrawModel()

end
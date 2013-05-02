AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize() -- This function is called when it first inializes.
    self:SetModel("models/props_junk/wood_crate001a.mdl"); -- Make it a vending machine
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox

        local phys = self:GetPhysicsObject()

		phys:Wake()
	self:SetNWEntity('owner', self.Owner)

end
   
   

   

   
function CreateEvilVendie(ply,cmd,args) -- This is called when we type "create_evil_vendie" in the console
      if !ply:IsAdmin() then return false end -- Stop the function here, If the caller isn't a admin.
      local e = ents.Create("Test") -- Create a evil_vendie ent
      e:SetPos(ply:GetPos() + Vector(0,0,1000)) -- Set it's pos, To 500 something above you.
       -- Set it's pos, To 500 something above you.
      e:Spawn() -- spawn it.
	  undo.Create( "Test ent" )
    undo.AddEntity( e )
    undo.SetPlayer( ply )
	undo.Finish()
end
   concommand.Add("create_evil_vendie",CreateEvilVendie) -- Add the console command
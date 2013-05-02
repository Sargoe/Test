if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "melee"
	
end

if ( CLIENT ) then

	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 60
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	
	killicon.Add( "weapon_equalizerthing", "HUD/killicons/equalizer", Color( 255, 80, 0, 100 ) )
end

SWEP.PrintName = "Wooden Pickaxe"
SWEP.Author			= "Sargoe85"
SWEP.Contact		= ""
SWEP.Purpose		= "Everyone gets one!"
SWEP.Instructions	= "Use it to mine stuff.."

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

SWEP.Primary.Sound			= ""
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay			= 1.2

SWEP.NextStrike = 0;

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.HitModel = ""
SWEP.AdminMode = false
SWEP.NextReload = 0

	local woodsounds = {"physics/wood/wood_solid_impact_hard1.wav",
				"physics/wood/wood_solid_impact_hard2.wav",
				"physics/wood/wood_solid_impact_hard3.wav"}
				
					local rocksounds = {"physics/concrete/rock_impact_hard2.wav",
							"physics/concrete/rock_impact_hard3.wav",
							"physics/concrete/rock_impact_hard4.wav"}

function SWEP:Initialize()
	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
end

function SWEP:Deploy()
end

function SWEP:Reload()
	if self.NextReload > CurTime() then return end
	local ply = self.Owner
	self.NextReload = CurTime() + 1
		
	if ply:IsAdmin() then
		if self.AdminMode == false then
			self.AdminMode = true
			ply:ChatPrint('Admin mode turned on')
		else
			self.AdminMode = false
			ply:ChatPrint('Admin mode turned off')
		end
	else
			ply:ChatPrint('You are not admin')
	end
end





function SWEP:PrimaryAttack()
	
	local tr = self.Owner:GetEyeTrace()
	local pos = tr.HitPos
	local agi = self.Owner.Data['agility']
	local mod = (agi/250)
	local tiem = 1
	
	if( CurTime() < self.NextStrike ) then return; end
	self.Weapon:EmitSound('weapons/iceaxe/iceaxe_swing1.wav')
	self.NextStrike = ( CurTime() + (tiem - mod) );
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
			

				
	
	
	if( self.Owner:EyePos():Distance( pos ) > 120 ) then return; end
	
	
	if tr.HitNonWorld then
		
		

		
		local ply = self.Owner
		self.HitModel = tr.Entity:GetModel()
		self:DoHit()
		if self.AdminMode then 
			ply:ChatPrint(tr.Entity:GetModel())
			
			ply:ChatPrint(mod)
		end
	end
	
end

function SWEP:DoHit()
	if (SERVER) then
		local number = math.floor(math.Rand(1, 4))
		local tr = self.Owner:GetEyeTrace()
		local mod = tr.Entity:GetModel()
		local tre = tr.Entity
		
		// self.Owner:TraceHullAttack( self.Owner:GetShootPos(), self.Owner:GetAimVector() * 100, Vector(-16,-16,-16), Vector(36,36,36), 5, DMG_SLASH, 1, true )
			for k, v in pairs(cnrpg.Models) do
				if mod == v then
					if string.find( mod, "tree", 1, false ) then
						minetree(self.Owner, tre)
						self.Weapon:EmitSound(tostring(woodsounds[number]))
						return
					elseif string.find( mod, "rock", 1, false ) or string.find( mod, "stone", 1, false ) then
						minestone(self.Owner, tre)
						self.Weapon:EmitSound(tostring(rocksounds[number]))
						
						return
					end
				end
			end
	end
end

function SWEP:SecondaryAttack()
	if self.AdminMode == false then self.Owner:ChatPrint('You are NOT an admin and do not have access to this') return end
	local tr = self.Owner:GetEyeTrace()
	local pos = tr.HitPos
	local ply = self.Owner
	if( self.Owner:EyePos():Distance( pos ) > 500 ) then ply:ChatPrint('Look at something dickhead') return; end

	if tr.HitNonWorld and IsValid(tr.Entity) then
		table.insert(cnrpg.Models, tr.Entity:GetModel())
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		local ply = self.Owner
		ply:ChatPrint(tr.Entity:GetModel() .. "added to table")

	end
	
end




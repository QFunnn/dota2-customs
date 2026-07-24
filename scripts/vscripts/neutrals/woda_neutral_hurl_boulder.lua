--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_hurl_boulder = class({})

function woda_neutral_hurl_boulder:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/mud_golem_hurl_boulder.vpcf", context )
end

function woda_neutral_hurl_boulder:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})

	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		local info = {
		     Target = target,
		     Source = self:GetCaster(),
		     Ability = self, 
		     EffectName = "particles/neutral_fx/mud_golem_hurl_boulder.vpcf",
		     iMoveSpeed = 800,
		     bReplaceExisting = false,                         
		     bProvidesVision = true,                           
		     iVisionRadius = 450,        
		     iVisionTeamNumber = self:GetCaster():GetTeamNumber()        
		}
		self:GetCaster():EmitSound("n_mud_golem.Boulder.Cast")
    	ProjectileManager:CreateTrackingProjectile(info)
    	self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

function woda_neutral_hurl_boulder:OnProjectileHit(target, vLocation)
	if not IsServer() then return end
	if target == nil then return end
	if target:IsMagicImmune() then return end
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration * (1 - target:GetStatusResistance()) })     
    target:EmitSound("n_mud_golem.Boulder.Target")
end
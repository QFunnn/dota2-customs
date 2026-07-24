--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dragon_knight_18_cooldown", "modifiers/talents/npc_dota_hero_dragon_knight/modifier_dragon_knight_18", LUA_MODIFIER_MOTION_NONE)

modifier_dragon_knight_18=class({})

function modifier_dragon_knight_18:IsHidden() return true end
function modifier_dragon_knight_18:IsPurgable() return false end
function modifier_dragon_knight_18:IsPurgeException() return false end
function modifier_dragon_knight_18:RemoveOnDeath() return false end

modifier_dragon_knight_18.cooldown = {40,20}

function modifier_dragon_knight_18:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_dragon_knight_18:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dragon_knight_18:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSORB_SPELL
	}
end

function modifier_dragon_knight_18:GetAbsorbSpell( params )
	if not IsServer() then return end
	if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_dragon_knight_18_cooldown") then return end
	if params.ability:GetCaster():GetTeamNumber() == self:GetParent():GetTeamNumber() then return nil end
	local effect_cast = ParticleManager:CreateParticle( "particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_dragon_knight_18_cooldown", {duration = self.cooldown[self:GetStackCount()]})
    self:GetParent():EmitSound("DOTA_Item.LinkensSphere.Activate")
	return 1
end

modifier_dragon_knight_18_cooldown = class({})
function modifier_dragon_knight_18_cooldown:IsDebuff() return true end
function modifier_dragon_knight_18_cooldown:RemoveOnDeath() return false end
function modifier_dragon_knight_18_cooldown:IsPurgable() return false end
function modifier_dragon_knight_18_cooldown:GetTexture() return "dragon_knight_18" end
--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_barrel", "modifiers/modifier_barrel", LUA_MODIFIER_MOTION_NONE)

barrel_no_health_bar = class({})

function barrel_no_health_bar:GetIntrinsicModifierName()
	return "modifier_barrel"
end

modifier_barrel = class({})

function modifier_barrel:IsHidden() return true end
function modifier_barrel:IsPurgable() return false end
function modifier_barrel:IsPurgeException() return false end

function modifier_barrel:CheckState()
	return
	{
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_SPECIALLY_DENIABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_CANNOT_TARGET_ENEMIES] = true,
		[MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_INVULNERABLE] = false,
	}
end

function modifier_barrel:DeclareFunctions()
	return
	{
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_AVOID_DAMAGE,
	}
end

function modifier_barrel:OnDeath(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	local particle = ParticleManager:CreateParticle("particles/newplayer_fx/npx_tree_break.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
	self:GetParent():AddNoDraw()
end

function modifier_barrel:GetModifierAvoidDamage(params)
	if not IsServer() then return end
	if params.attacker and not params.attacker:IsHero() then
		return 1
	end
end
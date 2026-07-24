--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_broodmother_spawn_spiderlings_lua = class({})

function modifier_broodmother_spawn_spiderlings_lua:IsDebuff() return true end
function modifier_broodmother_spawn_spiderlings_lua:GetEffectName() return "particles/units/heroes/hero_broodmother/broodmother_spiderlings_debuff.vpcf" end
function modifier_broodmother_spawn_spiderlings_lua:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end
function modifier_broodmother_spawn_spiderlings_lua:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_broodmother_spawn_spiderlings_lua:OnDestroy()
	if IsClient() then return end

	local ability = self:GetAbility()
	local caster = self:GetCaster()
	local parent = self:GetParent()

	if not ability or not caster then return end

	if parent:IsAlive() then return end

	local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_broodmother/broodmother_spiderlings_spawn.vpcf", PATTACH_ABSORIGIN, parent)
	ParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx)
	parent:EmitSound("Hero_Broodmother.SpawnSpiderlings")

	ability:SpawnSpiderlings(parent)
end
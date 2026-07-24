--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_book_of_shadows_custom", "items/item_book_of_shadows_custom.lua", LUA_MODIFIER_MOTION_NONE )

if item_book_of_shadows_custom == nil then
	item_book_of_shadows_custom = class({})
end

function item_book_of_shadows_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_dark_willow/dark_willow_shadow_realm.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf", context)
end

function item_book_of_shadows_custom:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local Duration = self:GetSpecialValueFor("duration")

	if target then
		local bIsEnemy = target:GetTeamNumber() ~= caster:GetTeamNumber()
		if bIsEnemy then
			if not target:IsDebuffImmune() then
				target:Purge(true, false, false, false, false)
			end
		else
			target:Purge(false, true, false, false, false)
		end

		if target:GetTeamNumber() ~= caster:GetTeamNumber() then
			Duration = Duration * (1 - target:GetStatusResistance())
		end
		
		target:AddNewModifier(caster, self, "modifier_item_book_of_shadows_custom", {duration=Duration})
	end
end

modifier_item_book_of_shadows_custom = class({
	IsHidden                = function(self) return false end,
    -- Book of Shadows — бафф на самого героя (incoming damage 0).
    -- Раньше IsPurgable=false блокировал ВСЕ типы диспела — бафф снимался только
    -- статус-резистансом или истечением времени, что для способности уровня ulti
    -- было слишком сильным иммунитетом без честного counter'а.
    -- Теперь модификатор сделан снимаемым (IsPurgable=true), флаг IsPurgeException
    -- сохраняет ему "исключительный" статус по правилам Source 2.
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return false end,

	GetStatusEffectName 	= function(self) return "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf" end,

	CheckState				= function(self)
		local bIsAlly = self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber()
		local bApply = bIsAlly or not self:GetParent():IsDebuffImmune()
		return {
			[MODIFIER_STATE_NO_UNIT_COLLISION]=bApply,
			[MODIFIER_STATE_ATTACK_IMMUNE]=bApply,
			[MODIFIER_STATE_UNTARGETABLE_ENEMY]=bIsAlly,
			[MODIFIER_STATE_DISARMED]=bApply,
			[MODIFIER_STATE_SILENCED]=bApply,
			[MODIFIER_STATE_MUTED]=bApply,
		}
	end,

	OnCreated				= function(self)
		if not IsServer() then return end

		local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_dark_willow/dark_willow_shadow_realm.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControlEnt(fx, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
		self:AddParticle(fx, false, false, -1, false, false)

		EmitSoundOn("Item.BookOfShadows.Target", self:GetParent())
	end
})
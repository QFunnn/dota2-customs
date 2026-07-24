--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_enigma_malefice_custom", "abilities/enigma_malefice_custom", LUA_MODIFIER_MOTION_NONE)

enigma_malefice_custom = class({})

function enigma_malefice_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function enigma_malefice_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	local tick_rate = self:GetSpecialValueFor("tick_rate")
	local stun_instances = self:GetSpecialValueFor("stun_instances")
	local cursor_target = self:GetCursorTarget()
	if cursor_target:TriggerSpellAbsorb(self) then return end
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
	local eid = 1
	for id, target in pairs(enemies) do
		target:AddNewModifier(self:GetCaster(), self, "modifier_enigma_malefice_custom", {eid = eid, duration = tick_rate * stun_instances})
		eid = 0
		target:EmitSound("Hero_Enigma.Malefice")
	end
end

modifier_enigma_malefice_custom = class({})

function modifier_enigma_malefice_custom:IsHidden()
	return false
end

function modifier_enigma_malefice_custom:IsDebuff()
	return true
end

function modifier_enigma_malefice_custom:IsStunDebuff()
	return false
end

function modifier_enigma_malefice_custom:IsPurgable()
	return true
end

function modifier_enigma_malefice_custom:OnCreated( kv )
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
	local tick_rate = self.ability:GetSpecialValueFor( "tick_rate" )
	local damage = self.ability:GetSpecialValueFor( "damage" )
	self.stun = self.ability:GetSpecialValueFor( "stun_duration" )
	self.eid = kv.eid
	if IsServer() then
		self.damageTable = 
		{
			victim = self.parent,
			attacker = self.caster,
			damage = damage,
			damage_type = self.ability:GetAbilityDamageType(),
			ability = self.ability,
		}
		self:StartIntervalThink( tick_rate )
		self:OnIntervalThink()
	end
end

function modifier_enigma_malefice_custom:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_enigma_malefice_custom:OnIntervalThink()
	if not IsServer() then return end
	self.parent:AddNewModifier( self.caster, self.ability, "modifier_stunned", { duration = self.stun } )
	ApplyDamage( self.damageTable )
	EmitSoundOn( "Hero_Enigma.MaleficeTick", self.parent )
	-- [#1] Эйдолоны от Malefice (шард) должны быть ИДЕНТИЧНЫ эйдолонам Demonic Conversion:
	-- тот же тип юнита (по уровню Q), те же модификаторы, характеристики и L20-талант.
	-- Раньше тут хардкодился npc_dota_dire_eidolon без кастомного стат-модификатора, плюс
	-- ВСЕ значения эйдолона (eidolon_dmg_tooltip/hp/тип/талант) лежат на demonic_conversion,
	-- а не на malefice. Поэтому делегируем спавн самому Demonic Conversion — единый источник
	-- правды. Кол-во берём из eidolon_spawns_per_tick (шард = +1).
	if tonumber(self.eid) == 1 and self.caster:HasShard() then
		local spawns = self.ability:GetSpecialValueFor("eidolon_spawns_per_tick")
		if not spawns or spawns < 1 then spawns = 1 end
		local demonic = self.caster:FindAbilityByName("enigma_demonic_conversion_custom")
		for i = 1, spawns do
			local vPos = self.parent:GetAbsOrigin() + RandomVector(150)
			if demonic and not demonic:IsNull() and demonic:GetLevel() > 0 then
				demonic:CreateEidolon(self.parent, vPos)
			else
				-- Фолбэк: у героя нет (прокачанной) Demonic Conversion — спавним как раньше.
				local eidolon = CreateUnitByName("npc_dota_dire_eidolon", vPos, true, self.caster, self.caster, self.caster:GetTeamNumber())
				if eidolon then
					eidolon:AddNewModifier(self.caster, self.ability, "modifier_kill", {duration = 40})
					eidolon:AddNewModifier(self.caster, self, "modifier_demonic_conversion", {duration = 40})
					eidolon:SetOwner(self.caster)
					eidolon:SetControllableByPlayer(self.caster:GetPlayerID(), true)
					FindClearSpaceForUnit(eidolon, eidolon:GetAbsOrigin(), true)
				end
			end
		end
	end
end

function modifier_enigma_malefice_custom:GetEffectName()
	return "particles/units/heroes/hero_enigma/enigma_malefice.vpcf"
end

function modifier_enigma_malefice_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_enigma_malefice_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_enigma_malefice.vpcf"
end
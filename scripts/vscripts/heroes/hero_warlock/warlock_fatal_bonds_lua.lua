--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_fatal_bonds_debuff_lua", "heroes/hero_warlock/warlock_fatal_bonds_lua",
	LUA_MODIFIER_MOTION_NONE)

warlock_fatal_bonds_lua = class({}) ---@class warlock_fatal_bonds_lua : CDOTA_Ability_Lua

_G.FatalBondsGroups = _G.FatalBondsGroups or {}

local function NewBondId()
	return tostring(GameRules:GetGameTime()) .. "_" .. tostring(RandomInt(1, 1000000000))
end

function warlock_fatal_bonds_lua:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not target then return end
	if target:TriggerSpellAbsorb(self) then return end

	local maxCount = self:GetSpecialValueFor("count") or 0
	local damage_share = self:GetSpecialValueFor("damage_share_percentage") or 0
	local duration = self:GetSpecialValueFor("duration") or 0

	local list = {}
	table.insert(list, target:entindex())

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		self:GetSpecialValueFor("search_aoe"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= target then
			table.insert(list, enemy:entindex())
			if #list >= maxCount then break end
		end
	end


	local bond_id = NewBondId()
	_G.FatalBondsGroups[bond_id] = list

	for _, entIndex in ipairs(list) do
		local unit = EntIndexToHScript(entIndex)
		if unit and not unit:IsNull() then ---@cast unit CDOTA_BaseNPC
			unit:AddNewModifier(caster, self, "modifier_fatal_bonds_debuff_lua", {
				duration = duration * unit:GetStatusResistanceFactor(caster),
				damage_share = damage_share,
				bond_id = bond_id,
			})
		end
	end
end

-----------------------------------------------------
modifier_fatal_bonds_debuff_lua = class({}) ---@class CDOTA_Modifier_Lua

function modifier_fatal_bonds_debuff_lua:IsDebuff() return true end

function modifier_fatal_bonds_debuff_lua:IsHidden() return false end

function modifier_fatal_bonds_debuff_lua:IsPurgable() return true end

function modifier_fatal_bonds_debuff_lua:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_fatal_bonds_debuff_lua:ShouldUseOverheadOffset() return true end

function modifier_fatal_bonds_debuff_lua:GetEffectName()
	return "particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon.vpcf"
end

function modifier_fatal_bonds_debuff_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_fatal_bonds_debuff_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_TOOLTIP, MODIFIER_EVENT_ON_TAKEDAMAGE }
end

function modifier_fatal_bonds_debuff_lua:OnTooltip()
	return self.damage_share_pct or
		(self:GetAbility() and self:GetAbility():GetSpecialValueFor("damage_share_percentage")) or 0
end

function modifier_fatal_bonds_debuff_lua:OnCreated(kv)
	if not IsServer() then return end

	self.bond_id = kv.bond_id
	self.damage_share_pct = tonumber(kv.damage_share) or 0
	self.damage_share = self.damage_share_pct * 0.01

	self.damageToApply = 0
	self.damageType = DAMAGE_TYPE_MAGICAL

	self:StartIntervalThink(1.0)
end

local function HasFlag(flags, flag)
	return bit.band(flags or 0, flag) ~= 0
end

function modifier_fatal_bonds_debuff_lua:OnTakeDamage(event)
	if not IsServer() then return end
	if event.unit ~= self:GetParent() then return end

	if HasFlag(event.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) then return end

	self.damageType = event.damage_type or self.damageType
	self.damageToApply = self.damageToApply + (event.damage or 0) * self.damage_share

	if not event.unit:IsAlive() then
		self:OnIntervalThink()
	end
end

function modifier_fatal_bonds_debuff_lua:OnIntervalThink()
	if not IsServer() then return end

	local parent = self:GetParent()
	if not parent or parent:IsNull() then return end

	local dmg = self.damageToApply
	self.damageToApply = 0
	if dmg <= 0 then
		if not parent:IsAlive() then self:Destroy() end
		return
	end

	local list = _G.FatalBondsGroups and self.bond_id and _G.FatalBondsGroups[self.bond_id]
	if type(list) ~= "table" then return end

	local parent_loc = parent:GetAbsOrigin()
	for _, entIndex in ipairs(list) do
		local target = EntIndexToHScript(entIndex)
		if target and (not target:IsNull()) and target:IsAlive() and target ~= parent then ---@cast target CDOTA_BaseNPC
			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				parent
			)
			ParticleManager:SetParticleControl(pfx, 0, parent_loc + Vector(0, 0, 100))
			ParticleManager:SetParticleControl(pfx, 1, target:GetAbsOrigin() + Vector(0, 0, 100))
			ParticleManager:ReleaseParticleIndex(pfx)

			ApplyDamage({
				attacker = self:GetCaster(),
				victim = target,
				ability = self:GetAbility(),
				damage = dmg,
				damage_type = self.damageType or DAMAGE_TYPE_MAGICAL,
				damage_flags =
					DOTA_DAMAGE_FLAG_REFLECTION +
					DOTA_DAMAGE_FLAG_HPLOSS +
					DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION +
					DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL
			})
		end
	end

	if not parent:IsAlive() then
		self:Destroy()
	end
end
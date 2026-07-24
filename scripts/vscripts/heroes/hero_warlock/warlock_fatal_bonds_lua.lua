--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier("modifier_fatal_bonds_debuff", "heroes/hero_warlock/warlock_fatal_bonds_lua", LUA_MODIFIER_MOTION_NONE)

warlock_fatal_bonds_lua = class({})

Kill_Ability = {
	item_hand_of_midas_lua = true,
	night_stalker_hunter_in_the_night_lua = true,
	pudge_meat_hook = true,
	mirana_arrow = true,
	doom_bringer_devour = true,
}

function warlock_fatal_bonds_lua:OnSpellStart()
	if IsServer() then
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local count = self:GetSpecialValueFor("count")
		local damage_share = self:GetSpecialValueFor("damage_share_percentage")

		if not IsValid(target) then
			return
		end

		if target:TriggerSpellAbsorb(self) then
			return
		end

		-- Talent
		local talent = caster:FindAbilityByName("special_bonus_unique_warlock_5")
		if talent and talent:GetLevel() > 0 then
			damage_share = damage_share + talent:GetSpecialValueFor("value")
		end

		-- Include the main target
		local targets = {}
		targets[count] = target:entindex()
		count = count - 1

		-- Find nearby enemies to affect
		local enemies = FindUnitsInRadius(caster:GetTeam(), target:GetAbsOrigin(), nil, self:GetSpecialValueFor("search_aoe"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER, false)
		for _, enemy in pairs(enemies) do
			if enemy ~= target and count > 0 then
				targets[count] = enemy:entindex()
				count = count - 1
			end
		end

		for _, affected_enemy_index in pairs(targets) do
			EntIndexToHScript(affected_enemy_index):AddNewModifier(caster, self, "modifier_fatal_bonds_debuff", {
				duration = self:GetSpecialValueFor("duration") * EntIndexToHScript(affected_enemy_index):GetStatusResistanceFactor(caster),
				damage_share = damage_share,
				target_1 = targets[1],
				target_2 = targets[2],
				target_3 = targets[3],
				target_4 = targets[4],
				target_5 = targets[5],
				target_6 = targets[6]
			})
		end
	end
end

modifier_fatal_bonds_debuff = class({})

function modifier_fatal_bonds_debuff:IsDebuff() return true end
function modifier_fatal_bonds_debuff:IsHidden() return false end
function modifier_fatal_bonds_debuff:IsPurgable() return true end
function modifier_fatal_bonds_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_fatal_bonds_debuff:ShouldUseOverheadOffset()
	return true
end

function modifier_fatal_bonds_debuff:GetEffectName()
	return "particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon.vpcf"
end

function modifier_fatal_bonds_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_fatal_bonds_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_EVENT_ON_TAKEDAMAGE
	}
	return funcs
end

function modifier_fatal_bonds_debuff:OnTooltip()
	return self:GetAbility():GetSpecialValueFor("damage_share_percentage")
end

function modifier_fatal_bonds_debuff:OnCreated(keys)
	if IsServer() then
		self.current_damage = 0
		if not keys.damage_share then keys.damage_share = 12 end
		self.damage_share = keys.damage_share * 0.01
		self.share_targets = {}

		if keys.target_1 then table.insert(self.share_targets, EntIndexToHScript(keys.target_1)) end
		if keys.target_2 then table.insert(self.share_targets, EntIndexToHScript(keys.target_2)) end
		if keys.target_3 then table.insert(self.share_targets, EntIndexToHScript(keys.target_3)) end
		if keys.target_4 then table.insert(self.share_targets, EntIndexToHScript(keys.target_4)) end
		if keys.target_5 then table.insert(self.share_targets, EntIndexToHScript(keys.target_5)) end
		if keys.target_6 then table.insert(self.share_targets, EntIndexToHScript(keys.target_6)) end

		self:StartIntervalThink(1.0)
		self:OnIntervalThink()
	end
end

function modifier_fatal_bonds_debuff:OnTakeDamage(keys)
	local hParent = self:GetParent()
	if IsServer() then
		if keys.unit == self:GetParent() then
			local ability = keys.inflictor
			if ability ~= nil and ability.GetAbilityName ~= nil and Kill_Ability[ability:GetAbilityName()] ~= nil then
				return
			end
			self.current_damage = self.current_damage + keys.damage * self.damage_share
			if not keys.unit:IsAlive() then
				self:OnIntervalThink()
			end
		end
	end
end

function modifier_fatal_bonds_debuff:OnIntervalThink()
	if IsServer() then
		local caster = self:GetCaster()
		local parent = self:GetParent()
		local parent_loc = parent:GetAbsOrigin()

		for _, target in pairs(self.share_targets) do
			if (not target:IsNull()) and target:IsAlive() and target:HasModifier("modifier_fatal_bonds_debuff") and parent ~= target then
				local bonds_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
				ParticleManager:SetParticleControl(bonds_pfx, 0, parent_loc + Vector(0, 0, 100))
				ParticleManager:SetParticleControl(bonds_pfx, 1, target:GetAbsOrigin() + Vector(0, 0, 100))
				ParticleManager:ReleaseParticleIndex(bonds_pfx)

				if self.current_damage > 0 then
					ApplyDamage({attacker = caster, victim = target, damage = self.current_damage, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_BYPASSES_ALL_BLOCK})
				end
			end
		end

		self.current_damage = 0

		if not parent:IsAlive() then
			self:Destroy()
		end
	end
end
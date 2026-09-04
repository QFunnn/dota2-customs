--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_item_0189_glimmer, modifier_item_0178_maim, modifier_item_0124_broken_armor, modifier_item_0234_broken_armor, modifier_item_0300_broken_armor, modifier_item_0125_frost, modifier_item_0150_corrosion, modifier_item_0298_mire_shield
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_shatter_shared = require("abilities.items.item_shatter_shared")
local modifier_item_shatter_base = ____item_shatter_shared.modifier_item_shatter_base
local modifier_item_shatter_debuff_base = ____item_shatter_shared.modifier_item_shatter_debuff_base
local item_0129 = __TS__Class()
item_0129.name = "item_0129"
__TS__ClassExtends(item_0129, BaseItem_CS)
function item_0129.prototype.GetIntrinsicModifierName(self)
	return "item_0129_modifier"
end
item_0129 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0129)
local item_0129_modifier = __TS__Class()
item_0129_modifier.name = "item_0129_modifier"
__TS__ClassExtends(item_0129_modifier, BaseModifier_CS)
function item_0129_modifier.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function item_0129_modifier.prototype.IsHidden(self)
	return true
end
function item_0129_modifier.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	if RollPercentage(25) then
		Damage:ApplyDamage({
			victim = event.target,
			attacker = event.attacker,
			damage = 50,
			damage_type = 1,
			ability = self:GetAbility(),
		})
		local pfx = MyGameHeroParticleManager:CreateParticle(
			"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			event.target,
			self:GetParent()
		)
		MyGameHeroParticleManager:SetParticleControlEnt(
			pfx,
			0,
			event.target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			event.target:GetAbsOrigin(),
			true
		)
		MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
		EmitSoundOn("Hero_Lion.ImpaleHitTarget", event.target)
	end
end
item_0129_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_0129_modifier)
local item_0131 = __TS__Class()
item_0131.name = "item_0131"
__TS__ClassExtends(item_0131, item_0129)
function item_0131.prototype.GetIntrinsicModifierName(self)
	return "item_0131_modifier"
end
item_0131 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0131)
local item_0131_modifier = __TS__Class()
item_0131_modifier.name = "item_0131_modifier"
__TS__ClassExtends(item_0131_modifier, BaseModifier_CS)
function item_0131_modifier.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function item_0131_modifier.prototype.IsHidden(self)
	return true
end
function item_0131_modifier.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local ability = self:GetAbility()
	local target = event.target
	if not ability or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_ps_chance = ability:GetSpecialValueFor("ability_ps_chance")
	if not RollPercentage(ability_ps_chance) then
		return
	end
	local ability_ps_damage = ability:GetSpecialValueFor("ability_ps_damage")
	local ability_ps_radius = ability:GetSpecialValueFor("ability_ps_radius")
	if ability_ps_damage <= 0 or ability_ps_radius <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		ability_ps_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue19
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = ability_ps_damage,
				damage_type = 1,
				ability = ability,
			})
		end
		::__continue19::
	end
	self:PlayEffects1(target)
end
function item_0131_modifier.prototype.PlayEffects1(self, target)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	local pfx2 = MyGameHeroParticleManager:CreateParticle(
		"particles/windrunner_tailwind_oneshot_arcana.vpcf",
		PATTACH_WORLDORIGIN,
		nil,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(pfx2, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx2)
	EmitSoundOn("Hero_Lion.ImpaleHitTarget", target)
end
item_0131_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_0131_modifier)
local item_0457 = __TS__Class()
item_0457.name = "item_0457"
__TS__ClassExtends(item_0457, item_0129)
function item_0457.prototype.GetIntrinsicModifierName(self)
	return "item_0131_modifier"
end
item_0457 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0457)
local item_0165 = __TS__Class()
item_0165.name = "item_0165"
__TS__ClassExtends(item_0165, BaseItem_CS)
function item_0165.prototype.GetIntrinsicModifierName(self)
	return "item_0165_modifier"
end
item_0165 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0165)
local item_0165_modifier = __TS__Class()
item_0165_modifier.name = "item_0165_modifier"
__TS__ClassExtends(item_0165_modifier, BaseModifier_CS)
function item_0165_modifier.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function item_0165_modifier.prototype.GetMutexKey(self)
	return "item_0165_mutex"
end
function item_0165_modifier.prototype.GetMutexPriority(self)
	return 100
end
function item_0165_modifier.prototype.IsHidden(self)
	return true
end
function item_0165_modifier.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	event.attacker:GiveMana(1)
	Damage:ApplyDamage({
		victim = event.target,
		attacker = event.attacker,
		damage = 20,
		damage_type = 2,
		ability = self:GetAbility(),
	})
	local hitEffect = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack_launch.vpcf",
		PATTACH_CENTER_FOLLOW,
		event.target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		hitEffect,
		9,
		event.target,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		event.target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(hitEffect)
end
item_0165_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_0165_modifier)
local item_0169 = __TS__Class()
item_0169.name = "item_0169"
__TS__ClassExtends(item_0169, BaseItem_CS)
function item_0169.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0169_aura"
end
item_0169 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0169)
local modifier_item_0169_aura = __TS__Class()
modifier_item_0169_aura.name = "modifier_item_0169_aura"
__TS__ClassExtends(modifier_item_0169_aura, BaseModifier_CS)
function modifier_item_0169_aura.prototype.GetModifierAura(self)
	return "modifier_item_0169_aura_effect"
end
function modifier_item_0169_aura.prototype.GetAuraRadius(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_aura_radius")
	else
		____ability_0 = 0
	end
	return ____ability_0
end
function modifier_item_0169_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_item_0169_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_item_0169_aura.prototype.IsAura(self)
	return true
end
function modifier_item_0169_aura.prototype.IsHidden(self)
	return true
end
function modifier_item_0169_aura.prototype.IsDebuff(self)
	return false
end
function modifier_item_0169_aura.prototype.IsPurgable(self)
	return false
end
modifier_item_0169_aura = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0169_aura)
local modifier_item_0169_aura_effect = __TS__Class()
modifier_item_0169_aura_effect.name = "modifier_item_0169_aura_effect"
__TS__ClassExtends(modifier_item_0169_aura_effect, BaseModifier_CS)
function modifier_item_0169_aura_effect.GetLocalizationCN(self)
	return { name = "摧破", description = "护甲降低。" }
end
function modifier_item_0169_aura_effect.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_1
	if ability then
		____ability_1 = ability:GetSpecialValueFor("ability_armor_reduction")
	else
		____ability_1 = 0
	end
	local armorReduction = ____ability_1
	return { bonus_armor = -armorReduction }
end
function modifier_item_0169_aura_effect.prototype.IsHidden(self)
	return false
end
function modifier_item_0169_aura_effect.prototype.IsDebuff(self)
	return true
end
function modifier_item_0169_aura_effect.prototype.IsPurgable(self)
	return true
end
modifier_item_0169_aura_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0169_aura_effect)
local item_0178 = __TS__Class()
item_0178.name = "item_0178"
__TS__ClassExtends(item_0178, BaseItem_CS)
function item_0178.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0178"
end
item_0178 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0178)
local item_0180 = __TS__Class()
item_0180.name = "item_0180"
__TS__ClassExtends(item_0180, item_0178)
item_0180 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0180)
local item_0189 = __TS__Class()
item_0189.name = "item_0189"
__TS__ClassExtends(item_0189, BaseItem_CS)
function item_0189.prototype.GetFadeDelayValue(self)
	return self:GetSpecialValueFor("ability_initial_fade_delay")
end
function item_0189.prototype.GetInvisDurationValue(self)
	return self:GetSpecialValueFor("ability_duration")
end
function item_0189.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0189.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	modifier_item_0189_glimmer:applys(caster, caster, self, {
		duration = self:GetFadeDelayValue() + self:GetInvisDurationValue(),
		fade_duration = self:GetFadeDelayValue(),
	})
	caster:EmitSound("Item.GlimmerCape.Activate")
end
item_0189 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0189)
modifier_item_0189_glimmer = __TS__Class()
modifier_item_0189_glimmer.name = "modifier_item_0189_glimmer"
__TS__ClassExtends(modifier_item_0189_glimmer, BaseModifier_CS)
function modifier_item_0189_glimmer.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.fadeDuration = 0
	self.fadeStartTime = 0
	self.nextInvisTime = 0
end
function modifier_item_0189_glimmer.prototype.OnCreated(self, params)
	self.fadeDuration = params.fade_duration or 0
	self:RestartFade()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local initialParticle = ParticleManager:CreateParticle(
		"particles/items3_fx/glimmer_cape_initial.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(initialParticle, 0, parent:GetAbsOrigin())
	self:AddParticle(initialParticle, false, false, -1, false, false)
	local flashParticle = ParticleManager:CreateParticle(
		"particles/items3_fx/glimmer_cape_initial_flash.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(flashParticle, 0, parent:GetAbsOrigin())
	self:AddParticle(flashParticle, false, false, -1, false, false)
end
function modifier_item_0189_glimmer.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_START, BusinessEvents.ON_ABILITY_START }
end
function modifier_item_0189_glimmer.prototype.RestartFade(self)
	local now = GameRules:GetGameTime()
	self.fadeStartTime = now
	self.nextInvisTime = now + self.fadeDuration
end
function modifier_item_0189_glimmer.prototype.IsInvisibleActive(self)
	return GameRules:GetGameTime() >= self.nextInvisTime
end
function modifier_item_0189_glimmer.prototype.OnAttackStart_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	self:RestartFade()
end
function modifier_item_0189_glimmer.prototype.OnAbilityStart_CS(self, event)
	if not IsServer() then
		return
	end
	if event.caster ~= self:GetParent():entindex() then
		return
	end
	self.fadeStartTime = GameRules:GetGameTime()
	self.nextInvisTime = math.huge
end
function modifier_item_0189_glimmer.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
function modifier_item_0189_glimmer.prototype.GetModifierInvisibilityLevel(self)
	return self:IsInvisibleActive() and 1 or 0
end
function modifier_item_0189_glimmer.prototype.CheckState(self)
	local ____MODIFIER_STATE_INVISIBLE_3 = MODIFIER_STATE_INVISIBLE
	local ____table_IsInvisibleActive_result_2
	if self:IsInvisibleActive() then
		____table_IsInvisibleActive_result_2 = true
	else
		____table_IsInvisibleActive_result_2 = nil
	end
	return { [____MODIFIER_STATE_INVISIBLE_3] = ____table_IsInvisibleActive_result_2 }
end
function modifier_item_0189_glimmer.prototype.IsHidden(self)
	return false
end
function modifier_item_0189_glimmer.prototype.IsDebuff(self)
	return false
end
function modifier_item_0189_glimmer.prototype.IsPurgable(self)
	return true
end
function modifier_item_0189_glimmer.prototype.GetTexture(self)
	return "item_glimmer_cape"
end
modifier_item_0189_glimmer = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0189_glimmer)
local item_0191 = __TS__Class()
item_0191.name = "item_0191"
__TS__ClassExtends(item_0191, BaseItem_CS)
function item_0191.prototype.GetCastRangeValue(self)
	return self:GetSpecialValueFor("ability_cast_range")
end
function item_0191.prototype.GetIntDamageMultiplierValue(self)
	return self:GetSpecialValueFor("ability_int_damage_multiplier")
end
function item_0191.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET,
		canCast = function(____, ____bindingPattern0)
			local target
			target = ____bindingPattern0.target
			if not target then
				return UF_FAIL_CUSTOM
			end
			if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
				return UF_FAIL_CUSTOM
			end
			if not IsValidAlive(nil, target) or target:IsBuilding() then
				return UF_FAIL_CUSTOM
			end
			return UF_SUCCESS
		end,
		castError = function(____, ____bindingPattern0)
			local target
			target = ____bindingPattern0.target
			if not target then
				return "#dota_hud_error_invalid_target"
			end
			if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
				return "#dota_hud_error_unit_not_enemy"
			end
			if not IsValidAlive(nil, target) or target:IsBuilding() then
				return "#dota_hud_error_invalid_target"
			end
			return ""
		end,
	}
end
function item_0191.prototype.GetCastRange(self, location, target)
	return self:GetCastRangeValue()
end
function item_0191.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not IsValidAlive(nil, caster) or not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == caster:GetTeamNumber() then
		return
	end
	local intelligence = MyGameAttribute:GetAttribute(caster, "total_intelligence") or 0
	local damage = intelligence * self:GetIntDamageMultiplierValue()
	caster:EmitSound("DOTA_Item.Dagon.Activate")
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items_fx/dagon.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 2, Vector(400, 400, 400))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("DOTA_Item.Dagon5.Target", target)
	Damage:ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = 2,
		ability = self,
	})
end
item_0191 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0191)
local item_0192 = __TS__Class()
item_0192.name = "item_0192"
__TS__ClassExtends(item_0192, BaseItem_CS)
function item_0192.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0192_insight"
end
item_0192 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0192)
____exports.item_0195 = __TS__Class()
local item_0195 = ____exports.item_0195
item_0195.name = "item_0195"
__TS__ClassExtends(item_0195, BaseItem_CS)
function item_0195.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET,
		canCast = function(____, ____bindingPattern0)
			local target
			target = ____bindingPattern0.target
			if not target then
				return UF_FAIL_CUSTOM
			end
			local caster = self:GetCaster()
			if target:GetTeamNumber() == caster:GetTeamNumber() and target ~= caster then
				return UF_FAIL_CUSTOM
			end
			if not IsValidAlive(nil, target) or target:IsBuilding() then
				return UF_FAIL_CUSTOM
			end
			local ____this_5
			____this_5 = target
			local ____opt_4 = ____this_5.IsDestructible
			if (____opt_4 and ____opt_4(____this_5)) == true then
				return UF_FAIL_CUSTOM
			end
			local ____this_7
			____this_7 = target
			local ____opt_6 = ____this_7.IsBoss
			if (____opt_6 and ____opt_6(____this_7)) == true then
				return UF_FAIL_CUSTOM
			end
			return UF_SUCCESS
		end,
	}
end
function item_0195.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not target then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	target:AddNewModifier(caster, self, "modifier_eul_cyclone", { duration = ability_duration })
	self:PlayEffects1(caster, target)
end
function item_0195.prototype.GetCastRange(self, location, target)
	return self:GetSpecialValueFor("ability_cast_range")
end
function item_0195.prototype.PlayEffects1(self, caster, target)
	caster:EmitSound("DOTA_Item.Cyclone.Activate")
end
item_0195 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0195)
____exports.item_0195 = item_0195
local item_0196 = __TS__Class()
item_0196.name = "item_0196"
__TS__ClassExtends(item_0196, BaseItem_CS)
function item_0196.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0196"
end
item_0196 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0196)
local modifier_item_0196 = __TS__Class()
modifier_item_0196.name = "modifier_item_0196"
__TS__ClassExtends(modifier_item_0196, BaseModifier_CS)
function modifier_item_0196.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0196.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	local ability_trigger_chance_pct = ability:GetSpecialValueFor("ability_trigger_chance_pct")
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	local ability_vulnerable_duration = ability:GetSpecialValueFor("ability_vulnerable_duration")
	AddDeBuffStatus(
		nil,
		target,
		event.attacker,
		ability,
		DebuffStatusType.VULNERABLE,
		{ duration = ability_vulnerable_duration, effect_name = "particles/items2_fx/orchid_2.vpcf" }
	)
	self:StartAbilityCooldown(ability)
	self:PlayEffects1(event.attacker, target)
end
function modifier_item_0196.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local ability_cooldown = ability:GetCooldown(level)
	if ability_cooldown > 0 then
		ability:StartCooldown(ability_cooldown)
	end
end
function modifier_item_0196.prototype.PlayEffects1(self, caster, target)
	EmitSoundOn("DOTA_Item.Orchid.Activate", target)
end
modifier_item_0196 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0196)
local item_0311 = __TS__Class()
item_0311.name = "item_0311"
__TS__ClassExtends(item_0311, BaseItem_CS)
function item_0311.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0196"
end
item_0311 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0311)
local item_0197 = __TS__Class()
item_0197.name = "item_0197"
__TS__ClassExtends(item_0197, BaseItem_CS)
function item_0197.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("ability_radius")
end
function item_0197.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE }
end
function item_0197.prototype.GetCastRange(self, location, target)
	return self:GetSpecialValueFor("ability_cast_range")
end
function item_0197.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target_point = self:GetCursorPosition()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayEffects1(caster)
	local ability_radius = self:GetSpecialValueFor("ability_radius")
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	local ability_projectile_speed = self:GetSpecialValueFor("ability_projectile_speed")
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target_point,
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue120
			end
			CreateProjectile(nil, {
				caster = caster,
				ability = self,
				effect_name = "particles/items3_fx/gleipnir_projectile.vpcf",
				projectile_type = "tracking",
				target = enemy,
				projectile_speed = ability_projectile_speed,
				start_point = caster:GetAbsOrigin(),
				on_hit = function(____, hitTarget)
					if not IsServer() then
						return true
					end
					if not hitTarget or not IsValidAlive(nil, hitTarget) or hitTarget:IsBuilding() then
						return true
					end
					hitTarget:AddNewModifier(caster, self, "modifier_item_0197_root", { duration = ability_duration })
					self:PlayEffects2(caster, hitTarget:GetAbsOrigin())
					return true
				end,
			})
		end
		::__continue120::
	end
end
function item_0197.prototype.PlayEffects1(self, caster)
	caster:EmitSound("Item.Gleipnir.Cast")
end
function item_0197.prototype.PlayEffects2(self, caster, impactPosition)
	EmitSoundOnLocationWithCaster(impactPosition, "Item.Gleipnir.Target", caster)
end
item_0197 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0197)
local modifier_item_0197_root = __TS__Class()
modifier_item_0197_root.name = "modifier_item_0197_root"
__TS__ClassExtends(modifier_item_0197_root, BaseModifier_CS)
function modifier_item_0197_root.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.rootParticle = MyGameHeroParticleManager:CreateParticle(
		"particles/items3_fx/gleipnir_root.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		self:GetCaster()
	)
	MyGameHeroParticleManager:SetParticleControl(self.rootParticle, 0, parent:GetAbsOrigin())
end
function modifier_item_0197_root.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.rootParticle ~= nil then
		MyGameHeroParticleManager:DestroyParticle(self.rootParticle, false)
		MyGameHeroParticleManager:ReleaseParticleIndex(self.rootParticle)
		self.rootParticle = nil
	end
end
function modifier_item_0197_root.prototype.IsHidden(self)
	return false
end
function modifier_item_0197_root.prototype.IsDebuff(self)
	return true
end
function modifier_item_0197_root.prototype.IsPurgable(self)
	return true
end
function modifier_item_0197_root.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true }
end
modifier_item_0197_root = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0197_root)
____exports.item_0198 = __TS__Class()
local item_0198 = ____exports.item_0198
item_0198.name = "item_0198"
__TS__ClassExtends(item_0198, BaseItem_CS)
function item_0198.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET }
end
function item_0198.prototype.GetCastRange(self, location, target)
	return self:GetSpecialValueFor("ability_cast_range")
end
function item_0198.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not IsValidAlive(nil, caster) or not target or not IsValidAlive(nil, target) then
		return
	end
	self:PlayEffects1(caster)
	local ability_projectile_speed = self:GetSpecialValueFor("ability_projectile_speed")
	CreateProjectile(nil, {
		caster = caster,
		ability = self,
		effect_name = "particles/items_fx/ethereal_blade.vpcf",
		projectile_type = "tracking",
		target = target,
		projectile_speed = ability_projectile_speed,
		on_hit = function(____, hitTarget)
			if not IsServer() then
				return true
			end
			if not hitTarget or not IsValidAlive(nil, hitTarget) or hitTarget:IsBuilding() then
				return true
			end
			if hitTarget:GetTeamNumber() == caster:GetTeamNumber() then
				return true
			end
			local rolledDuration = self:GetSpecialValueFor("ability_value_duration")
			local ____temp_8
			if rolledDuration > 0 then
				____temp_8 = rolledDuration
			else
				____temp_8 = self:GetSpecialValueFor("ability_duration")
			end
			local ability_duration = ____temp_8
			hitTarget:AddNewModifier(caster, self, "modifier_item_0198_ethereal", { duration = ability_duration })
			self:PlayEffects2(caster, hitTarget)
			return true
		end,
	})
end
function item_0198.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.EtherealBlade.Activate")
end
function item_0198.prototype.PlayEffects2(self, caster, target)
	EmitSoundOn("DOTA_Item.EtherealBlade.Target", target)
end
item_0198 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0198)
____exports.item_0198 = item_0198
local modifier_item_0198_ethereal = __TS__Class()
modifier_item_0198_ethereal.name = "modifier_item_0198_ethereal"
__TS__ClassExtends(modifier_item_0198_ethereal, BaseModifier_CS)
function modifier_item_0198_ethereal.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0198_ethereal.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	if event.ctx.spec.damage_type ~= 1 then
		return
	end
	event.prevent_apply = true
end
function modifier_item_0198_ethereal.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_9
	if ability then
		____ability_9 = ability:GetSpecialValueFor("ability_move_slow_pct")
	else
		____ability_9 = 0
	end
	local ability_move_slow_pct = ____ability_9
	local ____ability_10
	if ability then
		____ability_10 = ability:GetSpecialValueFor("ability_value_magical_pct")
	else
		____ability_10 = 0
	end
	local rolledMagic = ____ability_10
	local ____temp_12
	if rolledMagic > 0 then
		____temp_12 = rolledMagic
	else
		local ____ability_11
		if ability then
			____ability_11 = ability:GetSpecialValueFor("ability_magical_pct")
		else
			____ability_11 = 0
		end
		____temp_12 = ____ability_11
	end
	local ability_magical_pct = ____temp_12
	return { bonus_movespeed_pct = -ability_move_slow_pct, incoming_magical_damage_increase_pct = ability_magical_pct }
end
function modifier_item_0198_ethereal.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_ATTACK_IMMUNE] = true }
end
function modifier_item_0198_ethereal.prototype.IsHidden(self)
	return false
end
function modifier_item_0198_ethereal.prototype.IsDebuff(self)
	return true
end
function modifier_item_0198_ethereal.prototype.IsPurgable(self)
	return true
end
function modifier_item_0198_ethereal.prototype.GetEffectName(self)
	return "particles/items_fx/ghost.vpcf"
end
function modifier_item_0198_ethereal.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_ghost.vpcf"
end
function modifier_item_0198_ethereal.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_item_0198_ethereal.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_item_0198_ethereal = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0198_ethereal)
local item_0224 = __TS__Class()
item_0224.name = "item_0224"
__TS__ClassExtends(item_0224, BaseItem_CS)
function item_0224.prototype.GetDurationValue(self)
	return self:GetSpecialValueFor("ability_duration")
end
function item_0224.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0224.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:AddNewModifier(caster, self, "modifier_item_0224_shield", { duration = self:GetDurationValue() })
end
item_0224 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0224)
local ITEM_0223_OUT_OF_COMBAT_DELAY = 4
local item_0223 = __TS__Class()
item_0223.name = "item_0223"
__TS__ClassExtends(item_0223, BaseItem_CS)
function item_0223.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0223"
end
item_0223 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0223)
local modifier_item_0223 = __TS__Class()
modifier_item_0223.name = "modifier_item_0223"
__TS__ClassExtends(modifier_item_0223, BaseModifier_CS)
function modifier_item_0223.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.isOutOfCombat = false
end
function modifier_item_0223.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.isOutOfCombat = false
	self:StartIntervalThink(0.2)
end
function modifier_item_0223.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE, BusinessEvents.ON_DEAL_DAMAGE }
end
function modifier_item_0223.prototype.OnTakeDamage_CS(self, event)
	self:RecordDamage()
end
function modifier_item_0223.prototype.OnDealDamage_CS(self, event)
	self:RecordDamage()
end
function modifier_item_0223.prototype.OnIntervalThink(self)
	if self._ability:IsCooldownReady() then
		self.isOutOfCombat = true
		self:RefreshAttributes()
	end
end
function modifier_item_0223.prototype.GetAttributeBonus(self)
	if not self.isOutOfCombat then
		return {}
	end
	local ability = self:GetAbility()
	local ____ability_13
	if ability then
		____ability_13 = ability:GetSpecialValueFor("ability_bonus_movespeed")
	else
		____ability_13 = 0
	end
	local bonusMovespeed = ____ability_13
	local ____ability_14
	if ability then
		____ability_14 = ability:GetSpecialValueFor("ability_health_regen_pct")
	else
		____ability_14 = 0
	end
	local healthRegenPct = ____ability_14
	return { base_movespeed = bonusMovespeed, health_regen_pct = healthRegenPct }
end
function modifier_item_0223.prototype.IsHidden(self)
	return true
end
function modifier_item_0223.prototype.RecordDamage(self)
	local ability = self._ability
	ability:StartCooldown(ITEM_0223_OUT_OF_COMBAT_DELAY)
	if not self.isOutOfCombat then
		return
	end
	self.isOutOfCombat = false
	self:RefreshAttributes()
end
modifier_item_0223 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0223)
____exports.item_0231 = __TS__Class()
local item_0231 = ____exports.item_0231
item_0231.name = "item_0231"
__TS__ClassExtends(item_0231, BaseItem_CS)
function item_0231.prototype.GetDurationValue(self)
	return self:GetSpecialValueFor("ability_duration")
end
function item_0231.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0231.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:AddNewModifier(caster, self, "modifier_item_0231_essence_ring", { duration = self:GetDurationValue() })
	caster:EmitSound("DOTA_Item.EssenceRing.Cast")
end
item_0231 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0231)
____exports.item_0231 = item_0231
local item_0232 = __TS__Class()
item_0232.name = "item_0232"
__TS__ClassExtends(item_0232, BaseItem_CS)
function item_0232.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0605"
end
item_0232 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0232)
local item_0218 = __TS__Class()
item_0218.name = "item_0218"
__TS__ClassExtends(item_0218, BaseItem_CS)
function item_0218.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0605"
end
item_0218 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0218)
local item_0233 = __TS__Class()
item_0233.name = "item_0233"
__TS__ClassExtends(item_0233, BaseItem_CS)
function item_0233.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0233_aura"
end
item_0233 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0233)
local modifier_item_0178 = __TS__Class()
modifier_item_0178.name = "modifier_item_0178"
__TS__ClassExtends(modifier_item_0178, BaseModifier_CS)
function modifier_item_0178.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0178.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	local maimChancePct = ability:GetSpecialValueFor("ability_maim_chance_pct")
	local maimDuration = ability:GetSpecialValueFor("ability_maim_duration")
	if not RollPercentage(maimChancePct) then
		return
	end
	modifier_item_0178_maim:applys(target, event.attacker, self:GetAbility(), { duration = maimDuration })
end
modifier_item_0178 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0178)
modifier_item_0178_maim = __TS__Class()
modifier_item_0178_maim.name = "modifier_item_0178_maim"
__TS__ClassExtends(modifier_item_0178_maim, BaseModifier_CS)
function modifier_item_0178_maim.GetLocalizationCN(self)
	return { name = "残废", description = "攻击力降低，移动速度降低。" }
end
function modifier_item_0178_maim.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/sange_maim.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_item_0178_maim.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_15
	if ability then
		____ability_15 = ability:GetSpecialValueFor("ability_attack_reduction_pct")
	else
		____ability_15 = 0
	end
	local attackReductionPct = ____ability_15
	local ____ability_16
	if ability then
		____ability_16 = ability:GetSpecialValueFor("ability_move_slow_pct")
	else
		____ability_16 = 0
	end
	local moveSlowPct = ____ability_16
	return { base_attack_damage_percent = -attackReductionPct, bonus_movespeed_pct = -moveSlowPct }
end
function modifier_item_0178_maim.prototype.IsHidden(self)
	return false
end
function modifier_item_0178_maim.prototype.IsDebuff(self)
	return true
end
function modifier_item_0178_maim.prototype.IsPurgable(self)
	return true
end
modifier_item_0178_maim = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0178_maim)
local modifier_item_0233_aura = __TS__Class()
modifier_item_0233_aura.name = "modifier_item_0233_aura"
__TS__ClassExtends(modifier_item_0233_aura, BaseModifier_CS)
function modifier_item_0233_aura.prototype.GetModifierAura(self)
	return "modifier_item_0233_aura_effect"
end
function modifier_item_0233_aura.prototype.GetAuraRadius(self)
	local ability = self:GetAbility()
	local ____ability_17
	if ability then
		____ability_17 = ability:GetSpecialValueFor("ability_aura_radius")
	else
		____ability_17 = 0
	end
	return ____ability_17
end
function modifier_item_0233_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_item_0233_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_CREEP
end
function modifier_item_0233_aura.prototype.IsAura(self)
	return true
end
function modifier_item_0233_aura.prototype.IsHidden(self)
	return true
end
function modifier_item_0233_aura.prototype.IsDebuff(self)
	return false
end
function modifier_item_0233_aura.prototype.IsPurgable(self)
	return false
end
modifier_item_0233_aura = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0233_aura)
local modifier_item_0233_aura_effect = __TS__Class()
modifier_item_0233_aura_effect.name = "modifier_item_0233_aura_effect"
__TS__ClassExtends(modifier_item_0233_aura_effect, BaseModifier_CS)
function modifier_item_0233_aura_effect.GetLocalizationCN(self)
	return { name = "凝视", description = "攻击速度降低。" }
end
function modifier_item_0233_aura_effect.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_18
	if ability then
		____ability_18 = ability:GetSpecialValueFor("ability_attack_speed_reduction_pct")
	else
		____ability_18 = 0
	end
	local attackSpeedReductionPct = ____ability_18
	return { attack_speed_pct = -attackSpeedReductionPct }
end
function modifier_item_0233_aura_effect.prototype.IsHidden(self)
	return false
end
function modifier_item_0233_aura_effect.prototype.IsDebuff(self)
	return true
end
function modifier_item_0233_aura_effect.prototype.IsPurgable(self)
	return true
end
modifier_item_0233_aura_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0233_aura_effect)
local modifier_item_0231_essence_ring = __TS__Class()
modifier_item_0231_essence_ring.name = "modifier_item_0231_essence_ring"
__TS__ClassExtends(modifier_item_0231_essence_ring, BaseModifier_CS)
function modifier_item_0231_essence_ring.GetLocalizationCN(self)
	return { name = "强健", description = "提高生命值上限。" }
end
function modifier_item_0231_essence_ring.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local particle =
		ParticleManager:CreateParticle("particles/items5_fx/essence_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		parent,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_item_0231_essence_ring.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_19
	if ability then
		____ability_19 = ability:GetSpecialValueFor("ability_bonus_health")
	else
		____ability_19 = 0
	end
	local bonusHealth = ____ability_19
	return { bonus_health = bonusHealth }
end
function modifier_item_0231_essence_ring.prototype.IsHidden(self)
	return false
end
function modifier_item_0231_essence_ring.prototype.IsDebuff(self)
	return false
end
function modifier_item_0231_essence_ring.prototype.IsPurgable(self)
	return true
end
modifier_item_0231_essence_ring = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0231_essence_ring)
local modifier_item_0224_shield = __TS__Class()
modifier_item_0224_shield.name = "modifier_item_0224_shield"
__TS__ClassExtends(modifier_item_0224_shield, BaseModifier_CS)
function modifier_item_0224_shield.GetLocalizationCN(self)
	return { name = "日耀", description = "额外获得护盾值上限与当前护盾。" }
end
function modifier_item_0224_shield.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local origin = parent:GetAbsOrigin()
	parent:EmitSound("Item.StarEmblem.Friendly")
	EmitSoundOn("Item.Pavise.Target", parent)
	local overheadParticle =
		ParticleManager:CreateParticle("particles/items3_fx/star_emblem_friend.vpcf", PATTACH_CENTER_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		overheadParticle,
		0,
		parent,
		PATTACH_OVERHEAD_FOLLOW,
		"follow_overhead",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		overheadParticle,
		1,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		overheadParticle,
		5,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(overheadParticle, false, false, -1, false, false)
	local ability = self:GetAbility()
	if ability then
		parent:AddCurrentEnergyShield(ability:GetSpecialValueFor("ability_shield_amount"), "next_frame_delta")
	end
end
function modifier_item_0224_shield.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_20
	if ability then
		____ability_20 = ability:GetSpecialValueFor("ability_shield_amount")
	else
		____ability_20 = 0
	end
	local shieldAmount = ____ability_20
	return { base_energy_shield = shieldAmount }
end
function modifier_item_0224_shield.prototype.IsHidden(self)
	return false
end
function modifier_item_0224_shield.prototype.IsDebuff(self)
	return false
end
function modifier_item_0224_shield.prototype.IsPurgable(self)
	return true
end
modifier_item_0224_shield = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0224_shield)
local TREE_CHOP_RADIUS = 80
local function ChopTreeAtCursor(self, item)
	local position = item:GetCursorPosition()
	if not position then
		return
	end
	local caster = item:GetCaster()
	local treesBefore = Entities:FindAllByClassnameWithin("ent_dota_tree", position, TREE_CHOP_RADIUS)
	GridNav:DestroyTreesAroundPoint(position, TREE_CHOP_RADIUS, false)
	if not IsServer() or not caster or not IsValid(nil, caster) then
		return
	end
	local treeCount = #treesBefore
	if treeCount <= 0 then
		return
	end
	MyGameEvent:FireEvent("OnTreeDestroyed_CS", {
		caster = caster,
		item_name = item:GetName(),
		tree_count = treeCount,
		position = position,
	}, { scope = "global" })
end
local item_0119 = __TS__Class()
item_0119.name = "item_0119"
__TS__ClassExtends(item_0119, BaseItem_CS)
function item_0119.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE, castAnimation = ACT_DOTA_ATTACK }
end
function item_0119.prototype.GetCastRange(self, location, target)
	return 250
end
function item_0119.prototype.GetAOERadius(self)
	return TREE_CHOP_RADIUS
end
function item_0119.prototype.OnSpellStart(self)
	ChopTreeAtCursor(nil, self)
end
item_0119 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0119)
local item_0106 = __TS__Class()
item_0106.name = "item_0106"
__TS__ClassExtends(item_0106, item_0119)
function item_0106.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE,
		castAnimation = ACT_DOTA_ATTACK,
	}
end
function item_0106.prototype.GetCastRange(self, location, target)
	return 250
end
function item_0106.prototype.GetAOERadius(self)
	return TREE_CHOP_RADIUS
end
function item_0106.prototype.OnSpellStart(self)
	ChopTreeAtCursor(nil, self)
end
item_0106 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0106)
local item_0123 = __TS__Class()
item_0123.name = "item_0123"
__TS__ClassExtends(item_0123, BaseItem_CS)
function item_0123.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0123.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_mana_restore = self:GetSpecialValueFor("ability_mana_restore")
	if ability_mana_restore <= 0 then
		return
	end
	caster:GiveMana(ability_mana_restore)
	local effect = MyGameHeroParticleManager:CreateParticle(
		"particles/items3_fx/mango_active.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(effect)
	caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
end
item_0123 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0123)
local ITEM_0124_DEBUFF_DURATION = 5
local ITEM_0124_ARMOR_REDUCTION = -2
local item_0124 = __TS__Class()
item_0124.name = "item_0124"
__TS__ClassExtends(item_0124, BaseItem_CS)
function item_0124.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0124"
end
item_0124 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0124)
local modifier_item_0124 = __TS__Class()
modifier_item_0124.name = "modifier_item_0124"
__TS__ClassExtends(modifier_item_0124, BaseModifier_CS)
function modifier_item_0124.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0124.prototype.IsHidden(self)
	return true
end
function modifier_item_0124.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	modifier_item_0124_broken_armor:applys(
		target,
		event.attacker,
		self:GetAbility(),
		{ duration = ITEM_0124_DEBUFF_DURATION }
	)
end
modifier_item_0124 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0124)
modifier_item_0124_broken_armor = __TS__Class()
modifier_item_0124_broken_armor.name = "modifier_item_0124_broken_armor"
__TS__ClassExtends(modifier_item_0124_broken_armor, BaseModifier_CS)
function modifier_item_0124_broken_armor.prototype.GetAttributeBonus(self)
	return { bonus_armor = ITEM_0124_ARMOR_REDUCTION }
end
function modifier_item_0124_broken_armor.prototype.IsDebuff(self)
	return true
end
function modifier_item_0124_broken_armor.prototype.IsHidden(self)
	return true
end
modifier_item_0124_broken_armor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0124_broken_armor)
local item_0234 = __TS__Class()
item_0234.name = "item_0234"
__TS__ClassExtends(item_0234, BaseItem_CS)
function item_0234.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0234"
end
item_0234 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0234)
local modifier_item_0234 = __TS__Class()
modifier_item_0234.name = "modifier_item_0234"
__TS__ClassExtends(modifier_item_0234, BaseModifier_CS)
function modifier_item_0234.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0234.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	local ability_agility_damage_pct = ability:GetSpecialValueFor("ability_agility_damage_pct")
	local agility = MyGameAttribute:GetAttribute(event.attacker, "total_agility") or 0
	local damage = agility * (ability_agility_damage_pct / 100)
	if damage > 0 then
		Damage:ApplyDamage({
			victim = target,
			attacker = event.attacker,
			damage = damage,
			damage_type = 1,
			ability = ability,
		})
	end
	modifier_item_0234_broken_armor:applys(
		target,
		event.attacker,
		ability,
		{ duration = ability:GetSpecialValueFor("ability_duration") }
	)
end
function modifier_item_0234.prototype.IsDebuff(self)
	return true
end
function modifier_item_0234.prototype.IsHidden(self)
	return true
end
modifier_item_0234 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0234)
modifier_item_0234_broken_armor = __TS__Class()
modifier_item_0234_broken_armor.name = "modifier_item_0234_broken_armor"
__TS__ClassExtends(modifier_item_0234_broken_armor, BaseModifier_CS)
function modifier_item_0234_broken_armor.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return { bonus_armor = -math.abs(ability:GetSpecialValueFor("ability_armor_reduce")) }
end
function modifier_item_0234_broken_armor.prototype.IsDebuff(self)
	return true
end
function modifier_item_0234_broken_armor.prototype.IsHidden(self)
	return true
end
modifier_item_0234_broken_armor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0234_broken_armor)
____exports.item_0300 = __TS__Class()
local item_0300 = ____exports.item_0300
item_0300.name = "item_0300"
__TS__ClassExtends(item_0300, BaseItem_CS)
function item_0300.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0300"
end
item_0300 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0300)
____exports.item_0300 = item_0300
local modifier_item_0300 = __TS__Class()
modifier_item_0300.name = "modifier_item_0300"
__TS__ClassExtends(modifier_item_0300, BaseModifier_CS)
function modifier_item_0300.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0300.prototype.GetMutexKey(self)
	return "item_0165_mutex"
end
function modifier_item_0300.prototype.GetMutexPriority(self)
	return 200
end
function modifier_item_0300.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	local ability_agility_damage_pct = ability:GetSpecialValueFor("ability_value_agility_damage_pct")
	local agility = MyGameAttribute:GetAttribute(event.attacker, "total_agility") or 0
	local damage = agility * (ability_agility_damage_pct / 100)
	if damage > 0 then
		Damage:ApplyDamage({
			victim = target,
			attacker = event.attacker,
			damage = damage,
			damage_type = 1,
			ability = ability,
		})
	end
	modifier_item_0300_broken_armor:applys(
		target,
		event.attacker,
		ability,
		{ duration = ability:GetSpecialValueFor("ability_duration") }
	)
end
function modifier_item_0300.prototype.IsDebuff(self)
	return true
end
function modifier_item_0300.prototype.IsHidden(self)
	return true
end
modifier_item_0300 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0300)
modifier_item_0300_broken_armor = __TS__Class()
modifier_item_0300_broken_armor.name = "modifier_item_0300_broken_armor"
__TS__ClassExtends(modifier_item_0300_broken_armor, BaseModifier_CS)
function modifier_item_0300_broken_armor.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return { bonus_armor = -math.abs(ability:GetSpecialValueFor("ability_armor_reduce")) }
end
function modifier_item_0300_broken_armor.prototype.IsDebuff(self)
	return true
end
function modifier_item_0300_broken_armor.prototype.IsHidden(self)
	return true
end
modifier_item_0300_broken_armor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0300_broken_armor)
local ITEM_0125_DEBUFF_DURATION = 5
local ITEM_0125_MOVE_SLOW_PCT = 15
local ITEM_0125_ATTACK_SLOW = -15
local item_0125 = __TS__Class()
item_0125.name = "item_0125"
__TS__ClassExtends(item_0125, BaseItem_CS)
function item_0125.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0125"
end
item_0125 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0125)
local modifier_item_0125 = __TS__Class()
modifier_item_0125.name = "modifier_item_0125"
__TS__ClassExtends(modifier_item_0125, BaseModifier_CS)
function modifier_item_0125.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0125.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	modifier_item_0125_frost:applys(target, event.attacker, self:GetAbility(), { duration = ITEM_0125_DEBUFF_DURATION })
end
modifier_item_0125 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0125)
modifier_item_0125_frost = __TS__Class()
modifier_item_0125_frost.name = "modifier_item_0125_frost"
__TS__ClassExtends(modifier_item_0125_frost, BaseModifier_CS)
function modifier_item_0125_frost.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -ITEM_0125_MOVE_SLOW_PCT, attack_speed = ITEM_0125_ATTACK_SLOW }
end
function modifier_item_0125_frost.prototype.IsDebuff(self)
	return true
end
function modifier_item_0125_frost.prototype.IsPurgable(self)
	return true
end
function modifier_item_0125_frost.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_slow.vpcf"
end
function modifier_item_0125_frost.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_item_0125_frost = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0125_frost)
local ITEM_0150_DEBUFF_DURATION = 5
local ITEM_0150_ARMOR_REDUCTION = -4
local ITEM_0150_MOVE_SLOW_PCT = 15
local item_0150 = __TS__Class()
item_0150.name = "item_0150"
__TS__ClassExtends(item_0150, BaseItem_CS)
function item_0150.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0150"
end
item_0150 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0150)
local modifier_item_0150 = __TS__Class()
modifier_item_0150.name = "modifier_item_0150"
__TS__ClassExtends(modifier_item_0150, BaseModifier_CS)
function modifier_item_0150.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0150.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	modifier_item_0150_corrosion:applys(
		target,
		event.attacker,
		self:GetAbility(),
		{ duration = ITEM_0150_DEBUFF_DURATION }
	)
end
modifier_item_0150 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0150)
modifier_item_0150_corrosion = __TS__Class()
modifier_item_0150_corrosion.name = "modifier_item_0150_corrosion"
__TS__ClassExtends(modifier_item_0150_corrosion, BaseModifier_CS)
function modifier_item_0150_corrosion.GetLocalizationCN(self)
	return { name = "腐蚀", description = "护甲降低，移动速度降低。" }
end
function modifier_item_0150_corrosion.prototype.GetAttributeBonus(self)
	return { bonus_armor = ITEM_0150_ARMOR_REDUCTION, bonus_movespeed_pct = -ITEM_0150_MOVE_SLOW_PCT }
end
function modifier_item_0150_corrosion.prototype.IsDebuff(self)
	return true
end
function modifier_item_0150_corrosion.prototype.IsPurgable(self)
	return true
end
modifier_item_0150_corrosion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0150_corrosion)
local item_0121 = __TS__Class()
item_0121.name = "item_0121"
__TS__ClassExtends(item_0121, BaseItem_CS)
function item_0121.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0121"
end
item_0121 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0121)
local item_0210 = __TS__Class()
item_0210.name = "item_0210"
__TS__ClassExtends(item_0210, item_0121)
item_0210 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0210)
local modifier_item_0121 = __TS__Class()
modifier_item_0121.name = "modifier_item_0121"
__TS__ClassExtends(modifier_item_0121, BaseModifier_CS)
function modifier_item_0121.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0121.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local ability_bonus_max_health_pct = ability:GetSpecialValueFor("ability_bonus_max_health_pct")
	local maxHp = MyGameAttribute:GetAttribute(event.attacker, "total_health") or 0
	local bonus = maxHp * (ability_bonus_max_health_pct / 100)
	if bonus <= 0 then
		return
	end
	self:PlayEffects1(event.target)
	Damage:ApplyDamage({
		victim = target,
		attacker = event.attacker,
		damage = bonus,
		damage_type = 1,
		ability = ability,
	})
	local lv = math.max(0, ability:GetLevel() - 1)
	local cd = ability:GetCooldown(lv)
	ability:StartCooldown(cd)
end
function modifier_item_0121.prototype.PlayEffects1(self, target)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn("Hero_Lion.ImpaleHitTarget", target)
end
modifier_item_0121 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0121)
local item_0166 = __TS__Class()
item_0166.name = "item_0166"
__TS__ClassExtends(item_0166, BaseItem_CS)
function item_0166.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0166"
end
item_0166 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0166)
local modifier_item_0166 = __TS__Class()
modifier_item_0166.name = "modifier_item_0166"
__TS__ClassExtends(modifier_item_0166, BaseModifier_CS)
function modifier_item_0166.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0166.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not ability:IsCooldownReady() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	AddDeBuffStatus(
		nil,
		target,
		event.attacker,
		ability,
		DebuffStatusType.POISON,
		{ stack = 1, effect_name = "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf" }
	)
	local lv = math.max(0, ability:GetLevel() - 1)
	local cd = ability:GetCooldown(lv)
	ability:StartCooldown(cd)
end
modifier_item_0166 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0166)
local item_0152 = __TS__Class()
item_0152.name = "item_0152"
__TS__ClassExtends(item_0152, BaseItem_CS)
function item_0152.prototype.GetPhaseDurationValue(self)
	return self:GetSpecialValueFor("ability_phase_duration")
end
function item_0152.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0152.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:AddNewModifier(caster, self, "modifier_item_0152_phase", { duration = self:GetPhaseDurationValue() })
	caster:EmitSound("DOTA_Item.PhaseBoots.Activate")
end
item_0152 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0152)
local modifier_item_0152_phase = __TS__Class()
modifier_item_0152_phase.name = "modifier_item_0152_phase"
__TS__ClassExtends(modifier_item_0152_phase, BaseModifier_CS)
function modifier_item_0152_phase.GetLocalizationCN(self)
	return { name = "相位", description = "移动速度提高，并获得相位状态。" }
end
function modifier_item_0152_phase.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local particle = ParticleManager:CreateParticle("particles/item/item_0152.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_item_0152_phase.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_21
	if ability then
		____ability_21 = ability:GetSpecialValueFor("ability_phase_ms_pct")
	else
		____ability_21 = 0
	end
	local phaseMsPct = ____ability_21
	local ____ability_22
	if ability then
		____ability_22 = ability:GetSpecialValueFor("ability_evasion_pct")
	else
		____ability_22 = 0
	end
	local evasionPct = ____ability_22
	return { bonus_movespeed_pct = phaseMsPct, evasion_pct = evasionPct }
end
function modifier_item_0152_phase.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_item_0152_phase.prototype.IsHidden(self)
	return false
end
function modifier_item_0152_phase.prototype.IsDebuff(self)
	return false
end
modifier_item_0152_phase = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0152_phase)
local item_0155 = __TS__Class()
item_0155.name = "item_0155"
__TS__ClassExtends(item_0155, BaseItem_CS)
function item_0155.prototype.GetDurationValue(self)
	return self:GetSpecialValueFor("ability_duration")
end
function item_0155.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0155.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:AddNewModifier(caster, self, "modifier_item_0155_madness", { duration = self:GetDurationValue() })
	caster:EmitSound("DOTA_Item.MaskOfMadness.Activate")
end
item_0155 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0155)
local modifier_item_0155_madness = __TS__Class()
modifier_item_0155_madness.name = "modifier_item_0155_madness"
__TS__ClassExtends(modifier_item_0155_madness, BaseModifier_CS)
function modifier_item_0155_madness.GetLocalizationCN(self)
	return { name = "疯狂", description = "攻击速度和移动速度提高，护甲降低，并被沉默。" }
end
function modifier_item_0155_madness.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_item_0155_madness.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_23
	if ability then
		____ability_23 = ability:GetSpecialValueFor("ability_bonus_attack_speed")
	else
		____ability_23 = 0
	end
	local bonusAttackSpeed = ____ability_23
	local ____ability_24
	if ability then
		____ability_24 = ability:GetSpecialValueFor("ability_bonus_move_speed")
	else
		____ability_24 = 0
	end
	local bonusMoveSpeed = ____ability_24
	local ____ability_25
	if ability then
		____ability_25 = ability:GetSpecialValueFor("ability_armor_reduction")
	else
		____ability_25 = 0
	end
	local armorReduction = ____ability_25
	return { attack_speed = bonusAttackSpeed, base_movespeed = bonusMoveSpeed, bonus_armor = -armorReduction }
end
function modifier_item_0155_madness.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
end
function modifier_item_0155_madness.prototype.IsPurgable(self)
	return true
end
function modifier_item_0155_madness.prototype.IsHidden(self)
	return false
end
function modifier_item_0155_madness.prototype.IsDebuff(self)
	return false
end
modifier_item_0155_madness = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0155_madness)
local item_0145 = __TS__Class()
item_0145.name = "item_0145"
__TS__ClassExtends(item_0145, BaseItem_CS)
function item_0145.prototype.GetDurationValue(self)
	return self:GetSpecialValueFor("ability_duration")
end
function item_0145.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0145.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:AddNewModifier(caster, self, "modifier_item_0145_ghost", { duration = self:GetDurationValue() })
	caster:EmitSound("DOTA_Item.GhostScepter.Activate")
end
item_0145 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0145)
local modifier_item_0145_ghost = __TS__Class()
modifier_item_0145_ghost.name = "modifier_item_0145_ghost"
__TS__ClassExtends(modifier_item_0145_ghost, BaseModifier_CS)
function modifier_item_0145_ghost.GetLocalizationCN(self)
	return {
		name = "幽魂",
		description = "处于虚无状态，免疫物理伤害，无法攻击，并额外承受魔法伤害。",
	}
end
function modifier_item_0145_ghost.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0145_ghost.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	if event.ctx.spec.damage_type ~= 1 then
		return
	end
	event.prevent_apply = true
end
function modifier_item_0145_ghost.prototype.GetAttributeBonus(self)
	return { incoming_magical_damage_increase_pct = self:GetAbility():GetSpecialValueFor("ability_magical_pct") }
end
function modifier_item_0145_ghost.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
function modifier_item_0145_ghost.prototype.IsHidden(self)
	return false
end
function modifier_item_0145_ghost.prototype.IsDebuff(self)
	return false
end
function modifier_item_0145_ghost.prototype.IsPurgable(self)
	return true
end
function modifier_item_0145_ghost.prototype.GetEffectName(self)
	return "particles/items_fx/ghost.vpcf"
end
function modifier_item_0145_ghost.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_ghost.vpcf"
end
function modifier_item_0145_ghost.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_item_0145_ghost.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_item_0145_ghost = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0145_ghost)
local item_0149 = __TS__Class()
item_0149.name = "item_0149"
__TS__ClassExtends(item_0149, BaseItem_CS)
function item_0149.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0149"
end
function item_0149.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
item_0149 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0149)
local modifier_item_0149 = __TS__Class()
modifier_item_0149.name = "modifier_item_0149"
__TS__ClassExtends(modifier_item_0149, BaseModifier_CS)
function modifier_item_0149.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_HEALTH_COST }
end
function modifier_item_0149.prototype.IsHidden(self)
	return true
end
function modifier_item_0149.prototype.IsPurgable(self)
	return false
end
function modifier_item_0149.prototype.OnHealthCost_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if event.unit ~= parent then
		return
	end
	if event.attacker ~= parent then
		return
	end
	if event.ability ~= ability then
		return
	end
	local actualCost = math.max(0, math.floor(event.actual_cost or 0))
	if actualCost <= 0 then
		return
	end
	local bonusMana = math.floor(actualCost * 0.1)
	if bonusMana <= 0 then
		return
	end
	parent:AddNewModifier(parent, ability, "modifier_item_0149_sacrifice", { duration = 12, bonus_mana = bonusMana })
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items2_fx/soul_ring.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(3, 0, 0))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	parent:EmitSound("DOTA_Item.SoulRing.Activate")
end
modifier_item_0149 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0149)
local modifier_item_0149_sacrifice = __TS__Class()
modifier_item_0149_sacrifice.name = "modifier_item_0149_sacrifice"
__TS__ClassExtends(modifier_item_0149_sacrifice, BaseModifier_CS)
function modifier_item_0149_sacrifice.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.bonusMana = 0
end
function modifier_item_0149_sacrifice.GetLocalizationCN(self)
	return { name = "献祭", description = "最大法力值提升。" }
end
function modifier_item_0149_sacrifice.prototype.OnCreated(self, params)
	self:UpdateBonusMana(params)
end
function modifier_item_0149_sacrifice.prototype.OnRefresh(self, params)
	self:UpdateBonusMana(params)
end
function modifier_item_0149_sacrifice.prototype.GetAttributeBonus(self)
	return { bonus_mana = self.bonusMana }
end
function modifier_item_0149_sacrifice.prototype.IsHidden(self)
	return false
end
function modifier_item_0149_sacrifice.prototype.IsDebuff(self)
	return false
end
function modifier_item_0149_sacrifice.prototype.IsPurgable(self)
	return true
end
function modifier_item_0149_sacrifice.prototype.GetTexture(self)
	return "item_soul_ring"
end
function modifier_item_0149_sacrifice.prototype.UpdateBonusMana(self, params)
	self.bonusMana = math.max(0, math.floor(params.bonus_mana or 0))
	self:RefreshAttributes()
end
modifier_item_0149_sacrifice = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0149_sacrifice)
____exports.item_0238 = __TS__Class()
local item_0238 = ____exports.item_0238
item_0238.name = "item_0238"
__TS__ClassExtends(item_0238, BaseItem_CS)
function item_0238.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0238"
end
item_0238 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0238)
____exports.item_0238 = item_0238
local modifier_item_0238 = __TS__Class()
modifier_item_0238.name = "modifier_item_0238"
__TS__ClassExtends(modifier_item_0238, BaseModifier_CS)
function modifier_item_0238.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0238.prototype.IsHidden(self)
	return true
end
function modifier_item_0238.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	local attacker = event.attacker
	if not IsValidAlive(nil, attacker) or attacker:IsBuilding() then
		return
	end
	if attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	AddDeBuffStatus(
		nil,
		attacker,
		self:GetParent(),
		ability,
		DebuffStatusType.POISON,
		{ stack = 1, effect_name = "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf" }
	)
end
function modifier_item_0238.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local poisonChancePct = ability:GetSpecialValueFor("ability_value_poison_chance_pct")
	if poisonChancePct <= 0 or not RollPercentage(poisonChancePct) then
		return
	end
	AddDeBuffStatus(
		nil,
		target,
		event.attacker,
		ability,
		DebuffStatusType.POISON,
		{ stack = 1, effect_name = "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf" }
	)
end
modifier_item_0238 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0238)
local item_0206 = __TS__Class()
item_0206.name = "item_0206"
__TS__ClassExtends(item_0206, BaseItem_CS)
function item_0206.prototype.GetIntrinsicModifierName(self)
	return "item_0206_modifier"
end
item_0206 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0206)
local item_0206_modifier = __TS__Class()
item_0206_modifier.name = "item_0206_modifier"
__TS__ClassExtends(item_0206_modifier, modifier_item_shatter_base)
function item_0206_modifier.prototype.GetDebuffModifierName(self)
	return "modifier_item_0206_debuff"
end
item_0206_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_0206_modifier)
local modifier_item_0206_debuff = __TS__Class()
modifier_item_0206_debuff.name = "modifier_item_0206_debuff"
__TS__ClassExtends(modifier_item_0206_debuff, modifier_item_shatter_debuff_base)
modifier_item_0206_debuff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0206_debuff)
local item_0187 = __TS__Class()
item_0187.name = "item_0187"
__TS__ClassExtends(item_0187, BaseItem_CS)
function item_0187.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0187"
end
item_0187 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0187)
local modifier_item_0187 = __TS__Class()
modifier_item_0187.name = "modifier_item_0187"
__TS__ClassExtends(modifier_item_0187, BaseModifier_CS)
function modifier_item_0187.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0187.prototype.IsHidden(self)
	return true
end
function modifier_item_0187.prototype.GetMutexKey(self)
	return "shi_po"
end
function modifier_item_0187.prototype.GetMutexPriority(self)
	return 100
end
function modifier_item_0187.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local attacker = self:GetParent()
	if event.attacker ~= attacker then
		return
	end
	local ability = self:GetAbility()
	if not ability or not ability:IsCooldownReady() then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == attacker:GetTeamNumber() then
		return
	end
	local ability_trigger_chance_pct = ability:GetSpecialValueFor("ability_trigger_chance_pct")
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	local ability_reduce_cooldown_sec = math.max(0, ability:GetSpecialValueFor("ability_reduce_cooldown_sec"))
	if ability_reduce_cooldown_sec <= 0 then
		return
	end
	local qAbility = attacker:GetAbilityByIndex(modifier_item_0187.Q_ABILITY_INDEX)
	if not qAbility or qAbility == ability then
		return
	end
	local cooldownRemaining = qAbility:GetCooldownTimeRemaining()
	if cooldownRemaining <= 0 then
		return
	end
	qAbility:EndCooldown()
	local nextCooldown = math.max(0, cooldownRemaining - ability_reduce_cooldown_sec)
	if nextCooldown > 0 then
		qAbility:StartCooldown(nextCooldown)
	end
	self:StartTriggerCooldown(ability)
end
function modifier_item_0187.prototype.StartTriggerCooldown(self, ability)
	local ability_trigger_cooldown = math.max(0, ability:GetSpecialValueFor("ability_trigger_cooldown"))
	if ability_trigger_cooldown > 0 then
		ability:StartCooldown(ability_trigger_cooldown)
		return
	end
	local level = math.max(0, ability:GetLevel() - 1)
	local cooldown = ability:GetCooldown(level)
	if cooldown > 0 then
		ability:StartCooldown(cooldown)
	end
end
modifier_item_0187.Q_ABILITY_INDEX = 0
modifier_item_0187 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0187)
local ITEM_0298_MAX_DAMAGE_REDUCTION_PCT = 25
local ITEM_0298_RECALCULATE_INTERVAL = 0.2
local item_0298 = __TS__Class()
item_0298.name = "item_0298"
__TS__ClassExtends(item_0298, BaseItem_CS)
function item_0298.prototype.GetIntrinsicModifierName(self)
	return modifier_item_0298_mire_shield.name
end
item_0298 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0298)
modifier_item_0298_mire_shield = __TS__Class()
modifier_item_0298_mire_shield.name = "modifier_item_0298_mire_shield"
__TS__ClassExtends(modifier_item_0298_mire_shield, BaseModifier_CS)
function modifier_item_0298_mire_shield.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.currentDamageReductionPct = 0
end
function modifier_item_0298_mire_shield.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:UpdateDamageReduction(true)
	self:StartIntervalThink(ITEM_0298_RECALCULATE_INTERVAL)
end
function modifier_item_0298_mire_shield.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:UpdateDamageReduction(false)
end
function modifier_item_0298_mire_shield.prototype.IsHidden(self)
	return false
end
function modifier_item_0298_mire_shield.prototype.IsPurgable(self)
	return false
end
function modifier_item_0298_mire_shield.prototype.GetTexture(self)
	return "item_icon_27"
end
function modifier_item_0298_mire_shield.prototype.GetAttributeBonus(self)
	return { damage_reduction_pct = self.currentDamageReductionPct }
end
function modifier_item_0298_mire_shield.prototype.UpdateDamageReduction(self, forceRefresh)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local damageReductionPct = MyGameAttribute:GetAttribute(parent, "bonus_movespeed_pct") or 0
	if self:GetStackCount() == -damageReductionPct then
		return
	end
	if damageReductionPct < 0 then
		self.currentDamageReductionPct = math.min(-damageReductionPct, ITEM_0298_MAX_DAMAGE_REDUCTION_PCT)
	end
	self:SetStackCount(-damageReductionPct)
	self:RefreshAttributes()
end
modifier_item_0298_mire_shield = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0298_mire_shield)
return ____exports
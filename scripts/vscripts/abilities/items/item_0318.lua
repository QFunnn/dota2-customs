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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ITEM_0318_FIREBALL_DAMAGE_MULTIPLIER = 1
local ITEM_0318_FIREBALL_INTERNAL_COOLDOWN = 0.1
local ITEM_0318_FIREBALL_SEARCH_RADIUS = 1000
local ITEM_0318_FIREBALL_PROJECTILE_SPEED = 1200
local ITEM_0318_GLIMMER_INITIAL_PARTICLE = "particles/items3_fx/glimmer_cape_initial.vpcf"
local ITEM_0318_GLIMMER_FLASH_PARTICLE = "particles/items3_fx/glimmer_cape_initial_flash.vpcf"
local ITEM_0318_FIREBALL_PARTICLE = "particles/items_fx/phylactery.vpcf"
____exports.item_0318 = __TS__Class()
local item_0318 = ____exports.item_0318
item_0318.name = "item_0318"
__TS__ClassExtends(item_0318, BaseItem_CS)
function item_0318.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_0318_GLIMMER_INITIAL_PARTICLE, context)
	PrecacheResource("particle", ITEM_0318_GLIMMER_FLASH_PARTICLE, context)
	PrecacheResource("particle", ITEM_0318_FIREBALL_PARTICLE, context)
end
function item_0318.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0318.name
end
function item_0318.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0318.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local fadeDuration = self:GetSpecialValueFor("ability_initial_fade_delay")
	local invisDuration = self:GetSpecialValueFor("ability_duration")
	____exports.modifier_item_0318_glimmer:applys(
		caster,
		caster,
		self,
		{ duration = fadeDuration + invisDuration, fade_duration = fadeDuration }
	)
	caster:AddNewModifier(caster, self, "modifier_cs_damage_reduction", { duration = 0.3, damage_reduction_pct = 80 })
	caster:EmitSound("Item.GlimmerCape.Activate")
end
item_0318 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0318)
____exports.item_0318 = item_0318
____exports.modifier_item_0318 = __TS__Class()
local modifier_item_0318 = ____exports.modifier_item_0318
modifier_item_0318.name = "modifier_item_0318"
__TS__ClassExtends(modifier_item_0318, BaseModifier_CS)
function modifier_item_0318.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.nextTriggerTime = 0
end
function modifier_item_0318.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0318.prototype.IsHidden(self)
	return true
end
function modifier_item_0318.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	if GameRules:GetGameTime() < self.nextTriggerTime then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_0 = castAbility.IsItem
	if ____opt_0 and ____opt_0(castAbility) then
		return
	end
	local ____opt_2 = castAbility.IsToggle
	if ____opt_2 and ____opt_2(castAbility) then
		return
	end
	local target = self:FindFireballTarget(parent)
	if not target then
		return
	end
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	local damage = intelligence * ITEM_0318_FIREBALL_DAMAGE_MULTIPLIER
	if damage <= 0 then
		return
	end
	self.nextTriggerTime = GameRules:GetGameTime() + ITEM_0318_FIREBALL_INTERNAL_COOLDOWN
	self:LaunchFireball(parent, ability, target, damage)
end
function modifier_item_0318.prototype.FindFireballTarget(self, parent)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ITEM_0318_FIREBALL_SEARCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue22
			end
			return enemy
		end
		::__continue22::
	end
	return nil
end
function modifier_item_0318.prototype.LaunchFireball(self, caster, ability, target, damage)
	local startPoint = self:GetProjectileLaunchOrigin(caster)
	caster:EmitSound("Item.Phylactery.Target")
	CreateProjectile(nil, {
		caster = caster,
		ability = ability,
		effect_name = ITEM_0318_FIREBALL_PARTICLE,
		target = target,
		start_point = startPoint,
		projectile_type = "tracking",
		projectile_speed = ITEM_0318_FIREBALL_PROJECTILE_SPEED,
		on_hit = function(____, hitTarget)
			if not IsServer() then
				return true
			end
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, hitTarget) or hitTarget:IsBuilding() then
				return true
			end
			if hitTarget:GetTeamNumber() == caster:GetTeamNumber() then
				return true
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = hitTarget,
				damage = damage,
				damage_type = 2,
				ability = ability,
			})
			EmitSoundOn("Item.Phylactery.Target", hitTarget)
			return true
		end,
	})
end
function modifier_item_0318.prototype.GetProjectileLaunchOrigin(self, caster)
	local attach = caster:ScriptLookupAttachment("attach_hitloc")
	if attach > 0 then
		return caster:GetAttachmentOrigin(attach)
	end
	return caster:GetAbsOrigin()
end
modifier_item_0318 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0318)
____exports.modifier_item_0318 = modifier_item_0318
____exports.modifier_item_0318_glimmer = __TS__Class()
local modifier_item_0318_glimmer = ____exports.modifier_item_0318_glimmer
modifier_item_0318_glimmer.name = "modifier_item_0318_glimmer"
__TS__ClassExtends(modifier_item_0318_glimmer, BaseModifier_CS)
function modifier_item_0318_glimmer.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.fadeDuration = 0
	self.fadeStartTime = 0
	self.nextInvisTime = 0
end
function modifier_item_0318_glimmer.prototype.OnCreated(self, params)
	self.fadeDuration = params.fade_duration or 0
	self:RestartFade()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local initialParticle =
		ParticleManager:CreateParticle(ITEM_0318_GLIMMER_INITIAL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(initialParticle, 0, parent:GetAbsOrigin())
	self:AddParticle(initialParticle, false, false, -1, false, false)
	local flashParticle =
		ParticleManager:CreateParticle(ITEM_0318_GLIMMER_FLASH_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(flashParticle, 0, parent:GetAbsOrigin())
	self:AddParticle(flashParticle, false, false, -1, false, false)
end
function modifier_item_0318_glimmer.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_START, BusinessEvents.ON_ABILITY_START }
end
function modifier_item_0318_glimmer.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
function modifier_item_0318_glimmer.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = 25, damage_reduction_pct = 40 }
end
function modifier_item_0318_glimmer.prototype.CheckState(self)
	local ____MODIFIER_STATE_INVISIBLE_5 = MODIFIER_STATE_INVISIBLE
	local ____table_IsInvisibleActive_result_4
	if self:IsInvisibleActive() then
		____table_IsInvisibleActive_result_4 = true
	else
		____table_IsInvisibleActive_result_4 = nil
	end
	return { [____MODIFIER_STATE_INVISIBLE_5] = ____table_IsInvisibleActive_result_4 }
end
function modifier_item_0318_glimmer.prototype.IsHidden(self)
	return false
end
function modifier_item_0318_glimmer.prototype.IsDebuff(self)
	return false
end
function modifier_item_0318_glimmer.prototype.IsPurgable(self)
	return true
end
function modifier_item_0318_glimmer.prototype.GetTexture(self)
	return "item_glimmer_cape"
end
function modifier_item_0318_glimmer.prototype.OnAttackStart_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	self:RestartFade()
end
function modifier_item_0318_glimmer.prototype.OnAbilityStart_CS(self, event)
	if not IsServer() then
		return
	end
	if event.caster ~= self:GetParent():entindex() then
		return
	end
	self.fadeStartTime = GameRules:GetGameTime()
	self.nextInvisTime = math.huge
end
function modifier_item_0318_glimmer.prototype.GetModifierInvisibilityLevel(self)
	return self:IsInvisibleActive() and 1 or 0
end
function modifier_item_0318_glimmer.prototype.RestartFade(self)
	local now = GameRules:GetGameTime()
	self.fadeStartTime = now
	self.nextInvisTime = now + self.fadeDuration
end
function modifier_item_0318_glimmer.prototype.IsInvisibleActive(self)
	return GameRules:GetGameTime() >= self.nextInvisTime
end
modifier_item_0318_glimmer = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0318_glimmer)
____exports.modifier_item_0318_glimmer = modifier_item_0318_glimmer
return ____exports
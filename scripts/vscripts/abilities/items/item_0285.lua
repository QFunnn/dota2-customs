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
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ObjectValues = ____lualib.__TS__ObjectValues
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ability_item_0285_reflect_trigger_effect = "particles/items3_fx/lotus_orb_reflect.vpcf"
local ability_item_0285_reflect_projectile_effect = "particles/units/heroes/hero_oracle/oracle_base_attack.vpcf"
local ability_item_0285_reflect_sound = "Item.LotusOrb.Activate"
local ITEM_0285_MERGE_WINDOW = 0.5
____exports.item_0285 = __TS__Class()
local item_0285 = ____exports.item_0285
item_0285.name = "item_0285"
__TS__ClassExtends(item_0285, BaseItem_CS)
function item_0285.prototype.Precache(self, context)
	PrecacheResource("particle", ability_item_0285_reflect_trigger_effect, context)
	PrecacheResource("particle", ability_item_0285_reflect_projectile_effect, context)
end
function item_0285.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0285_curse_conduction.name
end
item_0285 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0285)
____exports.item_0285 = item_0285
____exports.modifier_item_0285_curse_conduction = __TS__Class()
local modifier_item_0285_curse_conduction = ____exports.modifier_item_0285_curse_conduction
modifier_item_0285_curse_conduction.name = "modifier_item_0285_curse_conduction"
__TS__ClassExtends(modifier_item_0285_curse_conduction, BaseModifier_CS)
function modifier_item_0285_curse_conduction.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.reflectPending = false
end
function modifier_item_0285_curse_conduction.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEBUFF_STATUS_APPLIED }
end
function modifier_item_0285_curse_conduction.prototype.IsHidden(self)
	return true
end
function modifier_item_0285_curse_conduction.prototype.OnDebuffStatusApplied_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.target ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if ability:IsCooldownReady() == false then
		return
	end
	if self.reflectPending then
		return
	end
	self.reflectPending = true
	local interval = math.max(0.1, ability:GetSpecialValueFor("ability_interval"))
	ability:StartCooldown(interval)
	Timers:CreateTimer(ITEM_0285_MERGE_WINDOW, function()
		self.reflectPending = false
		if not IsValid(nil, self) or self:IsNull() then
			return
		end
		if not IsValidAlive(nil, parent) then
			return
		end
		local radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
		local target = self:FindNearestEnemy(radius)
		if not IsValidAlive(nil, target) then
			return
		end
		local snapshots = self:CollectAndRemoveOwnDebuffsForTransfer()
		if #snapshots <= 0 then
			return
		end
		self:PlayEffects1(parent)
		self:LaunchReflectProjectile(parent, target, snapshots)
	end)
end
function modifier_item_0285_curse_conduction.prototype.FindNearestEnemy(self, radius)
	local parent = self:GetParent()
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	return __TS__ArrayFind(enemies, function(____, enemy)
		return IsValidAlive(nil, enemy) and not enemy:IsBuilding()
	end)
end
function modifier_item_0285_curse_conduction.prototype.CollectAndRemoveOwnDebuffsForTransfer(self)
	local parent = self:GetParent()
	local supportedStatuses = self:GetSupportedDebuffStatuses()
	local snapshots = {}
	for ____, status in ipairs(supportedStatuses) do
		do
			local modifierName = self:GetModifierNameByStatus(status)
			if not modifierName then
				goto __continue20
			end
			local modifiers = __TS__ArrayFilter(parent:FindAllModifiers() or {}, function(____, modifier)
				return modifier:GetName() == modifierName
			end)
			for ____, modifier in ipairs(modifiers) do
				do
					if not modifier.IsDebuff or not modifier:IsDebuff() then
						goto __continue23
					end
					local snapshot = self:CreateSnapshot(status, modifier)
					if not snapshot then
						goto __continue23
					end
					snapshots[#snapshots + 1] = snapshot
					modifier:Destroy()
				end
				::__continue23::
			end
		end
		::__continue20::
	end
	return snapshots
end
function modifier_item_0285_curse_conduction.prototype.GetSupportedDebuffStatuses(self)
	return __TS__ArrayFilter(__TS__ObjectValues(DebuffStatusType), function(____, value)
		return type(value) == "number"
	end)
end
function modifier_item_0285_curse_conduction.prototype.GetModifierNameByStatus(self, status)
	repeat
		local ____switch31 = status
		local ____cond31 = ____switch31 == DebuffStatusType.ICE_SLOW
		if ____cond31 then
			return "modifier_generic_slow"
		end
		____cond31 = ____cond31 or ____switch31 == DebuffStatusType.STUN
		if ____cond31 then
			return "modifier_generic_stunned"
		end
		____cond31 = ____cond31 or ____switch31 == DebuffStatusType.BLEED
		if ____cond31 then
			return "modifier_generic_bleed"
		end
		____cond31 = ____cond31 or ____switch31 == DebuffStatusType.POISON
		if ____cond31 then
			return "modifier_generic_poison"
		end
		____cond31 = ____cond31 or ____switch31 == DebuffStatusType.BURN
		if ____cond31 then
			return "modifier_generic_burning"
		end
		____cond31 = ____cond31 or ____switch31 == DebuffStatusType.VULNERABLE
		if ____cond31 then
			return "modifier_generic_vulnerable"
		end
		do
			return nil
		end
	until true
end
function modifier_item_0285_curse_conduction.prototype.CreateSnapshot(self, status, modifier)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return nil
	end
	local ____math_max_2 = math.max
	local ____this_1
	____this_1 = modifier
	local ____opt_0 = ____this_1.GetRemainingTime
	local duration = ____math_max_2(0.03, ____opt_0 and ____opt_0(____this_1) or 0)
	local stackCount = math.max(1, modifier:GetStackCount())
	if duration <= 0 then
		return nil
	end
	repeat
		local ____switch35 = status
		local ____cond35 = ____switch35 == DebuffStatusType.ICE_SLOW
		if ____cond35 then
			return { status = DebuffStatusType.ICE_SLOW, duration = duration, stackCount = stackCount }
		end
		____cond35 = ____cond35 or ____switch35 == DebuffStatusType.STUN
		if ____cond35 then
			return { status = DebuffStatusType.STUN, duration = duration }
		end
		____cond35 = ____cond35 or ____switch35 == DebuffStatusType.BLEED
		if ____cond35 then
			do
				local sourceFinalDamage = stackCount
				return {
					status = DebuffStatusType.BLEED,
					stackCount = stackCount,
					sourceFinalDamage = sourceFinalDamage,
				}
			end
		end
		____cond35 = ____cond35 or ____switch35 == DebuffStatusType.POISON
		if ____cond35 then
			return { status = DebuffStatusType.POISON, stackCount = stackCount }
		end
		____cond35 = ____cond35 or ____switch35 == DebuffStatusType.BURN
		if ____cond35 then
			return { status = DebuffStatusType.BURN, duration = duration }
		end
		____cond35 = ____cond35 or ____switch35 == DebuffStatusType.VULNERABLE
		if ____cond35 then
			return { status = DebuffStatusType.VULNERABLE, duration = duration, stackCount = stackCount }
		end
		do
			return nil
		end
	until true
end
function modifier_item_0285_curse_conduction.prototype.LaunchReflectProjectile(self, caster, target, snapshots)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local projectileSpeed = 1200
	CreateProjectile(nil, {
		projectile_type = "tracking",
		caster = caster,
		target = target,
		effect_name = ability_item_0285_reflect_projectile_effect,
		projectile_speed = projectileSpeed,
		ability = ability,
		on_hit = function(____, hitTarget, _location, _extra)
			if not IsServer() then
				return true
			end
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, hitTarget) or hitTarget:IsBuilding() then
				return true
			end
			if hitTarget:GetTeamNumber() == caster:GetTeamNumber() then
				return true
			end
			self:ReapplySnapshotsToTarget(caster, hitTarget, snapshots)
			self:PlayEffects2(hitTarget)
			return true
		end,
	})
end
function modifier_item_0285_curse_conduction.prototype.ReapplySnapshotsToTarget(self, caster, target, snapshots)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	for ____, snapshot in ipairs(snapshots) do
		repeat
			local ____switch46 = snapshot.status
			local ____cond46 = ____switch46 == DebuffStatusType.ICE_SLOW
			if ____cond46 then
				AddDeBuffStatus(
					nil,
					target,
					caster,
					ability,
					DebuffStatusType.ICE_SLOW,
					{ duration = snapshot.duration, stack = snapshot.stackCount }
				)
				break
			end
			____cond46 = ____cond46 or ____switch46 == DebuffStatusType.STUN
			if ____cond46 then
				AddDeBuffStatus(nil, target, caster, ability, DebuffStatusType.STUN, { duration = snapshot.duration })
				break
			end
			____cond46 = ____cond46 or ____switch46 == DebuffStatusType.BLEED
			if ____cond46 then
				AddDeBuffStatus(
					nil,
					target,
					caster,
					ability,
					DebuffStatusType.BLEED,
					{ source_final_damage = snapshot.sourceFinalDamage }
				)
				break
			end
			____cond46 = ____cond46 or ____switch46 == DebuffStatusType.POISON
			if ____cond46 then
				AddDeBuffStatus(nil, target, caster, ability, DebuffStatusType.POISON, { stack = snapshot.stackCount })
				break
			end
			____cond46 = ____cond46 or ____switch46 == DebuffStatusType.BURN
			if ____cond46 then
				AddDeBuffStatus(nil, target, caster, ability, DebuffStatusType.BURN, { duration = snapshot.duration })
				break
			end
			____cond46 = ____cond46 or ____switch46 == DebuffStatusType.VULNERABLE
			if ____cond46 then
				AddDeBuffStatus(
					nil,
					target,
					caster,
					ability,
					DebuffStatusType.VULNERABLE,
					{ duration = snapshot.duration, stack = snapshot.stackCount }
				)
				break
			end
		until true
	end
end
function modifier_item_0285_curse_conduction.prototype.PlayEffects1(self, caster)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		ability_item_0285_reflect_trigger_effect,
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	caster:EmitSound(ability_item_0285_reflect_sound)
end
function modifier_item_0285_curse_conduction.prototype.PlayEffects2(self, target)
	target:EmitSound("Hero_Visage.SoulAssumption.Target")
end
modifier_item_0285_curse_conduction =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0285_curse_conduction)
____exports.modifier_item_0285_curse_conduction = modifier_item_0285_curse_conduction
return ____exports
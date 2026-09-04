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
____exports.item_0221 = __TS__Class()
local item_0221 = ____exports.item_0221
item_0221.name = "item_0221"
__TS__ClassExtends(item_0221, BaseItem_CS)
function item_0221.prototype.GetCastRange(self, location, target)
	return self:GetSpecialValueFor("ability_cast_range")
end
function item_0221.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET,
		canCast = function(____, ____bindingPattern0)
			local target
			target = ____bindingPattern0.target
			if not target then
				return UF_FAIL_CUSTOM
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) or target:IsBuilding() then
				return UF_FAIL_CUSTOM
			end
			if target:GetTeamNumber() == caster:GetTeamNumber() then
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
			local caster = self:GetCaster()
			if target:GetTeamNumber() == caster:GetTeamNumber() then
				return "#dota_hud_error_unit_not_enemy"
			end
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) or target:IsBuilding() then
				return "#dota_hud_error_invalid_target"
			end
			return ""
		end,
	}
end
function item_0221.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == caster:GetTeamNumber() then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	if ability_duration <= 0 then
		return
	end
	target:AddNewModifier(caster, self, ____exports.modifier_item_0221_soul_rend.name, { duration = ability_duration })
	self:PlayEffects1(caster, target)
end
function item_0221.prototype.PlayEffects1(self, caster, target)
	caster:EmitSound("DOTA_Item.Bloodthorn.Activate")
	EmitSoundOn("DOTA_Item.Bloodthorn.Target", target)
end
item_0221 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0221)
____exports.item_0221 = item_0221
____exports.modifier_item_0221_soul_rend = __TS__Class()
local modifier_item_0221_soul_rend = ____exports.modifier_item_0221_soul_rend
modifier_item_0221_soul_rend.name = "modifier_item_0221_soul_rend"
__TS__ClassExtends(modifier_item_0221_soul_rend, BaseModifier_CS)
function modifier_item_0221_soul_rend.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.recordedDamage = 0
end
function modifier_item_0221_soul_rend.GetLocalizationCN(self)
	return { name = "灵魂剥离", description = "结束时结算期间受到的部分伤害。" }
end
function modifier_item_0221_soul_rend.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEAL_DAMAGE }
end
function modifier_item_0221_soul_rend.prototype.OnCreated(self)
	self.recordedDamage = 0
	if not IsServer() then
		return
	end
	self:PlayEffects2()
end
function modifier_item_0221_soul_rend.prototype.OnRefresh(self)
	self.recordedDamage = 0
	if not IsServer() then
		return
	end
	self:PlayEffects2()
end
function modifier_item_0221_soul_rend.prototype.OnDealDamage_CS(self, event)
	if not IsServer() then
		return
	end
	if event.victim ~= self:GetParent() then
		return
	end
	if event.attacker ~= self:GetCaster() then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	self.recordedDamage = self.recordedDamage + (event.final_damage or 0)
end
function modifier_item_0221_soul_rend.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, caster) or not IsValidAlive(nil, parent) then
		return
	end
	local ability_damage_pct = ability:GetSpecialValueFor("ability_damage_pct")
	local damage = self.recordedDamage * (ability_damage_pct / 100)
	if damage <= 0 then
		return
	end
	self:PlayEffects3(caster, parent)
	Damage:ApplyDamage({
		victim = parent,
		attacker = caster,
		damage = damage,
		damage_type = 2,
		ability = ability,
	})
end
function modifier_item_0221_soul_rend.prototype.IsDebuff(self)
	return true
end
function modifier_item_0221_soul_rend.prototype.IsPurgable(self)
	return true
end
function modifier_item_0221_soul_rend.prototype.GetTexture(self)
	return "item_bloodthorn"
end
function modifier_item_0221_soul_rend.prototype.GetEffectName(self)
	return "particles/items2_fx/bloodthorn.vpcf"
end
function modifier_item_0221_soul_rend.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_item_0221_soul_rend.prototype.PlayEffects2(self)
	local parent = self:GetParent()
	parent:EmitSound("DOTA_Item.Bloodthorn.Target")
end
function modifier_item_0221_soul_rend.prototype.PlayEffects3(self, caster, parent)
	EmitSoundOn("DOTA_Item.Bloodthorn.Damage", parent)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/cc/assass_hit_corea_2.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		caster
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
modifier_item_0221_soul_rend = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0221_soul_rend)
____exports.modifier_item_0221_soul_rend = modifier_item_0221_soul_rend
return ____exports
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
local ____due_set = require("shared.due_set")
local CountDueItems = ____due_set.CountDueItems
local THINK_INTERVAL = 0.5
--- 镜像 debuff 的补挂时长：略大于 tick，持续补挂即跟随、脱离范围自动过期。
local MIRROR_LINGER = 1
____exports.item_0580 = __TS__Class()
local item_0580 = ____exports.item_0580
item_0580.name = "item_0580"
__TS__ClassExtends(item_0580, BaseItem_CS)
function item_0580.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0580.name
end
item_0580 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0580)
____exports.item_0580 = item_0580
--- 固有被动「同渡」：汇总自身负面属性效果 → 缩放成镜像包 → 转嫁给周围敌人。
____exports.modifier_item_0580 = __TS__Class()
local modifier_item_0580 = ____exports.modifier_item_0580
modifier_item_0580.name = "modifier_item_0580"
__TS__ClassExtends(modifier_item_0580, BaseModifier_CS)
function modifier_item_0580.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.mirrorBundle = {}
	self.mirrorKeyCount = 0
end
function modifier_item_0580.GetLocalizationCN(self)
	return {
		name = "同渡",
		description = "自身承受的负面状态，其属性效果按比例同样施加给周围的敌人。",
	}
end
function modifier_item_0580.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0580.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0580.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:RebuildMirrorBundle()
	if self.mirrorKeyCount <= 0 then
		return
	end
	self:SpreadMirrors()
end
function modifier_item_0580.prototype.GetMirrorBundle(self)
	return self.mirrorBundle
end
function modifier_item_0580.prototype.IsHidden(self)
	return true
end
function modifier_item_0580.prototype.IsDebuff(self)
	return false
end
function modifier_item_0580.prototype.IsPurgable(self)
	return false
end
function modifier_item_0580.prototype.RebuildMirrorBundle(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	self.mirrorBundle = {}
	self.mirrorKeyCount = 0
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local isFullSet = CountDueItems(nil, parent) >= 2
	local pct = math.max(0, ability:GetSpecialValueFor(isFullSet and "ability_mirror_pct_full" or "ability_mirror_pct"))
	if pct <= 0 then
		return
	end
	local bundle = {}
	local keys = 0
	local mods = parent:FindAllModifiers() or {}
	for ____, m in ipairs(mods) do
		do
			if not m.IsDebuff or not m:IsDebuff() then
				goto __continue19
			end
			if m:GetName() == ____exports.modifier_item_0580_mirror.name then
				goto __continue19
			end
			local anyMod = m
			if anyMod.GetAttributeBonus == nil then
				goto __continue19
			end
			local bonus = anyMod:GetAttributeBonus()
			if not bonus then
				goto __continue19
			end
			for key in pairs(bonus) do
				local v = bonus[key]
				if type(v) == "number" and v ~= 0 then
					if bundle[key] == nil then
						keys = keys + 1
					end
					bundle[key] = (bundle[key] or 0) + v * (pct / 100)
				end
			end
		end
		::__continue19::
	end
	self.mirrorBundle = bundle
	self.mirrorKeyCount = keys
end
function modifier_item_0580.prototype.SpreadMirrors(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local radius = math.max(0, ability:GetSpecialValueFor("ability_mirror_radius"))
	if radius <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue32
			end
			enemy:AddNewModifier(
				parent,
				ability,
				____exports.modifier_item_0580_mirror.name,
				{ duration = MIRROR_LINGER }
			)
		end
		::__continue32::
	end
end
modifier_item_0580 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0580)
____exports.modifier_item_0580 = modifier_item_0580
--- 镜像 debuff「厄运同渡」：挂在敌人身上，自治读取宝铃本体的镜像包并应用。
____exports.modifier_item_0580_mirror = __TS__Class()
local modifier_item_0580_mirror = ____exports.modifier_item_0580_mirror
modifier_item_0580_mirror.name = "modifier_item_0580_mirror"
__TS__ClassExtends(modifier_item_0580_mirror, BaseModifier_CS)
function modifier_item_0580_mirror.GetLocalizationCN(self)
	return { name = "厄运同渡", description = "承受了渡厄宝铃持有者转嫁而来的负面属性效果。" }
end
function modifier_item_0580_mirror.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0580_mirror.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local source = self:FindSourceModifier()
	if not source then
		self:Destroy()
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0580_mirror.prototype.GetAttributeBonus(self)
	local source = self:FindSourceModifier()
	if not source then
		return {}
	end
	return source:GetMirrorBundle()
end
function modifier_item_0580_mirror.prototype.FindSourceModifier(self)
	local caster = self:GetCaster()
	if not caster or caster:IsNull() or not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:FindModifierByName(____exports.modifier_item_0580.name)
end
function modifier_item_0580_mirror.prototype.IsHidden(self)
	return false
end
function modifier_item_0580_mirror.prototype.IsDebuff(self)
	return true
end
function modifier_item_0580_mirror.prototype.IsPurgable(self)
	return false
end
function modifier_item_0580_mirror.prototype.GetTexture(self)
	return "item_spirit_vessel"
end
modifier_item_0580_mirror = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0580_mirror)
____exports.modifier_item_0580_mirror = modifier_item_0580_mirror
return ____exports
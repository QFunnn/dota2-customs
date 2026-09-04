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
local ____base_ability = require("abilities._base.base_ability")
local BaseAbility_CS = ____base_ability.BaseAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____effect_modifiers = require("modifiers.effect_modifiers")
local modifier_wearable_unit_state = ____effect_modifiers.modifier_wearable_unit_state
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
--- 宠物猫的头部模型；猫猫神暂时复用好奇猫头部，但保留独立宠物单位。
local CAT_PET_HEAD_MODELS = {
	pet_cat_curious = "models/items/courier/catakeet/catakeet_head_curious.vmdl",
	pet_cat_evil = "models/items/courier/catakeet/catakeet_head_evil.vmdl",
	pet_cat_sly = "models/items/courier/catakeet/catakeet_head_sly.vmdl",
	pet_cat_god = "models/items/courier/catakeet/catakeet_head_curious.vmdl",
}
local CAT_PET_TAIL_MODEL = "models/items/courier/catakeet/catakeet_tail_good.vmdl"
local CAT_PET_SKIN = 0
--- 为固定宠物单位提供猫咪头尾组合的隐藏被动技能。
____exports.pet_cat_visual = __TS__Class()
local pet_cat_visual = ____exports.pet_cat_visual
pet_cat_visual.name = "pet_cat_visual"
__TS__ClassExtends(pet_cat_visual, BaseAbility_CS)
function pet_cat_visual.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function pet_cat_visual.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_pet_cat_visual.name
end
pet_cat_visual = __TS__DecorateLegacy({ registerAbility(nil) }, pet_cat_visual)
____exports.pet_cat_visual = pet_cat_visual
--- Modifier 生命周期与宠物单位一致，负责创建和回收头尾实体。
____exports.modifier_pet_cat_visual = __TS__Class()
local modifier_pet_cat_visual = ____exports.modifier_pet_cat_visual
modifier_pet_cat_visual.name = "modifier_pet_cat_visual"
__TS__ClassExtends(modifier_pet_cat_visual, BaseModifier_CS)
function modifier_pet_cat_visual.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.visualEntityIndexes = {}
end
function modifier_pet_cat_visual.prototype.IsHidden(self)
	return true
end
function modifier_pet_cat_visual.prototype.IsPurgable(self)
	return false
end
function modifier_pet_cat_visual.prototype.IsPermanent(self)
	return true
end
function modifier_pet_cat_visual.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:CreateVisuals()
end
function modifier_pet_cat_visual.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	for ____, entityIndex in ipairs(self.visualEntityIndexes) do
		do
			local entity = EntIndexToHScript(entityIndex)
			if not entity or not IsValid(nil, entity) or entity:IsNull() then
				goto __continue11
			end
			entity:AddNoDraw()
			entity:RemoveSelf()
		end
		::__continue11::
	end
	self.visualEntityIndexes = {}
end
function modifier_pet_cat_visual.prototype.CreateVisuals(self)
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	local headModel = CAT_PET_HEAD_MODELS[parent:GetUnitName()]
	if not headModel then
		return
	end
	local head = self:CreateAttachedWearable(headModel, parent)
	if head then
		local ____self_visualEntityIndexes_0 = self.visualEntityIndexes
		____self_visualEntityIndexes_0[#____self_visualEntityIndexes_0 + 1] = head:entindex()
	end
	local tail = self:CreateAttachedWearable(CAT_PET_TAIL_MODEL, parent)
	if tail then
		local ____self_visualEntityIndexes_1 = self.visualEntityIndexes
		____self_visualEntityIndexes_1[#____self_visualEntityIndexes_1 + 1] = tail:entindex()
	end
end
function modifier_pet_cat_visual.prototype.CreateAttachedWearable(self, model, target)
	local wearable = SpawnEntityFromTableSynchronous("npc_dota_creature", { model = model, StatusHealth = 99999 })
	if not wearable or not IsValid(nil, wearable) then
		return nil
	end
	wearable:SetOwner(target)
	wearable:SetParent(target, "")
	wearable:FollowEntity(target, true)
	wearable:SetTeam(target:GetTeamNumber())
	wearable:SetSkin(CAT_PET_SKIN)
	modifier_wearable_unit_state:applys(wearable, target, nil, { duration = -1, invisibility_level = 0 })
	return wearable
end
modifier_pet_cat_visual = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pet_cat_visual)
____exports.modifier_pet_cat_visual = modifier_pet_cat_visual
return ____exports
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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 可破坏物容器 Modifier（参考原生 modifier_breakable_container）
-- - 禁止自动攻击、隐藏血条、提供视野等
-- - 死亡时播放破碎音效（不包含掉落逻辑，由 drop_manager 处理）
____exports.modifier_breakable_container = __TS__Class()
local modifier_breakable_container = ____exports.modifier_breakable_container
modifier_breakable_container.name = "modifier_breakable_container"
__TS__ClassExtends(modifier_breakable_container, BaseModifier_CS)
function modifier_breakable_container.prototype.IsHidden(self)
	return true
end
function modifier_breakable_container.prototype.IsPurgable(self)
	return false
end
function modifier_breakable_container.prototype.IsDebuff(self)
	return false
end
function modifier_breakable_container.prototype.IsPermanent(self)
	return true
end
function modifier_breakable_container.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROVIDES_FOW_POSITION }
end
function modifier_breakable_container.prototype.GetModifierProvidesFOWVision(self)
	return 1
end
function modifier_breakable_container.prototype.CanParentBeAutoAttacked(self)
	return false
end
function modifier_breakable_container.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_BLIND] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	}
end
function modifier_breakable_container.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local size = tonumber(parent:GetKeyValue("ModelScale") or 1)
	local size_rate = 0.7 + math.random() * 0.2
	parent:SetModelScale(size * size_rate)
end
function modifier_breakable_container.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local unitName = parent:GetUnitName()
	if unitName == "dest_crate" then
		if RandomInt(0, 1) >= 1 then
			EmitSoundOn("Dungeon.SmashCrateShort", parent)
		else
			EmitSoundOn("Dungeon.SmashCrateLong", parent)
		end
	else
		EmitSoundOn("Dungeon.VaseBreak", parent)
	end
end
modifier_breakable_container =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_breakable_container") }, modifier_breakable_container)
____exports.modifier_breakable_container = modifier_breakable_container
return ____exports
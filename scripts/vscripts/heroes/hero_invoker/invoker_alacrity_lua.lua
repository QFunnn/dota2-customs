--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


invoker_alacrity_lua = class({})

LinkLuaModifier(
	"modifier_invoker_alacrity_lua",
	"heroes/hero_invoker/modifier_invoker_alacrity_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_invoker_alacrity_talent",
	"heroes/hero_invoker/modifier_invoker_alacrity_talent",
	LUA_MODIFIER_MOTION_NONE
)

function invoker_alacrity_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")
	target:AddNewModifier(caster, self, "modifier_invoker_alacrity_lua", { duration = duration })
end

function invoker_alacrity_lua:GetCastAnimation()
	return ACT_DOTA_CAST_ALACRITY
end
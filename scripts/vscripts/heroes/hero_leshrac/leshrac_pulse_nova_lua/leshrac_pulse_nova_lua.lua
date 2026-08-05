--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


leshrac_pulse_nova_lua = class({})
LinkLuaModifier(
	"modifier_leshrac_pulse_nova_lua",
	"heroes/hero_leshrac/leshrac_pulse_nova_lua/modifier_leshrac_pulse_nova_lua",
	LUA_MODIFIER_MOTION_NONE
)

function leshrac_pulse_nova_lua:OnSpellStart()
	local caster = self:GetCaster()
end

function leshrac_pulse_nova_lua:OnToggle()
	local caster = self:GetCaster()

	local toggle = self:GetToggleState()

	if toggle then
		-- add modifier
		self.modifier = caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_leshrac_pulse_nova_lua", -- modifier name
			{} -- kv
		)
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end
end
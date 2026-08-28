--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


chaos_knight_phantasm_lua = chaos_knight_phantasm_lua or class({})
LinkLuaModifier(
	"modifier_chaos_knight_phantasm_lua_shard",
	"abilities/heroes/chaos_knight/modifier_chaos_knight_phantasm_lua_shard",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_chaos_knight_phantasm_lua",
	"abilities/heroes/chaos_knight/modifier_chaos_knight_phantasm_lua",
	LUA_MODIFIER_MOTION_NONE
)

function chaos_knight_phantasm_lua:GetIntrinsicModifierName()
	return "modifier_chaos_knight_phantasm_lua_shard"
end

function chaos_knight_phantasm_lua:OnSpellStart()
	local caster = self:GetCaster()

	local vision_radius = self:GetSpecialValueFor("vision_radius")
	local invulnerability_duration = self:GetSpecialValueFor("invuln_duration")

	AddFOWViewer(caster:GetTeamNumber(), caster:GetAbsOrigin(), vision_radius, invulnerability_duration, false)

	caster:AddNewModifier(caster, self, "modifier_chaos_knight_phantasm_lua", {
		duration = invulnerability_duration,
	})
end

function chaos_knight_phantasm_lua:CreateIllusionsAt(source, illusion_count, illusion_duration, place_at_source)
	local caster = self:GetCaster()

	local outgoing_damage = self:GetSpecialValueFor("outgoing_damage")
	local incoming_damage = self:GetSpecialValueFor("incoming_damage")

	local illusions = CreateIllusions(caster, source, {
		outgoing_damage = outgoing_damage,
		incoming_damage = incoming_damage,
		duration = illusion_duration,
	}, illusion_count, 128, false, true)

	for _, illusion in pairs(illusions or {}) do
		if IsValidEntity(illusion) then
			illusion:AddNewModifier(caster, self, "modifier_chaos_knight_phantasm_illusion", {
				duration = illusion_duration,
			})

			if place_at_source then
				FindClearRandomPositionAroundUnit(illusion, source, 150)
			end
		end
	end

	return illusions
end
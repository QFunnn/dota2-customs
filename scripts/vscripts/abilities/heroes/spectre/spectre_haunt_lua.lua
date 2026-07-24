--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


spectre_haunt_lua = spectre_haunt_lua or class({})
LinkLuaModifier("modifier_spectre_haunt_lua", "abilities/heroes/spectre/modifier_spectre_haunt_lua", LUA_MODIFIER_MOTION_NONE)

function spectre_haunt_lua:OnSpellStart()
	local caster = self:GetCaster()
	local caster_team = caster:GetTeam()

	local delay_increment = self:GetSpecialValueFor("spawn_delay")
	local outgoing_damage = self:GetSpecialValueFor("illusion_damage_outgoing")
	local incoming_damage = self:GetSpecialValueFor("illusion_damage_incoming")
	local duration = self:GetSpecialValueFor("duration")
	local padding = self:GetSpecialValueFor("padding")

	local delay = 0

	-- WARNING: it is generally not advised to use game loop logic inside abilities
	-- as it creates dependency that makes it hard to export this ability somewhere
	-- but it serves great to cut corners!

	caster:EmitSound("Hero_Spectre.HauntCast")
	for _, hero in pairs(GameLoop.hero_by_player_id or {}) do
		if hero:GetTeam() ~= caster_team then
			hero:EmitSound("Hero_Spectre.Haunt")
			Timers:CreateTimer(delay, function()
				if not IsValidEntity(hero) or not IsValidEntity(self) then return end

				local illusion = CreateIllusions(
					caster,
					caster,
					{
						outgoing_damage = outgoing_damage,
						incoming_damage = incoming_damage,
						duration = duration,
					},
					1,
					padding,
					false,
					true
				)[1]

				illusion:SetControllableByPlayer(caster:GetPlayerOwnerID(), false)
				-- adding vanilla modifier for compatibility with vanilla Reality
				illusion:AddNewModifier(caster, self, "modifier_spectre_haunt", {
					duration = duration,
				})
				-- and custom modifier to control movement and attack behaviour
				illusion:AddNewModifier(caster, self, "modifier_spectre_haunt_lua", {
					duration = duration,
					target = hero:GetEntityIndex()
				})

				FindClearRandomPositionAroundUnit(illusion, hero, padding)
			end)

			delay = delay + delay_increment
		end
	end
end
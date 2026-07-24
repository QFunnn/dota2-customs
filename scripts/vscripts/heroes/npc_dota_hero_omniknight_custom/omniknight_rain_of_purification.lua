--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_omniknight_rain_of_purification", "heroes/npc_dota_hero_omniknight_custom/omniknight_rain_of_purification" , LUA_MODIFIER_MOTION_NONE)

omniknight_rain_of_purification = class({})

function omniknight_rain_of_purification:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_omniknight_rain_of_purification", {duration = duration})
end

modifier_omniknight_rain_of_purification = class({})

function modifier_omniknight_rain_of_purification:IsHidden() return false end
function modifier_omniknight_rain_of_purification:IsPurgable() return false end

function modifier_omniknight_rain_of_purification:OnCreated()
	if not IsServer() then return end
	self.timers = {}
	self:StartPurrificationEvent()
end

function modifier_omniknight_rain_of_purification:StartPurrificationEvent()
	if not IsServer() then return end
	local caster = self:GetParent()
	local delay_spawn = self:GetAbility():GetSpecialValueFor("delay_spawn")
	local radius = self:GetAbility():GetSpecialValueFor("radius")
	local duration = self:GetAbility():GetSpecialValueFor("duration")

	local count = duration / delay_spawn

	if #self.timers > 0 then 
		for _,timer in pairs(self.timers) do
			if timer then 
				Timers:RemoveTimer(timer)
			end
		end
	end

	for i = 0, count do
		self.timers[i] = Timers:CreateTimer(delay_spawn * i, function()
			if not caster:IsAlive() then
				return
			end
			local random_point = caster:GetAbsOrigin() + RandomVector(RandomInt(0, radius))
			self:CreatePuriffication(random_point, caster)
		end)
	end
end

function modifier_omniknight_rain_of_purification:OnRefresh()
	self:StartPurrificationEvent()
end

function modifier_omniknight_rain_of_purification:CreatePuriffication(origin, caster)
	if not IsServer() then return end
	local ability = caster:FindAbilityByName("omniknight_purification_custom")
	if ability and ability:GetLevel() > 0 then
		local heal = ability:GetSpecialValueFor("heal")
		local radius = ability:GetSpecialValueFor("radius")
		if caster:HasModifier("modifier_omniknight_2") then
			radius = radius + ability.modifier_omniknight_2_bonus_radius[caster:GetTalentLevel("modifier_omniknight_2")]
		end
		if caster:HasModifier("modifier_omniknight_4") then
			heal = heal + ( caster:GetStrength() / 100 * ability.modifier_omniknight_4_heal_increase_strength[caster:GetTalentLevel("modifier_omniknight_4")])
		end
		heal = heal / 2
		ability:PlayEffects3( origin, radius )
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), origin, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		for _,enemy in pairs(enemies) do
			if enemy:GetTeamNumber() == caster:GetTeamNumber() then
				enemy:Heal( heal, ability )
                if caster:HasModifier("modifier_omniknight_1") then
                    local new_heal = heal * (ability.modifier_omniknight_1[caster:GetTalentLevel("modifier_omniknight_1")] / 100)
                    enemy:AddNewModifier(self:GetCaster(), ability, "modifier_omniknight_purification_custom_repeat", {duration = 3, new_heal = new_heal})
                end
			else
				ApplyDamage({ attacker = caster, victim = enemy, damage = heal, damage_type = DAMAGE_TYPE_PURE, ability = ability })
			end
		end
	end
end
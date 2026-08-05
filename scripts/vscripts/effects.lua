--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


effects = effects or { players = {} }

function effects:RegisterHudListener(event_name, function_name)
	CustomGameEventManager:RegisterListener(event_name, function(_, kv)
		self[function_name](self, kv)
	end)
end

function effects:init()
	self:RegisterHudListener("CastSpray", "CastSpray")
	self:RegisterHudListener("HighFive", "HighFive")
	self.spray = {}
end

function effects:CastSpray(t)
	print("spray start")
	local hero = PlayerResource:GetSelectedHeroEntity(t.PlayerID)
	local front = hero:GetForwardVector():Normalized()
	local point = hero:GetAbsOrigin() + front * 150

	if self.spray[t.PlayerID] then
		ParticleManager:DestroyParticle(self.spray[t.PlayerID], true)
		ParticleManager:ReleaseParticleIndex(self.spray[t.PlayerID])
	end

	local tab = CustomNetTables:GetTableValue("sprays", tostring(t.PlayerID))
	if tab then
		if tab.spray ~= nil then
			local effect =
				ParticleManager:CreateParticle("particles/sprays/spray_placement.vpcf", PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(effect, 0, point)
			ParticleManager:ReleaseParticleIndex(effect)

			local spray = ParticleManager:CreateParticle(tab.spray, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(spray, 0, point)
			ParticleManager:SetParticleControl(spray, 1, Vector(196, 1, 0))

			if _G.player_quest[t.PlayerID]["spray_quest"] == nil then
				_G.player_quest[t.PlayerID]["spray_quest"] = 1
			else
				_G.player_quest[t.PlayerID]["spray_quest"] = _G.player_quest[t.PlayerID]["spray_quest"] + 1
			end

			local sound_cast = "Spraywheel.Paint"
			-- EmitSoundOnLocationWithCaster( point, sound_cast, hero )
			EmitSoundOn(sound_cast, hero)
			self.spray[t.PlayerID] = spray
		end
	end
end

function effects:HighFive(t)
	print("highfive start")
	local tab = CustomNetTables:GetTableValue("highfive", tostring(t.PlayerID))
	if tab then
		if tab.highfive ~= nil then
			local caster = PlayerResource:GetSelectedHeroEntity(t.PlayerID)

			if not caster:IsAlive() then
				return
			end
			caster:AddNewModifier(
				caster,
				nil,
				"modifier_high_five_custom_search",
				{ duration = 5, particle = tab.highfive }
			)
			EmitSoundOn("high_five.cast", caster)

			if _G.player_quest[t.PlayerID]["highfive_quest"] == nil then
				_G.player_quest[t.PlayerID]["highfive_quest"] = 1
			else
				_G.player_quest[t.PlayerID]["highfive_quest"] = _G.player_quest[t.PlayerID]["highfive_quest"] + 1
			end
		end
	end
end

LinkLuaModifier("modifier_high_five_custom_search", "effects.lua", LUA_MODIFIER_MOTION_NONE)
modifier_high_five_custom_search = class({})

function modifier_high_five_custom_search:IsHidden()
	return true
end

function modifier_high_five_custom_search:RemoveOnDeath()
	return false
end

function modifier_high_five_custom_search:IsPurgable()
	return false
end

function modifier_high_five_custom_search:OnCreated(data)
	local overhead_particle = ParticleManager:CreateParticle(data.particle, PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	self:AddParticle(overhead_particle, false, false, -1, false, false)

	self.parent = self:GetParent()
	self:StartIntervalThink(0.2)
end

function modifier_high_five_custom_search:OnDestroy() end

function modifier_high_five_custom_search:OnIntervalThink()
	if not IsServer() then
		return
	end
	local units = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetOrigin(),
		self.parent,
		800,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)
	for k, v in pairs(units) do
		local modifier = v:FindModifierByName("modifier_high_five_custom_search")
		if modifier and v ~= self.parent then
			Start_Five(self.parent, v)
			self:Destroy()
			modifier:Destroy()
			break
		end
	end
end

LinkLuaModifier("modifier_dummy", "modifiers/modifier_dummy", LUA_MODIFIER_MOTION_NONE)

function Start_Five(hero1, hero2)
	local vPoint = (hero2:GetOrigin() + hero1:GetOrigin()) / 2
	local dummy = CreateUnitByName("npc_dummy_unit", vPoint, false, nil, nil, DOTA_TEAM_NEUTRALS)
	dummy:AddNewModifier(hero1, nil, "modifier_dummy", {})

	ProjectileManager:CreateLinearProjectile({
		Source = hero1,
		Ability = ability1,
		vSpawnOrigin = hero1:GetAbsOrigin(),

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_NONE,

		EffectName = "particles/econ/events/ti9/high_five/high_five_lvl1_travel.vpcf",
		fDistance = #(vPoint - hero1:GetOrigin()),
		fStartRadius = 10,
		fEndRadius = 10,
		vVelocity = (vPoint - hero1:GetOrigin()):Normalized() * 700,
	})
	ProjectileManager:CreateLinearProjectile({
		Source = hero2,
		Ability = ability2,
		vSpawnOrigin = hero2:GetAbsOrigin(),

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_NONE,

		EffectName = "particles/econ/events/ti9/high_five/high_five_lvl1_travel.vpcf",
		fDistance = #(vPoint - hero2:GetOrigin()),
		fStartRadius = 10,
		fEndRadius = 10,
		vVelocity = (vPoint - hero2:GetOrigin()):Normalized() * 700,
	})

	Timers:CreateTimer(0.5 * #(hero2:GetOrigin() - hero1:GetOrigin()) / 700, function()
		local particle = ParticleManager:CreateParticle(
			"particles/econ/events/ti9/high_five/high_five_impact.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			dummy
		)
		ParticleManager:SetParticleControl(particle, 3, dummy:GetOrigin())
		dummy:ForceKill(false)
		ParticleManager:ReleaseParticleIndex(particle)
		EmitSoundOn("high_five.impact", dummy)
	end)
end
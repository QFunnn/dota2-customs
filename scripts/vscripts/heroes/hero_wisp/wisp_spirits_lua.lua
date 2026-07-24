--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


wisp_spirits_lua = class({})
LinkLuaModifier("modifier_wisp_spirits_active", "heroes/hero_wisp/modifier_wisp_spirits_active", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_spirits_creep", "heroes/hero_wisp/modifier_wisp_spirits_active", LUA_MODIFIER_MOTION_NONE)


function wisp_spirits_lua:Spawn()
	if not IsServer() then return end
	
	self.scepter_gained_listener = EventDriver:Listen("Hero:ScepterReceived", function(self, event)
		if event.hero ~= self:GetCaster() then return end
		if self:GetLevel() == 0 then return end
		if not self:IsCooldownReady() then return end
		local modifier = event.hero:FindModifierByName("modifier_wisp_spirits_active")
		if modifier and not modifier:IsNull() then
			modifier:SetDuration(-1, true)
		else
			self:OnSpellStart()
		end
	end, self)
    
    --暂时无用
	self.scepter_lost_listener = EventDriver:Listen("Hero:ScepterLost", function(self, event)
		if event.hero ~= self:GetCaster() then return end
		local modifier = event.hero:FindModifierByName("modifier_wisp_spirits_active")

		if modifier and not modifier:IsNull() and modifier:GetDuration() <= -1 then
			modifier:SetDuration(self:GetSpecialValueFor("spirit_duration"), true)
		end
	end, self)
end


function wisp_spirits_lua:OnUpgrade()
	if not IsServer() then return end

	if self:GetCaster():HasScepter() then
		self:OnSpellStart()
	end

	local modifier = self:GetCaster():FindModifierByName("modifier_wisp_spirits_active")
	if modifier and not modifier:IsNull() then
		modifier:ForceRefresh()
	end
end


function wisp_spirits_lua:OnSpellStart()
	local caster = self:GetCaster()

	local duration = self:GetSpecialValueFor("spirit_duration")
	if caster:HasScepter() then duration = -1 end

	if caster:HasModifier("modifier_wisp_spirits_active") then caster:RemoveModifierByName("modifier_wisp_spirits_active") end

	local modifier = caster:AddNewModifier(caster, self, "modifier_wisp_spirits_active", {duration = duration})

	local control_ability = caster:FindAbilityByName("wisp_spirits_in_lua")
	if not control_ability then
		control_ability = caster:AddAbility("wisp_spirits_in_lua")
	end
	control_ability:SetLevel(self:GetLevel())
	caster:SwapAbilities(
		self:GetAbilityName(),
		"wisp_spirits_in_lua",
		false,
		true
	)

	caster:EmitSound("Hero_Wisp.Spirits.Cast")

	if modifier then
	  modifier.control_ability = control_ability
	end
end


wisp_spirits_in_lua = class({})


function wisp_spirits_in_lua:OnToggle()
	-- literally does nothing on it's own lmao
end

function wisp_spirits_in_lua:ResetToggleOnRespawn() return true end
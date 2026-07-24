--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_modifier_windrunner_20_buff", "modifiers/talents/npc_dota_hero_windrunner/modifier_windrunner_20", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_modifier_windrunner_20_buff_cooldown", "modifiers/talents/npc_dota_hero_windrunner/modifier_windrunner_20", LUA_MODIFIER_MOTION_NONE)

modifier_windrunner_20=class({})

function modifier_windrunner_20:IsHidden() return true end
function modifier_windrunner_20:IsPurgable() return false end
function modifier_windrunner_20:IsPurgeException() return false end
function modifier_windrunner_20:RemoveOnDeath() return false end

function modifier_windrunner_20:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_windrunner_20:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_windrunner_20:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH
	}
end

function modifier_windrunner_20:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_modifier_windrunner_20_buff_cooldown") then return end
	return 1
end

function modifier_windrunner_20:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if self:GetParent():GetHealth() > 1 then return end
	if self:GetParent():HasModifier("modifier_modifier_windrunner_20_buff") then return end
	if self:GetParent():HasModifier("modifier_modifier_windrunner_20_buff_cooldown") then return end
	self:GetParent():EmitSound("Item.Brooch.Cast")
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_modifier_windrunner_20_buff", {duration = 1})
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_modifier_windrunner_20_buff_cooldown", {duration = 120})
end

modifier_modifier_windrunner_20_buff = class({})

function modifier_modifier_windrunner_20_buff:OnCreated()
	if not IsServer() then return end

	local particle = ParticleManager:CreateParticle( "particles/items5_fx/havoc_hammer.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin() )
    ParticleManager:SetParticleControl(particle, 1, Vector(300, 300, 300))

	local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)   
    for _, enemy in pairs(enemies) do
    	local distance = (enemy:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
		local direction = (enemy:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()
		local bump_point = self:GetParent():GetAbsOrigin() - direction * (distance + 300)
		local knockbackProperties =
		{
			center_x = bump_point.x,
			center_y = bump_point.y,
			center_z = bump_point.z,
			duration = 0.1,
			knockback_duration = 0.1,
			knockback_distance = 300,
			knockback_height = 0,
			should_stun = false,
		}
			
		if not enemy:HasModifier("modifier_knockback") then
			enemy:AddNewModifier( enemy, nil, "modifier_knockback", knockbackProperties )
		end

    	local ability = self:GetParent():FindAbilityByName("windrunner_shackleshot_custom")
    	if ability then
    		ability:OnSpellStart(enemy)
    	end
    end
end

function modifier_modifier_windrunner_20_buff:GetEffectName() return "particles/helm_of_the_undying_custom_3.vpcf" end
function modifier_modifier_windrunner_20_buff:IsHidden() return false end
function modifier_modifier_windrunner_20_buff:IsPurgable() return false end

function modifier_modifier_windrunner_20_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_modifier_windrunner_20_buff:GetMinHealth()
	return 1
end

function modifier_modifier_windrunner_20_buff:GetTexture()
	return "windrunner_20"
end

modifier_modifier_windrunner_20_buff_cooldown = class({})

function modifier_modifier_windrunner_20_buff_cooldown:IsHidden() return false end
function modifier_modifier_windrunner_20_buff_cooldown:IsPurgable() return false end
function modifier_modifier_windrunner_20_buff_cooldown:IsDebuff() return true end
function modifier_modifier_windrunner_20_buff_cooldown:RemoveOnDeath() return false end

function modifier_modifier_windrunner_20_buff_cooldown:GetTexture()
	return "windrunner_20"
end
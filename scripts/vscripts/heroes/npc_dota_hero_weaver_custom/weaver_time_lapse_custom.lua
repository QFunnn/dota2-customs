--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_weaver_time_lapse_custom", "heroes/npc_dota_hero_weaver_custom/weaver_time_lapse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_time_lapse_custom_talent_purge", "heroes/npc_dota_hero_weaver_custom/weaver_time_lapse_custom", LUA_MODIFIER_MOTION_NONE)

weaver_time_lapse_custom = class({})

weaver_time_lapse_custom.modifier_weaver_19 = 5

function weaver_time_lapse_custom:GetIntrinsicModifierName()	
    return "modifier_weaver_time_lapse_custom" 
end

function weaver_time_lapse_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():Stop()
    if not self.intrinsic_modifier then
        self.intrinsic_modifier = self:GetCaster():FindModifierByName(self:GetIntrinsicModifierName())
    end
    if self.intrinsic_modifier and self.intrinsic_modifier.instances_health and self.intrinsic_modifier.instances_health[1] and self.intrinsic_modifier.instances_mana and self.intrinsic_modifier.instances_mana[1] and self.intrinsic_modifier.instances_position and self.intrinsic_modifier.instances_position[1] then
        self:GetCaster():EmitSound("Hero_Weaver.TimeLapse")

        local time_lapse_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_weaver/weaver_timelapse.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
        ParticleManager:SetParticleControl(time_lapse_particle, 0, self:GetCaster():GetAbsOrigin())
        ParticleManager:SetParticleControl(time_lapse_particle, 2, self.intrinsic_modifier.instances_position[1])
        ParticleManager:ReleaseParticleIndex(time_lapse_particle)
        
        ProjectileManager:ProjectileDodge(self:GetCaster())

        self:GetCaster():Purge(false, true, false, true, true)

        self:GetCaster():Stop()

        self:GetCaster():SetHealth(math.max(self.intrinsic_modifier.instances_health[1], 1))

        self:GetCaster():SetMana(self.intrinsic_modifier.instances_mana[1])

        FindClearSpaceForUnit(self:GetCaster(), self.intrinsic_modifier.instances_position[1], false)

        if self:GetCaster():HasModifier("modifier_weaver_19") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_weaver_time_lapse_custom_talent_purge", {duration = self.modifier_weaver_19})
        end
    end
end

modifier_weaver_time_lapse_custom = class({})
function modifier_weaver_time_lapse_custom:IsHidden() return true end
function modifier_weaver_time_lapse_custom:IsPurgable() return false end
function modifier_weaver_time_lapse_custom:IsPurgeException() return false end
function modifier_weaver_time_lapse_custom:RemoveOnDeath() return false end

function modifier_weaver_time_lapse_custom:OnCreated()
	if not IsServer() then return end
	self.lapsed_time = 5
	self.instances_health = {}
	self.instances_mana = {}
	self.instances_position = {}
	self.interval = 0.1
	self.total_saved_points	= self.lapsed_time / self.interval
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_weaver_time_lapse_custom:OnIntervalThink()
	if self:GetParent():IsAlive() then
		table.insert(self.instances_health, self:GetParent():GetHealth())
		table.insert(self.instances_mana, self:GetParent():GetMana())
		table.insert(self.instances_position, self:GetParent():GetAbsOrigin())
		if #self.instances_health >= self.total_saved_points then
			table.remove(self.instances_health, 1)
			table.remove(self.instances_mana, 1)
			table.remove(self.instances_position, 1)
		end
	end
end


modifier_weaver_time_lapse_custom_talent_purge = class({})
function modifier_weaver_time_lapse_custom_talent_purge:IsPurgeException() return false end
function modifier_weaver_time_lapse_custom_talent_purge:IsPurgable() return false end
function modifier_weaver_time_lapse_custom_talent_purge:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():Purge(false, true, false, true, true)
    local particle = ParticleManager:CreateParticle("particles/items_fx/wand_of_sanctitude_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector(150, 150,150))
    ParticleManager:ReleaseParticleIndex(particle)
end
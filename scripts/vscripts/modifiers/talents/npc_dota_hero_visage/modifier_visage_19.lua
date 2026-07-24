--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_19=class({})

LinkLuaModifier("modifier_visage_19_charges", "modifiers/talents/npc_dota_hero_visage/modifier_visage_19", LUA_MODIFIER_MOTION_NONE)

function modifier_visage_19:IsHidden() return true end
function modifier_visage_19:IsPurgable() return false end
function modifier_visage_19:IsPurgeException() return false end
function modifier_visage_19:RemoveOnDeath() return false end

function modifier_visage_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_visage_19_charges", {})
    local visage_summon_familiars_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_custom")
    if visage_summon_familiars_custom then
        visage_summon_familiars_custom:EndCooldown()
        if visage_summon_familiars_custom.familiar_table then
            for _, familiar in pairs(visage_summon_familiars_custom.familiar_table) do
                if familiar and not familiar:IsNull() and familiar:IsAlive() then
                    familiar:ForceKill(false)
                end
            end
        end
    end
end

function modifier_visage_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

modifier_visage_19_charges=class({})

function modifier_visage_19_charges:IsHidden() return false end
function modifier_visage_19_charges:IsPurgable() return false end
function modifier_visage_19_charges:IsPurgeException() return false end
function modifier_visage_19_charges:RemoveOnDeath() return false end
function modifier_visage_19_charges:DestroyOnExpire() return false end
function modifier_visage_19_charges:GetTexture() return "visage_stone_form_self_cast" end

function modifier_visage_19_charges:OnCreated()
	if not IsServer() then return end
	self:UpdateCharges()
	self:StartIntervalThink(FrameTime())
end

function modifier_visage_19_charges:OnIntervalThink()
	if not IsServer() then return end
	self:UpdateCharges()
end

function modifier_visage_19_charges:UpdateCharges()
	local ability = self:GetCaster():FindAbilityByName("visage_stone_form_self_cast_custom")
	if not ability then return end
	local max_charges = ability:GetTalent19MaxCharges()
	local now = GameRules:GetGameTime()
	local queue = ability:GetTalent19RechargeQueue(now, max_charges)
	local charges = max_charges - #queue
	if self:GetStackCount() ~= charges then
		self:SetStackCount(charges)
	end
	local target_end = queue[1]
	if target_end then
		if self.displayed_end ~= target_end then
			self.displayed_end = target_end
			self:SetDuration(target_end - now, true)
		end
	elseif self.displayed_end ~= nil then
		self.displayed_end = nil
		self:SetDuration(-1, true)
	end
end
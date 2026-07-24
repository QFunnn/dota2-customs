--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_boss_bar_aura", "modifiers/modifier_woda_boss_bar", LUA_MODIFIER_MOTION_NONE)

modifier_woda_boss_bar = class({})
function modifier_woda_boss_bar:IsHidden() return true end
function modifier_woda_boss_bar:IsPurgable() return false end
function modifier_woda_boss_bar:OnCreated()
    if not IsServer() then return end
    self.unit_name = self:GetCaster():GetUnitName()
    self.fixed_max_health = 0
    self:StartIntervalThink(FrameTime())
end
function modifier_woda_boss_bar:OnIntervalThink()
    if not IsServer() then return end
    for i=1,24 do
        AddFOWViewer(i, self:GetCaster():GetAbsOrigin(), 1200, 0.1, true)
    end
    local modifier_boss_low_health = self:GetCaster():FindModifierByName("modifier_boss_low_health")
    if modifier_boss_low_health then
        local health = (modifier_boss_low_health.charge_counter * modifier_boss_low_health.new_charge_health) - (modifier_boss_low_health.new_charge_health - self:GetCaster():GetHealth())
	    local max_health = modifier_boss_low_health.max_health
        local charge_counter = modifier_boss_low_health.charge_counter
        local max_charge_counter = modifier_boss_low_health.max_charge_counter or charge_counter
        self.fixed_max_health = max_health
        local current_stage_health = self:GetCaster():GetHealthPercent() / 100
        local hp_stages = {}
        for stage = 1, max_charge_counter do
            if charge_counter == (max_charge_counter - stage + 1) then
                hp_stages[stage] = current_stage_health
            elseif charge_counter < (max_charge_counter - stage + 1) then
                hp_stages[stage] = 0
            else
                hp_stages[stage] = 1
            end
        end
        CustomGameEventManager:Send_ServerToAllClients("event_woda_boss_health_bar_update", {health = health, max_health = max_health, unit_name = self.unit_name, stages_count = max_charge_counter, hp_stages = hp_stages, multiplier = charge_counter})
        CustomGameEventManager:Send_ServerToAllClients("event_woda_boss_health_bar_start", {health = health, max_health = max_health, unit_name = self.unit_name, stages_count = max_charge_counter})
    end
end
function modifier_woda_boss_bar:OnDestroy()
	if not IsServer() then return end
    CustomGameEventManager:Send_ServerToAllClients("event_woda_boss_health_bar_update", {health = 0, max_health = self.fixed_max_health, unit_name = self.unit_name, stages_count = 0, hp_stages = {}, multiplier = 0})
    CustomGameEventManager:Send_ServerToAllClients("event_woda_boss_health_bar_end", {})
    if self:GetRemainingTime() <= 1 then
	    self:GetCaster().end_arena = true
	    self:GetCaster():ForceKill(false)
    end
    self:StartIntervalThink(-1)
end
function modifier_woda_boss_bar:OnDeath(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    self:Destroy()
end
function modifier_woda_boss_bar:DeclareFunctions()
	return 
    {
		MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_PROVIDES_FOW_POSITION
	}
end
function modifier_woda_boss_bar:CheckState()
	return 
	{
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}
end
function modifier_woda_boss_bar:GetModifierProvidesFOWVision()
	return 1
end
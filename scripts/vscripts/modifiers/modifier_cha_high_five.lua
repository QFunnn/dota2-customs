--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_cha_high_five_thinker", "modifiers/modifier_cha_high_five", LUA_MODIFIER_MOTION_NONE)

modifier_cha_high_five = class({})

function modifier_cha_high_five:OnCreated()
	if not IsServer() then return end
	self:GetParent():EmitSound("high_five.cast")
	self:StartIntervalThink(FrameTime())
end

function modifier_cha_high_five:IsHidden() return true end
function modifier_cha_high_five:IsPurgable() return false end
function modifier_cha_high_five:IsPurgeException() return false end
function modifier_cha_high_five:OnCreated()
    if not IsServer() then return end
    self.overhead_effect = "particles/econ/events/plus/high_five/high_five_lvl1_overhead.vpcf"
    self.proj_effect = "particles/econ/events/plus/high_five/high_five_lvl1_travel.vpcf"
    self.target_proj = "particles/econ/events/plus/high_five/high_five_lvl1_travel.vpcf"
    local PlayerInfo = Server:GetPlayerInfo(self:GetParent():GetPlayerOwnerID())
    if PlayerInfo then
        if PlayerInfo.selected_five == 1 then
            self.overhead_effect = "particles/econ/events/plus/high_five/high_five_lvl3_overhead.vpcf"
            self.proj_effect = "particles/econ/events/plus/high_five/high_five_lvl3_travel.vpcf"
        end
        if PlayerInfo.selected_five == 6 then
            self.overhead_effect = "particles/econ/events/diretide_2020/high_five/high_five_lvl1_overhead.vpcf"
            self.proj_effect = "particles/econ/events/diretide_2020/high_five/high_five_lvl1_travel.vpcf"
        end
        if PlayerInfo.selected_five == 2 then
            self.overhead_effect = "particles/econ/events/ti9/high_five/high_five_lvl3_overhead.vpcf"
            self.proj_effect = "particles/econ/events/ti9/high_five/high_five_lvl3_travel.vpcf"
        end
        if PlayerInfo.selected_five == 3 then
            self.overhead_effect = "particles/econ/events/spring_2021/high_five_spring_2021_overhead.vpcf"
            self.proj_effect = "particles/econ/events/spring_2021/high_five_spring_2021_travel.vpcf"
        end
        if PlayerInfo.selected_five == 4 then
            self.overhead_effect = "particles/econ/events/plus/high_five/high_five_lvl2_overhead.vpcf"
            self.proj_effect = "particles/econ/events/plus/high_five/high_five_lvl2_travel.vpcf"
        end
        if PlayerInfo.selected_five == 5 then
            self.overhead_effect = "particles/econ/events/fall_2022/high_five/high_five_fall_2022_overhead.vpcf"
            self.proj_effect = "particles/econ/events/fall_2022/high_five/high_five_fall2022_travel.vpcf"
        end
    end
    local particle = ParticleManager:CreateParticle(self.overhead_effect, PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():EmitSound("high_five.cast")
    self:StartIntervalThink(0.1)
end

function modifier_cha_high_five:StartProj(caster, target, vPoint)
    if not IsServer() then return end
    local PlayerInfo = Server:GetPlayerInfo(target:GetPlayerOwnerID())
    if PlayerInfo then
        if PlayerInfo.selected_five == 1 then
            self.target_proj = "particles/econ/events/plus/high_five/high_five_lvl3_travel.vpcf"
        end
        if PlayerInfo.selected_five == 6 then
            self.target_proj = "particles/econ/events/diretide_2020/high_five/high_five_lvl1_travel.vpcf"
        end
        if PlayerInfo.selected_five == 2 then
            self.target_proj = "particles/econ/events/ti9/high_five/high_five_lvl3_travel.vpcf"
        end
        if PlayerInfo.selected_five == 3 then
            self.target_proj = "particles/econ/events/spring_2021/high_five_spring_2021_travel.vpcf"
        end
        if PlayerInfo.selected_five == 4 then
            self.target_proj = "particles/econ/events/plus/high_five/high_five_lvl2_travel.vpcf"
        end
        if PlayerInfo.selected_five == 5 then
            self.target_proj = "particles/econ/events/fall_2022/high_five/high_five_fall2022_travel.vpcf"
        end
    end
    ProjectileManager:CreateLinearProjectile(
    {
        Source = caster,
        Ability = nil,
        vSpawnOrigin = caster:GetAbsOrigin(),
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_NONE,
        EffectName = self.proj_effect,
        fDistance = (vPoint - caster:GetOrigin()):Length2D(),
        fStartRadius = 10,
        fEndRadius = 10,
        vVelocity = (vPoint - caster:GetOrigin()):Normalized() * 700,
    })

    ProjectileManager:CreateLinearProjectile(
    {
        Source = target,
        Ability = nil,
        vSpawnOrigin = target:GetAbsOrigin(),
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_NONE,
        EffectName = self.target_proj,
        fDistance = (vPoint - target:GetOrigin()):Length2D(),
        fStartRadius = 10,
        fEndRadius = 10,
        vVelocity = (vPoint - target:GetOrigin()):Normalized() * 700,
    })
end

function modifier_cha_high_five:OnIntervalThink()
	if not IsServer() then return end
    local target = nil
    local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
	for k, hero in pairs(units) do
		if hero ~= self:GetParent() then
			if hero:HasModifier("modifier_cha_high_five") then
                target = hero
                break
            end
        end
    end
    
    if target == nil then return end

    if target:IsRealHero() then
        local player_target = PlayerResource:GetPlayer(target:GetPlayerOwnerID())
        if player_target and player_target.high_five_cooldown and player_target.high_five_cooldown > 0 then
            player_target.high_five_cooldown = 1
        end
    end

    local player_caster = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
    if player_caster and player_caster.high_five_cooldown and player_caster.high_five_cooldown > 0 then
        player_caster.high_five_cooldown = 1
    end

	local vPoint = (target:GetOrigin() + self:GetParent():GetOrigin()) / 2
    self:StartProj(self:GetParent(), target, vPoint)
	CreateModifierThinker(self:GetParent(), nil, "modifier_cha_high_five_thinker", {duration = (vPoint - target:GetOrigin()):Length2D()/700}, vPoint, self:GetParent():GetTeamNumber(), false)
	target:RemoveModifierByName("modifier_cha_high_five")
	self:Destroy()
end

modifier_cha_high_five_thinker = class({})

function modifier_cha_high_five_thinker:OnDestroy()
	if not IsServer() then return end
    self:GetParent():EmitSound("high_five.impact")
	self:GetParent():EmitSound('high_five.impact')

    local particle = ParticleManager:CreateParticle("particles/econ/events/plus/high_five/high_five_impact.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
end
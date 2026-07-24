--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_2\\boss_2_1"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 4,["13"] = 5,["14"] = 6,["15"] = 4,["16"] = 8,["17"] = 9,["18"] = 8,["19"] = 11,["20"] = 12,["21"] = 11,["22"] = 14,["23"] = 15,["24"] = 14,["25"] = 17,["26"] = 18,["27"] = 17,["28"] = 20,["29"] = 21,["30"] = 22,["31"] = 23,["32"] = 24,["33"] = 25,["34"] = 26,["35"] = 27,["36"] = 27,["37"] = 28,["38"] = 29,["39"] = 30,["40"] = 30,["41"] = 30,["42"] = 30,["43"] = 30,["44"] = 27,["45"] = 27,["46"] = 27,["47"] = 34,["48"] = 20,["49"] = 36,["50"] = 37,["51"] = 38,["52"] = 38,["53"] = 39,["54"] = 38,["55"] = 38,["56"] = 38,["58"] = 36,["59"] = 45,["60"] = 46,["61"] = 47,["62"] = 48,["63"] = 49,["64"] = 50,["65"] = 51,["66"] = 52,["67"] = 53,["68"] = 54,["69"] = 55,["70"] = 55,["71"] = 56,["72"] = 57,["73"] = 58,["74"] = 58,["75"] = 58,["76"] = 58,["77"] = 58,["78"] = 59,["79"] = 55,["80"] = 55,["81"] = 55,["82"] = 63,["83"] = 63,["84"] = 63,["85"] = 63,["86"] = 63,["87"] = 63,["88"] = 63,["89"] = 63,["90"] = 63,["91"] = 63,["92"] = 63,["93"] = 74,["94"] = 75,["95"] = 75,["96"] = 75,["97"] = 75,["98"] = 75,["99"] = 75,["100"] = 75,["101"] = 82,["103"] = 84,["104"] = 84,["105"] = 84,["106"] = 84,["107"] = 84,["108"] = 84,["109"] = 84,["110"] = 84,["111"] = 84,["112"] = 45,["113"] = 2,["114"] = 1,["115"] = 2,["117"] = 87,["118"] = 87,["119"] = 88,["120"] = 95,["121"] = 96,["122"] = 97,["123"] = 98,["124"] = 99,["125"] = 100,["126"] = 101,["127"] = 102,["128"] = 103,["129"] = 104,["131"] = 95,["132"] = 107,["133"] = 108,["134"] = 109,["135"] = 110,["136"] = 111,["137"] = 112,["138"] = 113,["139"] = 113,["140"] = 114,["141"] = 115,["142"] = 116,["143"] = 116,["144"] = 116,["145"] = 116,["146"] = 116,["147"] = 113,["148"] = 113,["149"] = 113,["150"] = 120,["151"] = 120,["152"] = 120,["153"] = 121,["156"] = 122,["157"] = 122,["158"] = 123,["159"] = 124,["160"] = 125,["161"] = 125,["162"] = 125,["163"] = 125,["164"] = 125,["165"] = 126,["166"] = 122,["167"] = 122,["168"] = 122,["169"] = 130,["170"] = 130,["171"] = 130,["172"] = 130,["173"] = 130,["174"] = 130,["175"] = 130,["176"] = 130,["177"] = 130,["178"] = 130,["179"] = 130,["180"] = 141,["181"] = 142,["182"] = 142,["183"] = 142,["184"] = 142,["185"] = 142,["186"] = 142,["187"] = 142,["188"] = 149,["190"] = 120,["191"] = 120,["192"] = 152,["193"] = 153,["195"] = 107,["196"] = 156,["197"] = 157,["198"] = 156,["199"] = 88,["200"] = 87,["201"] = 88});
boss_2_1 = __TS__Class()
boss_2_1.name = "boss_2_1"
__TS__ClassExtends(boss_2_1, BaseAbility)
function boss_2_1.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/warning/circular.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_2/boss_2_1/boom/boom.vpcf", context)
end
function boss_2_1.prototype.GetCastPoint(self)
    return 1
end
function boss_2_1.prototype.GetPlaybackRateOverride(self)
    return 0.63
end
function boss_2_1.prototype.GetCastAnimation(self)
    return ACT_DOTA_CAST_ABILITY_7
end
function boss_2_1.prototype.GetAOERadius(self)
    return self.Values:radius()
end
function boss_2_1.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vPosition = self:GetCursorPosition()
    local fCastPoint = self:GetCastPoint()
    local fRadius = self.Values:radius()
    local vDirection = (vPosition - hCaster:GetAbsOrigin()):Normalized()
    vPosition = hCaster:GetAbsOrigin() + vDirection * 450
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 0, vPosition)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                2,
                Vector(fRadius, fCastPoint, 1 / fCastPoint)
            )
        end,
        {weight = 0}
    )
    return true
end
function boss_2_1.prototype.OnAbilityPhaseInterrupted(self)
    if self.iParticleID ~= nil then
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
            end,
            {weight = 0}
        )
    end
end
function boss_2_1.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local vPosition = self:GetCursorPosition()
    local fRadius = self.Values:radius()
    local dmg_factor = self.Values:dmg_factor()
    local fDuration = self.Values:stun_duration()
    local animation_time = self.Values:animation_time()
    local vDirection = (vPosition - hCaster:GetAbsOrigin()):Normalized()
    vPosition = hCaster:GetAbsOrigin() + vDirection * 450
    local fDamage = AttributeKind.Atk:Get(hCaster) * dmg_factor
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_2/boss_2_1/boom/boom.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                1,
                Vector(fRadius, fRadius, fRadius)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
        end,
        {weight = 0}
    )
    local tTargets = FindUnitsInRadius(
        hCaster:GetTeamNumber(),
        vPosition,
        nil,
        fRadius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_CLOSEST,
        false
    )
    for _, hTarget in ipairs(tTargets) do
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            damage = fDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            victim = hTarget
        })
        hTarget:AddNewModifier(hCaster, self, "modifier_stunned_custom", {duration = fDuration})
    end
    hCaster:AddNewModifier(
        hCaster,
        self,
        "modifier_2_1_buff",
        {
            duration = animation_time + 1,
            vPosition = VectorToString(_G, vPosition)
        }
    )
end
boss_2_1 = __TS__DecorateLegacy(
    {register(_G)},
    boss_2_1
)
modifier_2_1_buff = __TS__Class()
modifier_2_1_buff.name = "modifier_2_1_buff"
__TS__ClassExtends(modifier_2_1_buff, BaseModifier)
function modifier_2_1_buff.prototype.OnCreated(self, params)
    if IsServer() then
        local hParent = self:GetParent()
        self.iCount = 1
        self.radius = self.Values:radius()
        self.dmg_factor = self.Values:dmg_factor()
        self.stun_duration = self.Values:stun_duration()
        self.vPosition = StringToVector(_G, params.vPosition)
        self.fDamage = AttributeKind.Atk:Get(hParent) * self.dmg_factor
        self:StartIntervalThink(self.Values:interval())
    end
end
function modifier_2_1_buff.prototype.OnIntervalThink(self)
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    hParent:StartGesture(ACT_DOTA_CAST_ABILITY_7)
    self.iCount = self.iCount + 1
    self.radius = self.radius + 50 * self.iCount
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iParticleID, 0, self.vPosition)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                2,
                Vector(self.radius, 0.63, 1 / 0.63)
            )
        end,
        {weight = 0}
    )
    hParent:GameTimer(
        0.63,
        function()
            if not IsValid(hParent) or not hParent:IsAlive() then
                return
            end
            ParticleManager_s2c:ToClient(
                function()
                    local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_2/boss_2_1/boom/boom.vpcf", PATTACH_CUSTOMORIGIN, nil)
                    ParticleManager_s2c:SetParticleControl(iParticleID, 0, self.vPosition)
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        1,
                        Vector(self.radius, self.radius, self.radius)
                    )
                    ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                end,
                {weight = 0}
            )
            local tTargets = FindUnitsInRadius(
                hParent:GetTeamNumber(),
                self.vPosition,
                nil,
                self.radius,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_CLOSEST,
                false
            )
            for _, hTarget in ipairs(tTargets) do
                ApplyDamage({
                    ability = hAbility,
                    attacker = hParent,
                    damage = self.fDamage,
                    damage_type = DAMAGE_TYPE_PHYSICAL,
                    victim = hTarget
                })
                hTarget:AddNewModifier(hParent, hAbility, "modifier_stunned_custom", {duration = self.stun_duration})
            end
        end
    )
    if self.iCount >= 4 then
        self:StartIntervalThink(-1)
    end
end
function modifier_2_1_buff.prototype.CheckState(self)
    return {[MODIFIER_STATE_COMMAND_RESTRICTED] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true}
end
modifier_2_1_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_2_1_buff
)
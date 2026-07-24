--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_5\\boss_5_5"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["10"] = 2,["11"] = 2,["12"] = 3,["13"] = 4,["14"] = 5,["15"] = 4,["16"] = 7,["17"] = 8,["18"] = 7,["19"] = 10,["20"] = 11,["21"] = 12,["22"] = 13,["23"] = 14,["24"] = 15,["25"] = 15,["26"] = 15,["27"] = 16,["28"] = 17,["29"] = 17,["30"] = 17,["31"] = 17,["32"] = 17,["33"] = 17,["34"] = 17,["35"] = 17,["36"] = 18,["37"] = 19,["38"] = 20,["39"] = 20,["40"] = 20,["41"] = 20,["42"] = 20,["43"] = 21,["44"] = 22,["45"] = 23,["47"] = 15,["48"] = 15,["49"] = 10,["50"] = 3,["51"] = 2,["52"] = 3,["54"] = 28,["55"] = 28,["56"] = 29,["57"] = 32,["58"] = 33,["59"] = 32,["60"] = 35,["61"] = 36,["62"] = 37,["63"] = 38,["64"] = 39,["65"] = 40,["66"] = 41,["67"] = 42,["68"] = 43,["69"] = 43,["70"] = 43,["71"] = 43,["72"] = 43,["73"] = 43,["74"] = 43,["75"] = 43,["76"] = 43,["77"] = 44,["78"] = 44,["79"] = 44,["80"] = 44,["81"] = 44,["82"] = 44,["83"] = 44,["84"] = 44,["85"] = 44,["86"] = 45,["87"] = 45,["88"] = 45,["89"] = 45,["90"] = 45,["91"] = 45,["92"] = 45,["93"] = 45,["94"] = 41,["96"] = 48,["98"] = 35,["99"] = 51,["100"] = 52,["101"] = 53,["102"] = 54,["103"] = 55,["104"] = 56,["105"] = 57,["106"] = 58,["109"] = 61,["110"] = 62,["111"] = 62,["112"] = 62,["113"] = 62,["114"] = 62,["115"] = 62,["116"] = 62,["117"] = 62,["118"] = 62,["119"] = 62,["120"] = 62,["121"] = 62,["122"] = 62,["123"] = 72,["124"] = 73,["125"] = 74,["126"] = 75,["127"] = 76,["128"] = 77,["129"] = 78,["130"] = 78,["131"] = 78,["132"] = 78,["133"] = 78,["134"] = 78,["135"] = 78,["136"] = 78,["137"] = 78,["138"] = 79,["139"] = 79,["140"] = 79,["141"] = 79,["142"] = 79,["143"] = 79,["144"] = 79,["145"] = 79,["146"] = 79,["147"] = 80,["148"] = 80,["149"] = 80,["150"] = 80,["151"] = 80,["152"] = 80,["153"] = 80,["154"] = 80,["155"] = 75,["158"] = 84,["159"] = 84,["160"] = 84,["161"] = 84,["162"] = 84,["163"] = 84,["164"] = 84,["165"] = 84,["166"] = 84,["167"] = 84,["168"] = 84,["169"] = 95,["170"] = 96,["171"] = 97,["172"] = 98,["173"] = 99,["174"] = 100,["175"] = 100,["176"] = 100,["177"] = 100,["178"] = 100,["179"] = 100,["180"] = 100,["181"] = 100,["182"] = 100,["183"] = 101,["184"] = 101,["185"] = 101,["186"] = 101,["187"] = 101,["188"] = 101,["189"] = 101,["190"] = 101,["191"] = 101,["192"] = 102,["193"] = 102,["194"] = 102,["195"] = 102,["196"] = 102,["197"] = 102,["198"] = 102,["199"] = 102,["200"] = 98,["204"] = 51,["205"] = 108,["206"] = 109,["207"] = 108,["208"] = 113,["209"] = 114,["210"] = 115,["211"] = 116,["212"] = 117,["213"] = 118,["214"] = 118,["215"] = 118,["216"] = 118,["217"] = 118,["218"] = 118,["219"] = 118,["220"] = 118,["221"] = 118,["222"] = 118,["223"] = 118,["224"] = 129,["225"] = 130,["226"] = 131,["227"] = 132,["228"] = 133,["229"] = 133,["230"] = 133,["231"] = 133,["232"] = 133,["233"] = 133,["234"] = 133,["235"] = 133,["236"] = 133,["237"] = 132,["239"] = 136,["240"] = 137,["241"] = 138,["242"] = 137,["246"] = 113,["247"] = 144,["248"] = 145,["249"] = 144,["250"] = 152,["251"] = 153,["252"] = 154,["253"] = 155,["255"] = 152,["256"] = 29,["257"] = 28,["258"] = 29});
boss_5_5 = __TS__Class()
boss_5_5.name = "boss_5_5"
__TS__ClassExtends(boss_5_5, BaseAbility)
function boss_5_5.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_5/link/link.vpcf", context)
end
function boss_5_5.prototype.OnAbilityPhaseStart(self)
    return true
end
function boss_5_5.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local radius = self.Values:radius()
    local atk = self.Values:inherite_attack_pct()
    local duration = self.Values:duration()
    EachPlayer(
        _G,
        function(____, iPlayerID)
            local vPosition = hCaster:GetAbsOrigin() + RandomVector(radius)
            local hPhoenix = CreateUnitByName(
                "boss_5_phoenix",
                vPosition,
                true,
                hCaster,
                hCaster,
                hCaster:GetTeamNumber()
            )
            if IsValid(hPhoenix) then
                hPhoenix:AddAbility("attribute")
                AttributeKind.Atk.BONUS:Set(
                    hPhoenix,
                    AttributeKind.Atk:Get(hCaster) * atk * 0.01,
                    "BASE"
                )
                AttributeKind.Atk.BONUS:UpdateClient(hPhoenix, "BASE")
                hPhoenix:AddNewModifier(hCaster, self, "modifier_boss_5_5", {duration = duration, iPlayerID = iPlayerID})
                hPhoenix:AddNewModifier(hCaster, self, "modifier_kill", {duration = duration})
            end
        end
    )
end
boss_5_5 = __TS__DecorateLegacy(
    {register(_G)},
    boss_5_5
)
modifier_boss_5_5 = __TS__Class()
modifier_boss_5_5.name = "modifier_boss_5_5"
__TS__ClassExtends(modifier_boss_5_5, DiyModifier)
function modifier_boss_5_5.prototype.IsHidden(self)
    return true
end
function modifier_boss_5_5.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsServer() then
        self.hHero = PlayerResource:GetSelectedHeroEntity(params.iPlayerID)
        if IsValid(self.hHero) and self.hHero:IsAlive() then
            hParent:SetForceAttackTarget(self.hHero)
            ParticleManager_s2c:ToClient(function()
                self.iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_5/link/link.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControlEnt(
                    self.iParticleID,
                    0,
                    hParent,
                    PATTACH_POINT_FOLLOW,
                    "attach_hitloc",
                    hParent:GetAbsOrigin(),
                    true
                )
                ParticleManager_s2c:SetParticleControlEnt(
                    self.iParticleID,
                    1,
                    self.hHero,
                    PATTACH_POINT_FOLLOW,
                    "attach_hitloc",
                    self.hHero:GetAbsOrigin(),
                    true
                )
                self:AddParticle_s2c(
                    self.iParticleID,
                    false,
                    false,
                    -1,
                    false,
                    false
                )
            end)
        end
        self:StartIntervalThink(0.1)
    end
end
function modifier_boss_5_5.prototype.OnIntervalThink(self)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    if IsServer() then
        if not IsValid(hCaster) or not hCaster:IsAlive() or not IsValid(hAbility) then
            UTIL_Remove(hParent)
            self:StartIntervalThink(-1)
            return
        end
        if IsValid(self.hHero) and self.hHero:IsAlive() then
            local hHero = __TS__ArrayFilter(
                FindUnitsInLine(
                    hParent:GetTeamNumber(),
                    hParent:GetAbsOrigin(),
                    self.hHero:GetAbsOrigin(),
                    nil,
                    50,
                    2,
                    1,
                    0
                ),
                function(____, v) return v ~= self.hHero end
            )[1]
            if IsValid(hHero) and hHero:IsAlive() then
                self.hHero = hHero
                hParent:SetForceAttackTarget(self.hHero)
                ParticleManager_s2c:ToClient(function()
                    ParticleManager_s2c:DestroyParticle(self.iParticleID, false)
                    self.iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_5/link/link.vpcf", PATTACH_CUSTOMORIGIN, nil)
                    ParticleManager_s2c:SetParticleControlEnt(
                        self.iParticleID,
                        0,
                        hParent,
                        PATTACH_POINT_FOLLOW,
                        "attach_hitloc",
                        hParent:GetAbsOrigin(),
                        true
                    )
                    ParticleManager_s2c:SetParticleControlEnt(
                        self.iParticleID,
                        1,
                        self.hHero,
                        PATTACH_POINT_FOLLOW,
                        "attach_hitloc",
                        self.hHero:GetAbsOrigin(),
                        true
                    )
                    self:AddParticle_s2c(
                        self.iParticleID,
                        false,
                        false,
                        -1,
                        false,
                        false
                    )
                end)
            end
        else
            local hHero = FindUnitsInRadius(
                hParent:GetTeamNumber(),
                hParent:GetAbsOrigin(),
                nil,
                -1,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER,
                false
            )[1]
            if IsValid(hHero) and hHero:IsAlive() then
                self.hHero = hHero
                hParent:SetForceAttackTarget(self.hHero)
                ParticleManager_s2c:ToClient(function()
                    self.iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_5/link/link.vpcf", PATTACH_CUSTOMORIGIN, nil)
                    ParticleManager_s2c:SetParticleControlEnt(
                        self.iParticleID,
                        0,
                        hParent,
                        PATTACH_POINT_FOLLOW,
                        "attach_hitloc",
                        hParent:GetAbsOrigin(),
                        true
                    )
                    ParticleManager_s2c:SetParticleControlEnt(
                        self.iParticleID,
                        1,
                        self.hHero,
                        PATTACH_POINT_FOLLOW,
                        "attach_hitloc",
                        self.hHero:GetAbsOrigin(),
                        true
                    )
                    self:AddParticle_s2c(
                        self.iParticleID,
                        false,
                        false,
                        -1,
                        false,
                        false
                    )
                end)
            end
        end
    end
end
function modifier_boss_5_5.prototype.DDeclareFunctions(self)
    return {[MODIFIER_EVENT_ON_DEATH] = {}}
end
function modifier_boss_5_5.prototype.OnDeath(self, event)
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        if event.unit:IsHero() and event.unit == self.hHero then
            local hHero = FindUnitsInRadius(
                hParent:GetTeamNumber(),
                hParent:GetAbsOrigin(),
                nil,
                -1,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER,
                false
            )[1]
            if IsValid(hHero) and hHero:IsAlive() then
                self.hHero = hHero
                hParent:SetForceAttackTarget(self.hHero)
                ParticleManager_s2c:ToClient(function()
                    ParticleManager_s2c:SetParticleControlEnt(
                        self.iParticleID,
                        1,
                        self.hHero,
                        PATTACH_POINT_FOLLOW,
                        "attach_hitloc",
                        self.hHero:GetAbsOrigin(),
                        true
                    )
                end)
            else
                self.hHero = nil
                ParticleManager_s2c:ToClient(function()
                    ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
                end)
            end
        end
    end
end
function modifier_boss_5_5.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_NO_TEAM_SELECT] = true, [MODIFIER_STATE_UNSELECTABLE] = true}
end
function modifier_boss_5_5.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        hParent:AddNoDraw()
    end
end
modifier_boss_5_5 = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_5_5
)
--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_1\\boss_1_2"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 7,["15"] = 5,["16"] = 9,["17"] = 10,["18"] = 9,["19"] = 12,["20"] = 13,["21"] = 12,["22"] = 15,["23"] = 16,["24"] = 15,["25"] = 18,["26"] = 19,["27"] = 20,["28"] = 21,["29"] = 22,["30"] = 23,["31"] = 24,["32"] = 25,["33"] = 26,["34"] = 27,["35"] = 27,["36"] = 28,["37"] = 29,["38"] = 29,["39"] = 29,["40"] = 29,["41"] = 29,["42"] = 30,["43"] = 31,["44"] = 31,["45"] = 31,["46"] = 31,["47"] = 31,["48"] = 27,["49"] = 27,["50"] = 27,["51"] = 35,["52"] = 18,["53"] = 37,["54"] = 38,["55"] = 39,["56"] = 39,["57"] = 40,["58"] = 39,["59"] = 39,["60"] = 39,["62"] = 37,["63"] = 46,["64"] = 47,["65"] = 48,["66"] = 48,["67"] = 49,["68"] = 48,["69"] = 48,["70"] = 48,["72"] = 54,["73"] = 55,["74"] = 56,["75"] = 57,["76"] = 58,["77"] = 59,["78"] = 60,["79"] = 61,["80"] = 62,["81"] = 63,["82"] = 64,["83"] = 65,["84"] = 66,["85"] = 66,["86"] = 67,["87"] = 68,["88"] = 68,["89"] = 68,["90"] = 68,["91"] = 68,["92"] = 69,["93"] = 70,["94"] = 66,["95"] = 66,["96"] = 66,["97"] = 74,["98"] = 74,["99"] = 74,["100"] = 74,["101"] = 74,["102"] = 74,["103"] = 74,["104"] = 74,["105"] = 74,["106"] = 74,["107"] = 74,["108"] = 74,["109"] = 74,["110"] = 90,["111"] = 90,["112"] = 90,["113"] = 91,["114"] = 91,["115"] = 91,["116"] = 91,["117"] = 91,["118"] = 91,["119"] = 91,["120"] = 91,["121"] = 91,["122"] = 91,["123"] = 91,["124"] = 91,["125"] = 91,["126"] = 90,["127"] = 90,["128"] = 46,["129"] = 94,["130"] = 95,["131"] = 96,["132"] = 97,["133"] = 97,["134"] = 97,["135"] = 97,["136"] = 97,["137"] = 97,["138"] = 97,["139"] = 105,["140"] = 106,["141"] = 106,["142"] = 106,["143"] = 106,["144"] = 106,["145"] = 106,["146"] = 106,["147"] = 106,["148"] = 106,["149"] = 106,["150"] = 106,["151"] = 106,["152"] = 106,["153"] = 106,["154"] = 106,["156"] = 117,["157"] = 118,["158"] = 118,["159"] = 119,["160"] = 118,["161"] = 118,["162"] = 118,["165"] = 94,["166"] = 3,["167"] = 2,["168"] = 3,["170"] = 127,["171"] = 127,["172"] = 128,["173"] = 135,["174"] = 136,["175"] = 137,["176"] = 138,["177"] = 139,["178"] = 140,["179"] = 141,["180"] = 142,["181"] = 143,["182"] = 144,["183"] = 145,["184"] = 145,["185"] = 145,["186"] = 145,["187"] = 145,["188"] = 145,["189"] = 145,["190"] = 145,["191"] = 145,["193"] = 135,["194"] = 148,["195"] = 149,["196"] = 150,["197"] = 151,["198"] = 151,["199"] = 151,["200"] = 151,["201"] = 151,["202"] = 151,["203"] = 151,["204"] = 151,["205"] = 151,["206"] = 151,["207"] = 161,["208"] = 162,["209"] = 162,["210"] = 162,["211"] = 162,["212"] = 162,["213"] = 162,["214"] = 162,["216"] = 148,["217"] = 128,["218"] = 127,["219"] = 128});
boss_1_2 = __TS__Class()
boss_1_2.name = "boss_1_2"
__TS__ClassExtends(boss_1_2, BaseAbility)
function boss_1_2.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/warning/trapezium/trapezium.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_sonic_wave.vpcf", context)
end
function boss_1_2.prototype.GetCastPoint(self)
    return 1
end
function boss_1_2.prototype.GetPlaybackRateOverride(self)
    return 0.5
end
function boss_1_2.prototype.GetCastAnimation(self)
    return ACT_DOTA_CAST_ABILITY_4
end
function boss_1_2.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vPostion = self:GetCursorPosition()
    local fDistance = self.Values:distance()
    local vDirection = (vPostion - hCaster:GetAbsOrigin()):Normalized()
    vPostion = hCaster:GetAbsOrigin() + vDirection * fDistance
    local start_width = self.Values:start_width()
    local end_width = self.Values:end_width()
    local fCastPoint = self:GetCastPoint()
    ParticleManager_s2c:ToClient(
        function()
            self.iParticleID = ParticleManager_s2c:CreateParticle("particles/warning/trapezium/trapezium.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                0,
                hCaster:GetAbsOrigin()
            )
            ParticleManager_s2c:SetParticleControl(self.iParticleID, 1, vPostion)
            ParticleManager_s2c:SetParticleControl(
                self.iParticleID,
                2,
                Vector(0, end_width, fCastPoint)
            )
        end,
        {weight = 0}
    )
    return true
end
function boss_1_2.prototype.OnAbilityPhaseInterrupted(self)
    if self.iParticleID ~= nil then
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
            end,
            {weight = 0}
        )
    end
end
function boss_1_2.prototype.OnSpellStart(self)
    if self.iParticleID ~= nil then
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:DestroyParticle(self.iParticleID, true)
            end,
            {weight = 0}
        )
    end
    local hCaster = self:GetCaster()
    local vStartPos = hCaster:GetAbsOrigin()
    local vPostion = self:GetCursorPosition()
    local vDirection = (vPostion - vStartPos):Normalized()
    local distance = self.Values:distance()
    vPostion = vStartPos + vDirection * distance
    local start_width = self.Values:start_width()
    local end_width = self.Values:end_width()
    local speed = self.Values:speed()
    local dmg_factor = self.Values:dmg_factor()
    local fDamage = AttributeKind.Atk:Get(hCaster) * dmg_factor
    local iParticleID
    ParticleManager_s2c:ToClient(
        function()
            iParticleID = ParticleManager_s2c:CreateParticle("particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_sonic_wave.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                0,
                hCaster:GetAttachmentOrigin(hCaster:ScriptLookupAttachment("attach_mouth"))
            )
            ParticleManager_s2c:SetParticleControlForward(iParticleID, 0, vDirection)
            ParticleManager_s2c:SetParticleControl(iParticleID, 1, vDirection * speed)
        end,
        {weight = 0}
    )
    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        Source = hCaster,
        EffectName = "",
        vSpawnOrigin = vStartPos,
        fDistance = distance,
        fStartRadius = start_width,
        fEndRadius = end_width,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        vVelocity = vDirection * speed,
        ExtraData = {iParticleID = iParticleID, fDamage = fDamage}
    })
    self:GameTimer(
        distance / speed,
        function()
            CreateModifierThinker(
                hCaster,
                self,
                "modifier_boss_1_2_thinker",
                {
                    duration = self.Values:burn_duration(),
                    vStartPos = VectorToString(_G, vStartPos),
                    vEndPos = VectorToString(_G, vPostion)
                },
                vStartPos,
                hCaster:GetTeamNumber(),
                false
            )
        end
    )
end
function boss_1_2.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    if IsValid(target) then
        local hCaster = self:GetCaster()
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            damage = extraData.fDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            victim = target
        })
        local vCenter = hCaster:GetAbsOrigin()
        target:AddNewModifier(
            hCaster,
            self,
            "modifier_knockback",
            {
                center_x = vCenter.x,
                center_y = vCenter.y,
                center_z = vCenter.z,
                should_stun = 0,
                duration = self.Values:knockback_duration(),
                knockback_duration = self.Values:knockback_duration(),
                knockback_distance = self.Values:knockback_distance(),
                knockback_height = 100
            }
        )
    else
        if extraData.iParticleID ~= nil then
            ParticleManager_s2c:ToClient(
                function()
                    ParticleManager_s2c:DestroyParticle(extraData.iParticleID, false)
                end,
                {weight = 0}
            )
        end
    end
end
boss_1_2 = __TS__DecorateLegacy(
    {register(_G)},
    boss_1_2
)
modifier_boss_1_2_thinker = __TS__Class()
modifier_boss_1_2_thinker.name = "modifier_boss_1_2_thinker"
__TS__ClassExtends(modifier_boss_1_2_thinker, BaseModifier)
function modifier_boss_1_2_thinker.prototype.OnCreated(self, params)
    if IsServer() then
        local hCaster = self:GetCaster()
        self.burn_interval = self.Values:burn_interval()
        self.dmg_factor = self.Values:dmg_factor()
        self.end_width = self.Values:end_width()
        self.fDamage = AttributeKind.Atk:Get(hCaster) * self.dmg_factor * 0.5
        self.vStartPos = StringToVector(_G, params.vStartPos)
        self.vEndPos = StringToVector(_G, params.vEndPos)
        self:StartIntervalThink(self.burn_interval)
        DebugDrawLine(
            self.vStartPos,
            self.vEndPos,
            255,
            0,
            0,
            false,
            self:GetDuration()
        )
    end
end
function modifier_boss_1_2_thinker.prototype.OnIntervalThink(self)
    local hCaster = self:GetCaster()
    local hAbility = self:GetAbility()
    local tTargets = FindUnitsInLine(
        hCaster:GetTeamNumber(),
        self.vStartPos,
        self.vEndPos,
        nil,
        self.end_width,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE
    )
    for _, hTarget in ipairs(tTargets) do
        ApplyDamage({
            ability = hAbility,
            attacker = hCaster,
            damage = self.fDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            victim = hTarget
        })
    end
end
modifier_boss_1_2_thinker = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_1_2_thinker
)
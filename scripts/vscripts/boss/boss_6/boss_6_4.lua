--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_6\\boss_6_4"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["13"] = 3,["14"] = 8,["15"] = 19,["16"] = 2,["17"] = 21,["18"] = 22,["19"] = 23,["20"] = 24,["21"] = 25,["22"] = 26,["23"] = 27,["24"] = 21,["25"] = 30,["26"] = 31,["27"] = 30,["28"] = 34,["29"] = 35,["30"] = 38,["31"] = 38,["32"] = 39,["33"] = 38,["34"] = 38,["35"] = 38,["36"] = 44,["37"] = 45,["38"] = 34,["39"] = 48,["40"] = 49,["41"] = 50,["43"] = 48,["44"] = 54,["45"] = 55,["46"] = 57,["47"] = 58,["49"] = 61,["50"] = 62,["53"] = 54,["54"] = 68,["55"] = 83,["56"] = 84,["57"] = 86,["58"] = 86,["59"] = 86,["60"] = 86,["61"] = 87,["62"] = 94,["63"] = 95,["64"] = 97,["65"] = 98,["67"] = 100,["68"] = 101,["70"] = 104,["71"] = 105,["72"] = 105,["73"] = 105,["74"] = 106,["75"] = 107,["76"] = 108,["78"] = 105,["79"] = 105,["80"] = 111,["83"] = 112,["85"] = 114,["87"] = 116,["88"] = 117,["90"] = 121,["91"] = 122,["92"] = 122,["93"] = 123,["94"] = 124,["95"] = 125,["96"] = 126,["97"] = 126,["98"] = 126,["99"] = 126,["100"] = 126,["101"] = 126,["102"] = 126,["103"] = 126,["104"] = 126,["105"] = 127,["106"] = 127,["107"] = 127,["108"] = 127,["109"] = 127,["110"] = 122,["111"] = 122,["112"] = 122,["113"] = 133,["114"] = 134,["115"] = 135,["116"] = 136,["117"] = 136,["118"] = 137,["119"] = 137,["120"] = 139,["121"] = 140,["122"] = 141,["124"] = 143,["125"] = 144,["127"] = 148,["128"] = 149,["129"] = 149,["130"] = 150,["131"] = 149,["132"] = 149,["133"] = 149,["135"] = 156,["136"] = 137,["137"] = 137,["139"] = 162,["140"] = 163,["141"] = 163,["142"] = 163,["143"] = 163,["144"] = 163,["145"] = 163,["146"] = 163,["147"] = 163,["148"] = 164,["149"] = 165,["150"] = 166,["151"] = 167,["152"] = 168,["153"] = 169,["154"] = 170,["155"] = 173,["156"] = 173,["157"] = 174,["158"] = 173,["159"] = 173,["160"] = 173,["161"] = 162,["162"] = 179,["163"] = 180,["164"] = 181,["165"] = 181,["167"] = 183,["169"] = 186,["170"] = 187,["171"] = 68,["172"] = 191,["173"] = 192,["174"] = 193,["177"] = 195,["178"] = 196,["180"] = 198,["181"] = 199,["182"] = 199,["183"] = 200,["184"] = 199,["185"] = 199,["186"] = 199,["188"] = 205,["189"] = 206,["190"] = 206,["191"] = 207,["192"] = 206,["193"] = 206,["194"] = 206,["195"] = 211,["196"] = 212,["198"] = 214,["199"] = 191,["200"] = 5,["201"] = 3,["202"] = 2,["203"] = 3,["205"] = 220,["206"] = 220,["207"] = 221,["208"] = 222,["209"] = 222,["210"] = 222,["211"] = 227,["212"] = 228,["214"] = 231,["215"] = 232,["216"] = 233,["217"] = 234,["218"] = 234,["219"] = 234,["220"] = 234,["221"] = 234,["222"] = 234,["223"] = 234,["224"] = 234,["225"] = 234,["226"] = 235,["227"] = 235,["228"] = 235,["229"] = 235,["230"] = 235,["231"] = 235,["232"] = 235,["233"] = 235,["236"] = 227,["237"] = 240,["238"] = 241,["239"] = 243,["240"] = 244,["241"] = 245,["242"] = 246,["243"] = 249,["244"] = 249,["245"] = 250,["246"] = 251,["247"] = 251,["248"] = 251,["249"] = 251,["250"] = 251,["251"] = 252,["252"] = 252,["253"] = 252,["254"] = 252,["255"] = 252,["256"] = 254,["257"] = 256,["258"] = 249,["259"] = 249,["260"] = 249,["262"] = 240,["263"] = 263,["264"] = 264,["265"] = 263,["266"] = 271,["267"] = 272,["268"] = 271,["269"] = 275,["270"] = 276,["271"] = 275,["272"] = 221,["273"] = 220,["274"] = 221,["276"] = 281,["277"] = 281,["278"] = 282,["280"] = 282,["281"] = 290,["282"] = 281,["283"] = 283,["284"] = 283,["285"] = 283,["286"] = 296,["287"] = 297,["288"] = 298,["289"] = 299,["290"] = 300,["293"] = 304,["294"] = 307,["295"] = 308,["296"] = 309,["297"] = 310,["298"] = 311,["299"] = 313,["300"] = 314,["301"] = 315,["302"] = 316,["304"] = 319,["305"] = 320,["306"] = 321,["307"] = 321,["308"] = 321,["309"] = 321,["310"] = 321,["311"] = 321,["312"] = 321,["313"] = 321,["314"] = 321,["315"] = 322,["316"] = 322,["317"] = 322,["318"] = 322,["319"] = 322,["320"] = 322,["321"] = 322,["322"] = 322,["325"] = 296,["326"] = 327,["327"] = 328,["328"] = 329,["329"] = 330,["330"] = 332,["331"] = 333,["332"] = 335,["333"] = 336,["334"] = 338,["335"] = 339,["337"] = 341,["338"] = 342,["339"] = 344,["340"] = 347,["341"] = 347,["342"] = 348,["343"] = 349,["344"] = 350,["345"] = 350,["346"] = 350,["347"] = 350,["348"] = 350,["349"] = 351,["350"] = 353,["351"] = 354,["352"] = 355,["353"] = 355,["354"] = 355,["355"] = 355,["356"] = 355,["357"] = 356,["358"] = 358,["359"] = 359,["360"] = 347,["361"] = 347,["362"] = 347,["363"] = 364,["364"] = 367,["365"] = 368,["366"] = 368,["367"] = 368,["368"] = 368,["369"] = 368,["370"] = 368,["371"] = 368,["372"] = 368,["373"] = 368,["374"] = 368,["375"] = 368,["376"] = 375,["379"] = 378,["380"] = 378,["381"] = 378,["382"] = 378,["383"] = 378,["384"] = 378,["385"] = 378,["386"] = 386,["387"] = 387,["388"] = 388,["389"] = 389,["390"] = 389,["391"] = 389,["392"] = 389,["393"] = 389,["394"] = 389,["395"] = 388,["396"] = 388,["397"] = 388,["398"] = 388,["399"] = 388,["400"] = 388,["401"] = 388,["402"] = 388,["403"] = 397,["404"] = 398,["405"] = 399,["406"] = 400,["407"] = 401,["408"] = 402,["410"] = 404,["413"] = 409,["414"] = 410,["415"] = 410,["416"] = 410,["417"] = 410,["418"] = 410,["419"] = 410,["420"] = 410,["421"] = 410,["422"] = 410,["423"] = 410,["424"] = 410,["425"] = 417,["426"] = 419,["427"] = 420,["428"] = 421,["431"] = 425,["432"] = 426,["433"] = 427,["434"] = 427,["435"] = 427,["436"] = 427,["437"] = 427,["438"] = 427,["439"] = 426,["440"] = 426,["441"] = 426,["442"] = 426,["443"] = 426,["444"] = 426,["445"] = 426,["446"] = 426,["447"] = 435,["448"] = 436,["449"] = 437,["450"] = 438,["451"] = 439,["452"] = 440,["454"] = 442,["457"] = 447,["458"] = 448,["459"] = 449,["460"] = 450,["461"] = 451,["462"] = 452,["463"] = 449,["465"] = 457,["466"] = 457,["467"] = 457,["468"] = 458,["469"] = 457,["470"] = 457,["472"] = 327,["473"] = 463,["474"] = 464,["475"] = 463,["476"] = 467,["477"] = 468,["478"] = 469,["479"] = 470,["480"] = 471,["481"] = 467,["482"] = 474,["483"] = 475,["484"] = 474,["485"] = 282,["486"] = 281,["487"] = 282});
boss_6_4 = __TS__Class()
boss_6_4.name = "boss_6_4"
__TS__ClassExtends(boss_6_4, BossAbility)
function boss_6_4.prototype.____constructor(self, ...)
    BossAbility.prototype.____constructor(self, ...)
    self.tFireDatas = {}
    self.tMeteors = {}
end
function boss_6_4.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_4/meteor/meteor.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_4/meteor_fly/meteor_fly.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_4/meteor_crumble/meteor_crumble.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_4/meteor_bomb/meteor_bomb.vpcf", context)
    PrecacheResource("particle", "particles/warning/circular_1/circular_1.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_4/meteor_ground/meteor_ground.vpcf", context)
end
function boss_6_4.prototype.GetPlaybackRateOverride(self)
    return 3 / self:GetCastPoint()
end
function boss_6_4.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    ParticleManager_s2c:ToClient(
        function()
            ParticleManager_s2c:EmitSoundOn("Hero_Lycan.Howl", hCaster)
        end,
        {weight = 0}
    )
    self.iMeteorID_Cur = self:FireMeteor({})
    return self.iMeteorID_Cur ~= nil
end
function boss_6_4.prototype.OnAbilityPhaseInterrupted(self)
    if self.iMeteorID_Cur ~= nil then
        self:StopFireMeteor(self.iMeteorID_Cur)
    end
end
function boss_6_4.prototype.OnDestroy(self)
    if IsServer() then
        for iMeteorID, _ in pairs(self.tFireDatas) do
            self:StopFireMeteor(iMeteorID)
        end
        for _, hMeteor in pairs(self.tMeteors) do
            hMeteor:ForceKill(false)
        end
    end
end
function boss_6_4.prototype.FireMeteor(self, params)
    local hCaster = self:GetCaster()
    local hTarget
    local ____boss_6_4_0, ____iMeteorID_1 = boss_6_4, "iMeteorID"
    local ____boss_6_4_iMeteorID_2 = ____boss_6_4_0[____iMeteorID_1]
    ____boss_6_4_0[____iMeteorID_1] = ____boss_6_4_iMeteorID_2 + 1
    local iMeteorID = ____boss_6_4_iMeteorID_2
    local tFireData = {id = iMeteorID, pos = nil, timers = {}, ability = params.ability}
    params.duration = params.duration or self:GetCastPoint()
    params.duration_fly = params.duration_fly or self.Values:meteor_fly_duration()
    if params.target_pos ~= nil then
        tFireData.pos = params.target_pos
    else
        if params.target ~= nil then
            hTarget = params.target
        else
            local t = {}
            EachPlayer(
                _G,
                function(____, iPlayerID)
                    local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
                    if hHero ~= nil and hHero:IsAlive() then
                        t[#t + 1] = hHero
                    end
                end
            )
            if #t <= 0 then
                return
            end
            hTarget = t[RandomInt(0, #t - 1) + 1]
        end
        tFireData.pos = hTarget:GetAbsOrigin()
    end
    if params.random_offset_max ~= nil then
        tFireData.pos = tFireData.pos + RandomVector(RandomFloat(params.random_offset_min or 0, params.random_offset_max))
    end
    local iPtclID_Warning
    ParticleManager_s2c:ToClient(
        function()
            iPtclID_Warning = ParticleManager_s2c:CreateParticle("particles/warning/circular_1/circular_1.vpcf", PATTACH_WORLDORIGIN, nil)
            tFireData.ptclid_warning = iPtclID_Warning
            ParticleManager_s2c:SetParticleControl(iPtclID_Warning, 0, tFireData.pos)
            ParticleManager_s2c:SetParticleControl(
                iPtclID_Warning,
                2,
                Vector(
                    self.Values:range(),
                    params.duration,
                    1 / params.duration
                )
            )
            ParticleManager_s2c:SetParticleControl(
                iPtclID_Warning,
                3,
                Vector(KeyValues.UnitsKv.summon_boss_6_4.RingRadius * 1.3, 0, 0)
            )
        end,
        {weight = 0}
    )
    if hTarget ~= nil then
        local fFPS = FrameTime()
        local fSpeed = self.Values:trace_speed() * fFPS
        local ____tFireData_timers_3 = tFireData.timers
        ____tFireData_timers_3[#____tFireData_timers_3 + 1] = self:GameTimer(
            0,
            function()
                local fDis = (hTarget:GetAbsOrigin() - tFireData.pos):Length2D()
                if fSpeed >= fDis then
                    tFireData.pos = hTarget:GetAbsOrigin()
                else
                    local vVel = (hTarget:GetAbsOrigin() - tFireData.pos):Normalized() * fSpeed
                    tFireData.pos = tFireData.pos + vVel
                end
                if iPtclID_Warning ~= nil then
                    ParticleManager_s2c:ToClient(
                        function()
                            ParticleManager_s2c:SetParticleControl(iPtclID_Warning, 0, tFireData.pos)
                        end,
                        {weight = 0}
                    )
                end
                return 0
            end
        )
    end
    local function createMeteor()
        local hMeteor = CreateUnitByName(
            "summon_boss_6_4",
            tFireData.pos,
            false,
            hCaster,
            hCaster,
            hCaster:GetTeamNumber()
        )
        tFireData.meteor = hMeteor
        hMeteor.tFireData = tFireData
        local tKv = KeyValues.UnitsKv.summon_boss_6_4
        hMeteor:SetHullRadius(tKv.RingRadius)
        hMeteor:SetForwardVector((tFireData.pos - hCaster:GetAbsOrigin()):Normalized())
        hMeteor:AddNewModifier(hCaster, self, "modifier_boss_6_4_meteor", nil)
        hMeteor:AddNewModifier(hCaster, self, "modifier_boss_6_4_meteor_fly", {duration = params.duration_fly})
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:EmitSoundOn("Boss_6.4_MeteorLoop", hMeteor)
            end,
            {weight = 0}
        )
    end
    local fDelay = params.duration - params.duration_fly
    if fDelay > 0 then
        local ____tFireData_timers_4 = tFireData.timers
        ____tFireData_timers_4[#____tFireData_timers_4 + 1] = self:GameTimer(fDelay, createMeteor)
    else
        createMeteor(_G)
    end
    self.tFireDatas[iMeteorID] = tFireData
    return iMeteorID
end
function boss_6_4.prototype.StopFireMeteor(self, iMeteorID)
    local tFireData = self.tFireDatas[iMeteorID]
    if tFireData == nil then
        return
    end
    for ____, sTimer in ipairs(tFireData.timers) do
        self:StopTimer(sTimer)
    end
    if tFireData.ptclid_warning then
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:DestroyParticle(tFireData.ptclid_warning, true)
            end,
            {weight = 0}
        )
    end
    if IsValid(tFireData.meteor) then
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:StopSoundOn("Boss_6.4_MeteorLoop", tFireData.meteor)
            end,
            {weight = 0}
        )
        tFireData.meteor:AddNoDraw()
        tFireData.meteor:ForceKill(false)
    end
    self.tFireDatas[iMeteorID] = nil
end
boss_6_4.iMeteorID = 0
boss_6_4 = __TS__DecorateLegacy(
    {register(_G)},
    boss_6_4
)
modifier_boss_6_4_meteor = __TS__Class()
modifier_boss_6_4_meteor.name = "modifier_boss_6_4_meteor"
__TS__ClassExtends(modifier_boss_6_4_meteor, BaseModifier)
function modifier_boss_6_4_meteor.prototype.IsHidden(self)
    return true
end
function modifier_boss_6_4_meteor.prototype.OnCreated(self, params)
    if IsServer() then
    else
        local hParent = self:GetParent()
        if ParticleManager_s2c:CheckClientBlocked() then
            local iPtclID = ParticleManager:CreateParticle("particles/boss/boss_6/boss_6_4/meteor/meteor.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
            ParticleManager:SetParticleControlEnt(
                iPtclID,
                3,
                hParent,
                PATTACH_ABSORIGIN_FOLLOW,
                "attach_hitloc",
                hParent:GetAbsOrigin(),
                true
            )
            self:AddParticle(
                iPtclID,
                false,
                false,
                -1,
                false,
                false
            )
        end
    end
end
function modifier_boss_6_4_meteor.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        hParent:AddNoDraw()
        local hAblt = self:GetAbility()
        hAblt.tMeteors[hParent:entindex()] = nil
        ParticleManager_s2c:ToClient(
            function()
                local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_4/meteor_crumble/meteor_crumble.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(
                    iPtclID,
                    3,
                    hParent:GetAbsOrigin()
                )
                ParticleManager_s2c:SetParticleControlForward(
                    iPtclID,
                    3,
                    hParent:GetForwardVector()
                )
                ParticleManager_s2c:DestroyParticle(self.iPtclID_ground, false)
                ParticleManager_s2c:EmitSoundOn("Boss_6.4_MeteorCrumble", hParent)
            end,
            {weight = 0}
        )
    end
end
function modifier_boss_6_4_meteor.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_UNSELECTABLE] = true}
end
function modifier_boss_6_4_meteor.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_VISUAL_Z_DELTA}
end
function modifier_boss_6_4_meteor.prototype.GetVisualZDelta(self)
    return 35
end
modifier_boss_6_4_meteor = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_6_4_meteor
)
modifier_boss_6_4_meteor_fly = __TS__Class()
modifier_boss_6_4_meteor_fly.name = "modifier_boss_6_4_meteor_fly"
__TS__ClassExtends(modifier_boss_6_4_meteor_fly, BaseModifierMotionBoth)
function modifier_boss_6_4_meteor_fly.prototype.____constructor(self, ...)
    BaseModifierMotionBoth.prototype.____constructor(self, ...)
    self.c = 800
end
function modifier_boss_6_4_meteor_fly.prototype.IsHidden(self)
    return true
end
function modifier_boss_6_4_meteor_fly.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsServer() then
        if not self:ApplyHorizontalMotionController() or not self:ApplyVerticalMotionController() then
            self:Destroy()
            return
        end
        self.tFireData = hParent.tFireData
        local hCaster = self:GetCaster()
        self.vStart = hCaster:GetAbsOrigin()
        self.vStart.z = self.c
        self.vTarget = self.tFireData.pos
        hParent:SetAbsOrigin(self.vStart)
        local fDis = (self.vTarget - self.vStart):Length2D()
        self.a = -self.c / fDis ^ 2
        self.vVel = (self.vTarget - self.vStart):Normalized() * (fDis / self:GetDuration())
        self.vVel.z = 0
    else
        if ParticleManager_s2c:CheckClientBlocked() then
            local iPtclID = ParticleManager:CreateParticle("particles/boss/boss_6/boss_6_4/meteor_fly/meteor_fly.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
            ParticleManager:SetParticleControlEnt(
                iPtclID,
                3,
                hParent,
                PATTACH_ABSORIGIN_FOLLOW,
                "attach_hitloc",
                hParent:GetAbsOrigin(),
                true
            )
            self:AddParticle(
                iPtclID,
                false,
                false,
                -1,
                false,
                false
            )
        end
    end
end
function modifier_boss_6_4_meteor_fly.prototype.OnDestroy(self)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()
        hCaster:RemoveHorizontalMotionController(self)
        hCaster:RemoveVerticalMotionController(self)
        local vTarget = self.vTarget
        local hAblt = self:GetAbility()
        for ____, sTimer in ipairs(self.tFireData.timers) do
            hAblt:StopTimer(sTimer)
        end
        hAblt.tFireDatas[self.tFireData.id] = nil
        hAblt.tMeteors[hParent:entindex()] = hParent
        local range = self.Values:range()
        ParticleManager_s2c:ToClient(
            function()
                local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_1/dust_bomb_warp/dust_bomb_warp.vpcf", PATTACH_WORLDORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iPtclID, 0, vTarget)
                ParticleManager_s2c:SetParticleControl(
                    iPtclID,
                    1,
                    Vector(range, 0, 0)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
                local iPtclID2 = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_4/meteor_bomb/meteor_bomb.vpcf", PATTACH_WORLDORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iPtclID2, 0, vTarget)
                ParticleManager_s2c:SetParticleControl(
                    iPtclID2,
                    1,
                    Vector(range, 0, 0)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iPtclID2)
                ParticleManager_s2c:StopSoundOn("Boss_6.4_MeteorLoop", hParent)
                ParticleManager_s2c:EmitSoundOn("Boss_6.4_MeteorImpact", hParent)
            end,
            {weight = 0}
        )
        local fMeteorReadius = hParent:GetHullRadius()
        local fDmg = self.Values:damage_factor() * AttributeKind.Atk:Get(hCaster)
        for ____, hTarget in ipairs(FindUnitsInRadius(
            hCaster:GetTeamNumber(),
            vTarget,
            nil,
            range,
            hAblt:GetAbilityTargetTeam(),
            hAblt:GetAbilityTargetType(),
            hAblt:GetAbilityTargetFlags(),
            FIND_ANY_ORDER,
            false
        )) do
            if not IsValid(hTarget) then
                return
            end
            ApplyDamage({
                ability = self.tFireData.ability or hAblt,
                attacker = hCaster,
                damage_type = DAMAGE_TYPE_PURE,
                victim = hTarget,
                damage = fDmg
            })
            local fDis = (hTarget:GetAbsOrigin() - vTarget):Length2D()
            if fDis <= fMeteorReadius then
                local tKnockback = {
                    duration = RemapValClamped(
                        fDis,
                        0,
                        fMeteorReadius,
                        0.1,
                        0.3
                    ),
                    knockback_distance = fMeteorReadius + hTarget:GetHullRadius() - fDis,
                    knockback_height = 50,
                    center_x = vTarget.x,
                    center_y = vTarget.y,
                    center_z = vTarget.z,
                    should_stun = 0
                }
                tKnockback.knockback_duration = tKnockback.duration
                if fDis < 1 then
                    local vCenter = vTarget - hTarget:GetForwardVector() * 100
                    tKnockback.center_x = vCenter.x
                    tKnockback.center_y = vCenter.y
                    tKnockback.center_z = vCenter.z
                end
                hTarget:AddNewModifier(hCaster, hAblt, "modifier_knockback", tKnockback)
            end
        end
        GridNav:DestroyTreesAroundPoint(vTarget, fMeteorReadius, true)
        for ____, hTarget in ipairs(FindUnitsInRadius(
            hCaster:GetTeamNumber(),
            vTarget,
            nil,
            fMeteorReadius,
            DOTA_UNIT_TARGET_TEAM_BOTH,
            DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
            DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
            FIND_ANY_ORDER,
            false
        )) do
            if IsValid(hTarget) and hTarget:HasModifier("modifier_boss_6_4_meteor") then
                if hTarget ~= hParent then
                    hTarget:SetForwardVector((hTarget:GetAbsOrigin() - vTarget):Normalized())
                    hTarget:ForceKill(false)
                end
            else
                local fDis = (hTarget:GetAbsOrigin() - vTarget):Length2D()
                local tKnockback = {
                    duration = RemapValClamped(
                        fDis,
                        0,
                        fMeteorReadius,
                        0.1,
                        0.3
                    ),
                    knockback_distance = fMeteorReadius + hTarget:GetHullRadius() - fDis,
                    knockback_height = 50,
                    center_x = vTarget.x,
                    center_y = vTarget.y,
                    center_z = vTarget.z,
                    should_stun = 0
                }
                tKnockback.knockback_duration = tKnockback.duration
                if fDis < 1 then
                    local vCenter = vTarget - hTarget:GetForwardVector() * 100
                    tKnockback.center_x = vCenter.x
                    tKnockback.center_y = vCenter.y
                    tKnockback.center_z = vCenter.z
                end
                hTarget:AddNewModifier(hCaster, hAblt, "modifier_knockback", tKnockback)
            end
        end
        local hMdf = hParent:FindModifierByName("modifier_boss_6_4_meteor")
        if hMdf ~= nil then
            ParticleManager_s2c:ToClient(function()
                local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_4/meteor_ground/meteor_ground.vpcf", PATTACH_WORLDORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iPtclID, 0, vTarget)
                hMdf.iPtclID_ground = iPtclID
            end)
        end
        hParent:GameTimer(
            0,
            function()
                hParent:SetAbsOrigin(self.vTarget)
            end
        )
    end
end
function modifier_boss_6_4_meteor_fly.prototype.UpdateHorizontalMotion(self, me, dt)
    me:SetAbsOrigin(me:GetAbsOrigin() + self.vVel * dt)
end
function modifier_boss_6_4_meteor_fly.prototype.UpdateVerticalMotion(self, me, dt)
    local vPos = me:GetAbsOrigin()
    local x = (vPos - self.vStart):Length2D()
    vPos.z = self.a * x ^ 2 + self.c
    me:SetAbsOrigin(vPos)
end
function modifier_boss_6_4_meteor_fly.prototype.CheckState(self)
    return {[MODIFIER_STATE_NO_UNIT_COLLISION] = true}
end
modifier_boss_6_4_meteor_fly = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_6_4_meteor_fly
)
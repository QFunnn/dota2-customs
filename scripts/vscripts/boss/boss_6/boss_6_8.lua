--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_6\\boss_6_8"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 10,["13"] = 11,["14"] = 12,["15"] = 13,["16"] = 14,["17"] = 15,["18"] = 16,["19"] = 17,["20"] = 18,["21"] = 10,["22"] = 21,["23"] = 22,["24"] = 23,["25"] = 24,["26"] = 27,["27"] = 28,["28"] = 29,["29"] = 30,["30"] = 31,["32"] = 32,["33"] = 34,["34"] = 38,["35"] = 39,["36"] = 40,["37"] = 41,["38"] = 42,["39"] = 42,["40"] = 42,["41"] = 43,["42"] = 43,["43"] = 44,["44"] = 44,["45"] = 44,["46"] = 44,["47"] = 42,["48"] = 42,["49"] = 42,["50"] = 51,["54"] = 57,["55"] = 57,["56"] = 57,["57"] = 58,["58"] = 58,["59"] = 59,["60"] = 59,["61"] = 59,["62"] = 59,["63"] = 59,["64"] = 59,["65"] = 57,["66"] = 57,["67"] = 57,["72"] = 71,["73"] = 74,["74"] = 75,["75"] = 75,["76"] = 76,["77"] = 78,["78"] = 78,["79"] = 78,["80"] = 78,["81"] = 78,["82"] = 79,["83"] = 79,["84"] = 79,["85"] = 79,["86"] = 79,["87"] = 80,["88"] = 80,["89"] = 80,["90"] = 80,["91"] = 80,["92"] = 81,["93"] = 81,["94"] = 83,["95"] = 84,["96"] = 85,["97"] = 85,["98"] = 85,["99"] = 85,["100"] = 85,["101"] = 86,["102"] = 86,["103"] = 88,["104"] = 89,["105"] = 89,["106"] = 92,["107"] = 93,["108"] = 94,["109"] = 94,["110"] = 94,["111"] = 94,["112"] = 94,["113"] = 95,["114"] = 75,["115"] = 75,["116"] = 75,["117"] = 101,["118"] = 102,["119"] = 102,["120"] = 102,["121"] = 103,["122"] = 104,["124"] = 106,["126"] = 108,["127"] = 109,["128"] = 102,["129"] = 102,["130"] = 102,["131"] = 113,["132"] = 113,["133"] = 113,["134"] = 114,["135"] = 114,["136"] = 115,["137"] = 116,["138"] = 117,["139"] = 114,["140"] = 114,["141"] = 114,["142"] = 113,["143"] = 113,["144"] = 113,["145"] = 123,["146"] = 123,["147"] = 123,["148"] = 125,["149"] = 125,["150"] = 125,["151"] = 125,["152"] = 125,["153"] = 125,["154"] = 125,["155"] = 125,["156"] = 125,["157"] = 127,["158"] = 128,["159"] = 129,["160"] = 130,["161"] = 131,["162"] = 132,["163"] = 132,["164"] = 132,["165"] = 132,["166"] = 132,["167"] = 132,["168"] = 132,["169"] = 132,["170"] = 132,["171"] = 132,["172"] = 137,["173"] = 137,["174"] = 137,["175"] = 137,["176"] = 138,["179"] = 143,["180"] = 144,["181"] = 145,["182"] = 147,["183"] = 147,["184"] = 148,["185"] = 149,["186"] = 150,["187"] = 151,["188"] = 151,["189"] = 151,["190"] = 151,["191"] = 151,["192"] = 152,["193"] = 153,["194"] = 153,["195"] = 153,["196"] = 153,["197"] = 153,["198"] = 154,["199"] = 154,["200"] = 154,["201"] = 154,["202"] = 154,["203"] = 154,["204"] = 154,["205"] = 154,["206"] = 147,["207"] = 147,["208"] = 147,["209"] = 159,["210"] = 160,["211"] = 161,["212"] = 162,["213"] = 162,["214"] = 162,["215"] = 162,["216"] = 162,["217"] = 162,["218"] = 162,["219"] = 162,["220"] = 159,["224"] = 167,["225"] = 167,["226"] = 167,["227"] = 167,["228"] = 167,["229"] = 167,["230"] = 167,["231"] = 167,["232"] = 167,["233"] = 167,["234"] = 167,["235"] = 174,["236"] = 175,["237"] = 175,["238"] = 175,["239"] = 175,["240"] = 175,["241"] = 175,["242"] = 175,["243"] = 175,["244"] = 175,["247"] = 181,["248"] = 123,["249"] = 123,["250"] = 123,["251"] = 184,["252"] = 21,["253"] = 187,["254"] = 188,["255"] = 189,["256"] = 190,["257"] = 190,["258"] = 191,["259"] = 192,["261"] = 190,["262"] = 190,["263"] = 190,["264"] = 197,["266"] = 201,["267"] = 202,["268"] = 203,["269"] = 204,["271"] = 206,["272"] = 207,["274"] = 209,["276"] = 212,["277"] = 213,["278"] = 214,["279"] = 187,["280"] = 217,["281"] = 218,["282"] = 219,["283"] = 220,["284"] = 220,["285"] = 221,["286"] = 222,["288"] = 220,["289"] = 220,["290"] = 220,["291"] = 227,["292"] = 230,["293"] = 233,["294"] = 233,["295"] = 233,["296"] = 233,["297"] = 233,["298"] = 233,["299"] = 233,["300"] = 233,["301"] = 233,["302"] = 234,["303"] = 234,["304"] = 234,["305"] = 235,["306"] = 235,["307"] = 235,["308"] = 235,["309"] = 235,["310"] = 235,["311"] = 235,["312"] = 235,["313"] = 235,["314"] = 238,["315"] = 238,["316"] = 239,["317"] = 240,["318"] = 240,["319"] = 240,["320"] = 240,["321"] = 240,["322"] = 241,["323"] = 241,["324"] = 241,["325"] = 241,["326"] = 241,["327"] = 242,["328"] = 238,["329"] = 238,["330"] = 238,["331"] = 248,["332"] = 248,["333"] = 248,["334"] = 249,["335"] = 249,["336"] = 252,["337"] = 253,["338"] = 253,["339"] = 253,["340"] = 253,["341"] = 253,["342"] = 254,["343"] = 254,["344"] = 254,["345"] = 254,["346"] = 254,["347"] = 255,["348"] = 263,["349"] = 249,["350"] = 249,["351"] = 249,["352"] = 269,["353"] = 270,["354"] = 271,["355"] = 272,["356"] = 273,["357"] = 274,["358"] = 275,["359"] = 276,["360"] = 278,["361"] = 278,["362"] = 278,["363"] = 278,["364"] = 278,["365"] = 278,["366"] = 278,["367"] = 278,["368"] = 278,["369"] = 278,["370"] = 283,["371"] = 283,["372"] = 283,["373"] = 283,["374"] = 284,["377"] = 289,["378"] = 290,["382"] = 296,["383"] = 297,["384"] = 297,["385"] = 297,["386"] = 297,["387"] = 297,["388"] = 297,["389"] = 297,["390"] = 297,["391"] = 297,["392"] = 297,["393"] = 297,["394"] = 304,["395"] = 305,["396"] = 305,["397"] = 305,["398"] = 305,["399"] = 305,["400"] = 305,["401"] = 305,["404"] = 248,["405"] = 248,["406"] = 234,["407"] = 234,["408"] = 217,["409"] = 318,["410"] = 319,["411"] = 318,["412"] = 325,["413"] = 326,["414"] = 327,["415"] = 328,["417"] = 325,["418"] = 3,["419"] = 2,["420"] = 3,["422"] = 334,["423"] = 334,["424"] = 335,["425"] = 336,["426"] = 336,["427"] = 336,["428"] = 337,["429"] = 337,["430"] = 337,["431"] = 339,["432"] = 340,["434"] = 342,["435"] = 343,["436"] = 344,["437"] = 344,["438"] = 344,["439"] = 344,["440"] = 344,["441"] = 345,["442"] = 346,["443"] = 346,["444"] = 346,["445"] = 346,["446"] = 346,["447"] = 346,["448"] = 346,["449"] = 346,["452"] = 339,["453"] = 351,["454"] = 352,["455"] = 353,["456"] = 354,["457"] = 355,["458"] = 356,["459"] = 357,["460"] = 358,["461"] = 358,["462"] = 358,["463"] = 358,["464"] = 358,["465"] = 358,["466"] = 358,["469"] = 351,["470"] = 335,["471"] = 334,["472"] = 335,["474"] = 371,["475"] = 371,["476"] = 372,["477"] = 373,["478"] = 373,["479"] = 373,["480"] = 374,["481"] = 374,["482"] = 374,["483"] = 376,["484"] = 377,["485"] = 378,["487"] = 376,["488"] = 381,["489"] = 382,["490"] = 383,["492"] = 381,["493"] = 372,["494"] = 371,["495"] = 372,["497"] = 388,["498"] = 388,["499"] = 389,["500"] = 390,["501"] = 390,["502"] = 390,["503"] = 391,["504"] = 392,["505"] = 392,["506"] = 392,["507"] = 392,["508"] = 391,["509"] = 397,["510"] = 398,["511"] = 399,["513"] = 401,["515"] = 397,["516"] = 389,["517"] = 388,["518"] = 389,["520"] = 406,["521"] = 406,["522"] = 407,["523"] = 408,["524"] = 408,["525"] = 408,["526"] = 409,["527"] = 410,["528"] = 409,["529"] = 407,["530"] = 406,["531"] = 407});
boss_6_8 = __TS__Class()
boss_6_8.name = "boss_6_8"
__TS__ClassExtends(boss_6_8, DiyAbility)
function boss_6_8.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_8/caster/caster.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_8/meteor_fly/meteor_fly.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_8/meteor_ground/meteor_ground.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_8/meteor_ground2/meteor_ground2.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_8/wraing_safe/wraing_safe.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_8/target_fire/target_fire.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_8/meteor_collapse/meteor_collapse.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_6/boss_6_8/bomb/bomb.vpcf", context)
end
function boss_6_8.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local fCastPoint = self:GetCastPoint()
    local meteor_block_range = self.Values:meteor_block_range()
    local hAblt4 = hCaster:FindAbilityByName("boss_6_4")
    if IsValid(hAblt4) then
        self.tLittleMeteorIDs = {}
        local tIgnorePlayerID = {}
        for i = 1, self.Values:little_meteor_count() do
            do
                if RollPercentage(50) then
                    local iPlayerID = RandomPlayer(_G, {bNotAbandoned = true, tIgnoreID = tIgnorePlayerID})
                    if iPlayerID ~= nil then
                        tIgnorePlayerID[#tIgnorePlayerID + 1] = iPlayerID
                        local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
                        if IsValid(hHero) then
                            self:GameTimer(
                                (i - 1) * fCastPoint * RandomFloat(0, 0.2),
                                function()
                                    local ____self_tLittleMeteorIDs_0 = self.tLittleMeteorIDs
                                    ____self_tLittleMeteorIDs_0[#____self_tLittleMeteorIDs_0 + 1] = hAblt4:FireMeteor({
                                        duration = fCastPoint * RandomFloat(0.1, 0.65),
                                        target = hHero,
                                        ability = self
                                    })
                                end,
                                "little_meteor_" .. tostring(i)
                            )
                            goto __continue5
                        end
                    end
                end
                self:GameTimer(
                    (i - 1) * fCastPoint * RandomFloat(0.2, 0.4),
                    function()
                        local ____self_tLittleMeteorIDs_1 = self.tLittleMeteorIDs
                        ____self_tLittleMeteorIDs_1[#____self_tLittleMeteorIDs_1 + 1] = hAblt4:FireMeteor({
                            duration = fCastPoint * RandomFloat(0.1, 0.45),
                            target_pos = hCaster:GetAbsOrigin(),
                            random_offset_min = 250,
                            random_offset_max = 750,
                            ability = self
                        })
                    end,
                    "little_meteor_" .. tostring(i)
                )
            end
            ::__continue5::
        end
    end
    self.vTarget = hCaster:GetAbsOrigin() + hCaster:GetForwardVector() * 1000
    self.tPtclIDs = {}
    ParticleManager_s2c:ToClient(
        function()
            local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_8/meteor_fly/meteor_fly.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                0,
                self.vTarget + Vector(0, 1500, 1000)
            )
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                1,
                self.vTarget + Vector(0, 0, 200)
            )
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                2,
                Vector(fCastPoint, 0, 0)
            )
            local ____self_tPtclIDs_2 = self.tPtclIDs
            ____self_tPtclIDs_2[#____self_tPtclIDs_2 + 1] = iPtclID
            iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_8/meteor_ground/meteor_ground.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iPtclID, 0, self.vTarget)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                1,
                Vector(750, 1, 1)
            )
            local ____self_tPtclIDs_3 = self.tPtclIDs
            ____self_tPtclIDs_3[#____self_tPtclIDs_3 + 1] = iPtclID
            iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_8/caster/caster.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
            local ____self_tPtclIDs_4 = self.tPtclIDs
            ____self_tPtclIDs_4[#____self_tPtclIDs_4 + 1] = iPtclID
            iPtclID = ParticleManager_s2c:CreateParticle("particles/warning/circular_3/circular_3.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(iPtclID, 0, self.vTarget)
            ParticleManager_s2c:SetParticleControl(
                iPtclID,
                2,
                Vector(10000, fCastPoint, 1 / fCastPoint)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
        end,
        {weight = 0}
    )
    local iSoundHowlFlag = true
    self:GameTimer(
        0,
        function()
            if iSoundHowlFlag then
                EmitSoundOn("Hero_Lycan.Howl", hCaster)
            else
                EmitSoundOn("Hero_Lycan.Howl.Team", hCaster)
            end
            iSoundHowlFlag = not iSoundHowlFlag
            return 1
        end,
        "sound_howl"
    )
    self:GameTimer(
        fCastPoint - 1.1,
        function()
            ParticleManager_s2c:ToClient(
                function()
                    local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_8/meteor_ground2/meteor_ground2.vpcf", PATTACH_WORLDORIGIN, nil)
                    ParticleManager_s2c:SetParticleControl(iPtclID, 0, self.vTarget)
                    self.iPtclID_Round2 = iPtclID
                end,
                {weight = 0}
            )
        end,
        "meteor_ground2"
    )
    self:GameTimer(
        0,
        function()
            ScreenShake(
                self.vTarget,
                5,
                50,
                2,
                0,
                0,
                true
            )
            local tIgnoreUnit = {}
            if IsValid(hAblt4) then
                for _, hMeteor in pairs(hAblt4.tMeteors) do
                    local vDir = (hMeteor:GetAbsOrigin() - self.vTarget):Normalized()
                    local vEnd = hMeteor:GetAbsOrigin() + vDir * meteor_block_range
                    for ____, hTarget in ipairs(FindUnitsInLine(
                        hCaster:GetTeamNumber(),
                        hMeteor:GetAbsOrigin(),
                        vEnd,
                        nil,
                        hMeteor:GetHullRadius(),
                        self:GetAbilityTargetTeam(),
                        self:GetAbilityTargetType(),
                        self:GetAbilityTargetFlags()
                    )) do
                        if hTarget:IsPositionInRange(
                            hMeteor:GetAbsOrigin(),
                            meteor_block_range
                        ) then
                            tIgnoreUnit[hTarget:GetEntityIndex()] = true
                        end
                    end
                    local hBuff = hMeteor:FindModifierByName("modifier_boss_6_4_meteor")
                    if hMeteor.__boss_6_8__flag == nil then
                        hMeteor.__boss_6_8__flag = true
                        ParticleManager_s2c:ToClient(
                            function()
                                local vDir = (hMeteor:GetAbsOrigin() - self.vTarget):Normalized()
                                local vEnd = hMeteor:GetAbsOrigin() + vDir * meteor_block_range
                                local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_8/wraing_safe/wraing_safe.vpcf", PATTACH_WORLDORIGIN, nil)
                                ParticleManager_s2c:SetParticleControl(
                                    iPtclID,
                                    0,
                                    hMeteor:GetAbsOrigin()
                                )
                                ParticleManager_s2c:SetParticleControl(iPtclID, 1, vEnd)
                                ParticleManager_s2c:SetParticleControl(
                                    iPtclID,
                                    2,
                                    Vector(0, fCastPoint, 0)
                                )
                                hBuff:AddParticle_s2c(
                                    iPtclID,
                                    true,
                                    false,
                                    -1,
                                    false,
                                    false
                                )
                            end,
                            {weight = 0}
                        )
                        ParticleManager_s2c:ToClient(function()
                            local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_8/target_fire/target_fire.vpcf", PATTACH_ABSORIGIN, hMeteor)
                            ParticleManager_s2c:SetParticleControl(iPtclID, 0, self.vTarget)
                            hBuff:AddParticle_s2c(
                                iPtclID,
                                true,
                                false,
                                -1,
                                false,
                                false
                            )
                        end)
                    end
                end
            end
            for ____, hTarget in ipairs(FindUnitsInRadius(
                hCaster:GetTeamNumber(),
                self.vTarget,
                nil,
                -1,
                self:GetAbilityTargetTeam(),
                self:GetAbilityTargetType(),
                self:GetAbilityTargetFlags(),
                FIND_ANY_ORDER,
                false
            )) do
                if tIgnoreUnit[hTarget:entindex()] == nil then
                    hTarget:AddPolymer(
                        hCaster,
                        self,
                        "modifier_boss_6_8_fire_debuff",
                        {
                            duration = 0.5,
                            target = VectorToString(_G, self.vTarget)
                        }
                    )
                end
            end
            return 0.1
        end,
        "update"
    )
    return true
end
function boss_6_8.prototype.OnAbilityPhaseInterrupted(self)
    local hCaster = self:GetCaster()
    if self.tPtclIDs ~= nil then
        ParticleManager_s2c:ToClient(
            function()
                for ____, iPtclID in ipairs(self.tPtclIDs) do
                    ParticleManager_s2c:DestroyParticle(iPtclID, true)
                end
            end,
            {weight = 0}
        )
        self.tPtclIDs = nil
    end
    local hAblt4 = hCaster:FindAbilityByName("boss_6_4")
    if IsValid(hAblt4) then
        for i = 1, self.Values:little_meteor_count() do
            self:StopTimer("little_meteor_" .. tostring(i))
        end
        for ____, iMeteorID in ipairs(self.tLittleMeteorIDs) do
            hAblt4:StopFireMeteor(iMeteorID)
        end
        self.tLittleMeteorIDs = nil
    end
    self:StopTimer("sound_howl")
    self:StopTimer("meteor_ground2")
    self:StopTimer("update")
end
function boss_6_8.prototype.OnSpellStart(self)
    self:StopTimer("sound_howl")
    self:StopTimer("update")
    ParticleManager_s2c:ToClient(
        function()
            for ____, iPtclID in ipairs(self.tPtclIDs) do
                ParticleManager_s2c:DestroyParticle(iPtclID, false)
            end
        end,
        {weight = 0}
    )
    self.tPtclIDs = nil
    local hCaster = self:GetCaster()
    ScreenShake(
        self.vTarget,
        5,
        50,
        2,
        0,
        1,
        true
    )
    self:GameTimer(
        0,
        function()
            ScreenShake(
                self.vTarget,
                500,
                1,
                2,
                0,
                0,
                true
            )
            ParticleManager_s2c:ToClient(
                function()
                    local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_8/meteor_collapse/meteor_collapse.vpcf", PATTACH_WORLDORIGIN, nil)
                    ParticleManager_s2c:SetParticleControl(
                        iPtclID,
                        0,
                        self.vTarget + Vector(0, 0, 150)
                    )
                    ParticleManager_s2c:SetParticleControl(
                        iPtclID,
                        1,
                        Vector(1000, 0, 0)
                    )
                    ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
                end,
                {weight = 0}
            )
            self:GameTimer(
                0.25,
                function()
                    ParticleManager_s2c:ToClient(
                        function()
                            local iPtclID = ParticleManager_s2c:CreateParticle("particles/boss/boss_6/boss_6_8/bomb/bomb.vpcf", PATTACH_WORLDORIGIN, nil)
                            ParticleManager_s2c:SetParticleControl(
                                iPtclID,
                                0,
                                self.vTarget + Vector(0, 0, 150)
                            )
                            ParticleManager_s2c:SetParticleControl(
                                iPtclID,
                                1,
                                Vector(10000, 0, 0)
                            )
                            ParticleManager_s2c:ReleaseParticleIndex(iPtclID)
                            ParticleManager_s2c:DestroyParticle(self.iPtclID_Round2, false)
                        end,
                        {weight = 0}
                    )
                    local tIgnoreUnit = {}
                    local hAblt4 = hCaster:FindAbilityByName("boss_6_4")
                    if hAblt4 ~= nil then
                        local meteor_block_range = self.Values:meteor_block_range()
                        for _, hMeteor in pairs(hAblt4.tMeteors) do
                            if IsValid(hMeteor) then
                                local vDir = (hMeteor:GetAbsOrigin() - self.vTarget):Normalized()
                                local vEnd = hMeteor:GetAbsOrigin() + vDir * meteor_block_range
                                for ____, hTarget in ipairs(FindUnitsInLine(
                                    hCaster:GetTeamNumber(),
                                    hMeteor:GetAbsOrigin(),
                                    vEnd,
                                    nil,
                                    hMeteor:GetHullRadius(),
                                    self:GetAbilityTargetTeam(),
                                    self:GetAbilityTargetType(),
                                    self:GetAbilityTargetFlags()
                                )) do
                                    if hTarget:IsPositionInRange(
                                        hMeteor:GetAbsOrigin(),
                                        meteor_block_range
                                    ) then
                                        tIgnoreUnit[hTarget:entindex()] = true
                                    end
                                end
                                hMeteor:SetForwardVector(vDir)
                                hMeteor:ForceKill(false)
                            end
                        end
                    end
                    local fDmg = self.Values:damage_factor() * AttributeKind.Atk:Get(hCaster)
                    for ____, hTarget in ipairs(FindUnitsInRadius(
                        hCaster:GetTeamNumber(),
                        self.vTarget,
                        nil,
                        -1,
                        self:GetAbilityTargetTeam(),
                        self:GetAbilityTargetType(),
                        self:GetAbilityTargetFlags(),
                        FIND_ANY_ORDER,
                        false
                    )) do
                        if tIgnoreUnit[hTarget:entindex()] == nil then
                            ApplyDamage({
                                ability = self,
                                attacker = hCaster,
                                damage_type = DAMAGE_TYPE_PURE,
                                victim = hTarget,
                                damage = fDmg
                            })
                        end
                    end
                end
            )
        end
    )
end
function boss_6_8.prototype.DDeclareFunctions(self)
    return {[MODIFIER_EVENT_ON_DEATH] = {source = self:GetCaster()}}
end
function boss_6_8.prototype.OnDeath(self, event)
    if event.inflictor == self then
        local hCaster = self:GetCaster()
        hCaster:AddPolymer(hCaster, self, "modifier_boss_6_8_buff")
    end
end
boss_6_8 = __TS__DecorateLegacy(
    {diy(_G)},
    boss_6_8
)
modifier_boss_6_8_fire_debuff = __TS__Class()
modifier_boss_6_8_fire_debuff.name = "modifier_boss_6_8_fire_debuff"
__TS__ClassExtends(modifier_boss_6_8_fire_debuff, DiyPolymer)
function modifier_boss_6_8_fire_debuff.prototype.IsHidden(self)
    return false
end
function modifier_boss_6_8_fire_debuff.prototype.IsDebuff(self)
    return true
end
function modifier_boss_6_8_fire_debuff.prototype.OnCreated(self, params)
    if IsServer() then
    else
        if ParticleManager_s2c:CheckClientBlocked() then
            local vTarget = StringToVector(_G, params.target)
            local iPtclID = ParticleManager:CreateParticle(
                "particles/boss/boss_6/boss_6_8/target_fire/target_fire.vpcf",
                PATTACH_ABSORIGIN,
                self:GetParent()
            )
            ParticleManager:SetParticleControl(iPtclID, 0, vTarget)
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
function modifier_boss_6_8_fire_debuff.prototype.OnRefresh(self, params)
    if IsServer() then
        local hCaster = self:GetCaster()
        local hParent = self:GetParent()
        local firing_hp_pct = self.Values:firing_hp_pct()
        if firing_hp_pct > 0 then
            local fDmg = AttributeKind.HpLimit:Get(hParent) * self.Values:firing_hp_pct() * 0.01
            ApplyDamage({
                ability = self:GetAbility(),
                attacker = hCaster,
                damage_type = DAMAGE_TYPE_PURE,
                victim = hParent,
                damage = fDmg
            })
        end
    end
end
modifier_boss_6_8_fire_debuff = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    modifier_boss_6_8_fire_debuff
)
modifier_boss_6_8_buff = __TS__Class()
modifier_boss_6_8_buff.name = "modifier_boss_6_8_buff"
__TS__ClassExtends(modifier_boss_6_8_buff, DiyPolymer)
function modifier_boss_6_8_buff.prototype.IsHidden(self)
    return false
end
function modifier_boss_6_8_buff.prototype.IsDebuff(self)
    return false
end
function modifier_boss_6_8_buff.prototype.OnCreated(self, params)
    if IsServer() then
        self:SetStackCount(1)
    end
end
function modifier_boss_6_8_buff.prototype.OnRefresh(self, params)
    if IsServer() then
        self:IncrementStackCount()
    end
end
modifier_boss_6_8_buff = __TS__DecorateLegacy(
    {diy_polymer(_G)},
    modifier_boss_6_8_buff
)
modifier_boss_6_8_ai = __TS__Class()
modifier_boss_6_8_ai.name = "modifier_boss_6_8_ai"
__TS__ClassExtends(modifier_boss_6_8_ai, DiyModifier)
function modifier_boss_6_8_ai.prototype.IsHidden(self)
    return true
end
function modifier_boss_6_8_ai.prototype.DDeclareFunctions(self)
    return {
        [AttributeKind.HpMin] = function() return self:GetParent():GetMaxHealth() * 0.5 end,
        [MODIFIER_PROPERTY_MIN_HEALTH] = self.GetHpMin
    }
end
function modifier_boss_6_8_ai.prototype.GetHpMin(self)
    if IsServer() then
        return CBaseEntity.GetMaxHealth(self:GetParent()) * 0.5
    else
        return C_BaseEntity.GetMaxHealth(self:GetParent()) * 0.5
    end
end
modifier_boss_6_8_ai = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_6_8_ai
)
modifier_boss_6_8_casting = __TS__Class()
modifier_boss_6_8_casting.name = "modifier_boss_6_8_casting"
__TS__ClassExtends(modifier_boss_6_8_casting, BaseModifier)
function modifier_boss_6_8_casting.prototype.IsHidden(self)
    return true
end
function modifier_boss_6_8_casting.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVULNERABLE] = true}
end
modifier_boss_6_8_casting = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_6_8_casting
)
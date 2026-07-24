--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GetDotaHud()
{
	let hPanel = $.GetContextPanel();

	while ( hPanel && hPanel.id !== 'Hud')
	{
        hPanel = hPanel.GetParent();
	}

	if (!hPanel)
	{
        throw new Error('Could not find Hud root from panel with id: ' + $.GetContextPanel().id);
	}

	return hPanel;
}

function FindDotaHudElement(sId)
{
	return GetDotaHud().FindChildTraverse(sId);
}

function HasModifier(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return true
        }
    }
    return false
}

function FindModifier(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return Entities.GetBuff(unit, i);
        }
    }
    return "none"
}

function formatNumber(num) {
    return parseFloat(num.toFixed(2));
}

function IsChineseLanguage()
{
    const lang = $.Language()
    return lang === "schinese" || lang === "tchinese"
}

function IsChineseLanguage()
{
    const lang = $.Language()
    return lang === "schinese" || lang === "tchinese"
}

function FormatChineseNumber(value, decimals = 1)
{
    const amount = Math.max(0, Number(value || 0))

    const units = [
        { value: 1e16, suffix: "京" },
        { value: 1e12, suffix: "兆" },
        { value: 1e8,  suffix: "亿" },
        { value: 1e4,  suffix: "万" },
    ]

    for (const unit of units)
    {
        if (amount >= unit.value)
        {
            return (amount / unit.value).toFixed(decimals) + unit.suffix
        }
    }

    return String(Math.floor(amount + 0.5))
}

function CheckStringDamage(damage)
{
    const amount = Math.max(0, Number(damage || 0))

    if (IsChineseLanguage())
    {
        return FormatChineseNumber(amount, 2)
    }

    if (amount >= 1000000000)
    {
        return String((amount / 1000000000).toFixed(2)) + "B"
    }
    else if (amount > 999999)
    {
        return String((amount / 1000000).toFixed(2)) + "M"
    }
    else if (amount > 999)
    {
        return String((amount / 1000).toFixed(2)) + "K"
    }
    else
    {
        return amount.toFixed(0)
    }
}

function GetModifierStackCount(unit, modifier)
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return Buffs.GetStackCount(unit, Entities.GetBuff(unit, i));
        }
    }
    return 0
}

function intToRgba(color) {
  const a = (color >> 24) & 0xFF;
  const r = (color >> 16) & 0xFF;
  const g = (color >> 8)  & 0xFF;
  const b =  color        & 0xFF;

  const alpha = (a / 255).toFixed(2);
  return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

function GetPlayerColorOriginal(player_id)
{
    let tables =
    {
        2 : "rgb(255, 0, 0)",
	    3 :  "rgb(5, 236, 233)",
	    6 : "rgb(255, 127, 39)",
	    7 : "rgb(226, 22, 230)",
	    8 : "rgb(87, 116, 255)",
	    9 : "rgb(255, 242, 0)",
    }
    var playerInfo = Game.GetPlayerInfo( player_id );
    if ( playerInfo )
    {
        var teamColor = tables[ playerInfo.player_team_id ];
        if ( teamColor )
        {
            return teamColor;
        }
    }
    return "white"
}

function GetPlayerColor(player_id)
{
    var playerInfo = Game.GetPlayerInfo( player_id );
    if ( playerInfo )
    {
        if ( GameUI.CustomUIConfig().team_colors )
        {
            var teamColor = GameUI.CustomUIConfig().team_colors[ playerInfo.player_team_id ];
            if ( teamColor )
            {
                return teamColor;
            }
        }
    }
    return "white"
}

function isNotInteger(num) {
  return num % 1 !== 0;
}

function ConvertTimeMinutes(time)
{
    var min = Math.trunc((time)/60) 
    var sec_n =  (time) - 60*Math.trunc((time)/60) 
    var min = String(min - 60*( Math.trunc(min/60) ))
    var sec = String(sec_n)
    if (sec_n < 10) 
    {
        sec = '0' + sec
    }
    if (min < 10)
    {
        min = '0' + min
    } 
    return min + ':' + sec
}

function ShowAbilityDescription(panel, ability)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityTooltip', panel, ability); });
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
    });       
}

function ShowAbilityDescriptionForHero(panel, ability, hero)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityTooltipForEntityIndex', panel, ability, hero); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
    });        
}

function ShowAbilityDescriptionLevel(panel, ability, level)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityTooltipForLevel', panel, ability, level); });
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
    });       
}

function ShowTextForPanel(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize(text)); });
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function SetShowTooltipTextWithName(panel, text, text2)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTitleTextTooltip', panel, text, text2 )});
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
        $.DispatchEvent('DOTAHideTitleTextTooltip', panel);
    });       
}

function Vector_normalize(vec)
{
	const val = 1 / Math.sqrt(Math.pow(vec[0], 2) + Math.pow(vec[1], 2) + Math.pow(vec[2], 2));
	return [vec[0] * val, vec[1] * val, vec[2] * val];
}

function Vector_mult(vec, mult)
{
	return [vec[0] * mult, vec[1] * mult, vec[2] * mult];
}

function Vector_add(vec1, vec2)
{
	return [vec1[0] + vec2[0], vec1[1] + vec2[1], vec1[2] + vec2[2]];
}

function Vector_sub(vec1, vec2)
{
	return [vec1[0] - vec2[0], vec1[1] - vec2[1], vec1[2] - vec2[2]];
}

function Vector_negate(vec)
{
	return [-vec[0], -vec[1], -vec[2]];
}

function Vector_flatten(vec)
{
	return [vec[0], vec[1], 0];
}

function Vector_raiseZ(vec, inc)
{
	return [vec[0], vec[1], vec[2] + inc];
}

function Vector_distance (vec1, vec2) 
{
	return Math.sqrt(((vec2[0] - vec1[0]) ** 2) + ((vec2[1] - vec1[1]) ** 2));
}

function roundTo(num, decimals) {
  let factor = 10 ** decimals;
  return Math.round(num * factor) / factor;
}

function FormatPrecisionValue(value)
{
    const number_value = Number(value)
    if (!isFinite(number_value))
    {
        return value
    }

    let rounded_value = Math.round((number_value + Number.EPSILON) * 10000) / 10000
    if (Math.abs(rounded_value) < 0.0001)
    {
        rounded_value = 0
    }

    if (Number.isInteger(rounded_value))
    {
        return String(rounded_value)
    }

    return rounded_value.toFixed(4).replace(/\.?0+$/, "")
}

function IsLevelUpPercentStatName(stat_name)
{
    stat_name = String(stat_name || "")
    return /_pct$/.test(stat_name)
        || stat_name === "attack_speed"
        || stat_name === "cooldown_reduction"
        || stat_name === "passive_artefact_cooldown_reduction"
        || stat_name === "spell_amp"
        || stat_name === "damage_increase"
        || stat_name === "damage_amplification"
}

function print(...args) 
{
    let result = ""
    args.forEach((element) => {
        let elem_str
        if (typeof(element) == "object"){
            elem_str = JSON.stringify(element)
        }
        else
        {
            elem_str = toString(element)
        }
        result = result + elem_str + ' '
    })
}

function FlagExists(a, flag)
{
    if ((a & flag) > 0)
    {
        return true
    }
    return false
}

function IsSpectator()
{
	const localPlayer = Players.GetLocalPlayer()
	if (Players.IsSpectator(localPlayer))
		return true
	const localTeam = Players.GetTeam(localPlayer)
	return localTeam !== 2 && localTeam !== 3 && localTeam !== 6 && localTeam !== 7 && localTeam !== 8 && localTeam !== 9
}

function GetHokeyCustom(list)
{
    let hotkey = ""
    if (list[0])
    {
        hotkey = Game.GetKeybindForCommand(list[0])
    }
    if (list[1] && hotkey == "")
    {
        hotkey = Game.GetKeybindForCommand(list[1])
    }
    return hotkey
}

function GetHokeyString(index)
{
    let hotkey = ""
    if (DEFAULTS_HOTKEYS[index])
    {
        hotkey = DEFAULTS_HOTKEYS[index]
    }
    return hotkey
}

function GetLevelUpKeyBind(type, index)
{
    let hotkey = ""
    let server_hotkeys = Game.GetKeySet()
    if (server_hotkeys && server_hotkeys[type] && server_hotkeys[type][index])
    {
        hotkey = server_hotkeys[type][index]
    }
    return hotkey
}

function FlagExistsBig(a, flag) 
{
    const A = BigInt(a);
    const F = BigInt(flag);
    return (A & F) !== 0n;
}

function ApplyStatFormat(child, value) 
{
    value = Math.floor(value);
    if (value === 0) 
    {
        child.visible = false;
        return;
    }
    child.visible = true;
    child.text = value > 0 ? "+" + value : value;
    child.SetHasClass("RedBonus", value < 0);
}

function ApplyNumberFormat(value)
{
    value = formatNumber(value)
    return value > 0 ? "+" + value : value;
}

function WrapFunction(name)
{
    return function()
    {
        Game[name]();
    }
}

function GetMousePoint()
{
    let point = GameUI.GetCursorPosition()
    point = Game.ScreenXYToWorld(point[0], point[1])
    return point
}

function GetPlayerHero()
{
    let unit = Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )
    return unit
}

function buildTooltipParams(data) 
{
    if (!data) return "";
    const parts = [];
    for (const k in data) 
    {
        if (!Object.prototype.hasOwnProperty.call(data, k)) continue;
        const v = data[k];
        if (v === undefined || v === null) continue;
        const valueStr = (typeof v === "object") ? JSON.stringify(v) : String(v);
        parts.push(encodeURIComponent(k) + "=" + encodeURIComponent(valueStr));
    }
    return parts.join("&");
}

function SetCustomTooltip(panel, tooltip_name, data) {
    const params = buildTooltipParams(data);
    panel.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent(
            "UIShowCustomLayoutParametersTooltip", panel, tooltip_name+"_custom",
            `file://{resources}/layout/custom_game/tooltips/${tooltip_name}/${tooltip_name}.xml`,
            params
        );
    });
    panel.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("UIHideCustomLayoutTooltip", panel, tooltip_name+"_custom");
    });
}

function SetServiceItemTooltip(panel, item_id, count, extra_data)
{
    if (!panel || !item_id) return
    const data = extra_data || {}
    data.item_id = item_id
    data.count = count || data.count || 0
    SetCustomTooltip(panel, "service_item_tooltip", data)
}

function SetServiceCurrencyListTooltip(panel, economy_data)
{
    if (!panel) return
    SetCustomTooltip(panel, "service_currency_list_tooltip", { currencies: economy_data || {} })
}

function ServiceNotifyToArray(data)
{
    if (!data) return []
    if (data instanceof Array) return data
    let result = []
    let keys = Object.keys(data)
    keys.sort(function(a, b) { return (Number(a) || 0) - (Number(b) || 0) })
    for (let i = 0; i < keys.length; i++)
    {
        result.push(data[keys[i]])
    }
    return result
}

function ServiceNotifyGetLocalPlayerKey()
{
    return String(Players.GetLocalPlayer())
}

function ServiceNotifyGetPlayerData()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_player", ServiceNotifyGetLocalPlayerKey()) : {}
}

function ServiceNotifyGetConfig(key)
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", key) : {}
}

function ServiceNotifyProfileLevelHasClaim(player_data, profile_config)
{
    if (player_data && player_data.profile_has_claim)
    {
        return true
    }

    let current_level = Number(player_data && player_data.profile_current_level) || 0
    let claimed = ((player_data && player_data.profile_level) || {}).levels_reached || {}
    let rewards = (profile_config && profile_config.level_rewards) || {}
    for (let level in rewards)
    {
        let level_number = Number(level) || 0
        if (level_number > 0 && level_number <= current_level && !claimed[String(level_number)])
        {
            return true
        }
    }
    return false
}

function ServiceNotifyAchievementHasClaim(achievement, state)
{
    achievement = achievement || {}
    state = state || {}
    if (state.has_reclaimable) return true
    let claimed_level = Number(state.claimed_level) || 0
    let next_level = claimed_level + 1
    let next_level_data = (achievement.levels || {})[next_level]
    let goal = Number(next_level_data && next_level_data.goal) || 0
    let progress = Number(state.progress) || 0
    return !!next_level_data && goal > 0 && progress >= goal
}

function ServiceNotifyProfileState(player_data, profile_config)
{
    let result =
    {
        any: false,
        profile_level: false,
        achievements: false,
        achievement_categories: {},
        blessing_level: !!(player_data && player_data.buffs_pending_level),
        vip_free: false,
        mail: false,
    }

    result.profile_level = ServiceNotifyProfileLevelHasClaim(player_data, profile_config)

    let achievements = ServiceNotifyToArray((profile_config && profile_config.achievements) || {})
    for (let i = 0; i < achievements.length; i++)
    {
        let achievement = achievements[i] || {}
        let achievement_id = achievement.id || String(i + 1)
        let state = ((player_data && player_data.achievements) || {})[achievement_id] || {}
        if (ServiceNotifyAchievementHasClaim(achievement, state))
        {
            let category = achievement.category || "achievement_1"
            result.achievements = true
            result.achievement_categories[category] = true
        }
    }

    let vip_offers = ServiceNotifyToArray((profile_config && profile_config.vip_offers) || {})
    let vip_level = Number(player_data && player_data.vip_current_level) || 0
    let vip_claimed = ((player_data && player_data.vip_level) || {}).chest_openeds || {}
    for (let i = 0; i < vip_offers.length; i++)
    {
        let offer = vip_offers[i] || {}
        let offer_id = String(offer.id || "")
        let is_free = offer_id.indexOf("_small_") !== -1 || offer.site_only !== true
        let required_level = Number(offer.required_level) || 0
        let limit = Number(offer.purchase_limit) || 0
        let purchases = Number(vip_claimed[offer_id]) || 0
        if (is_free && vip_level >= required_level && (limit <= 0 || purchases < limit))
        {
            result.vip_free = true
            break
        }
    }

    let mails = ServiceNotifyToArray((player_data && player_data.email_data) || {})
    for (let i = 0; i < mails.length; i++)
    {
        let mail_id = mails[i] && String(mails[i].id || "")
        let locally_read = mail_id && Game.service_read_mail_local && Game.service_read_mail_local[mail_id]
        if (mails[i] && !mails[i].read && !mails[i].claimed && !locally_read)
        {
            result.mail = true
            break
        }
    }

    result.any = result.profile_level || result.achievements || result.blessing_level || result.vip_free || result.mail
    return result
}

function ServiceNotifyQuestGroupHasClaim(group_id, group_config, player_quest_data, quest_access)
{
    let locked = quest_access && quest_access[group_id] === false
    if (locked) return false

    let quest_list = ServiceNotifyToArray(group_config && group_config.list)
    let group_state = (player_quest_data || {})[group_id] || {}
    for (let i = 0; i < quest_list.length; i++)
    {
        let quest_config = quest_list[i] || {}
        let quest_id = quest_config.id || ""
        let quest_state = group_state[quest_id] || {}
        let progress = Number(quest_state.progress) || 0
        let goal = Number(quest_config.goal || quest_state.goal) || 1
        if (progress >= goal && !quest_state.claimed)
        {
            return true
        }
    }
    return false
}

function ServiceNotifyPromoEventHasClaim(player_data)
{
    let state = (player_data && player_data.promo_event) || {}
    if (!state.active) return false

    let events_config = ServiceNotifyGetConfig("promo_events") || {}
    let events = ServiceNotifyToArray(events_config.events)
    let event = null
    for (let i = 0; i < events.length; i++)
    {
        if (events[i] && String(events[i].id) === String(state.event_id)) { event = events[i]; break }
    }
    if (!event) return false

    let water_cost = Math.max(1, Number(event.water && event.water.cost) || 1)
    if ((Number(state.currency) || 0) >= water_cost) return true

    let daily_state = state.daily || {}
    let daily = ServiceNotifyToArray(event.daily_quests)
    for (let i = 0; i < daily.length; i++)
    {
        let quest = daily[i] || {}
        let quest_state = daily_state[quest.id] || {}
        if ((Number(quest_state.progress) || 0) >= Math.max(1, Number(quest.goal) || 1) && !quest_state.claimed) return true
    }

    let waterings = Number(state.waterings) || 0
    let acc_claimed = state.accumulative_claimed || {}
    let accumulative = ServiceNotifyToArray(event.accumulative)
    for (let i = 0; i < accumulative.length; i++)
    {
        if (waterings >= (Number(accumulative[i] && accumulative[i].goal) || 0) && !acc_claimed[String(i + 1)]) return true
    }

    let vip_experience = Number(state.vip_experience) || 0
    let perm_claimed = state.permanent_claimed || {}
    let permanent = ServiceNotifyToArray(event.permanent)
    for (let i = 0; i < permanent.length; i++)
    {
        if (vip_experience >= (Number(permanent[i] && permanent[i].cny) || 0) && !perm_claimed[String(i + 1)]) return true
    }

    return false
}

function ServiceNotifyPromoState(player_data, promo_config)
{
    let result =
    {
        any: false,
        tasks: false,
        weekly: false,
        task_groups: {},
        daily_login: !!(player_data && player_data.daily_login_can_claim),
        invites: false,
        event: false,
    }

    let quest_config = (promo_config && promo_config.quests) || {}
    let quest_data = (player_data && player_data.quest_data) || {}
    let quest_access = (player_data && player_data.quest_access) || {}
    let week_data = quest_data.week_all_quest_data || {}
    let week_rewards = ServiceNotifyToArray((promo_config && promo_config.quest_week_rewards) || {})
    for (let i = 0; i < week_rewards.length; i++)
    {
        let reward = week_rewards[i] || {}
        let reward_index = String(i + 1)
        if ((Number(week_data.completed) || 0) >= (Number(reward.completed) || 0) && !(week_data.claimed && week_data.claimed[reward_index]))
        {
            result.weekly = true
            break
        }
    }

    let group_map =
    {
        daily: "day_quest_data",
        monthly: "month_sub_quest_data",
        yearly: "year_sub_quest_data",
    }
    for (let ui_group in group_map)
    {
        let group_id = group_map[ui_group]
        result.task_groups[ui_group] = ServiceNotifyQuestGroupHasClaim(group_id, quest_config[group_id] || {}, quest_data, quest_access)
    }
    result.tasks = result.weekly || result.task_groups.daily || result.task_groups.monthly || result.task_groups.yearly

    let invite_config = (promo_config && promo_config.invite) || {}
    let invite_data = (player_data && player_data.friends_invite_data) || {}
    let invite_claimed = invite_data.claimed || {}
    if (invite_data.inviter_id && !invite_claimed.bind)
    {
        result.invites = true
    }
    let invite_rewards = ServiceNotifyToArray(invite_config.invited_rewards)
    for (let i = 0; i < invite_rewards.length; i++)
    {
        let reward = invite_rewards[i] || {}
        let reward_index = String(i + 1)
        if ((Number(invite_data.invited_count) || 0) >= (Number(reward.invites) || 0) && !invite_claimed[reward_index])
        {
            result.invites = true
            break
        }
    }

    result.event = ServiceNotifyPromoEventHasClaim(player_data)
    result.any = result.tasks || result.daily_login || result.invites || result.event
    return result
}

function ServiceNotifyGetPassLevel(exp_by_level, experience)
{
    let level = 0
    for (let key in (exp_by_level || {}))
    {
        let level_id = Number(key) || 0
        let required = Number(exp_by_level[key]) || 0
        if (experience >= required && level_id > level)
        {
            level = level_id
        }
    }
    return level
}

function ServiceNotifyPassState(player_data, pass_config)
{
    let result = { any: false }
    let battlepass_data = (player_data && player_data.battlepass_data) || {}
    for (let pass_id in (pass_config || {}))
    {
        let config = pass_config[pass_id] || {}
        let pass_player = battlepass_data[pass_id] || {}
        let current_level = ServiceNotifyGetPassLevel(config.exp_by_level, Number(pass_player.experience) || 0)
        let premium_unlocked = !!pass_player.premium_unlocked
        let claimed_free = pass_player.claimed_free || {}
        let claimed_premium = pass_player.claimed_premium || {}
        for (let level_id in (config.rewards || {}))
        {
            let level_number = Number(level_id) || 0
            if (level_number > current_level) continue
            let reward_config = config.rewards[level_id] || {}
            let has_free_rewards = Object.keys(reward_config.free || {}).length > 0
            let has_premium_rewards = Object.keys(reward_config.premium || {}).length > 0
            if ((has_free_rewards && !claimed_free[String(level_number)]) || (premium_unlocked && has_premium_rewards && !claimed_premium[String(level_number)]))
            {
                result.any = true
                return result
            }
        }
    }
    return result
}

function ServiceNotifyStoreState(player_data)
{
    let result = { any: false, daily_monthly: false, daily_premium: false }
    let monthly_cards = (player_data && player_data.monthly_cards_data) || {}
    let history = (player_data && player_data.items_store_buying_history) || {}

    let basic = monthly_cards["monthly_basic"] || {}
    if (!!basic.active || Number(basic.remaining_days) > 0 || Number(basic.remaining_seconds) > 0)
    {
        let h = history["store_daily_monthly"] || {}
        if ((Number(h.purchases) || 0) < 1) result.daily_monthly = true
    }

    let premium = monthly_cards["monthly_premium"] || {}
    if (!!premium.active || Number(premium.remaining_days) > 0 || Number(premium.remaining_seconds) > 0)
    {
        let h = history["store_daily_premium"] || {}
        if ((Number(h.purchases) || 0) < 1) result.daily_premium = true
    }

    result.any = result.daily_monthly || result.daily_premium
    return result
}

function GetServiceClaimState()
{
    let player_data = ServiceNotifyGetPlayerData()
    let profile = ServiceNotifyProfileState(player_data, ServiceNotifyGetConfig("profile"))
    let promo = ServiceNotifyPromoState(player_data, ServiceNotifyGetConfig("promo"))
    let pass = ServiceNotifyPassState(player_data, ServiceNotifyGetConfig("battlepass"))
    let store = ServiceNotifyStoreState(player_data)
    return { profile: profile, promo: promo, pass: pass, store: store }
}

function EnsureServiceNotifyDot(panel)
{
    if (!panel || !panel.IsValid || !panel.IsValid()) return null
    let dot = panel.FindChild("ServiceNotifyDot")
    if (!dot)
    {
        dot = $.CreatePanel("Panel", panel, "ServiceNotifyDot")
        dot.AddClass("ServiceNotifyDot")
        dot.hittest = false
        dot.hittestchildren = false
    }
    return dot
}

function SetServiceNotifyDot(panel, active)
{
    let dot = EnsureServiceNotifyDot(panel)
    if (!dot) return
    dot.SetHasClass("ServiceNotifyDotVisible", !!active)
    dot.SetHasClass("ServiceNotifyDotHidden", !active)
}

function SetServiceNotifyDotByClass(root, class_name, active)
{
    if (!root || !root.FindChildrenWithClassTraverse) return
    let panels = root.FindChildrenWithClassTraverse(class_name) || []
    for (let i = 0; i < panels.length; i++)
    {
        SetServiceNotifyDot(panels[i], active)
    }
}

function UpdateServiceTopClaimNotifications()
{
    let root = null
    try { root = GetDotaHud() } catch (e) { root = $.GetContextPanel() }
    if (!root) return

    let state = GetServiceClaimState()
    SetServiceNotifyDotByClass(root, "ButtonProfile", state.profile && state.profile.any)
    SetServiceNotifyDotByClass(root, "ButtonPromo", state.promo && state.promo.any)
    SetServiceNotifyDotByClass(root, "ButtonPass", state.pass && state.pass.any)
    SetServiceNotifyDotByClass(root, "ButtonStore", state.store && state.store.any)
}

if (typeof Game !== "undefined")
{
    Game.GetServiceClaimState = GetServiceClaimState
    Game.SetServiceNotifyDot = SetServiceNotifyDot
    Game.UpdateServiceTopClaimNotifications = UpdateServiceTopClaimNotifications
}

var SERVICE_SERVER_SYNC_COOLDOWN_SECONDS = 30
Game.service_server_sync_cooldown_until = Game.service_server_sync_cooldown_until || 0

function GetServiceServerSyncNow()
{
    return Date.now() / 1000
}

function IsServiceServerSyncAvailable()
{
    let now = GetServiceServerSyncNow()
    let cooldown_until = Number(Game.service_server_sync_cooldown_until) || 0
    if (cooldown_until > now + SERVICE_SERVER_SYNC_COOLDOWN_SECONDS)
    {
        Game.service_server_sync_cooldown_until = 0
        return true
    }
    return now >= cooldown_until
}

function UpdateServiceServerSyncButton(button)
{
    if (!button || !button.IsValid()) return

    let available = IsServiceServerSyncAvailable()
    button.SetHasClass("ServiceServerSyncButtonDisabled", !available)
    button.hittest = available

    if (!available)
    {
        $.Schedule(0.25, function()
        {
            UpdateServiceServerSyncButton(button)
        })
    }
}

function RenderServiceServerSyncButton(row)
{
    if (!row) return

    let button = $.CreatePanel("Panel", row, "")
    button.AddClass("ServiceServerSyncButton")

    let icon = $.CreatePanel("Panel", button, "")
    icon.AddClass("ServiceServerSyncIcon")

    button.SetPanelEvent("onactivate", function()
    {
        if (!IsServiceServerSyncAvailable()) return

        Game.service_server_sync_cooldown_until = GetServiceServerSyncNow() + SERVICE_SERVER_SYNC_COOLDOWN_SECONDS
        GameEvents.SendCustomGameEventToServer("event_web_server_force_sync", {})
        UpdateServiceServerSyncButton(button)
    })

    UpdateServiceServerSyncButton(button)
    RenderServicePromocodeButton(row)
}

var service_promocode_modal = null
var service_promocode_status_label = null
var service_promocode_submit_button = null
var service_promocode_entry = null
var service_promocode_cooldown_until = 0

function LocalizeServiceMessage(message)
{
    if (!message) return ""
    return message.indexOf("#") === 0 ? $.Localize(message) : message
}

function CloseServicePromocodeModal()
{
    if (service_promocode_modal && service_promocode_modal.IsValid())
    {
        service_promocode_modal.DeleteAsync(0)
    }
    service_promocode_modal = null
    service_promocode_status_label = null
    service_promocode_submit_button = null
    service_promocode_entry = null
}

function SetServicePromocodePending(pending)
{
    if (service_promocode_entry && service_promocode_entry.IsValid())
    {
        service_promocode_entry.enabled = !pending
        service_promocode_entry.hittest = !pending
    }
    if (service_promocode_submit_button && service_promocode_submit_button.IsValid())
    {
        service_promocode_submit_button.SetHasClass("ServicePromocodeButtonDisabled", pending)
        service_promocode_submit_button.hittest = !pending
    }
}

function SubmitServicePromocode()
{
    if (!service_promocode_entry || !service_promocode_entry.IsValid()) return

    let code = String(service_promocode_entry.text || "").replace(/^\s+|\s+$/g, "")
    if (!code)
    {
        if (service_promocode_status_label && service_promocode_status_label.IsValid())
        {
            service_promocode_status_label.text = $.Localize("#services_promocode_empty")
            service_promocode_status_label.SetHasClass("ServicePromocodeStatusError", true)
        }
        return
    }

    let now = Game.Time()
    if (now < service_promocode_cooldown_until)
    {
        if (service_promocode_status_label && service_promocode_status_label.IsValid())
        {
            service_promocode_status_label.text = $.Localize("#services_promocode_too_fast")
            service_promocode_status_label.SetHasClass("ServicePromocodeStatusError", true)
        }
        return
    }
    service_promocode_cooldown_until = now + 3.0

    if (service_promocode_status_label && service_promocode_status_label.IsValid())
    {
        service_promocode_status_label.text = $.Localize("#services_promocode_sending")
        service_promocode_status_label.SetHasClass("ServicePromocodeStatusError", false)
    }
    SetServicePromocodePending(true)
    GameEvents.SendCustomGameEventToServer("event_services_redeem_promocode", { code: code })
}

function ShowServicePromocodeModal()
{
    CloseServicePromocodeModal()

    service_promocode_modal = $.CreatePanel("Panel", $.GetContextPanel(), "ServicePromocodeModal")
    service_promocode_modal.AddClass("ServicePromocodeModal")

    let shade = $.CreatePanel("Panel", service_promocode_modal, "")
    shade.AddClass("ServicePromocodeShade")
    shade.SetPanelEvent("onactivate", CloseServicePromocodeModal)

    let frame = $.CreatePanel("Panel", service_promocode_modal, "")
    frame.AddClass("ServicePromocodeFrame")

    let title = $.CreatePanel("Label", frame, "")
    title.AddClass("ServicePromocodeTitle")
    title.text = $.Localize("#services_promocode_title")

    let description = $.CreatePanel("Label", frame, "")
    description.AddClass("ServicePromocodeDescription")
    description.text = $.Localize("#services_promocode_description")

    service_promocode_entry = $.CreatePanel("TextEntry", frame, "ServicePromocodeEntry")
    service_promocode_entry.AddClass("ServicePromocodeEntry")
    service_promocode_entry.text = ""
    service_promocode_entry.SetPanelEvent("oninputsubmit", SubmitServicePromocode)

    service_promocode_status_label = $.CreatePanel("Label", frame, "")
    service_promocode_status_label.AddClass("ServicePromocodeStatus")
    service_promocode_status_label.text = $.Localize("#services_promocode_placeholder")

    let actions = $.CreatePanel("Panel", frame, "")
    actions.AddClass("ServicePromocodeActions")

    service_promocode_submit_button = $.CreatePanel("Panel", actions, "")
    service_promocode_submit_button.AddClass("ServicePromocodeActionButton")
    service_promocode_submit_button.SetPanelEvent("onactivate", SubmitServicePromocode)
    let submitLabel = $.CreatePanel("Label", service_promocode_submit_button, "")
    submitLabel.AddClass("ServicePromocodeActionLabel")
    submitLabel.text = $.Localize("#services_promocode_activate")

    let cancel = $.CreatePanel("Panel", actions, "")
    cancel.AddClass("ServicePromocodeActionButton")
    cancel.AddClass("ServicePromocodeCancelButton")
    cancel.SetPanelEvent("onactivate", CloseServicePromocodeModal)
    let cancelLabel = $.CreatePanel("Label", cancel, "")
    cancelLabel.AddClass("ServicePromocodeActionLabel")
    cancelLabel.text = $.Localize("#services_promocode_cancel")

    service_promocode_entry.SetFocus()
}

function RenderServicePromocodeButton(row)
{
    if (!row) return

    let button = $.CreatePanel("Panel", row, "")
    button.AddClass("ServicePromocodeOpenButton")
    button.SetPanelEvent("onactivate", ShowServicePromocodeModal)

    let label = $.CreatePanel("Label", button, "")
    label.AddClass("ServicePromocodeOpenLabel")
    label.text = $.Localize("#services_promocode_button")
}

GameEvents.Subscribe("event_services_promocode_result", function(data)
    {
        if (!service_promocode_status_label || !service_promocode_status_label.IsValid()) return

        let success = data && (data.success == 1 || data.success == true)
        service_promocode_status_label.text = LocalizeServiceMessage(data && data.message)
        service_promocode_status_label.SetHasClass("ServicePromocodeStatusError", !success)
        SetServicePromocodePending(false)

        if (success)
        {
            $.Schedule(0.7, CloseServicePromocodeModal)
        }
    })
function RenderServiceCurrencyMoreButton(row, economy_data)
{
    if (!row) return
    let button = $.CreatePanel("Panel", row, "")
    button.AddClass("ServiceCurrencyMoreButton")
    let arrow = $.CreatePanel("Panel", button, "")
    arrow.AddClass("ServiceCurrencyMoreArrow")
    SetServiceCurrencyListTooltip(button, economy_data || {})
}
function SetChestChancesTooltip(panel, chest_id)
{
    if (!panel || !chest_id) return
    SetCustomTooltip(panel, "chest_chances_tooltip", { chest_id: chest_id })
}

function SetCrystalTooltip(panel, category, index, level, total_level, rare)
{
    if (!panel || !category) return
    SetCustomTooltip(panel, "crystal_tooltip", {
        mode: rare ? "rare" : "crystal",
        category: category,
        index: index || 0,
        level: level || 0,
        total_level: total_level || 0
    })
}

function SetCrystalPullTooltip(panel)
{
    if (!panel) return
    SetCustomTooltip(panel, "crystal_tooltip", { mode: "pull" })
}

function SetTalentTooltip(panel, talent_id, config_id)
{
    if (!panel || !talent_id) return
    SetCustomTooltip(panel, "talent_tooltip", { talent_id: talent_id, config_id: config_id || 1 })
}

function GetDataFromObjectList(tbl, key, value)
{
    for (let data of tbl)
    {
        if (data[key] && data[key] == value)
        {
            return data
        }
    }
    return null
}

function NormalizeStatsBonusList(stats)
{
    if (!stats) return stats
    let normalized = {}
    for (let key in stats)
    {
        let value = stats[key]
        if (value && typeof value === "object" && value["1"] !== undefined && value["2"])
        {
            let amount = value["1"]
            let type = value["2"]
            normalized[type] = normalized[type] || {}
            normalized[type][key] = amount
        }
        else
        {
            normalized[key] = value
        }
    }
    return normalized
}

function MergeAllStats(stats)
{
    if (!stats) return stats
    for (const key in stats)
    {
        const block = stats[key]
        if (!block) continue
        const { agi, str, int } = block
        if (typeof agi === "number" && typeof str === "number" && typeof int === "number" && agi === str && str === int)
        {
            block.all_stats = agi
            delete block.agi
            delete block.str
            delete block.int
        }
    }
    return stats
}

function ReplaceQuallityString(number)
{
    const lang = $.Language()
    const table = quality_values[lang] || quality_values["all"]
    return table[number] || ""
}

function GetServiceLanguage()
{
    return $.Language ? $.Language() : "english"
}

function GetServiceRealCurrencyKey()
{
    const lang = GetServiceLanguage()
    if (lang === "russian") return "rub"
    if (lang === "schinese" || lang === "tchinese") return "cny"
    return "usd"
}

function SelectLocalizedServiceValue(value, fallback)
{
    if (value === undefined || value === null) return fallback || ""
    if (typeof value !== "object") return value

    const lang = GetServiceLanguage()
    const aliases =
    {
        russian: ["russian", "ru", "rus"],
        english: ["english", "en", "all"],
        schinese: ["schinese", "zh", "cn", "cny", "all"],
        tchinese: ["tchinese", "zh", "cn", "cny", "all"],
    }
    const keys = aliases[lang] || [lang, "english", "en", "all"]
    for (let i = 0; i < keys.length; i++)
    {
        if (value[keys[i]] !== undefined && value[keys[i]] !== null)
        {
            return value[keys[i]]
        }
    }
    if (value.english !== undefined) return value.english
    if (value.en !== undefined) return value.en
    if (value.all !== undefined) return value.all
    return fallback || ""
}

function LocalizeServiceKeyOrText(value, fallback)
{
    let text = SelectLocalizedServiceValue(value, fallback || "")
    text = String(text || "")
    if (text === "") return String(fallback || "")

    let key = text.charAt(0) === "#" ? text : "#" + text
    if ($.CanLocalize && $.CanLocalize(key))
    {
        return $.Localize(key)
    }
    return text.charAt(0) === "#" ? text.substring(1) : text
}

function LocalizeServiceItemName(item, fallback_id)
{
    item = item || {}
    let item_id = String(item.id || fallback_id || "")
    if (item_id !== "")
    {
        let item_key = "#" + item_id
        if ($.CanLocalize && $.CanLocalize(item_key))
        {
            return $.Localize(item_key)
        }
    }
    return LocalizeServiceKeyOrText(item.name || item_id, item_id)
}

function FormatWebPrice(price_data)
{
    const key = GetServiceRealCurrencyKey()
    let value = price_data
    if (price_data && typeof price_data === "object")
    {
        const real = price_data.real !== undefined ? price_data.real : price_data
        value = SelectLocalizedServiceValue(real, "")
        if (real && typeof real === "object")
        {
            value = real[key] !== undefined ? real[key] : value
        }
    }

    value = String(value || "").trim()
    if (value === "") return "WEB"
    if (key === "rub") return value + " ₽"
    if (key === "cny") return "¥" + value
    return "$" + value
}

function IsContextWindowVisible(window_id)
{
    let panel = $.GetContextPanel()
    while (panel)
    {
        if (panel.id === window_id)
        {
            return panel.BHasClass("WindowVisible")
        }
        panel = panel.GetParent ? panel.GetParent() : null
    }
    return true
}

function UnFocusUI()
{
    $.DispatchEvent("DropInputFocus");
    $.Schedule(0.1, function()
    {
        $.DispatchEvent("DropInputFocus")
    })
}
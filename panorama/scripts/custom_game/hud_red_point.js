--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var red_point_utils = require('./red_point_utils.js');
var game_utils = require('./game_utils.js');
var netdata_utils = require('./netdata_utils.js');

const useActivityRedPointStore = () => {
  const [activities, setActivities] = libs.createSignal([]);
  const [loginActivities, setLoginActivities] = libs.createSignal();
  const [activityTasks, setActivityTasks] = libs.createSignal();
  const [taskProgresses, setTaskProgresses] = libs.createSignal();
  const [deepSeaRewards, setDeepSeaRewards] = libs.createSignal();
  const [playerTokens, setPlayerTokens] = libs.createSignal();
  const [activityTags, setActivityTags] = libs.createSignal(getClientGlobalData("activity_tag_list") ?? {});
  const [availableTabs, setAvailableTabs] = libs.createSignal(getClientGlobalData("menu_bar_activity_tabs") ?? []);
  const redPoints = libs.createMemo(() => {
    const result = new Set();
    const now = Date.now() / 1000;
    const currentActivities = activities();
    const currentLoginActivities = loginActivities();
    const currentActivityTasks = activityTasks();
    const currentTaskProgresses = taskProgresses();
    const currentDeepSeaRewards = deepSeaRewards();
    const currentPlayerTokens = playerTokens();
    const currentActivityTags = activityTags();
    const availableTabSet = new Set(availableTabs());
    const loginRewardActivityIDs = new Set();
    const unconfiguredLoginRewardActivityIDs = new Set();
    const taskRewardActivityIDs = new Set();
    for (const loginActivityID in currentLoginActivities ?? {}) {
      const loginActivity = currentLoginActivities[loginActivityID];
      for (const rewardID in loginActivity.rewards) {
        if (loginActivity.rewards[rewardID] != 0) {
          continue;
        }
        loginRewardActivityIDs.add(loginActivity.activity_id);
        unconfiguredLoginRewardActivityIDs.add(loginActivity.activity_id);
        break;
      }
    }
    for (const taskID in currentTaskProgresses ?? {}) {
      const progress = currentTaskProgresses[taskID];
      const task = currentActivityTasks?.[progress.task_id];
      const target = Number(task?.target);
      if (task != undefined && !Number.isNaN(target) && (progress.progress ?? 0) >= target && progress.receive_progress != 1) {
        taskRewardActivityIDs.add(task.activity_id);
      }
    }
    for (const activity of currentActivities) {
      unconfiguredLoginRewardActivityIDs.delete(activity.activity_id);
      const tab = currentActivityTags[activity.activity_id];
      const isOpen = activity.start_time <= now && (activity.end_time == 0 || activity.end_time > now);
      if (!isOpen || tab == undefined || !availableTabSet.has(tab)) {
        continue;
      }
      let starryTreasureRewardStage;
      const rewards = currentDeepSeaRewards?.[activity.activity_id];
      if (rewards != undefined) {
        const activityProgress = JSON.parseSafe(activity.extra_information)?.activity_progress;
        const currentStage = currentPlayerTokens?.[activityProgress]?.num ?? 0;
        let rewardIndex = 0;
        for (const rewardID in rewards) {
          if (rewardIndex++ == currentStage && rewards[rewardID].product_id == 0) {
            starryTreasureRewardStage = currentStage;
          }
          if (rewardIndex > currentStage) {
            break;
          }
        }
      }
      const hasReward = loginRewardActivityIDs.has(activity.activity_id) || taskRewardActivityIDs.has(activity.activity_id) || starryTreasureRewardStage != undefined;
      if (hasReward) {
        result.add(red_point_utils.createRedPointKey("activity", tab));
        if (starryTreasureRewardStage != undefined) {
          result.add(red_point_utils.createRedPointKey("activity", tab, "starry_treasure", starryTreasureRewardStage));
        }
      }
    }
    for (const activityID of unconfiguredLoginRewardActivityIDs) {
      const tab = currentActivityTags[activityID];
      if (tab != undefined && availableTabSet.has(tab)) {
        result.add(red_point_utils.createRedPointKey("activity", tab));
      }
    }
    return Array.from(result);
  });
  libs.createEffect(() => {
    const currentRedPoints = getClientGlobalData("red_points") ?? [];
    const nonActivityRedPoints = currentRedPoints.filter(key => !key.startsWith("activity|"));
    setClientGlobalData("red_points", nonActivityRedPoints.concat(redPoints()), true);
  });
  libs.onMount(() => {
    const playerID = Players.GetLocalPlayer();
    const listeners = [useNetData("info_activity_data", setActivities), useNetData("login_activity_data", setLoginActivities, playerID), useNetData("info_activity_task", setActivityTasks), useNetData("activity_task_progresses", setTaskProgresses, playerID), useNetData("info_deep_sea", setDeepSeaRewards), useNetData("player_token", setPlayerTokens, playerID), useClientGlobalData("activity_tag_list", setActivityTags), useClientGlobalData("menu_bar_activity_tabs", setAvailableTabs)];
    libs.onCleanup(() => listeners.forEach(listener => GameEvents.Unsubscribe(listener)));
  });
};

const useHeroRedPointStore = () => {
  const [heroMedalLevels, setHeroMedalLevels] = libs.createSignal();
  const [heroMedalRewards, setHeroMedalRewards] = libs.createSignal();
  const [receivedRewards, setReceivedRewards] = libs.createSignal();
  const redPoints = libs.createMemo(() => {
    const result = [];
    const levels = heroMedalLevels() ?? {};
    const rewards = heroMedalRewards() ?? {};
    const received = receivedRewards() ?? {};
    for (const [heroID, heroRewards] of Object.entries(rewards)) {
      const level = levels[heroID];
      if (level == undefined) {
        continue;
      }
      for (const reward of heroRewards) {
        if (reward.ok == 1 && level >= reward.medal_level && received[heroID]?.[reward.medal_level] != true) {
          result.push(red_point_utils.createRedPointKey("hero", "proficiency", heroID, reward.medal_level));
        }
      }
    }
    return result;
  });
  libs.createEffect(() => {
    const currentRedPoints = getClientGlobalData("red_points") ?? [];
    const nonHeroRedPoints = currentRedPoints.filter(key => !key.startsWith("hero|"));
    setClientGlobalData("red_points", nonHeroRedPoints.concat(redPoints()), true);
  });
  libs.onMount(() => {
    const playerID = Players.GetLocalPlayer();
    const gameEventListeners = [useNetData("info_hero_medal_rewards", setHeroMedalRewards), useNetData("player_hero_medal_received", setReceivedRewards, playerID)];
    const netTableListeners = [useServiceNetTable("player_hero_medal_level", setHeroMedalLevels, playerID)];
    libs.onCleanup(() => {
      gameEventListeners.forEach(listener => GameEvents.Unsubscribe(listener));
      netTableListeners.forEach(listener => CustomNetTables.UnsubscribeNetTableListener(listener));
    });
  });
};

const useLadderPassRedPointStore = () => {
  const season = game_utils.GetBattlePassSeason();
  const [rewards, setRewards] = libs.createSignal([]);
  const [battlePasses, setBattlePasses] = libs.createSignal();
  const [receivedRewards, setReceivedRewards] = libs.createSignal({});
  const [tasks, setTasks] = libs.createSignal();
  const [taskProgresses, setTaskProgresses] = libs.createSignal();
  const redPoints = libs.createMemo(() => {
    const result = [];
    const currentSeason = season();
    const battlePass = Object.values(battlePasses() ?? {}).find(data => data.season == currentSeason);
    if (battlePass != undefined) {
      let maxLevel = 0;
      for (const reward of rewards()) {
        if (reward.season != currentSeason || reward.level == 10001) {
          continue;
        }
        maxLevel = Math.max(maxLevel, reward.level);
        if ((battlePass.plus == 1 || reward.plus != 1) && battlePass.level >= reward.level) {
          const receivedKey = `${reward.level}-${reward.plus}-${currentSeason}`;
          if (!receivedRewards()[receivedKey]?.state) {
            result.push(red_point_utils.createRedPointKey("ladderpass", "reward", reward.level, reward.plus));
          }
        }
      }
      if (maxLevel > 0 && battlePass.level >= maxLevel) {
        for (let level = maxLevel + 1; level <= battlePass.level; level++) {
          if (!receivedRewards()[`${level}-0-${currentSeason}`]?.state) {
            result.push(red_point_utils.createRedPointKey("ladderpass", "reward", level, 0));
          }
        }
      }
    }
    const now = Date.now() / 1000;
    for (const progress of Object.values(taskProgresses() ?? {})) {
      const task = tasks()?.[progress.task_id];
      if (task == undefined || task.season_id != currentSeason || now < progress.start_time) {
        continue;
      }
      const targets = task.target?.split("|").map(Number) ?? [];
      const completedIndex = targets.findIndex(target => (progress.progress ?? 0) < target);
      const completedSteps = completedIndex == -1 ? targets.length : completedIndex;
      if (completedSteps > (progress.receive_progress ?? 0)) {
        result.push(red_point_utils.createRedPointKey("ladderpass", "task", progress.task_id));
      }
    }
    return result;
  });
  libs.createEffect(() => {
    const currentRedPoints = getClientGlobalData("red_points") ?? [];
    const nonLadderPassRedPoints = currentRedPoints.filter(key => !key.startsWith("ladderpass|"));
    setClientGlobalData("red_points", nonLadderPassRedPoints.concat(redPoints()), true);
  });
  libs.onMount(() => {
    const playerID = Players.GetLocalPlayer();
    callAction("activity_task_progress", {
      task_type: 1,
      sid: season(),
      aid: 0,
      start_time: 1,
      end_time: Math.floor(Date.now() / 1000)
    });
    const listeners = [useNetData("info_bp_rewards", setRewards), useNetData("player_battle_passes", setBattlePasses, playerID), useNetData("player_bp_received", setReceivedRewards, playerID), useNetData("info_bp_task", setTasks), useNetData("bp_task_progresses", setTaskProgresses, playerID)];
    libs.onCleanup(() => listeners.forEach(listener => GameEvents.Unsubscribe(listener)));
  });
};

const hasUnclaimedReward = mail => {
  return mail.items != "{}" && mail.step < 2;
};
const useMailRedPointStore = () => {
  const [mails, setMails] = libs.createSignal();
  const redPoints = libs.createMemo(() => {
    const result = [];
    for (const mail of Object.values(mails() ?? {})) {
      if (mail.step == 0 || hasUnclaimedReward(mail)) {
        result.push(red_point_utils.createRedPointKey("mail", mail.category, mail.mid));
      }
    }
    return result;
  });
  libs.createEffect(() => {
    const currentRedPoints = getClientGlobalData("red_points") ?? [];
    const nonMailRedPoints = currentRedPoints.filter(key => !key.startsWith("mail|"));
    setClientGlobalData("red_points", nonMailRedPoints.concat(redPoints()), true);
  });
  libs.onMount(() => {
    const listener = useNetData("player_mails", setMails, Players.GetLocalPlayer());
    libs.onCleanup(() => GameEvents.Unsubscribe(listener));
  });
};

const useStoreRedPointStore = () => {
  const [storeItems, setStoreItems] = libs.createSignal();
  const [purchasedProducts, setPurchasedProducts] = libs.createSignal();
  const [playerOrnaments, setPlayerOrnaments] = libs.createSignal();
  const [playerHeroes, setPlayerHeroes] = libs.createSignal();
  const [storeTags, setStoreTags] = libs.createSignal(getClientGlobalData("menu_bar_store_tabs") ?? []);
  const player_vip = netdata_utils.createPlayerNetData("player_vip", Players.GetLocalPlayer());
  const redPoints = libs.createMemo(() => {
    const result = [];
    const itemsByTag = storeItems();
    const purchases = purchasedProducts();
    const ornaments = playerOrnaments();
    const heroes = playerHeroes();
    const availableTags = storeTags();
    const playerVip = player_vip();
    if (itemsByTag == undefined || purchases == undefined || ornaments == undefined || heroes == undefined) {
      return result;
    }
    for (const tag in itemsByTag) {
      if (!availableTags.includes(tag)) {
        continue;
      }
      for (const item of itemsByTag[tag]) {
        if (item.status != 1 || item.real_price != 0) {
          continue;
        }
        if (playerVip?.vip_valid != 1 && item.vip == 1) {
          continue;
        }
        if (item.limit_type >= 1 && purchases[item.id] >= item.limit_count) {
          continue;
        }
        if (getCosmeticByStoreItem(item, ornaments) || getHerobyStoreItem(item, heroes)) {
          continue;
        }
        result.push(red_point_utils.createRedPointKey("store", tag, item.id));
      }
    }
    return result;
  });
  libs.createEffect(() => {
    const currentRedPoints = getClientGlobalData("red_points") ?? [];
    const nonStoreRedPoints = currentRedPoints.filter(key => !key.startsWith("store|"));
    setClientGlobalData("red_points", nonStoreRedPoints.concat(redPoints()), true);
  });
  libs.onMount(() => {
    const listeners = [];
    listeners.push(useNetData("info_shop_product_group_by_tag", setStoreItems));
    listeners.push(useNetData("player_purchased_products", data => {
      setPurchasedProducts(data.purchased_products);
    }, Players.GetLocalPlayer()));
    listeners.push(useNetData("player_ornament", setPlayerOrnaments, Players.GetLocalPlayer()));
    listeners.push(useNetData("player_hero", setPlayerHeroes, Players.GetLocalPlayer()));
    listeners.push(useClientGlobalData("menu_bar_store_tabs", setStoreTags));
    libs.onCleanup(() => {
      listeners.forEach(listener => GameEvents.Unsubscribe(listener));
    });
  });
};

const HudRedPoint = () => {
  useStoreRedPointStore();
  useMailRedPointStore();
  useLadderPassRedPointStore();
  useActivityRedPointStore();
  useHeroRedPointStore();
  return null;
};
libs.render(() => libs.createComponent(HudRedPoint, {}), $.GetContextPanel());
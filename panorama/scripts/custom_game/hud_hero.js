--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var AbilityImage = require('./AbilityImage.js');
var CosmeticCard = require('./CosmeticCard.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_PortraitFullBody = require('./EOM_PortraitFullBody.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var EOM_Separator = require('./EOM_Separator.js');
var GenericPanel = require('./GenericPanel.js');
var HeroProficiencyIcon = require('./HeroProficiencyIcon.js');
var Heroes = require('./Heroes.js');
var InfoButton = require('./InfoButton.js');
var InteractiveAbility = require('./InteractiveAbility.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var Player = require('./Player.js');
var ProductItem = require('./ProductItem.js');
var SectIcon = require('./SectIcon.js');
var ShardAbility = require('./ShardAbility.js');
var TalentTree = require('./TalentTree.js');
var netdata_utils = require('./netdata_utils.js');
var HeroRoleCard = require('./HeroRoleCard.js');
require('./EOM_Countdown.js');
require('./red_point_utils.js');
require('./ProductImage.js');
require('./EOM_Portrait.js');

if (!isSpectator()) {
  const [heroCollectionShow, setHeroCollectionShow] = libs.createSignal(false);
  const [previewHeroData, setPreviewHeroData] = libs.createSignal();
  const [heroProficiencyRewardState, setHeroProficiencyRewardState] = libs.createSignal({});
  const [poficiencyRewardState, setPoficiencyRewardState] = libs.createSignal(false);
  libs.createEffect(libs.on(heroProficiencyRewardState, _states => {
    let hasReward = false;
    if (_states) {
      hasReward = Object.values(_states).some(v => v);
    }
    if (!poficiencyRewardState() && hasReward) {
      setPoficiencyRewardState(true);
      clientSideEvent("poficiency_reward_state", {
        state: true
      });
    } else if (poficiencyRewardState() && !hasReward) {
      setPoficiencyRewardState(false);
      clientSideEvent("poficiency_reward_state", {
        state: false
      });
    }
  }));
  const isCasualOnly = heroName => {
    if (KeyValues.UnitsCommonKv[heroName] && KeyValues.UnitsCommonKv[heroName].CasualOnly == 1) {
      return true;
    }
    return false;
  };
  const [showDetail, setShowDetail] = libs.createSignal(false);
  const [proficiencyLevelValues, setProficiencyLevelValues] = libs.createSignal([]);
  const Hero = () => {
    const [show, setShow] = libs.createSignal(false);
    const [player_hero, setPlayerHero] = libs.createSignal({});
    const [info_prop, setInfoProp] = libs.createSignal({});
    const [player_props, setPlayerProps] = libs.createSignal({});
    const [hero_medal_count, setHeroMedalCount] = libs.createSignal();
    const [hero_medal_level, setHeroMedalLevel] = libs.createSignal();
    const weekly_free_hero = netdata_utils.createNetData("weekly_free_hero", []);
    const mixed_hero_data = libs.createMemo(() => {
      const week_list = weekly_free_hero();
      const data = {
        unlocked: {},
        locked: {}
      };
      const experienceHeroData = {};
      Object.values(player_props()).forEach(v => {
        if (v.amounts > 0) {
          let propInfo = info_prop()[v.prop_id];
          if (propInfo && propInfo.type == 3) {
            let params = JSON.parseSafe(propInfo.param);
            if (params.type && params.type != "any") {
              experienceHeroData[params.type] = {
                prop_id: v.prop_id,
                id: v.id
              };
            }
          }
        }
      });
      const heroNames = Object.keys(KeyValues.UnitsCommonKv);
      heroNames.forEach(hero_name => {
        const kv = KeyValues.UnitsCommonKv[hero_name];
        if (kv.Hide == 0 && kv.Hid != undefined) {
          if (player_hero()[kv.Hid] != undefined) {
            data.unlocked[hero_name] = player_hero()[kv.Hid];
          } else if (experienceHeroData[kv.Hid.toString()]) {
            data.unlocked[hero_name] = {
              hid: kv.Hid,
              xp: 0,
              TotalXp: 0,
              Permanent: 0,
              CanExperience: 1,
              propData: experienceHeroData[kv.Hid.toString()]
            };
          } else if (week_list.includes(kv.Hid)) {
            data.unlocked[hero_name] = {
              hid: kv.Hid,
              xp: 0,
              TotalXp: 0,
              Permanent: 2
            };
          } else {
            data.locked[hero_name] = {
              hid: kv.Hid,
              xp: 0,
              TotalXp: 0,
              Permanent: 0
            };
          }
        }
      });
      return data;
    });
    const [player_skin, setPlayerSkin] = libs.createSignal({});
    const [player_lock_count, setPlayerLockCount] = libs.createSignal(0);
    const [playerHeroLockList, setPlayerHeroLockList] = libs.createSignal([]);
    const [extraHeroLockCount, setExtraHeroLockCount] = libs.createSignal(0);
    const [hasVip, setHasVip] = libs.createSignal(false);
    libs.createEffect(() => {
      const current_player_hero = player_hero();
      let list = [];
      let count = extraHeroLockCount();
      if (hasVip()) {
        count += 1;
      }
      Object.keys(current_player_hero).sort((a, b) => finiteNumber(Number(a), 9999999) - finiteNumber(Number(b), 9999999)).forEach(v => {
        if (current_player_hero[v].banned == 1 && list.length < count) {
          list.push(v);
        }
      });
      setPlayerLockCount(count);
      setPlayerHeroLockList(list);
    });
    const updateHeroProficiencyRewardState = () => {
      const info_hero_medal_level = getNetDataCache("info_hero_medal_level");
      const info_hero_medal_rewards = getNetDataCache("info_hero_medal_rewards");
      if (info_hero_medal_level == undefined || info_hero_medal_rewards == undefined) return;
      const player_hero_medal_received = getNetDataCache("player_hero_medal_received", Players.GetLocalPlayer());
      const current_hero_medal_level = hero_medal_level();
      const result = {};
      if (current_hero_medal_level != undefined) {
        Object.keys(unlocked_data()).forEach(heroName => {
          const heroID = unlocked_data()[heroName].hid;
          if (current_hero_medal_level[heroID] == undefined) return;
          if (info_hero_medal_rewards[heroID] == undefined) return;
          const level = current_hero_medal_level[heroID];
          let state = info_hero_medal_rewards[heroID].some(info => info.ok == 1 && level >= info.medal_level && player_hero_medal_received?.[heroID]?.[info.medal_level] != true);
          result[heroID] = state;
        });
      }
      setHeroProficiencyRewardState(result);
    };
    libs.createEffect(libs.on(() => {
      return {
        heroMedalLevel: hero_medal_level(),
        unlockedData: unlocked_data()
      };
    }, _heroMedalLevel => {
      updateHeroProficiencyRewardState();
    }));
    libs.onMount(() => {
      const eventId = useToggleWindow('MenuButton_hero', show, setShow);
      libs.onCleanup(() => GameEvents.Unsubscribe(eventId));
    });
    libs.createEffect(() => {
      if (show()) GameEvents.SendCustomGameEventToServer('report_open_window', {
        window_type: 1
      });
    });
    EOM_MenuLayout.useEOM_MenuLayoutData(show, () => {
      const gameEventIDList = [];
      const NetTableIDList = [];
      gameEventIDList.push(useNetData('player_hero', data => {
        setPlayerHero(data);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData('info_prop', data => {
        setInfoProp(data);
      }));
      gameEventIDList.push(useNetData('player_props', data => {
        setPlayerProps(data);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData('player_hero_lock_extra', data => {
        setExtraHeroLockCount(data.count ?? 0);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("player_vip", data => {
        if (data.vip_valid == 1) {
          setHasVip(true);
        } else {
          setHasVip(false);
        }
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("player_hero_medal_count", data => {
        setHeroMedalCount(data);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData('player_ornament', data => {
        setPlayerSkin(getOrnamentWithType(data, OrnamentType.HERO_SKIN));
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("player_hero_medal_received", data => {
        updateHeroProficiencyRewardState();
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("info_hero_medal_level", data => {
        updateHeroProficiencyRewardState();
        setProficiencyLevelValues(data.map(v => v.medal));
      }));
      gameEventIDList.push(useNetData("info_hero_medal_rewards", data => {
        updateHeroProficiencyRewardState();
      }));
      NetTableIDList.push(useServiceNetTable("player_hero_medal_level", data => {
        setHeroMedalLevel(data);
      }, Players.GetLocalPlayer()));
      return () => {
        gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
        NetTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      };
    });
    const unlocked_data = () => mixed_hero_data()?.unlocked ?? {};
    const locked_data = () => mixed_hero_data()?.locked ?? {};
    return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
      renderOnShow: true,
      get show() {
        return show();
      },
      name: "MenuButton_hero",
      get children() {
        return [libs.createComponent(Player.CurrencyGroup, {
          tokens: ['coin'],
          exchangeButton: true
        }), libs.createComponent(libs.Show, {
          get when() {
            return !heroCollectionShow();
          },
          get children() {
            return [libs.createComponent(HeroList, {
              get player_lock_count() {
                return player_lock_count();
              },
              get player_lock_list() {
                return playerHeroLockList();
              },
              get hasVip() {
                return hasVip();
              },
              get mixed_hero_data() {
                return mixed_hero_data();
              },
              get hero_medal_count() {
                return hero_medal_count();
              },
              get unlocked_data() {
                return unlocked_data();
              },
              get locked_data() {
                return locked_data();
              },
              get hero_medal_level() {
                return hero_medal_level();
              },
              get weekly_free_hero() {
                return weekly_free_hero();
              }
            }), libs.createComponent(HeroDetail, {
              get player_skin() {
                return player_skin();
              }
            })];
          }
        }), libs.createComponent(HeroCollection, {
          get unlocked_data() {
            return unlocked_data();
          },
          get hero_medal_count() {
            return hero_medal_count();
          },
          get hero_medal_level() {
            return hero_medal_level();
          }
        })];
      }
    });
  };
  const HeroList = props => {
    const [local, others] = libs.splitProps(props, ['mixed_hero_data', 'hero_medal_count', 'unlocked_data', "locked_data", "hero_medal_level", "player_lock_list", "hasVip", "player_lock_count", "weekly_free_hero"]);
    const [medal_orderby, setMedalOrderby] = libs.createSignal(0);
    const getMedalCount = hid => {
      return local.hero_medal_count?.[hid.toString()] ?? 0;
    };
    const [collectionFiltered, setCollectionFiltered] = libs.createSignal(false);
    const [sectFilter, setSectFilter] = libs.createSignal('');
    const [collectedHeroes, setCollectedHeroes] = libs.createSignal([]);
    const [freeHero, setFreeHero] = libs.createSignal(false);
    libs.onMount(() => {
      const NetTableListeners = [];
      const gameEventIDList = [];
      NetTableListeners.push(useServiceNetTable("player_hero_collection", data => {
        let collected_heroes = [];
        for (const sect in data) {
          data[sect].hero.forEach(id => {
            const hero_name = GetHeroNameByGoodID(id);
            if (hero_name) {
              collected_heroes.push(hero_name);
            }
          });
        }
        setCollectedHeroes(collected_heroes);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("info_activity_data", data => {
        let now = Math.floor(Date.now() / 1000);
        for (const activityInfo of data) {
          if (activityInfo.activity_id == 11001 && (activityInfo.end_time > now || activityInfo.end_time == 0)) {
            setFreeHero(true);
            break;
          }
        }
      }));
      libs.onCleanup(() => {
        gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
        NetTableListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      });
    });
    const unlocked_list = () => {
      let list = Object.keys(local.unlocked_data);
      const rewardState = heroProficiencyRewardState();
      const collectedSet = new Set(collectedHeroes());
      const weeklyFreeSet = new Set(local.weekly_free_hero);
      list.sort((a, b) => {
        const aData = local.unlocked_data[a];
        const bData = local.unlocked_data[b];
        const isWeeklyA = weeklyFreeSet.has(aData.hid);
        const isWeeklyB = weeklyFreeSet.has(bData.hid);
        let expA = !isWeeklyA && aData.CanExperience ? 1 : 0;
        let expB = !isWeeklyB && bData.CanExperience ? 1 : 0;
        if (isWeeklyA !== isWeeklyB) {
          return isWeeklyB ? 1 : -1;
        }
        if (expB !== expA) return expB - expA;
        const rewardA = rewardState[aData.hid] ? 1 : 0;
        const rewardB = rewardState[bData.hid] ? 1 : 0;
        if (rewardB !== rewardA) return rewardB - rewardA;
        const permA = aData.Permanent ?? 0;
        const permB = bData.Permanent ?? 0;
        if (permA !== permB) return permA - permB;
        const expTimeA = aData.Expire ?? 0;
        const expTimeB = bData.Expire ?? 0;
        if (expTimeA !== expTimeB) return expTimeA - expTimeB;
        const collectedA = collectedSet.has(a) ? 1 : 0;
        const collectedB = collectedSet.has(b) ? 1 : 0;
        if (collectedB !== collectedA) return collectedB - collectedA;
        const medalA = getMedalCount(aData.hid);
        const medalB = getMedalCount(bData.hid);
        return medal_orderby() == 0 ? medalB - medalA : medalA - medalB;
      });
      return list;
    };
    const locked_list = () => {
      return Object.keys(local.locked_data);
    };
    const hero_count_label = () => $.Localize('#HeroList') + ': ' + unlocked_list().length + ' / ' + (unlocked_list().length + locked_list().length);
    const HeroLockSlotArr = () => {
      if (local.hasVip) {
        return [...Array(local.player_lock_count)].fill(1);
      }
      return [...Array(local.player_lock_count + 1)].fill(1);
    };
    const [heroLockEditing, setHeroLockEditing] = libs.createSignal(false);
    let cooldown = false;
    const onLockHero = (hid, isBan) => {
      if (cooldown) return;
      if (isBan) {
        if (local.player_lock_list.length >= local.player_lock_count) {
          return;
        }
      }
      cooldown = true;
      $.Schedule(0.1, () => {
        cooldown = false;
      });
      callAction("player_hero_lock", {
        hid,
        ban: isBan ? 1 : 0
      });
    };
    const weeklyHeroFreshTime = getWeekHeroRefreshTime();
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "HeroesPage",
      hittest: false,
      get className() {
        return libs.classNames('DashboardPage', {
          Show: !showDetail()
        });
      },
      onactivate: () => {},
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "MainContainer",
          hittest: false,
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "HeroListTop",
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  align: "left center",
                  flowChildren: "right",
                  height: '100%',
                  get children() {
                    return [libs.createComponent(GenericPanel.CLabel, {
                      id: "HeroListTitle",
                      get text() {
                        return hero_count_label();
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return poficiencyRewardState();
                      },
                      get children() {
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "FastPoficiencyReward",
                          get children() {
                            return [libs.createComponent(EOM_Button.EOM_Button, {
                              id: "FastPoficiencyRewardButton",
                              color: "Gold",
                              text: "#ReceiveAll",
                              onactivate: () => {
                                callAction("proficiency_reward_receive", {
                                  hid: 0,
                                  level: 0
                                });
                              }
                            }), libs.createComponent(EOM_Icon.EOM_Icon, {
                              get className() {
                                return libs.classNames("ProficiencyRewardIcon", "Show");
                              },
                              size: "64",
                              get src() {
                                return getSrcPath("icon/s6_reward_icon.png");
                              },
                              hittest: false
                            })];
                          }
                        });
                      }
                    })];
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "HeroLock",
                  get children() {
                    return [libs.createComponent(EOM_Button.EOM_Button, {
                      get className() {
                        return libs.classNames("HeroLockEditButton", {
                          Show: heroLockEditing()
                        });
                      },
                      color: "Red",
                      onactivate: () => setHeroLockEditing(false),
                      text: "#CloseEdit"
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "HeroLockTitle",
                      tooltip_text: "#PlayerHeroLock_Description",
                      get children() {
                        return [libs.createComponent(EOM_Icon.EOM_Icon, {
                          size: "16",
                          get src() {
                            return getSrcPath("icon/c_info.png");
                          }
                        }), libs.createElement("Label", {
                          text: "#PlayerHeroLock"
                        }, null)];
                      }
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "HeroLockList",
                      get children() {
                        return libs.createComponent(libs.For, {
                          get each() {
                            return HeroLockSlotArr();
                          },
                          children: (_, index) => {
                            const hid = () => local.player_lock_list[index()] ? Number(local.player_lock_list[index()]) : undefined;
                            const selected = () => heroLockEditing();
                            const type = () => {
                              if (HeroLockSlotArr().length - index() <= 1) {
                                return "vip";
                              } else if (index() >= 5) {
                                return "extra";
                              }
                              return "default";
                            };
                            const IsLocked = () => !local.hasVip && type() == "vip";
                            return libs.createComponent(EOM_Panel.EOM_Panel, {
                              get className() {
                                return libs.classNames("HeroLockSlot", type(), {
                                  Selected: selected() && !IsLocked(),
                                  noHover: IsLocked() || selected(),
                                  IsLocked: IsLocked()
                                });
                              },
                              onactivate: () => {
                                if (!IsLocked()) {
                                  setHeroLockEditing(true);
                                }
                              },
                              get children() {
                                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                  id: "HeroLockBG"
                                }), libs.createComponent(libs.Show, {
                                  get when() {
                                    return hid() != undefined;
                                  },
                                  get children() {
                                    return [libs.createComponent(Heroes.HeroImage, {
                                      get hero_name() {
                                        return GetHeroNameByGoodID(hid());
                                      }
                                    }), libs.createComponent(EOM_Button.EOM_IconButton, {
                                      id: "closeButton",
                                      get icon() {
                                        return libs.createComponent(EOM_Icon.EOM_Icon, {
                                          size: '16',
                                          get src() {
                                            return getSrcPath("hero_collection/s5_close.png");
                                          }
                                        });
                                      },
                                      onactivate: () => onLockHero(hid(), false)
                                    })];
                                  }
                                }), libs.createComponent(libs.Show, {
                                  get when() {
                                    return type() == "vip";
                                  },
                                  get children() {
                                    return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                      get visible() {
                                        return IsLocked();
                                      },
                                      align: 'center center',
                                      width: '20px',
                                      height: '20px',
                                      get src() {
                                        return getSrcPath("activity/pixel/lock.png");
                                      }
                                    }), libs.createComponent(EOM_Icon.EOM_Icon, {
                                      align: 'left top',
                                      width: '20px',
                                      height: '20px',
                                      get src() {
                                        return getSrcPath("icon/vip_icon_smallest.png");
                                      }
                                    })];
                                  }
                                })];
                              }
                            });
                          }
                        });
                      }
                    })];
                  }
                })];
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "HeroList",
              scroll: "y",
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "UnlockedList",
                  flowChildren: "right-wrap",
                  get children() {
                    return libs.createComponent(libs.Index, {
                      get each() {
                        return unlocked_list();
                      },
                      children: (heroName, index) => {
                        const hero_data = () => local.unlocked_data[heroName()];
                        const medal_count = () => getMedalCount(hero_data().hid);
                        const collected = () => collectedHeroes().includes(heroName());
                        const proficiency_level = () => local.hero_medal_level?.[hero_data().hid.toString()] ?? 0;
                        return libs.createComponent(EOM_Button.EOM_BaseButton, {
                          get className() {
                            return libs.classNames('HeroCardButton', {
                              Show: (sectFilter() == '' || (KeyValues.UnitsCommonKv[heroName()].Sect ?? '').includes(sectFilter())) && (!collectionFiltered() || collected())
                            });
                          },
                          get enabled() {
                            return !(heroLockEditing() && local.player_lock_list.includes(hero_data().hid.toString()));
                          },
                          onactivate: () => {
                            if (!heroLockEditing()) {
                              libs.batch(() => {
                                setShowDetail(true);
                                setPreviewHeroData({
                                  hero_name: heroName(),
                                  hid: hero_data().hid,
                                  xp: medal_count(),
                                  proficiency_level: proficiency_level(),
                                  lock: hero_data().CanExperience == 1,
                                  hasReward: heroProficiencyRewardState()[hero_data().hid],
                                  canExperience: hero_data().CanExperience == 1,
                                  propData: hero_data().propData
                                });
                              });
                            } else {
                              onLockHero(hero_data().hid, true);
                            }
                          },
                          get children() {
                            return [libs.createComponent(libs.Switch, {
                              get children() {
                                return [libs.createComponent(libs.Match, {
                                  get when() {
                                    return local.weekly_free_hero.includes(hero_data().hid);
                                  },
                                  get children() {
                                    const _el$2 = libs.createElement("Panel", {
                                        id: "WeekFree"
                                      }, null),
                                      _el$3 = libs.createElement("Panel", {
                                        id: "WeekFreeTime"
                                      }, _el$2);
                                    libs.insert(_el$2, libs.createComponent(GenericPanel.CImage, {
                                      id: "WeekFreeMarkBG",
                                      get children() {
                                        return libs.createComponent(GenericPanel.CImage, {
                                          id: "WeekFreeMark",
                                          get ["class"]() {
                                            return $.Language().toLocaleLowerCase();
                                          }
                                        });
                                      }
                                    }), _el$3);
                                    libs.insert(_el$3, libs.createComponent(CosmeticCard.EOM_CountdownWithIcon, {
                                      id: "WeekFreeCountdown",
                                      endTime: weeklyHeroFreshTime
                                    }));
                                    return _el$2;
                                  }
                                }), libs.createComponent(libs.Match, {
                                  get when() {
                                    return libs.memo(() => hero_data().Permanent != 1)() && (hero_data()?.Expire ?? 0) > 0;
                                  },
                                  get children() {
                                    const _el$4 = libs.createElement("Panel", {
                                        id: "Trial"
                                      }, null),
                                      _el$5 = libs.createElement("Panel", {
                                        id: "TrialTime"
                                      }, _el$4);
                                    libs.insert(_el$4, libs.createComponent(GenericPanel.CImage, {
                                      id: "TrialMark",
                                      get ["class"]() {
                                        return $.Language().toLocaleLowerCase();
                                      }
                                    }), _el$5);
                                    libs.insert(_el$5, libs.createComponent(CosmeticCard.EOM_CountdownWithIcon, {
                                      id: "HeroRoleCountdown",
                                      get endTime() {
                                        return Number(hero_data().Expire);
                                      }
                                    }));
                                    return _el$4;
                                  }
                                })];
                              }
                            }), libs.createComponent(HeroRoleCard.HeroRoleCard, {
                              get heroName() {
                                return heroName();
                              },
                              get collected() {
                                return collectedHeroes().includes(heroName());
                              },
                              get children() {
                                return [libs.createComponent(libs.Show, {
                                  get when() {
                                    return hero_data().CanExperience != 1;
                                  },
                                  get children() {
                                    return [libs.createComponent(HeroProficiencyIcon.HeroProficiencyIcon, {
                                      size: "small",
                                      get override_level() {
                                        return proficiency_level();
                                      }
                                    }), libs.createComponent(EOM_Icon.EOM_Icon, {
                                      get className() {
                                        return libs.classNames("ProficiencyRewardIcon", "Show");
                                      },
                                      get visible() {
                                        return heroProficiencyRewardState()[hero_data().hid.toString()] ?? false;
                                      },
                                      size: "64",
                                      get src() {
                                        return getSrcPath("icon/s6_reward_icon.png");
                                      },
                                      hittest: false
                                    })];
                                  }
                                }), libs.createComponent(libs.Show, {
                                  get when() {
                                    return hero_data().CanExperience == 1;
                                  },
                                  get children() {
                                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                                      className: "Experience",
                                      get children() {
                                        return libs.createComponent(EOM_Label.EOM_Label, {
                                          color: 'white',
                                          get text() {
                                            return $.Localize("#can_experience");
                                          }
                                        });
                                      }
                                    });
                                  }
                                })];
                              }
                            }), libs.createComponent(libs.Show, {
                              get when() {
                                return isCasualOnly(heroName());
                              },
                              get children() {
                                return libs.createComponent(EOM_Panel.EOM_Panel, {
                                  className: "CasualOnly",
                                  get children() {
                                    return [libs.createComponent(EOM_Image.EOM_Image, {
                                      id: "CasualOnlyLeftLine"
                                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                      id: "CasualOnlyLine",
                                      get children() {
                                        return libs.createComponent(GenericPanel.CLabel, {
                                          text: "#CasualOnly"
                                        });
                                      }
                                    }), libs.createComponent(EOM_Image.EOM_Image, {
                                      id: "CasualOnlyRightLine"
                                    })];
                                  }
                                });
                              }
                            })];
                          }
                        });
                      }
                    });
                  }
                }), libs.createComponent(libs.Show, {
                  get when() {
                    return libs.memo(() => !!!collectionFiltered())() && !heroLockEditing();
                  },
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "divider",
                      get children() {
                        return libs.createComponent(GenericPanel.CLabel, {
                          text: '#Hero_LockedHero'
                        });
                      }
                    });
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  get visible() {
                    return !heroLockEditing();
                  },
                  id: "lockedList",
                  flowChildren: "right-wrap",
                  paddingBottom: '35px',
                  get children() {
                    return libs.createComponent(libs.Index, {
                      get each() {
                        return locked_list();
                      },
                      children: (heroName, index) => {
                        const hero_data = () => local.locked_data[heroName()];
                        return libs.createComponent(EOM_Button.EOM_BaseButton, {
                          get className() {
                            return libs.classNames('HeroCardButton', {
                              Locked: !freeHero(),
                              Show: (sectFilter() == '' || (KeyValues.UnitsCommonKv[heroName()].Sect ?? '').includes(sectFilter())) && !collectionFiltered()
                            });
                          },
                          onactivate: () => libs.batch(() => {
                            setShowDetail(true);
                            setPreviewHeroData({
                              hero_name: heroName(),
                              hid: hero_data().hid,
                              xp: hero_data().TotalXp,
                              proficiency_level: 0,
                              lock: true,
                              canExperience: false
                            });
                          }),
                          get children() {
                            return [libs.createComponent(HeroRoleCard.HeroRoleCard, {
                              get heroName() {
                                return heroName();
                              }
                            }), libs.createComponent(libs.Show, {
                              get when() {
                                return isCasualOnly(heroName());
                              },
                              get children() {
                                return libs.createComponent(EOM_Panel.EOM_Panel, {
                                  className: "CasualOnly",
                                  get children() {
                                    return [libs.createComponent(EOM_Image.EOM_Image, {
                                      id: "CasualOnlyLeftLine"
                                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                      id: "CasualOnlyLine",
                                      get children() {
                                        return libs.createComponent(GenericPanel.CLabel, {
                                          text: "#CasualOnly"
                                        });
                                      }
                                    }), libs.createComponent(EOM_Image.EOM_Image, {
                                      id: "CasualOnlyRightLine"
                                    })];
                                  }
                                });
                              }
                            }), (() => {
                              const _el$6 = libs.createElement("Image", {
                                id: "Lock",
                                get ["class"]() {
                                  return libs.memo(() => !!freeHero())() ? $.Language().toLowerCase() : "";
                                }
                              }, null);
                              libs.effect(_$p => libs.setProp(_el$6, "class", libs.memo(() => !!freeHero())() ? $.Language().toLowerCase() : "", _$p));
                              return _el$6;
                            })()];
                          }
                        });
                      }
                    });
                  }
                })];
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "BottomContainer",
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "OrderFilter",
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "OrderFilterTitle",
                  text: '#Hero_OrderBy'
                }), libs.createComponent(EOM_DropDown.EOM_DropDown, {
                  id: "OrderFilterDropDown",
                  index: 0,
                  menuPosition: "top",
                  onChange: (index, item) => {
                    setMedalOrderby(index);
                  },
                  get children() {
                    return [libs.createComponent(GenericPanel.CLabel, {
                      text: '#Hero_OrderByMedalDown',
                      id: "medal_down"
                    }), libs.createComponent(GenericPanel.CLabel, {
                      text: '#Hero_OrderByMedalUp',
                      id: "medal_up"
                    })];
                  }
                })];
              }
            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
              get className() {
                return libs.classNames("CollecttionFilter", {
                  Active: collectionFiltered()
                });
              },
              onactivate: () => setCollectionFiltered(v => !v),
              get children() {
                return [libs.createComponent(EOM_Icon.EOM_Icon, {
                  id: "CollecttionFilterIcon"
                }), libs.createComponent(GenericPanel.CLabel, {
                  id: "CollecttionFilterText",
                  text: "#hero_collection_filter"
                })];
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "HeroFilter",
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  className: "TypeLabel",
                  text: '#PlayerInfoTitle_Sect'
                }), libs.createComponent(libs.For, {
                  get each() {
                    return KeyValues.SECT_LIST;
                  },
                  children: sectName => {
                    return libs.createComponent(EOM_Button.EOM_BaseButton, {
                      get className() {
                        return libs.classNames('SectFilter', {
                          Selected: sectFilter() == sectName
                        });
                      },
                      onactivate: self => {
                        if (sectFilter() == sectName) {
                          setSectFilter('');
                        } else {
                          setSectFilter(sectName);
                        }
                      },
                      get children() {
                        return libs.createComponent(SectIcon.SectIcon, {
                          sectName: sectName,
                          get active() {
                            return sectFilter() == sectName;
                          }
                        });
                      }
                    });
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  get children() {
                    return libs.createComponent(EOM_Button.EOM_Button, {
                      id: "HeroCollectionButton",
                      color: "Blue",
                      text: "#HeroCollection",
                      onactivate: () => {
                        setHeroCollectionShow(true);
                      }
                    });
                  }
                })];
              }
            })];
          }
        })];
      }
    });
  };
  const useProficiencyDetail = () => {
    const hero_id = () => previewHeroData()?.hid ?? -1;
    const [proficiencyMaxLevel, setProficiencyMaxLevel] = libs.createSignal(0);
    const [proficiencyRewardData, setProficiencyRewardData] = libs.createSignal();
    const [playerRewardReceivedRecord, setPlayerRewardReceivedRecord] = libs.createSignal();
    const updateProficiencyRewardData = data => {
      if (data == undefined) return;
      setProficiencyRewardData(data[hero_id().toString()]);
    };
    const updateProficiencyRewardReceivedRecord = data => {
      setPlayerRewardReceivedRecord(data);
    };
    libs.createEffect(libs.on(hero_id, heroID => {
      updateProficiencyRewardData(getNetDataCache("info_hero_medal_rewards"));
      updateProficiencyRewardReceivedRecord(getNetDataCache("player_hero_medal_received", Players.GetLocalPlayer())?.[heroID.toString()]);
    }));
    libs.onMount(() => {
      const gameEventIDList = [];
      gameEventIDList.push(useNetData("player_hero_medal_received", data => {
        updateProficiencyRewardReceivedRecord(data?.[hero_id().toString()]);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("info_hero_medal_rewards", data => {
        updateProficiencyRewardData(data);
      }));
      gameEventIDList.push(useNetData("info_hero_medal_level", data => {
        let maxLv = data.reduce((pre, cur) => Math.max(cur.medal_level, pre), 0);
        setProficiencyMaxLevel(maxLv);
      }));
      libs.onCleanup(() => {
        gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      });
    });
    const proficiencyLevelList = () => [...Array(proficiencyMaxLevel() + 1)].map((_, index) => index);
    const [showHeroProficiencyDetail, setShowHeroProficiencyDetail] = libs.createSignal(false);
    return {
      showHeroProficiencyDetail,
      setShowHeroProficiencyDetail,
      proficiencyLevelList,
      proficiencyRewardData,
      playerRewardReceivedRecord
    };
  };
  const useHeroDetail = props => {
    const [local, others] = libs.splitProps(props, ['player_skin']);
    const previewHeroCosmeticList = libs.createMemo(() => {
      const list = getHeroCosmeticList(previewHeroData()?.hid ?? 0);
      const cosmetic_list = [];
      const coloring_list = [];
      list.forEach((data, _) => {
        const type = data.cosmeticID.slice(0, 3);
        if (type == "510" || data.cosmeticID == "hero_skin_default") {
          const coloring = KeyValues.CosmeticsKv[data.cosmeticID]?.coloring;
          if (coloring == undefined) {
            cosmetic_list.push(data);
          } else {
            coloring_list.push({
              cosmeticID: data.cosmeticID,
              Rarity: data.Rarity,
              coloring
            });
          }
        }
      });
      return {
        cosmetic_list,
        coloring_list
      };
    });
    const hero_xp = () => previewHeroData()?.xp ?? 0;
    const proficiency_level = () => previewHeroData()?.proficiency_level ?? 0;
    const hero_name = () => previewHeroData()?.hero_name ?? '';
    const hero_id = () => previewHeroData()?.hid ?? -1;
    const storeID = () => KeyValues.UnitsCommonKv[hero_name()]?.StoreID;
    const access = () => KeyValues.UnitsCommonKv[hero_name()]?.Access;
    const hasReward = () => heroProficiencyRewardState()[hero_id()] ?? false;
    const equippedID = libs.createMemo(() => {
      for (const oid in local.player_skin) {
        const cosmeticData = local.player_skin[oid];
        if (cosmeticData.hid == hero_id() && cosmeticData.equip == 1) {
          return cosmeticData.oid.toString();
        }
      }
    });
    const getPrevewSkinID = id => {
      if (KeyValues.CosmeticsKv[id]?.coloring) {
        return KeyValues.CosmeticsKv[id].coloring.toString();
      }
      return id;
    };
    const seletedSkinID = () => getPrevewSkinID(equippedID() ?? "hero_skin_default");
    const [previewSkinID, setPreviewSkinID] = libs.createSignal(seletedSkinID());
    libs.createEffect(libs.on(previewHeroData, playerSkin => {
      setPreviewSkinID(seletedSkinID());
    }));
    let scene;
    const isEquip = (cosmeticID, isShelf = false) => {
      if (cosmeticID == "hero_skin_default") {
        for (const oid in local.player_skin) {
          const cosmeticData = local.player_skin[oid];
          if (cosmeticData.hid == hero_id() && cosmeticData.equip == 1) {
            return false;
          }
        }
        return true;
      }
      if (isShelf && KeyValues.CosmeticsKv[cosmeticID]?.hasColoring == 1) {
        for (const oid in local.player_skin) {
          if (local.player_skin[oid].equip == 1 && KeyValues.CosmeticsKv[oid]?.coloring == cosmeticID) {
            return true;
          }
        }
      }
      return local.player_skin[cosmeticID]?.equip == 1;
    };
    const isLocked = cosmeticID => {
      if (cosmeticID != "hero_skin_default") {
        return local.player_skin[cosmeticID] == undefined;
      }
    };
    const hasColoring = cosmeticID => {
      if (cosmeticID != "hero_skin_default") {
        if (KeyValues.CosmeticsKv[cosmeticID] && KeyValues.CosmeticsKv[cosmeticID].hasColoring == 1) {
          return true;
        }
      }
      return false;
    };
    const [previewing, setPreviewing] = libs.createSignal(seletedSkinID());
    libs.createEffect(libs.on(previewing, _ => {
    }));
    libs.createEffect(libs.on(previewSkinID, _previewSkinID => {
      if (equippedID() && previewHeroCosmeticList().coloring_list.reduce((prev, current) => prev ? prev : current.coloring.toString() == _previewSkinID && current.cosmeticID == equippedID(), false)) {
        setPreviewing(equippedID());
      } else {
        setPreviewing(_previewSkinID);
      }
    }));
    const coloringList = () => {
      const list = [];
      const current_previewSkinID = previewSkinID();
      const coloring_list = previewHeroCosmeticList().coloring_list;
      if (current_previewSkinID != "hero_skin_default" && KeyValues.CosmeticsKv[current_previewSkinID]?.hasColoring == 1) {
        coloring_list.forEach((data, _) => {
          if (data.coloring.toString() == current_previewSkinID) {
            list.push(Number(data.cosmeticID));
          }
        });
      }
      return list;
    };
    return {
      scene,
      previewing,
      hero_name,
      hero_xp,
      proficiency_level,
      access,
      storeID,
      coloringList,
      previewSkinID,
      isEquip,
      isLocked,
      setPreviewing,
      hero_id,
      previewHeroCosmeticList,
      seletedSkinID,
      hasColoring,
      setPreviewSkinID,
      hasReward
    };
  };
  const HeroDetail = props => {
    const {
      scene,
      previewing,
      hero_name,
      hero_xp,
      access,
      storeID,
      coloringList,
      previewSkinID,
      isEquip,
      isLocked,
      setPreviewing,
      hero_id,
      previewHeroCosmeticList,
      seletedSkinID,
      hasColoring,
      setPreviewSkinID,
      proficiency_level,
      hasReward
    } = useHeroDetail(props);
    const {
      showHeroProficiencyDetail,
      setShowHeroProficiencyDetail,
      proficiencyLevelList,
      proficiencyRewardData,
      playerRewardReceivedRecord
    } = useProficiencyDetail();
    let proficiencyDetailScroll;
    const [heroAbilityList, setHeroAbilityList] = libs.createSignal([]);
    const [heroInterActiveAbility, setHeroInterActiveAbility] = libs.createSignal();
    const customManaType = libs.createMemo(() => {
      if (hero_name() && KeyValues.UnitsCommonKv[hero_name()]) {
        return KeyValues.UnitsCommonKv[hero_name()].CustomManaType;
      }
    });
    const heroContributor = () => {
      if (hero_name() && previewSkinID() == "hero_skin_default" && KeyValues.UnitsCommonKv[hero_name()]) {
        return KeyValues.UnitsCommonKv[hero_name()].contributor;
      }
    };
    libs.createEffect(() => {
      let list = [];
      if (KeyValues.HeroAbilityDisplayList[hero_name()]) {
        list = KeyValues.HeroAbilityDisplayList[hero_name()];
      }
      const kv = KeyValues.UnitsCommonKv[hero_name()];
      if (kv && typeof kv?.InteractiveAbilityName == "string") {
        setHeroInterActiveAbility(kv?.InteractiveAbilityName);
      } else {
        setHeroInterActiveAbility();
      }
      setHeroAbilityList(list);
    });
    libs.createEffect(libs.on(() => {
      return {
        xp: hero_xp(),
        levelValues: proficiencyLevelValues()
      };
    }, data => {
    }));
    let receiveCD = false;
    const HeroSect = () => {
      return (KeyValues.UnitsCommonKv[hero_name()]?.Sect ?? '').split('|');
    };
    const HeroSectNeed = () => {
      let count = KeyValues.UnitsCommonKv[hero_name()]?.SectNeeds;
      if (typeof count == "number") {
        return count;
      }
    };
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "HeroesDetail",
      hittest: false,
      get className() {
        return libs.classNames('DashboardPage', {
          Show: showDetail(),
          ProficiencyDetail: showHeroProficiencyDetail()
        });
      },
      onactivate: () => {},
      get children() {
        return [libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
          ref: scene,
          id: "Preview3D",
          get unitname() {
            return libs.memo(() => previewing() == "hero_skin_default")() ? hero_name() : previewing();
          },
          width: "1020px",
          height: "1020px",
          align: "center center"
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "DetailMain",
          hittest: false,
          get children() {
            return [libs.createComponent(libs.Show, {
              get when() {
                return previewHeroData()?.lock;
              },
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  flowChildren: 'right',
                  align: 'center bottom',
                  marginBottom: '70px',
                  get children() {
                    return [libs.createComponent(libs.Switch, {
                      fallback: () => libs.createComponent(EOM_Button.EOM_Button, {
                        id: "GetButton",
                        color: "Blue",
                        text: "#CosmeticGet",
                        enabled: false,
                        onactivate: () => {}
                      }),
                      get children() {
                        return [libs.createComponent(libs.Match, {
                          get when() {
                            return libs.memo(() => access() == "store")() && storeID() != undefined;
                          },
                          get children() {
                            return libs.createComponent(EOM_Button.EOM_Button, {
                              id: "GetButton",
                              color: 'Blue',
                              text: '#Popup_Button_Buy',
                              onactivate: () => {
                                if (storeID()) {
                                  clientSideEvent('directly_purchase', {
                                    itemid: storeID()
                                  });
                                }
                              }
                            });
                          }
                        }), libs.createComponent(libs.Match, {
                          get when() {
                            return access() == "activity" || access() == "battlepass" || access() == "draw" || access() == "drawExchange";
                          },
                          get children() {
                            return libs.createComponent(EOM_Button.EOM_Button, {
                              id: "GetButton",
                              color: "Blue",
                              text: "#CosmeticGet",
                              onactivate: () => {
                                if (access() == "drawExchange" || access() == "draw") {
                                  if (storeID() != undefined) {
                                    clientSideEvent("switchDrawPool", {
                                      pid: storeID()
                                    });
                                    if (access() == "drawExchange") {
                                      clientSideEvent("openDrawExchange", {
                                        state: true
                                      });
                                    }
                                  }
                                  ToggleWindows('MenuButton_draw', true);
                                } else {
                                  ToggleWindows('MenuButton_' + access(), true);
                                  if (access() == "activity" && storeID() != undefined) {
                                    let tags = storeID().split(",");
                                    if (tags[0]) {
                                      clientSideEvent("switchActivityTag", {
                                        id: tags[0]
                                      });
                                    }
                                    if (tags[1]) {
                                      clientSideEvent("switchActivityExtraInfo", {
                                        id: tags[1]
                                      });
                                    }
                                  }
                                }
                              }
                            });
                          }
                        }), libs.createComponent(libs.Match, {
                          get when() {
                            return access() == "default";
                          },
                          get children() {
                            return [];
                          }
                        })];
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return previewHeroData()?.canExperience;
                      },
                      get children() {
                        return libs.createComponent(EOM_Button.EOM_Button, {
                          marginLeft: '20px',
                          color: 'Gold',
                          text: '#UseExperienceCard',
                          onactivate: () => {
                            callAction("use_prop", {
                              id: previewHeroData()?.propData?.id ?? 0,
                              prop_id: previewHeroData()?.propData?.prop_id ?? 0,
                              amounts: 1,
                              params: [(previewHeroData()?.hid ?? 0).toString()]
                            });
                            setShowDetail(false);
                          }
                        });
                      }
                    })];
                  }
                });
              }
            }), (() => {
              const _el$7 = libs.createElement("Panel", {
                  id: "HeroDetail"
                }, null),
                _el$8 = libs.createElement("Panel", {
                  id: "AttributeList"
                }, _el$7),
                _el$9 = libs.createElement("Panel", {}, _el$8),
                _el$0 = libs.createElement("Image", {}, _el$9),
                _el$1 = libs.createElement("Panel", {}, _el$9),
                _el$10 = libs.createElement("Panel", {}, _el$8),
                _el$11 = libs.createElement("Image", {}, _el$10),
                _el$12 = libs.createElement("Panel", {}, _el$10),
                _el$13 = libs.createElement("Panel", {}, _el$8),
                _el$14 = libs.createElement("Image", {}, _el$13),
                _el$15 = libs.createElement("Panel", {}, _el$13),
                _el$16 = libs.createElement("Panel", {}, _el$8),
                _el$17 = libs.createElement("Image", {}, _el$16),
                _el$18 = libs.createElement("Panel", {}, _el$16);
              libs.insert(_el$7, libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    id: "HeroName",
                    get text() {
                      return '#' + hero_name();
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    horizontalAlign: "right",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(libs.Index, {
                        get each() {
                          return HeroSect();
                        },
                        children: (sectName, index) => libs.createComponent(SectIcon.SectIcon, {
                          get sectName() {
                            return sectName();
                          }
                        })
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return HeroSectNeed() != undefined;
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "HeroSectNeed",
                            get dialogVariables() {
                              return {
                                count: HeroSectNeed()
                              };
                            },
                            tooltip_text: "#HeroSectNeeds",
                            get children() {
                              return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                size: '32',
                                get src() {
                                  return getSrcPath("icon/s_suggest.png");
                                }
                              }), libs.createComponent(EOM_Label.EOM_Label, {
                                get text() {
                                  return HeroSectNeed();
                                }
                              })];
                            }
                          });
                        }
                      })];
                    }
                  })];
                }
              }), _el$8);
              libs.insert(_el$7, libs.createComponent(EOM_Separator.EOM_Separator, {
                marginLeft: "-30px"
              }), _el$8);
              libs.insert(_el$7, libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "Hero_Emblem",
                get children() {
                  return [libs.createComponent(HeroProficiencyIcon.HeroProficiencyIcon, {
                    size: "small",
                    get override_level() {
                      return proficiency_level();
                    }
                  }), libs.createComponent(GenericPanel.CLabel, {
                    id: "EmblemCount",
                    get text() {
                      return hero_xp();
                    }
                  }), libs.createComponent(EOM_Icon.EOM_Icon, {
                    get visible() {
                      return hasReward();
                    },
                    get className() {
                      return libs.classNames("ProficiencyRewardIcon", {
                        Show: hasReward()
                      });
                    },
                    size: "64",
                    get src() {
                      return getSrcPath("icon/s6_reward_icon.png");
                    },
                    hittest: false
                  }), libs.createComponent(EOM_Button.EOM_DiamondButton, {
                    hasAnimation: true,
                    onactivate: () => setShowHeroProficiencyDetail(v => !v)
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return isCasualOnly(hero_name());
                    },
                    get children() {
                      return libs.createComponent(EOM_Icon.EOM_Icon, {
                        className: "CasualOnlyIcon",
                        tooltip_text: "#CasualOnly"
                      });
                    }
                  })];
                }
              }), _el$8);
              libs.insert(_el$7, libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "HealthBar",
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    className: "BarValue",
                    get text() {
                      return KeyValues.UnitsKv[hero_name()]?.StatusHealth ?? '';
                    }
                  });
                }
              }), _el$8);
              libs.insert(_el$7, libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "ManaBar",
                get className() {
                  return "ManaType_" + customManaType();
                },
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    className: "BarValue",
                    get text() {
                      return KeyValues.UnitsKv[hero_name()]?.StatusMana ?? '';
                    }
                  }), libs.createComponent(GenericPanel.CLabel, {
                    className: "BarRegenValue",
                    get text() {
                      return '+' + (KeyValues.UnitsKv[hero_name()]?.ManaRegen ?? '');
                    }
                  })];
                }
              }), _el$8);
              libs.setProp(_el$9, "className", "AttributeRow");
              libs.setProp(_el$9, "tooltip_text", "#Tooltip_Attribute_Attack");
              libs.setProp(_el$0, "className", "AttributeIcon Attack");
              libs.setProp(_el$1, "className", "AttributeValue");
              libs.insert(_el$1, libs.createComponent(GenericPanel.CLabel, {
                get text() {
                  return KeyValues.UnitsKv[hero_name()]?.AttackDamage ?? '';
                }
              }));
              libs.setProp(_el$10, "className", "AttributeRow");
              libs.setProp(_el$10, "tooltip_text", "#Tooltip_Attribute_Attackspeed");
              libs.setProp(_el$11, "className", "AttributeIcon AttackSpeed");
              libs.setProp(_el$12, "className", "AttributeValue");
              libs.insert(_el$12, libs.createComponent(GenericPanel.CLabel, {
                get text() {
                  return Round(1 / Number(KeyValues.UnitsKv[hero_name()]?.AttackRate), 2) ?? '';
                }
              }));
              libs.setProp(_el$13, "className", "AttributeRow");
              libs.setProp(_el$13, "tooltip_text", "#Tooltip_Attribute_CritChance");
              libs.setProp(_el$14, "className", "AttributeIcon Crit");
              libs.setProp(_el$15, "className", "AttributeValue");
              libs.insert(_el$15, libs.createComponent(GenericPanel.CLabel, {
                get text() {
                  return KeyValues.UnitsKv[hero_name()]?.PhysicalCritChance ?? '';
                }
              }));
              libs.setProp(_el$16, "className", "AttributeRow");
              libs.setProp(_el$16, "tooltip_text", "#Tooltip_Attribute_Evasion");
              libs.setProp(_el$17, "className", "AttributeIcon Evade");
              libs.setProp(_el$18, "className", "AttributeValue");
              libs.insert(_el$18, libs.createComponent(GenericPanel.CLabel, {
                get text() {
                  return KeyValues.UnitsKv[hero_name()]?.Evasion ?? '';
                }
              }));
              libs.insert(_el$7, libs.createComponent(EOM_Separator.EOM_Separator, {
                marginLeft: "-30px"
              }), null);
              libs.insert(_el$7, libs.createComponent(EOM_Panel.EOM_Panel, {
                marginTop: "25px",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(TalentTree.TalentTree, {
                    get heroName() {
                      return hero_name();
                    },
                    showTooltip: true,
                    tooltipPosition: "bottom"
                  }), libs.createComponent(libs.Index, {
                    get each() {
                      return heroAbilityList();
                    },
                    children: (name, i) => {
                      return libs.createComponent(AbilityImage.AbilityImage, {
                        get abilityName() {
                          return name();
                        }
                      });
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return heroInterActiveAbility() != undefined;
                    },
                    get children() {
                      return libs.createComponent(InteractiveAbility.InteractiveAbility, {
                        verticalAlign: 'center',
                        get heroName() {
                          return hero_name();
                        }
                      });
                    }
                  }), libs.createComponent(ShardAbility.ShardAbility, {
                    get heroName() {
                      return hero_name();
                    },
                    playerID: -1,
                    showTooltip: true,
                    tooltipPosition: "bottom"
                  })];
                }
              }), null);
              libs.insert(_el$7, libs.createComponent(libs.Show, {
                get when() {
                  return coloringList().length > 0;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ColoringContainer",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        id: "ColoringTitle",
                        text: "#ColoringSkin"
                      }), libs.createComponent(EOM_Separator.EOM_Separator, {
                        horizontalAlign: "center",
                        size: "symmetric"
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ColoringList",
                        get children() {
                          return libs.createComponent(libs.Index, {
                            get each() {
                              return [Number(previewSkinID())].concat(coloringList());
                            },
                            children: (id, _) => {
                              const rarity = () => {
                                return KeyValues.CosmeticsKv[id().toString()]?.rarity ?? 0;
                              };
                              const mark = () => {
                                return KeyValues.CosmeticsKv[id().toString()]?.mark ?? 0;
                              };
                              const equipped = libs.createMemo(() => isEquip(id().toString()));
                              return libs.createComponent(CosmeticCard.HeroCosmeticCard, {
                                get itemid() {
                                  return id().toString();
                                },
                                hid: -1,
                                get lock() {
                                  return isLocked(id().toString());
                                },
                                get equip() {
                                  return equipped();
                                },
                                get preview() {
                                  return previewing() == id().toString();
                                },
                                get rarity() {
                                  return rarity();
                                },
                                get mark() {
                                  return mark();
                                },
                                get hasColoring() {
                                  return previewSkinID() != id().toString();
                                },
                                onactivate: () => {
                                  setPreviewing(id().toString());
                                  if (!isLocked(id().toString())) {
                                    if (!equipped()) {
                                      callAction('ornament_equip', {
                                        hid: hero_id(),
                                        oid: id(),
                                        pool: 10
                                      });
                                    }
                                  }
                                }
                              });
                            }
                          });
                        }
                      })];
                    }
                  });
                }
              }), null);
              libs.insert(_el$7, libs.createComponent(EOM_Panel.EOM_Panel, {
                verticalAlign: "bottom",
                flowChildren: "down",
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return heroContributor() != undefined;
                    },
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        id: "HeroContributor",
                        text: "#HeroContributor",
                        get dialogVariables() {
                          return {
                            name: heroContributor()
                          };
                        },
                        html: true
                      });
                    }
                  }), libs.createComponent(GenericPanel.CLabel, {
                    id: "SkinName",
                    get text() {
                      return `#${previewing()}`;
                    }
                  }), libs.createComponent(EOM_Separator.EOM_Separator, {
                    marginLeft: "-30px",
                    size: 'short'
                  }), libs.createComponent(GenericPanel.CLabel, {
                    id: "SkinAccess",
                    get text() {
                      return (() => {
                        if (finiteNumber(Number(previewing()), -1) == -1) {
                          return `#Access_default`;
                        }
                        return `#${previewing()}_description`;
                      })();
                    }
                  })];
                }
              }), null);
              return _el$7;
            })(), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "CosmeticContainer",
              get children() {
                return [(() => {
                  const _el$19 = libs.createElement("Panel", {
                    id: "CosmeticTitle"
                  }, null);
                  libs.insert(_el$19, libs.createComponent(GenericPanel.CLabel, {
                    text: "#CosmeticSlot_10"
                  }));
                  return _el$19;
                })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "CosmeticList",
                  get children() {
                    return libs.createComponent(libs.Index, {
                      get each() {
                        return previewHeroCosmeticList().cosmetic_list;
                      },
                      children: (cosmeticData, index) => {
                        const equipped = libs.createMemo(() => isEquip(cosmeticData().cosmeticID, true));
                        return libs.createComponent(CosmeticCard.HeroCosmeticCard, {
                          get className() {
                            return libs.classNames({
                              Selected: seletedSkinID() == cosmeticData().cosmeticID
                            });
                          },
                          get itemid() {
                            return cosmeticData().cosmeticID;
                          },
                          get hid() {
                            return hero_id();
                          },
                          get rarity() {
                            return cosmeticData().Rarity;
                          },
                          get equip() {
                            return equipped();
                          },
                          get lock() {
                            return isLocked(cosmeticData().cosmeticID);
                          },
                          get hasColoring() {
                            return hasColoring(cosmeticData().cosmeticID);
                          },
                          get preview() {
                            return libs.memo(() => !!!isEquip(cosmeticData().cosmeticID))() && previewSkinID() == cosmeticData().cosmeticID;
                          },
                          onactivate: () => {
                            setPreviewSkinID(cosmeticData().cosmeticID);
                            if (!equipped()) {
                              callAction('ornament_equip', {
                                hid: hero_id(),
                                oid: cosmeticData().cosmeticID != 'hero_skin_default' ? parseInt(cosmeticData().cosmeticID) : 5100000,
                                pool: 10
                              });
                            }
                          }
                        });
                      }
                    });
                  }
                })];
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "ProficiencyDetailMain",
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "ProficiencyDetailTop",
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "HeroName",
                  get text() {
                    return "#" + hero_name();
                  }
                }), libs.createComponent(EOM_Separator.EOM_Separator, {
                  horizontalAlign: 'center',
                  size: "symmetric_long"
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "ProficiencyInfo",
                  get children() {
                    return [libs.createComponent(HeroProficiencyIcon.HeroProficiencyIcon, {
                      size: "small",
                      showParticle: true,
                      get override_level() {
                        return previewHeroData()?.proficiency_level;
                      }
                    }), libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return previewHeroData()?.xp ?? 0;
                      }
                    }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                      align: "right center",
                      onactivate: self => {
                        showPopup("HeroProficiencyInfo", {});
                      },
                      get children() {
                        return libs.createComponent(EOM_Icon.EOM_Icon, {
                          id: "InfoIcon",
                          get src() {
                            return getSrcPath("proficiency_icon/s6_button_01.png");
                          },
                          width: '29px',
                          height: '29px'
                        });
                      }
                    })];
                  }
                })];
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "ProficiencyDetailCenter",
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "ProficiencyDetailMask",
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "CenterScrollContainer",
                      ref(r$) {
                        const _ref$ = proficiencyDetailScroll;
                        typeof _ref$ === "function" ? _ref$(r$) : proficiencyDetailScroll = r$;
                      },
                      scroll: "x",
                      get children() {
                        return libs.createComponent(libs.Show, {
                          get when() {
                            return proficiencyLevelList().length > 0;
                          },
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "RewardList",
                              hittest: false,
                              get children() {
                                return libs.createComponent(libs.Index, {
                                  get each() {
                                    return proficiencyLevelList();
                                  },
                                  children: (level, _) => {
                                    const rewardData = libs.createMemo(() => {
                                      if (proficiencyRewardData()?.[level() - 1] != undefined) {
                                        return proficiencyRewardData()[level() - 1];
                                      }
                                    });
                                    const isLocked = () => {
                                      return proficiency_level() < level();
                                    };
                                    const received = () => playerRewardReceivedRecord()?.[level()] ?? false;
                                    return libs.createComponent(ProficiencyLevelReward, {
                                      get locked() {
                                        return isLocked();
                                      },
                                      get received() {
                                        return received();
                                      },
                                      get level() {
                                        return level();
                                      },
                                      get reward_data() {
                                        return rewardData();
                                      },
                                      onReceive: () => {
                                        if (receiveCD) return;
                                        receiveCD = true;
                                        $.Schedule(0.2, () => {
                                          receiveCD = false;
                                        });
                                        callAction("proficiency_reward_receive", {
                                          hid: hero_id(),
                                          level: level()
                                        });
                                      }
                                    });
                                  }
                                });
                              }
                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "ProgressContainer",
                              get children() {
                                return libs.createComponent(EOM_Panel.EOM_Panel, {
                                  id: "ProgressBox",
                                  get children() {
                                    return libs.createComponent(libs.Index, {
                                      get each() {
                                        return proficiencyLevelList().slice(0, -1) ?? [];
                                      },
                                      children: (level, i) => {
                                        const current_value = () => proficiencyLevelValues()[level()] ?? 0;
                                        const last_value = () => proficiencyLevelValues()[level() - 1] ?? 0;
                                        const percentage = () => {
                                          const xp = hero_xp() - last_value();
                                          if (xp < 0 || current_value() - last_value() <= 0) {
                                            return 0;
                                          }
                                          return Clamp(xp / (current_value() - last_value()) * 100, 0, 100);
                                        };
                                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                                          className: "ProgressBar",
                                          get children() {
                                            return libs.createComponent(EOM_Panel.EOM_Panel, {
                                              id: "ProgressBarUp",
                                              get width() {
                                                return `${percentage()}%`;
                                              }
                                            });
                                          }
                                        });
                                      }
                                    });
                                  }
                                });
                              }
                            })];
                          }
                        });
                      }
                    });
                  }
                });
              }
            })];
          }
        }), libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "BackButton",
          onactivate: () => {
            if (showHeroProficiencyDetail()) {
              setShowHeroProficiencyDetail(false);
            } else {
              setShowDetail(false);
            }
          },
          get children() {
            return [libs.createElement("Image", {
              id: "BackIcon"
            }, null), libs.createComponent(GenericPanel.CLabel, {
              id: "BackLabel",
              text: "#UI_BACK"
            })];
          }
        })];
      }
    });
  };
  const ProficiencyLevelReward = props => {
    const isValidReward = () => {
      return props.reward_data?.ok == 1;
    };
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "ProficiencyLevelReward",
      hittest: false,
      get children() {
        return [libs.createComponent(libs.Show, {
          get when() {
            return props.reward_data != undefined;
          },
          get children() {
            return libs.createComponent(EOM_Button.EOM_BaseButton, {
              get enabled() {
                return libs.memo(() => !!(!props.locked && !props.received))() && isValidReward();
              },
              onactivate: () => {
                props.onReceive();
              },
              get children() {
                return [libs.createComponent(libs.Show, {
                  get when() {
                    return !isValidReward();
                  },
                  fallback: () => libs.createComponent(ProductItem.ProductItem, {
                    get itemid() {
                      return props.reward_data.item_id;
                    },
                    get count() {
                      return props.reward_data?.amounts;
                    },
                    get rarity() {
                      return props.reward_data.rarity;
                    }
                  }),
                  get children() {
                    const _el$21 = libs.createElement("Image", {}, null);
                    libs.insert(_el$21, libs.createComponent(EOM_Image.EOM_Image, {
                      className: "ProductImage Invalid",
                      tooltip_text: "#comingSoon"
                    }));
                    libs.effect(_$p => libs.setProp(_el$21, "className", libs.classNames("ProductItem", "Rarity" + props.reward_data.rarity), _$p));
                    return _el$21;
                  }
                }), libs.createElement("Image", {
                  id: "Hover"
                }, null), libs.createComponent(libs.Switch, {
                  get children() {
                    return [libs.createComponent(libs.Match, {
                      get when() {
                        return libs.memo(() => !!(!props.received && !props.locked))() && isValidReward();
                      },
                      get children() {
                        return libs.createComponent(EOM_Icon.EOM_Icon, {
                          get className() {
                            return libs.classNames("ProficiencyRewardIcon", {
                              Show: true
                            });
                          },
                          size: "64",
                          get src() {
                            return getSrcPath("icon/s6_reward_icon.png");
                          },
                          hittest: false
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return props.received;
                      },
                      get children() {
                        return libs.createElement("Image", {
                          id: "Receive",
                          hittest: false
                        }, null);
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return props.locked || !isValidReward();
                      },
                      get children() {
                        return libs.createElement("Image", {
                          id: "PlusLock",
                          hittest: false
                        }, null);
                      }
                    })];
                  }
                })];
              }
            });
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "ProficiencyIconContainer",
          hittest: false,
          get children() {
            return libs.createComponent(HeroProficiencyIcon.HeroProficiencyIcon, {
              get override_level() {
                return props.level;
              },
              hittest: false
            });
          }
        }), libs.createComponent(GenericPanel.CLabel, {
          id: "NeededValue",
          get text() {
            return proficiencyLevelValues()[props.level - 1] ?? "0";
          },
          hittest: false
        })];
      }
    });
  };
  const HeroCollection = props => {
    const [collectionMaxCount, setCollectionMaxCount] = libs.createSignal(CustomNetTables.GetTableValue("common", "constant")?.HERO_COLLECTION_COUNT ?? 0);
    const [selectedSect, setSelectedSect] = libs.createSignal(KeyValues.SECT_LIST?.[0] ?? "");
    const [myHeroCollection, setMyHeroCollection] = libs.createStore((() => {
      let data = {};
      KeyValues.SECT_LIST.forEach(sectName => {
        data[sectName] = [];
      });
      return data;
    })());
    const unlocked_list = () => {
      let list = Object.keys(props.unlocked_data);
      const current_selectedSect = selectedSect();
      list = list.filter(v => {
        const heroName = GetHeroNameByGoodID(props.unlocked_data[v].hid);
        if (heroName != undefined) {
          return current_selectedSect == '' || (KeyValues.UnitsCommonKv[heroName].Sect ?? '').includes(current_selectedSect);
        }
        return false;
      });
      list.sort((a, b) => (props.hero_medal_count?.[props.unlocked_data[b].hid.toString()] ?? 0) - (props.hero_medal_count?.[props.unlocked_data[a].hid.toString()] ?? 0));
      return list;
    };
    const [playerHeroSkins, setPlayerHeroSkins] = libs.createSignal({});
    libs.onMount(() => {
      const gameEventListeners = [];
      const NetTableListeners = [];
      NetTableListeners.push(useServiceNetTable("player_hero_collection", data => {
        for (const sect in data) {
          const v = data[sect];
          if (myHeroCollection[sect].length != v.hero.length || myHeroCollection[sect].some(_ => !v.hero.includes(_.hid))) {
            const info = v.hero.map(id => {
              return {
                hid: id,
                hero_name: GetHeroNameByGoodID(id) ?? ""
              };
            });
            setMyHeroCollection(sect, info);
          }
        }
      }, Players.GetLocalPlayer()));
      NetTableListeners.push(useNetTableKey("common", "constant", data => {
        setCollectionMaxCount(data.HERO_COLLECTION_COUNT);
      }));
      NetTableListeners.push(useServiceNetTable("player_equipped_ornament", data => {
        let list = {};
        if (data?.[OrnamentType.HERO_SKIN] != undefined) {
          for (const oid in data[OrnamentType.HERO_SKIN]) {
            if (KeyValues.CosmeticsKv[oid] != undefined && typeof KeyValues.CosmeticsKv[oid].hero == "number") {
              list[KeyValues.CosmeticsKv[oid].hero.toString()] = oid;
            }
          }
        }
        setPlayerHeroSkins(list);
      }, Players.GetLocalPlayer()));
      libs.onCleanup(() => {
        gameEventListeners.forEach(id => GameEvents.Unsubscribe(id));
        NetTableListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      });
    });
    const getHeroCollectedSect = hid => {
      for (const sectName in myHeroCollection) {
        const info = myHeroCollection[sectName];
        if (info.some(v => v.hid == hid)) return sectName;
      }
    };
    const cd = 0.5;
    let cooldowning = false;
    const onHeroCollect = ({
      sect,
      hid,
      equip = true
    }) => {
      if (cooldowning) return;
      if (equip) {
        if (myHeroCollection[sect].length >= collectionMaxCount()) return;
        if (myHeroCollection[sect].some(v => v.hid == hid)) return;
        if (Object.values(myHeroCollection).some(v => v.some(_ => _.hid == hid))) {
          ErrorMessage("#other_sect_collected");
          return;
        }
        cooldowning = true;
        $.Schedule(cd, () => cooldowning = false);
        let newList = myHeroCollection[sect].map(v => v.hid).concat();
        newList.push(hid);
        if (newList.length > collectionMaxCount()) {
          newList.splice(0, 1);
        }
        GameEvents.SendCustomEventToServer("player_collect_hero", {
          sect,
          hero: newList
        });
      } else if (myHeroCollection[sect].some(v => v.hid == hid)) {
        cooldowning = true;
        $.Schedule(cd, () => cooldowning = false);
        let newList = myHeroCollection[sect].map(v => v.hid).concat();
        newList = newList.filter(v => v != hid);
        GameEvents.SendCustomEventToServer("player_collect_hero", {
          sect,
          hero: newList
        });
      }
    };
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("HeroCollection", {
          Show: heroCollectionShow()
        });
      },
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "HeroCollectionMain",
          onactivate: () => {},
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "RightContainer",
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "CollectionTitle",
                  get children() {
                    return [libs.createComponent(GenericPanel.CLabel, {
                      id: "CollectionTitleLabel",
                      text: "#HeroCollection"
                    }), libs.createComponent(EOM_Button.EOM_CloseButton, {
                      onactivate: () => {
                        setHeroCollectionShow(false);
                      }
                    })];
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "HeroList",
                  scroll: "y",
                  get children() {
                    return libs.createComponent(libs.Index, {
                      get each() {
                        return unlocked_list();
                      },
                      children: (heroName, index) => {
                        const hero_data = () => props.unlocked_data[heroName()];
                        const collectedSect = () => getHeroCollectedSect(hero_data().hid);
                        const proficiency_level = () => props.hero_medal_level?.[hero_data().hid.toString()] ?? 0;
                        return libs.createComponent(EOM_Button.EOM_BaseButton, {
                          get className() {
                            return libs.classNames('HeroCardButton', {
                              Show: true,
                              OtherCollected: collectedSect() != undefined && collectedSect() != selectedSect()
                            });
                          },
                          onactivate: () => {
                            onHeroCollect({
                              sect: selectedSect(),
                              hid: hero_data().hid
                            });
                          },
                          get children() {
                            return libs.createComponent(HeroRoleCard.HeroRoleCard, {
                              get heroName() {
                                return heroName();
                              },
                              get collected() {
                                return collectedSect() != undefined;
                              },
                              get children() {
                                return libs.createComponent(libs.Show, {
                                  get when() {
                                    return hero_data().CanExperience != 1;
                                  },
                                  get children() {
                                    return libs.createComponent(HeroProficiencyIcon.HeroProficiencyIcon, {
                                      size: "small",
                                      get override_level() {
                                        return proficiency_level();
                                      }
                                    });
                                  }
                                });
                              }
                            });
                          }
                        });
                      }
                    });
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "SectTagList",
                  get children() {
                    return libs.createComponent(libs.Index, {
                      get each() {
                        return KeyValues.SECT_LIST;
                      },
                      children: (sectName, index) => {
                        const isSectCollected = () => myHeroCollection[sectName()].length >= collectionMaxCount();
                        return libs.createComponent(EOM_Button.EOM_BaseButton, {
                          get className() {
                            return libs.classNames("SectTagButton", {
                              Selected: sectName() == selectedSect()
                            });
                          },
                          enabled: true,
                          onactivate: () => setSelectedSect(sectName()),
                          get children() {
                            return [libs.createComponent(SectIcon.SectIcon, {
                              get sectName() {
                                return sectName();
                              },
                              get active() {
                                return isSectCollected();
                              }
                            }), libs.createComponent(libs.Show, {
                              get when() {
                                return !isSectCollected();
                              },
                              get children() {
                                return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                                  type: "default"
                                });
                              }
                            })];
                          }
                        });
                      }
                    });
                  }
                })];
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "LeftContainer",
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "HeroCollectionEquip",
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("CollectionEquipButton");
                      },
                      onactivate: () => {},
                      get children() {
                        return libs.createComponent(libs.Show, {
                          get when() {
                            return myHeroCollection[selectedSect()]?.[0] != undefined;
                          },
                          fallback: () => libs.createComponent(EOM_Image.EOM_Image, {
                            id: "AddIcon"
                          }),
                          get children() {
                            return [libs.createComponent(Heroes.HeroImage, {
                              get hero_name() {
                                return myHeroCollection[selectedSect()]?.[0].hero_name;
                              },
                              get oid() {
                                return libs.memo(() => !!isFinite(Number(playerHeroSkins()[myHeroCollection[selectedSect()]?.[0].hid])))() ? Number(playerHeroSkins()[myHeroCollection[selectedSect()]?.[0].hid]) : undefined;
                              }
                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "CloseButtonContainer",
                              get children() {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  id: "CloseButton",
                                  onactivate: () => {
                                    onHeroCollect({
                                      sect: selectedSect(),
                                      hid: myHeroCollection[selectedSect()]?.[0].hid,
                                      equip: false
                                    });
                                  },
                                  get children() {
                                    return libs.createComponent(EOM_Image.EOM_Image, {
                                      width: "100%",
                                      height: "100%",
                                      backgroundSize: "100%",
                                      get src() {
                                        return getSrcPath("hero_collection/s5_close.png");
                                      }
                                    });
                                  }
                                });
                              }
                            })];
                          }
                        });
                      }
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("CollectionEquipButton");
                      },
                      onactivate: () => {},
                      get children() {
                        return libs.createComponent(libs.Show, {
                          get when() {
                            return myHeroCollection[selectedSect()]?.[1] != undefined;
                          },
                          fallback: () => libs.createComponent(EOM_Image.EOM_Image, {
                            id: "AddIcon"
                          }),
                          get children() {
                            return [libs.createComponent(Heroes.HeroImage, {
                              get hero_name() {
                                return myHeroCollection[selectedSect()]?.[1].hero_name;
                              },
                              get oid() {
                                return libs.memo(() => !!isFinite(Number(playerHeroSkins()[myHeroCollection[selectedSect()]?.[1].hid])))() ? Number(playerHeroSkins()[myHeroCollection[selectedSect()]?.[1].hid]) : undefined;
                              }
                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "CloseButtonContainer",
                              get children() {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  id: "CloseButton",
                                  onactivate: () => {
                                    onHeroCollect({
                                      sect: selectedSect(),
                                      hid: myHeroCollection[selectedSect()]?.[1].hid,
                                      equip: false
                                    });
                                  },
                                  get children() {
                                    return libs.createComponent(EOM_Image.EOM_Image, {
                                      width: "100%",
                                      height: "100%",
                                      backgroundSize: "100%",
                                      get src() {
                                        return getSrcPath("hero_collection/s5_close.png");
                                      }
                                    });
                                  }
                                });
                              }
                            })];
                          }
                        });
                      }
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("CollectionEquipInfo", {
                          Active: myHeroCollection[selectedSect()].length >= collectionMaxCount()
                        });
                      },
                      get children() {
                        return [libs.createComponent(SectIcon.SectIcon, {
                          get sectName() {
                            return selectedSect();
                          },
                          get active() {
                            return myHeroCollection[selectedSect()].length >= collectionMaxCount();
                          }
                        }), libs.createComponent(GenericPanel.CLabel, {
                          text: "#sect_collected"
                        })];
                      }
                    })];
                  }
                }), libs.createComponent(InfoButton.InfoButton, {
                  info: "#hero_collection_info",
                  tooltip: "#hero_collection_desc"
                }), libs.createComponent(libs.Show, {
                  get when() {
                    return myHeroCollection[selectedSect()]?.[0] != undefined;
                  },
                  get children() {
                    return libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
                      id: "Hero1",
                      showPedestal: false,
                      allowrotation: false,
                      get unitname() {
                        return playerHeroSkins()[myHeroCollection[selectedSect()]?.[0].hid] ?? myHeroCollection[selectedSect()]?.[0].hero_name;
                      },
                      hittest: false
                    });
                  }
                }), libs.createComponent(libs.Show, {
                  get when() {
                    return myHeroCollection[selectedSect()]?.[1] != undefined;
                  },
                  get children() {
                    return libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
                      id: "Hero2",
                      showPedestal: false,
                      allowrotation: false,
                      get unitname() {
                        return playerHeroSkins()[myHeroCollection[selectedSect()]?.[1].hid] ?? myHeroCollection[selectedSect()]?.[1].hero_name;
                      },
                      hittest: false
                    });
                  }
                })];
              }
            })];
          }
        });
      }
    });
  };
  libs.render(() => libs.createComponent(Hero, {}), $.GetContextPanel());
}
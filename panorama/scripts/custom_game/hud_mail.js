--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CosmeticCard = require('./CosmeticCard.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var GenericPanel = require('./GenericPanel.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var ProductItem = require('./ProductItem.js');
var red_point_utils = require('./red_point_utils.js');
require('./EOM_Label.js');
require('./EOM_Icon.js');
require('./ProductImage.js');

if (!isSpectator()) {
  const language = $.Language().toLowerCase();
  const getTitle = mailData => {
    if (mailData == undefined) {
      return "";
    }
    const mapData = {
      ["schinese"]: mailData.title,
      ["english"]: mailData.title_en,
      ["russian"]: mailData.title_ru
    };
    return mapData[language] ?? mailData.title_en;
  };
  const getSubTitle = mailData => {
    if (mailData == undefined) {
      return "";
    }
    const mapData = {
      ["schinese"]: mailData.sub_title,
      ["english"]: mailData.sub_title_en,
      ["russian"]: mailData.sub_title_ru
    };
    return mapData[language] ?? mailData.sub_title_en;
  };
  const getContent = mailData => {
    if (mailData == undefined) {
      return "";
    }
    const mapData = {
      ["schinese"]: mailData.content,
      ["english"]: mailData.content_en,
      ["russian"]: mailData.content_ru
    };
    return mapData[language] ?? mailData.content_en;
  };
  const mailOperate = (mid, step, mtype) => {
    callAction("mail_operate", {
      mid,
      step,
      mtype
    });
  };
  const mailOperateAll = step => {
    callAction("mail_operate_all", {
      step
    });
    if (step == 9) {
      setMailPreviewMid(undefined);
    }
  };
  const [mailPreviewMid, setMailPreviewMid] = libs.createSignal();
  const Mail = () => {
    const [show, setShow] = libs.createSignal(false);
    const [category, setCategory] = libs.createStore({
      "mail_all": []
    });
    const [mailList, setMailList] = libs.createSignal([]);
    const [filter, setFilter] = libs.createSignal("mail_all");
    const [redPoints, setRedPoints] = libs.createSignal(getClientGlobalData("red_points") ?? []);
    libs.createEffect(() => {
      if (show()) {
        callAction("mail_list", {});
      }
    });
    const mailPreview = libs.createMemo(() => {
      return mailList().find(mailData => mailData.mid == mailPreviewMid());
    });
    libs.onMount(() => {
      const eventId = useToggleWindow("MenuButton_mail", show, setShow);
      libs.onCleanup(() => GameEvents.Unsubscribe(eventId));
    });
    EOM_MenuLayout.useEOM_MenuLayoutData(show, () => {
      let gameEventIDList = [];
      gameEventIDList.push(useNetData("player_mails", data => {
        const nameList = {};
        for (const mid in data) {
          const mailData = data[mid];
          if (nameList[mailData.category] == undefined) {
            nameList[mailData.category] = [];
          }
          data[mid].mtype = data[mid].mtype ?? 0;
        }
        setCategory(nameList);
        const nextMailList = Object.values(data).sort((a, b) => multiCompare(a.step - b.step, b.mid - a.mid));
        setMailList(nextMailList);
        setMailPreviewMid(currentMid => {
          return nextMailList.some(mailData => mailData.mid == currentMid) ? currentMid : nextMailList[0]?.mid;
        });
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useClientGlobalData("red_points", setRedPoints));
      return () => {
        for (const id of gameEventIDList) {
          GameEvents.Unsubscribe(id);
        }
      };
    });
    return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
      get show() {
        return show();
      },
      renderOnShow: true,
      name: "MenuButton_mail",
      get children() {
        return [libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Menu, {
          menuName: "mail",
          menuList: category,
          onToggleMenu: (menu, menu2) => {
            setFilter(menu);
          }
        }), libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              flowChildren: "right",
              width: "100%",
              height: "100%",
              marginBottom: "100px",
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "MailBox MailList",
                  scroll: "y",
                  get children() {
                    return libs.createComponent(libs.For, {
                      get each() {
                        return mailList();
                      },
                      children: mailData => libs.createComponent(libs.Show, {
                        get when() {
                          return filter() == "mail_all" || filter() == mailData.category;
                        },
                        get children() {
                          return libs.createComponent(MailRow, {
                            mailData: mailData,
                            get hasRedPoint() {
                              return red_point_utils.hasRedPoint(redPoints(), "mail", mailData.category, mailData.mid);
                            },
                            callback: () => {
                              setMailPreviewMid(mailData.mid);
                            }
                          });
                        }
                      })
                    });
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "MailBox MailContent",
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      scroll: "y",
                      width: "100%",
                      height: "fit-children",
                      get children() {
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "down",
                          height: "fit-children",
                          width: "100%",
                          get children() {
                            return libs.createComponent(libs.Show, {
                              get when() {
                                return mailPreview() != undefined;
                              },
                              get children() {
                                return [libs.createComponent(GenericPanel.CLabel, {
                                  hittest: false,
                                  html: true,
                                  className: "ContentTitle",
                                  get text() {
                                    return getTitle(mailPreview());
                                  }
                                }), libs.createComponent(GenericPanel.CLabel, {
                                  hittest: false,
                                  html: true,
                                  className: "ContentLabel",
                                  get text() {
                                    return getContent(mailPreview());
                                  }
                                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                  horizontalAlign: "center",
                                  flowChildren: "right-wrap",
                                  hittest: false,
                                  get children() {
                                    return libs.createComponent(libs.Index, {
                                      get each() {
                                        return Object.keys(JSON.parse(mailPreview()?.items ?? "{}"));
                                      },
                                      children: (item, index) => {
                                        const rarity = () => {
                                          if (KeyValues.CosmeticsKv[item()]) {
                                            return KeyValues.CosmeticsKv[item()].rarity;
                                          } else if (KeyValues.BackpackKv[item()]) {
                                            return KeyValues.BackpackKv[item()].quality ?? 2;
                                          }
                                          return 2;
                                        };
                                        return libs.createComponent(ProductItem.ProductItem, {
                                          get itemid() {
                                            return item();
                                          },
                                          get count() {
                                            return JSON.parse(mailPreview()?.items ?? "{}")[item()];
                                          },
                                          get rarity() {
                                            return rarity();
                                          },
                                          get children() {
                                            return libs.createComponent(CosmeticCard.CosmeticImage, {
                                              get itemid() {
                                                return item();
                                              },
                                              align: "center center",
                                              hittest: false
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
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              width: "100%",
              verticalAlign: "bottom",
              flowChildren: "right",
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "ButtonBox",
                  get children() {
                    return [libs.createComponent(EOM_Button.EOM_Button, {
                      text: "#mail_action_receive_all",
                      color: "Blue",
                      onactivate: () => mailOperateAll(2)
                    }), libs.createComponent(EOM_Button.EOM_Button, {
                      text: "#mail_action_remove_all",
                      color: "Red",
                      onactivate: () => mailOperateAll(9)
                    })];
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "ButtonBox",
                  get children() {
                    return [libs.createComponent(EOM_Button.EOM_Button, {
                      text: "#mail_action_receive",
                      color: "Blue",
                      get enabled() {
                        return libs.memo(() => (mailPreview()?.step ?? 0) < 2)() && (mailPreview()?.items ?? "{}") != "{}";
                      },
                      onactivate: () => {
                        const mid = mailPreview()?.mid;
                        const mtype = mailPreview()?.mtype;
                        if (mid && mtype != undefined) {
                          mailOperate(mid, 2, mtype);
                        }
                      }
                    }), libs.createComponent(EOM_Button.EOM_Button, {
                      text: "#mail_delete",
                      color: "Red",
                      get enabled() {
                        return (mailPreview()?.step ?? 0) == 2;
                      },
                      onactivate: () => {
                        const mid = mailPreview()?.mid;
                        const mtype = mailPreview()?.mtype;
                        if (mid && mtype != undefined) {
                          mailOperate(mid, 9, mtype);
                        }
                      }
                    })];
                  }
                })];
              }
            })];
          }
        })];
      }
    });
  };
  const MailRow = props => {
    return (() => {
      const _el$ = libs.createElement("RadioButton", {
          group: "MailRow",
          get selected() {
            return mailPreviewMid() == props.mailData.mid;
          }
        }, null),
        _el$2 = libs.createElement("Image", {}, _el$);
      libs.setProp(_el$, "className", "MailRow");
      libs.setProp(_el$, "onactivate", self => {
        if (props.mailData.items && props.mailData.items != "{}") {
          if (props.mailData.step == 0) {
            mailOperate(props.mailData.mid, 1, props.mailData.mtype);
          }
        } else {
          if (props.mailData.step <= 1) {
            mailOperate(props.mailData.mid, 2, props.mailData.mtype);
          }
        }
        props.callback();
      });
      libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
        className: "MailTitle",
        get text() {
          return getSubTitle(props.mailData);
        }
      }), null);
      libs.insert(_el$, libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
        type: "default",
        hittest: false,
        get visible() {
          return props.hasRedPoint;
        }
      }), null);
      libs.insert(_el$, libs.createComponent(libs.Show, {
        get when() {
          return props.mailData.step == 2;
        },
        get children() {
          const _el$3 = libs.createElement("Image", {}, null);
          libs.setProp(_el$3, "className", "MailReadIcon");
          return _el$3;
        }
      }), null);
      libs.insert(_el$, libs.createComponent(EOM_Countdown.EOM_Countdown, {
        className: "MailTimeout",
        get endTime() {
          return props.mailData.end_time;
        },
        text: "#mail_timeout"
      }), null);
      libs.effect(_p$ => {
        const _v$ = mailPreviewMid() == props.mailData.mid,
          _v$2 = libs.classNames("MailIcon", props.mailData.category, {
            Open: props.mailData.step > 1
          });
        _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "selected", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$2, "className", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  };
  libs.render(() => libs.createComponent(Mail, {}), $.GetContextPanel());
}
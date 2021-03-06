require "UI/Common/UIHelper"
require "UI/Common/UIManager"
require "UI/Common/UIWidgetPool"
require "UI/Common/UIComponent"
require("UI/Common/Message")

--管理器--
Game = {}
local this = Game

local game
local transform
local gameObject

Ctrls = {}

--初始化完成
function Game.OnInitOK()
    print('Cat:Game.lua[Game.OnInitOK()]')
    Game.InitUI()
    Game.InitControllers()

end

function Game.InitUI()
    local msg_panel = CS.UnityEngine.GameObject.Find("UICanvas/Dynamic/MessagePanel")
    assert(msg_panel, "cannot fine message panel!")
    Message:Init(msg_panel.transform)

    UIMgr:Init({"UICanvas/Normal","UICanvas/MainUI", "UICanvas/Dynamic"}, "Normal")
    --增加默认的UI组件
    UIMgr:AddBeforeShowFunc(function ( view )
        if view.UIConfig.canvas_name == "Normal" then
        end
    end)
    local pre_load_prefab = {
        "Assets/AssetBundleRes/ui/prefab/common/Background.prefab",
    }
    UIWidgetPool:Init("UICanvas/HideUI")
    UIWidgetPool:RegisterWidgets(pre_load_prefab, call_back)
end

function Game.InitControllers()
    local ctrl_paths = {
        -- "UI/Error/ErrorController", 
        "UI/Test/TestController",
        "UI/Login/LoginController", 
    }
    for i,v in ipairs(ctrl_paths) do
        local ctrl = require(v)
        if type(ctrl) ~= "boolean" then
            --调用每个Controller的Init函数
            ctrl:Init()
            table.insert(Ctrls, ctrl)
        else
            --Controller类忘记了在最后return
            assert(false, 'Cat:Main.lua error : you must forgot write a return in you controller file :'..v)
        end
    end
end

--销毁--
function Game.OnDestroy()
end

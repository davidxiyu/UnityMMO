﻿using UnityEngine;
using System.Collections;
using XLua;

namespace XLuaFramework {

    /// <summary>
    /// </summary>
    public class Main : MonoBehaviour {
        public bool IsNeedPrintConcole = true;
        void Start() {
            Debug.Log("Main:Start()");

            AppConfig.Init();

            GameObject.DontDestroyOnLoad(this.gameObject);

            if (IsNeedPrintConcole)
            {
                if (Application.platform == RuntimePlatform.WindowsEditor || Application.platform == RuntimePlatform.WindowsPlayer || Application.platform == RuntimePlatform.Android)
                    this.gameObject.AddComponent<LogHandler>();
            }

            this.gameObject.AddComponent<ResourceManager>();
            this.gameObject.AddComponent<NetworkManager>();
            this.gameObject.AddComponent<XLuaManager>();
        }
    }
}
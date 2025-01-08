
local messages = {
    -- Status messages

    Ok = {
        Ok = {
            Id = 1
        }
    },

    Error = {
        Error = {
            Id = 0,
            ErrorMessage = "",
            ErrorCode = 0
        }
    },

    -- Handshake messages

    RequestServerInfo = {
        RequestServerInfo = {
            Id = 1,
            ClientName = "",
            MessageVersion = 1
        }
    },

    ServerInfo = {
        ServerInfo = {
            Id = 1,
            ServerName = "",
            MessageVersion = 1,
            MaxPingTime = 0
        }
    },

    -- Enumeration messages

    RequestDeviceList = {
        RequestDeviceList = {
            Id = 1
        }
    },

    DeviceList = {
        DeviceList = {
            Id = 1,
            Devices = {}
        }
    },

    StartScanning = {
        StartScanning = {
            Id = 1
        }
    },

    StopScanning = {
        StopScanning = {
            Id = 1
        }
    },

    ScanningFinished = {
        ScanningFinished = {
            Id = 0
        }
    },

    DeviceAdded = {
        DeviceAdded = {
            Id = 0,
            DeviceName = "",
            DeviceIndex = 0,
            DeviceMessages = {}
        }
    },

    DeviceRemoved = {
        DeviceRemoved = {
            Id = 0,
            DeviceIndex = 0
        }
    },

    -- Generic device messages

    StopDeviceCmd = {
        StopDeviceCmd = {
            Id = 1,
            DeviceIndex = 0
        }
    },

    StopAllDevices = {
        StopAllDevices = {
            Id = 1
        }
    },

    VibrateCmd = {
        VibrateCmd = {
            Id = 1,
            DeviceIndex = 0,
            Speeds = {}
        }
    }
}

--
-- Client
--

local buttplug = {
    msg_counter = 1,
    devices = {},
    print = print, -- User can override this w/ game print function
    -- Callbacks to run when receiving messages from the server
    cb = {
        Ok = {},
        Error = {},
        ServerInfo = {},
        DeviceList = {},
        DeviceAdded = {},
        DeviceRemoved = {},
        ScanningFinished = {}
    }
}

local HttpService = game:GetService("HttpService")

local function run_callbacks(message_type)
    for k, f in pairs(buttplug.cb[message_type]) do
        f()
    end
end

local function message_type(msg)
    return next(msg)
end

local function send(msg)
    local message_type = message_type(msg)

    msg[message_type].Id = buttplug.msg_counter -- set counter
    buttplug.msg_counter += 1                   -- increment counter

    local payload = `[{HttpService:JSONEncode(msg)}]`
    buttplug.print(`sent > {payload}`)
    return buttplug.sock:Send(payload)
end

local function ConnectWebSocket(url)
    local success, socket = pcall(function()
        return WebSocket.connect(url)
    end)

    if not success then
        error(`error connecting to websocket {url}`)
    end

    return socket
end
function buttplug.request_server_info(client_name)
    local msg = messages.RequestServerInfo

    msg["RequestServerInfo"]["ClientName"] = client_name

    return send(msg)
end

function buttplug.request_device_list()
    return send(messages.RequestDeviceList)
end

function buttplug.start_scanning()
    return send(messages.StartScanning)
end

function buttplug.stop_scanning() 
    return send(messages.StopScanning)
end

function buttplug.send_vibrate_cmd(dev_index, speeds)
    local msg = messages.VibrateCmd

    msg["VibrateCmd"]["DeviceIndex"] = dev_index

    for i,v in ipairs(speeds) do
        msg["VibrateCmd"]["Speeds"][i] = {Index = i - 1, Speed = v}
    end

    return send(msg)
end

function buttplug.send_stop_device_cmd(dev_index)
    local msg = messages.StopDeviceCmd

    msg["StopDeviceCmd"]["DeviceIndex"] = dev_index

    return send(msg)
end

function buttplug.send_stop_all_devices_cmd()
    return send(messages.StopAllDevices)
end

function buttplug.count_devices()
    return #buttplug.devices
end

function buttplug.add_device(dev)
    local dev_count = #buttplug.devices

    buttplug.devices[dev_count+1] = {
        index = dev["DeviceIndex"],
        name = dev["DeviceName"],
        messages = dev["DeviceMessages"]
    }
end

function buttplug.remove_device(dev_index)
    for i, v in ipairs(buttplug.devices) do
        if v.index == dev_index then
            table.remove(buttplug.devices, i) 
        end
    end
end

function buttplug.handle_message(raw_message)
    local msg = HttpService:JSONDecode(raw_message)[1]
    local msg_type = message_type(msg)
    local msg_contents = msg[msg_type]

    -- if DeviceList, add any devices
    if msg_type == "DeviceList" then
        local devices = msg_contents["Devices"]

        for i,v in ipairs(devices) do
            buttplug.add_device(v)
        end
    end

    -- if DeviceAdded, add the device
    if (msg_type == "DeviceAdded") then
        buttplug.add_device(msg_contents)
    end

    -- if DeviceRemoved, remove the device
    if (msg_type == "DeviceRemoved") then
        buttplug.remove_device(msg_contents["DeviceIndex"])
    end

    run_callbacks(msg_type)
end

function buttplug.connect(client_name, ws_addr) 
    buttplug.client_name = client_name
    buttplug.sock = ConnectWebSocket(ws_addr)
    buttplug.request_server_info(buttplug.client_name)
end

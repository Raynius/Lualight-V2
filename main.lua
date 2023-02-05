local Lualight = {}
local Lualight.Spoofs = {}
function Lualight.Spoofs.SpoofValue(ValueName, ReturnValue)
  local mt = getrawmetatable(game)
  setreadonly(mt, false)
  local old_index = mt.__index   
  mt.__index = function(a,b)
      if tostring(a) == ValueName then
           if tostring(b) == "Value" then
              return ReturnValue
          end
      end
      return old_index(a,b)
  end
end

local Lualight.Chassis = {}
local Chassis = Lualight.Chassis
function Chassis.Teleport(VehiclePath,VehiclePrimPart,TpPosition)
  VehiclePath.PrimaryPart = VehiclePath[VehiclePrimPart]
  VehiclePath:SetPrimaryPartCFrame(TpPosition)
end
function Chassis.ModifySpeed(VehiclePath, VehiclePrimPart, Speed)
  VehiclePath.PrimaryPart = VehiclePath[VehiclePrimPart]
  VehiclePath[VehiclePrimPart].BaseVelocity = Vector3.new(Speed, 0, 0)
end
function Chassis.Rotate(VehiclePath, VehiclePrimPart, Angle)
  VehiclePath.PrimaryPart = VehiclePath[VehiclePrimPart]
  local primaryPart = VehiclePath[VehiclePrimPart]:GetPrimaryPartCFrame()
  local rotation = CFrame.Angles(0,math.rad(Angle),0)
  local goal = primaryPart*rotation
  VehiclePath[VehiclePrimPart]:SetPrimaryPartCFrame(goal)
end

local Lualight.WebClient = {}
local wc = Lualight.WebClient
function wc.GetInfo(URL)
  URL = loadstring(game:HttpGet(URL))()
    for __,v in ipairs(URL) do
      return URL
    end
end

local Lualight.Audio = {}
local audio = Lualight.Audio
local SoundService = game:GetService("SoundService")
local currentTrack
function audio.AddAudio(val)
  if type(val) == "number" then
    currentTrack = val
    currentTrack.Parent = SoundService
    currentTrack:Play()
  else
    error("Number expected, got " .. type(val))
  end
end
function audio.Pause()
  if currentTrack then
    currentTrack:Pause()
  else
    error("No audio added. Please use Audio.AddAudio(assetId).")
  end
end
function audio.Resume()
  if currentTrack then
    currentTrack:Play()
  else
    error("No audio added. Please use Audio.AddAudio(assetId).")
  end
end
function audio.ChangeTrack(val)
  if type(val) == "number" then
    if currentTrack then
        currentTrack:Stop()
        currentTrack = val
        currentTrack.Parent = SoundService
        currentTrack:Play()
    else
        error("No audio added. Please use Audio.AddAudio(assetId).")
    end
  else
    error("Number expected, got " .. type(val))
  end
end

function audio.Stop()
  if currentTrack then
    currentTrack:Stop()
  end
end

function audio.looped(val)
  if type(val) == "number" then
    if currentTrack then
        currentTrack.Looped = val
    else
        Err("No audio added Please use Audio.AddAudio(assetId).")
    end
  else
    error("Number expected, got " .. type(val))
  end

  
end

function audio.Volume(val)
  if currentTrack then
    currentTrack.Volume = val
  else
    error("No audio added Please use Audio.AddAudio(assetId).")
  end
end


return Lualight

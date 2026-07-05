-- Xóa Menu cũ nếu có để tránh bị trùng lặp màn hình
if game.CoreGui:FindFirstChild("SpeedGlitchMenu") then
    game.CoreGui.SpeedGlitchMenu:Destroy()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local isGlitching = false
local speedMultiplier = 1.3 -- Bạn có thể chỉnh lên 1.5 hoặc 1.8 nếu muốn nhanh hơn

-- --- TẠO MENU GUI TRỰC TIẾP TRÊN MÀN HÌNH ---
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")

ScreenGui.Name = "SpeedGlitchMenu"
ScreenGui.Parent = game.CoreGui -- Đưa vào CoreGui để không bị mất khi chết (Reset)
ScreenGui.ResetOnSpawn = false

-- Thân Menu
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0) -- Nằm ở góc bên trái màn hình
MainFrame.Size = UDim2.new(0, 150, 0, 60)
MainFrame.Active = true
MainFrame.Draggable = true -- Bạn có thể lấy chuột kéo menu này đi chỗ khác tùy ý

UICorner.Parent = MainFrame

-- Nút Bật/Tắt
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Màu đỏ lúc tắt
ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleButton.Size = UDim2.new(0, 135, 0, 40)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "SPEED: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16

UICorner2.Parent = ToggleButton

-- --- LOGIC XỬ LÝ GLITCH & CAMERA ---
RunService.Heartbeat:Connect(function()
    if isGlitching and localPlayer.Character then
        local hrp = localPlayer.Character:FindFirstChild("HumanoidRootPart")
        local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        
        if hrp and humanoid and humanoid.MoveDirection.Magnitude > 0 then
            local lookVector = camera.CFrame.LookVector
            local moveVector = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
            
            -- Ép di chuyển chuẩn theo hướng nhìn của người chơi (Fix lệch góc)
            if humanoid.MoveDirection.Z > 0 then -- Đi lùi
                hrp.CFrame = hrp.CFrame + (-moveVector * speedMultiplier)
            elseif humanoid.MoveDirection.Z < 0 then -- Đi tiến
                hrp.CFrame = hrp.CFrame + (moveVector * speedMultiplier)
            else
                hrp.CFrame = hrp.CFrame + (humanoid.MoveDirection * speedMultiplier)
            end
        end
    end
end)

-- Sự kiện Click chuột vào Menu để Bật/Tắt
ToggleButton.MouseButton1Click:Connect(function()
    isGlitching = not isGlitching
    if isGlitching then
        ToggleButton.Text = "SPEED: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50) -- Đổi sang màu xanh lá
        camera.CameraType = Enum.CameraType.Follow -- Fix giật lắc camera
    else
        ToggleButton.Text = "SPEED: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Về màu đỏ
        camera.CameraType = Enum.CameraType.Custom
    end
end)

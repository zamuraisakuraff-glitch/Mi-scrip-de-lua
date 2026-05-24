-- Auto Shot + Aim Assist para Murderers VS Sheriffs Duels
-- Funciona en equipos (todos disparan)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local ENABLED = true
local AIMBOT = true
local FOV = 150
local SMOOTHNESS = 0.12
local TEAM_CHECK = true  -- Evita disparar a tus compañeros

local target = nil

-- Obtener enemigos (diferente equipo)
local function getEnemy()
    local myTeam = LocalPlayer.Team
    for _, player in ipairs(Players:GetPlayers()) do
        if player \~= LocalPlayer and player.Team \~= myTeam and player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Head")
            if root then
                return player.Character
            end
        end
    end
    return nil
end

RunService.RenderStepped:Connect(function()
    if not ENABLED then return end
    
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("Humanoid") then return end
    
    local enemyChar = getEnemy()
    if not enemyChar then return end
    
    local head = enemyChar:FindFirstChild("Head")
    if not head then return end
    
    -- Auto Aim
    if AIMBOT then
        local direction = (head.Position - Camera.CFrame.Position).Unit
        local targetCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + direction)
        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, SMOOTHNESS)
    end
    
    -- Auto Shot (dispara automáticamente)
    local tool = character:FindFirstChildWhichIsA("Tool")
    if tool then
        -- La mayoría de armas en este juego disparan con activar la herramienta
        if tool:FindFirstChild("GunScript") or tool:FindFirstChild("Shoot") then
            mouse1click()  -- Simula clic izquierdo
        end
    end
end)

print("✅ Auto Shot cargado para Murderers VS Sheriffs Duels")
print("Presiona RightShift para ON/OFF")

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        ENABLED = not ENABLED
        print("Auto Shot: " .. (ENABLED and "✅ ON" or "❌ OFF"))
    end
end)

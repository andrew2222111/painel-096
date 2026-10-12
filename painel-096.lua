-- 096 BY ANDREW | DARK PURPLE + HEAD SIT + SUPERMAN FLY + HEAD TAGS (PERSONALIZÁVEL)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local C = {
	bg = Color3.fromRGB(9, 7, 13),
	panel = Color3.fromRGB(18, 12, 25),
	purple = Color3.fromRGB(103, 35, 177),
	neon = Color3.fromRGB(177, 94, 255),
	white = Color3.fromRGB(245, 240, 255),
	muted = Color3.fromRGB(165, 150, 180),
	sounds = {
		Click = "rbxassetid://0",
		Open = "rbxassetid://0",
		Switch = "rbxassetid://0",
	},
	welcomeVoice = "rbxassetid://0",
	welcomeAmbience = "rbxassetid://0",
}

local old = playerGui:FindFirstChild("096Interface")
if old then old:Destroy() end

local function make(className, props, parent)
	local obj = Instance.new(className)
	for k, v in pairs(props or {}) do
		obj[k] = v
	end
	obj.Parent = parent
	return obj
end

local function corner(parent, radius)
	return make("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function stroke(parent, color, thickness)
	return make("UIStroke", {
		Color = color or C.purple,
		Thickness = thickness or 1.5,
		Transparency = 0.15
	}, parent)
end

local function tween(obj, duration, props, style)
	local tw = TweenService:Create(obj, TweenInfo.new(duration, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function sound(name)
	local id = C.sounds[name]
	if not id or id == "rbxassetid://0" then return end
	local s = Instance.new("Sound")
	s.SoundId = id
	s.Volume = 0.35
	s.Parent = SoundService
	s:Play()
	s.Ended:Once(function() s:Destroy() end)
	task.delay(10, function() if s.Parent then s:Destroy() end end)
end

local welcomePlayed = false
local function playWelcome()
	if welcomePlayed then return end
	welcomePlayed = true
	local function playConfiguredAudio(assetId, volume, looped)
		if not assetId or assetId == "rbxassetid://0" then return nil end
		local audio = Instance.new("Sound")
		audio.SoundId = assetId
		audio.Volume = volume
		audio.Looped = looped or false
		audio.Parent = SoundService
		audio:Play()
		audio.Ended:Once(function() if audio.Parent then audio:Destroy() end end)
		task.delay(30, function() if audio.Parent then audio:Destroy() end end)
		return audio
	end
	playConfiguredAudio(C.welcomeAmbience, 0.18, false)
	task.wait(0.35)
	playConfiguredAudio(C.welcomeVoice, 0.9, false)
end

local gui = make("ScreenGui", {
	Name = "096Interface",
	IgnoreGuiInset = true,
	ResetOnSpawn = false,
	DisplayOrder = 999,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, playerGui)

local main = make("Frame", {
	Name = "Main",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(600, 390),
	BackgroundColor3 = C.bg,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	Visible = true,
	ZIndex = 1
}, gui)
corner(main, 16)
local mainStroke = stroke(main, C.purple, 2)

local bgGradient = make("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(29, 13, 43)),
		ColorSequenceKeypoint.new(0.5, C.bg),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 8, 28))
	}),
	Rotation = 35
}, main)

local particles = make("Frame", {
	Name = "Particles",
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	Active = false,
	ZIndex = 1
}, main)

local header = make("Frame", {
	Name = "Header",
	Size = UDim2.new(1, 0, 0, 76),
	BackgroundColor3 = C.panel,
	BorderSizePixel = 0,
	ZIndex = 3
}, main)
make("UIGradient", { Color = ColorSequence.new(C.panel, Color3.fromRGB(43, 19, 60)) }, header)

local logo = make("Frame", {
	Size = UDim2.fromOffset(49, 49),
	Position = UDim2.new(0, 16, 0.5, 0),
	AnchorPoint = Vector2.new(0, 0.5),
	BackgroundColor3 = C.bg,
	ZIndex = 4
}, header)
corner(logo, 13)
local logoStroke = stroke(logo, C.neon, 2)
make("UIGradient", { Color = ColorSequence.new(C.purple, C.bg), Rotation = 45 }, logo)

local LOGO_URL = "https://www.roblox.com/asset-thumbnail/image?assetId=139645443333328&width=420&height=420&format=png"

make("ImageLabel", {
	Name = "LogoImage",
	Size = UDim2.new(1, -4, 1, -4),
	Position = UDim2.fromOffset(2, 2),
	BackgroundTransparency = 1,
	Image = LOGO_URL,
	ScaleType = Enum.ScaleType.Fit,
	ZIndex = 5
}, logo)

make("TextLabel", {
	Position = UDim2.new(0, 77, 0, 14),
	Size = UDim2.new(0, 300, 0, 28),
	BackgroundTransparency = 1,
	Text = "096 BY ANDREW",
	TextColor3 = C.white,
	TextSize = 19,
	TextXAlignment = Enum.TextXAlignment.Left,
	Font = Enum.Font.GothamBlack,
	ZIndex = 4
}, header)

make("TextLabel", {
	Position = UDim2.new(0, 78, 0, 42),
	Size = UDim2.new(0, 300, 0, 17),
	BackgroundTransparency = 1,
	Text = "DARK EDITION  •  PURPLE SYSTEM",
	TextColor3 = C.neon,
	TextSize = 10,
	TextXAlignment = Enum.TextXAlignment.Left,
	Font = Enum.Font.GothamMedium,
	ZIndex = 4
}, header)

local minimize = make("TextButton", {
	Size = UDim2.fromOffset(36, 36),
	Position = UDim2.new(1, -49, 0, 20),
	BackgroundColor3 = Color3.fromRGB(47, 25, 63),
	Text = "—",
	TextColor3 = C.white,
	TextSize = 21,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false,
	ZIndex = 5
}, header)
corner(minimize, 10)

-- SIDEBAR COM SCROLL
local sidebar = make("ScrollingFrame", {
	Name = "Sidebar",
	Position = UDim2.new(0, 0, 0, 76),
	Size = UDim2.new(0, 155, 1, -76),
	BackgroundColor3 = Color3.fromRGB(13, 10, 18),
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = C.neon,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	ScrollingDirection = Enum.ScrollingDirection.Y,
	ZIndex = 3
}, main)

make("UIPadding", {
	PaddingTop = UDim.new(0, 16),
	PaddingBottom = UDim.new(0, 16),
	PaddingLeft = UDim.new(0, 12),
	PaddingRight = UDim.new(0, 12)
}, sidebar)

make("UIListLayout", {
	Padding = UDim.new(0, 8),
	SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

local content = make("Frame", {
	Name = "Content",
	Position = UDim2.new(0, 155, 0, 76),
	Size = UDim2.new(1, -155, 1, -76),
	BackgroundTransparency = 1,
	ZIndex = 3
}, main)

local title = make("TextLabel", {
	Position = UDim2.new(0, 22, 0, 18),
	Size = UDim2.new(1, -44, 0, 32),
	BackgroundTransparency = 1,
	Text = "HOME / DASHBOARD",
	TextColor3 = C.white,
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 4
}, content)

local subtitle = make("TextLabel", {
	Position = UDim2.new(0, 23, 0, 50),
	Size = UDim2.new(1, -44, 0, 22),
	BackgroundTransparency = 1,
	Text = "Bem-vindo ao 096 by andrew.",
	TextColor3 = C.muted,
	TextSize = 12,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 4
}, content)

local body = make("ScrollingFrame", {
	Name = "PageBody",
	Position = UDim2.new(0, 22, 0, 86),
	Size = UDim2.new(1, -44, 1, -105),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	ScrollingDirection = Enum.ScrollingDirection.Y,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = C.neon,
	ZIndex = 4
}, content)
make("UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder }, body)

local pages = {
	Home = { "Painel principal", "Interface animada", "Tema preto e roxo" },
	Visual = {},
	Utility = {},
	Tag = {},
	Settings = { "Atalho: RightShift", "Tema: Dark Purple" }
}

local featureRegistry = {
	Visual = {}, Utility = {}, Settings = {},
	Teleport = {}, Fly = {}, AutoFarm = {}, Tag = {}
}

local function registerToggle(tab, label, callback, defaultState)
	table.insert(featureRegistry[tab], {
		kind = "toggle", label = label, callback = callback, state = defaultState == true
	})
end

local function registerAction(tab, label, callback)
	table.insert(featureRegistry[tab], {
		kind = "action", label = label, callback = callback
	})
end

local FlyModule, HeadSitModule, TagModule, ESP_MODULE

-- ========================
-- ESP
-- ========================
ESP_MODULE = (function()
	local ok, result = pcall(function()
		local Camera = workspace.CurrentCamera
		local CONFIG = { Enabled = false, BoxColor = Color3.fromRGB(255, 255, 255), Thickness = 1, Transparency = 1 }
		local ESP_DATA = {}
		local connections = {}
		local cleanedUp = false

		if not Drawing or type(Drawing.new) ~= "function" then
			return { Toggle = function() end, Cleanup = function() end }
		end

		local function createBox()
			local box = Drawing.new("Square")
			box.Visible = false
			box.Color = CONFIG.BoxColor
			box.Thickness = CONFIG.Thickness
			box.Transparency = CONFIG.Transparency
			box.Filled = false
			return box
		end

		local function removeESP(p)
			if ESP_DATA[p] then
				ESP_DATA[p].Visible = false
				ESP_DATA[p]:Remove()
				ESP_DATA[p] = nil
			end
		end

		local function addPlayer(p)
			if p ~= player and not ESP_DATA[p] then
				ESP_DATA[p] = createBox()
			end
		end

		local function updateESP()
			if not CONFIG.Enabled then
				for _, b in pairs(ESP_DATA) do b.Visible = false end
				return
			end
			Camera = workspace.CurrentCamera or Camera
			if not Camera then return end
			for p, box in pairs(ESP_DATA) do
				local char = p.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				if hrp and hum and hum.Health > 0 then
					local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
					if onScreen and pos.Z > 0 then
						local top = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.6, 0))
						local bottom = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
						local height = math.abs(bottom.Y - top.Y)
						local width = height / 1.5
						box.Size = Vector2.new(width, height)
						box.Position = Vector2.new(pos.X - width/2, pos.Y - height/2)
						box.Visible = true
					else
						box.Visible = false
					end
				else
					box.Visible = false
				end
			end
		end

		for _, p in ipairs(Players:GetPlayers()) do addPlayer(p) end
		table.insert(connections, Players.PlayerAdded:Connect(addPlayer))
		table.insert(connections, Players.PlayerRemoving:Connect(removeESP))
		table.insert(connections, RunService.RenderStepped:Connect(updateESP))

		return {
			Toggle = function(state)
				if cleanedUp then return end
				CONFIG.Enabled = state == true
				if not CONFIG.Enabled then
					for _, b in pairs(ESP_DATA) do b.Visible = false end
				end
			end,
			Cleanup = function()
				if cleanedUp then return end
				cleanedUp = true
				CONFIG.Enabled = false
				for _, conn in ipairs(connections) do conn:Disconnect() end
				for p in pairs(ESP_DATA) do removeESP(p) end
			end
		}
	end)

	if ok then return result end
	return { Toggle = function() end, Cleanup = function() end }
end)()

-- ========================
-- TAG MODULE (só quem usa o painel + nome personalizável)
-- ========================
TagModule = (function()
	local ok, result = pcall(function()
		local CONFIG = {
			TagName = "VIP / STAFF",
			TagColor = Color3.fromRGB(255, 255, 255),
			TagSize = 14,
			HeightOffset = 3,
			MarkerName = "096PanelUser"
		}

		local tags = {}
		local enabled = false
		local cleaned = false
		local Camera = workspace.CurrentCamera

		if not Drawing or type(Drawing.new) ~= "function" then
			return {
				Toggle = function() end,
				SetName = function() end,
				GetName = function() return CONFIG.TagName end,
				Cleanup = function() end
			}
		end

		-- Marca o personagem local para outros usuários do painel detectarem
		local function addMarker(char)
			if not char then return end
			if not char:FindFirstChild(CONFIG.MarkerName) then
				local marker = Instance.new("BoolValue")
				marker.Name = CONFIG.MarkerName
				marker.Value = true
				marker.Parent = char
			end
		end

		local function ensureLocalMarker()
			if player.Character then
				addMarker(player.Character)
			end
		end

		player.CharacterAdded:Connect(function(char)
			task.wait(0.3)
			addMarker(char)
		end)
		ensureLocalMarker()

		local function isPanelUser(p)
			if not p or not p.Character then return false end
			return p.Character:FindFirstChild(CONFIG.MarkerName) ~= nil
		end

		local function removeTag(p)
			local data = tags[p]
			if data then
				if data.connection then data.connection:Disconnect() end
				if data.drawing then
					data.drawing.Visible = false
					data.drawing:Remove()
				end
				tags[p] = nil
			end
		end

		local function createTag(p)
			if tags[p] then return end

			local drawTag = Drawing.new("Text")
			drawTag.Visible = false
			drawTag.Center = true
			drawTag.Outline = true
			drawTag.Font = 2
			drawTag.Size = CONFIG.TagSize
			drawTag.Color = CONFIG.TagColor
			drawTag.Text = CONFIG.TagName

			local connection = RunService.RenderStepped:Connect(function()
				if not enabled or cleaned then
					drawTag.Visible = false
					return
				end

				if not p or not p.Parent then
					removeTag(p)
					return
				end

				-- Só mostra tag se a pessoa também estiver usando o painel
				if not isPanelUser(p) then
					drawTag.Visible = false
					return
				end

				local head = p.Character and p.Character:FindFirstChild("Head")
				if head then
					Camera = workspace.CurrentCamera or Camera
					local pos, onScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, CONFIG.HeightOffset, 0))
					if onScreen and pos.Z > 0 then
						drawTag.Text = CONFIG.TagName
						drawTag.Position = Vector2.new(pos.X, pos.Y)
						drawTag.Visible = true
					else
						drawTag.Visible = false
					end
				else
					drawTag.Visible = false
				end
			end)

			tags[p] = { drawing = drawTag, connection = connection }
		end

		local function clearAll()
			for p in pairs(tags) do
				removeTag(p)
			end
		end

		local function refreshAllTags()
			for p, data in pairs(tags) do
				if data.drawing then
					data.drawing.Text = CONFIG.TagName
				end
			end
		end

		local function setEnabled(state)
			if cleaned then return end
			enabled = state == true
			ensureLocalMarker()

			if enabled then
				for _, p in ipairs(Players:GetPlayers()) do
					createTag(p)
				end
			else
				clearAll()
			end
		end

		local function setName(newName)
			if typeof(newName) ~= "string" then return end
			newName = newName:gsub("^%s+", ""):gsub("%s+$", "")
			if newName == "" then newName = "VIP / STAFF" end
			CONFIG.TagName = newName
			refreshAllTags()
		end

		local addConn = Players.PlayerAdded:Connect(function(p)
			if enabled then createTag(p) end
		end)
		local remConn = Players.PlayerRemoving:Connect(function(p)
			removeTag(p)
		end)

		-- Re-checa periodicamente quem tem o marker (quando alguém entra com o script)
		task.spawn(function()
			while not cleaned do
				if enabled then
					for _, p in ipairs(Players:GetPlayers()) do
						if isPanelUser(p) and not tags[p] then
							createTag(p)
						end
					end
				end
				task.wait(2)
			end
		end)

		return {
			Toggle = setEnabled,
			SetName = setName,
			GetName = function()
				return CONFIG.TagName
			end,
			Cleanup = function()
				if cleaned then return end
				cleaned = true
				enabled = false
				clearAll()
				addConn:Disconnect()
				remConn:Disconnect()
			end
		}
	end)

	if ok then return result end
	return {
		Toggle = function() end,
		SetName = function() end,
		GetName = function() return "VIP / STAFF" end,
		Cleanup = function() end
	}
end)()

-- ========================
-- AUTOFARM
-- ========================
local CrystalDetector = { Enabled = false, Highlights = {}, ScanDelay = 1.5, MaxDistance = 5000 }

local function isCrystalCandidate(part)
	if not part:IsA("BasePart") then return false end
	local color = part.Color
	local brightest = math.max(color.R, color.G, color.B)
	local darkest = math.min(color.R, color.G, color.B)
	local saturation = brightest - darkest
	local isBright = brightest >= 0.72
	local isColorful = saturation >= 0.35
	local hasGlow = part.Material == Enum.Material.Neon
		or part:FindFirstChildOfClass("PointLight")
		or part:FindFirstChildOfClass("SurfaceLight")
		or part:FindFirstChildOfClass("SpotLight")
	return isBright and isColorful and hasGlow
end

local function clearCrystalHighlights()
	for obj, hl in pairs(CrystalDetector.Highlights) do
		if hl then hl:Destroy() end
		CrystalDetector.Highlights[obj] = nil
	end
end

local function scanCrystals()
	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return 0 end
	local found = 0
	local seen = {}
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and isCrystalCandidate(obj) then
			local dist = (obj.Position - root.Position).Magnitude
			if dist <= CrystalDetector.MaxDistance then
				seen[obj] = true
				found += 1
				if not CrystalDetector.Highlights[obj] then
					local hl = Instance.new("Highlight")
					hl.Name = "096CrystalDetector"
					hl.Adornee = obj
					hl.FillColor = Color3.fromRGB(177, 94, 255)
					hl.OutlineColor = Color3.fromRGB(245, 240, 255)
					hl.FillTransparency = 0.72
					hl.OutlineTransparency = 0.05
					hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					hl.Parent = gui
					CrystalDetector.Highlights[obj] = hl
				end
			end
		end
	end
	for obj, hl in pairs(CrystalDetector.Highlights) do
		if not seen[obj] or not obj.Parent then
			if hl then hl:Destroy() end
			CrystalDetector.Highlights[obj] = nil
		end
	end
	return found
end

registerToggle("AutoFarm", "Detector de cristais", function(enabled)
	CrystalDetector.Enabled = enabled
	if enabled then
		task.spawn(function()
			while CrystalDetector.Enabled and gui.Parent do
				pcall(scanCrystals)
				task.wait(CrystalDetector.ScanDelay)
			end
		end)
	else
		clearCrystalHighlights()
	end
end, false)

registerAction("AutoFarm", "Procurar cristais agora", function()
	pcall(scanCrystals)
end)

registerToggle("AutoFarm", "Conversão automática (indisponível)", function() end, false)

registerToggle("Visual", "ESP Box NIK", function(enabled)
	ESP_MODULE.Toggle(enabled)
end, false)

registerToggle("Tag", "Ativar Head Tags", function(enabled)
	TagModule.Toggle(enabled)
end, false)

-- ========================
-- FLY
-- ========================
FlyModule = (function()
	local flying = false
	local bodyVelocity, bodyGyro
	local renderConnection, characterConnection
	local cleaned = false
	local SPEED = 60
	local HOTKEY = Enum.KeyCode.F
	local flyAnim = nil

	local FLY_ANIMS = {
		"rbxassetid://10921362566",
		"rbxassetid://3541043988",
		"rbxassetid://616006778",
		"rbxassetid://10714360343",
	}

	local function getParts()
		local char = player.Character
		if not char then return nil, nil end
		return char:FindFirstChild("HumanoidRootPart"), char:FindFirstChildOfClass("Humanoid")
	end

	local function stopAnim()
		if flyAnim then
			pcall(function() flyAnim:Stop() end)
			flyAnim = nil
		end
	end

	local function playFlyAnim(humanoid)
		stopAnim()
		for _, id in ipairs(FLY_ANIMS) do
			local ok, track = pcall(function()
				local anim = Instance.new("Animation")
				anim.AnimationId = id
				local t = humanoid:LoadAnimation(anim)
				t.Priority = Enum.AnimationPriority.Action4
				t.Looped = true
				t:Play(0.2)
				return t
			end)
			if ok and track then
				flyAnim = track
				return
			end
		end
	end

	local function stop()
		flying = false
		if bodyVelocity then
			bodyVelocity.Velocity = Vector3.zero
			bodyVelocity.MaxForce = Vector3.zero
			bodyVelocity.Parent = nil
		end
		if bodyGyro then
			bodyGyro.MaxTorque = Vector3.zero
			bodyGyro.Parent = nil
		end
		stopAnim()
	end

	local function setFlying(enabled)
		if cleaned then return end
		if not enabled then
			stop()
			return
		end

		local root, humanoid = getParts()
		if not root or not humanoid or humanoid.Health <= 0 then return end

		if not bodyVelocity then
			bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.Name = "096FlyVelocity"
			bodyVelocity.MaxForce = Vector3.zero
			bodyVelocity.P = 2500
		end
		if not bodyGyro then
			bodyGyro = Instance.new("BodyGyro")
			bodyGyro.Name = "096FlyGyro"
			bodyGyro.P = 4000
			bodyGyro.D = 800
			bodyGyro.MaxTorque = Vector3.zero
		end

		bodyVelocity.Parent = root
		bodyGyro.Parent = root
		bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.CFrame = root.CFrame

		flying = true
		playFlyAnim(humanoid)
	end

	renderConnection = RunService.RenderStepped:Connect(function()
		if not flying then return end
		local root, humanoid = getParts()
		local cam = workspace.CurrentCamera
		if not root or not humanoid or humanoid.Health <= 0 or not cam or not bodyVelocity or not bodyGyro then
			stop()
			return
		end

		local dir = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0, 1, 0) end

		if dir.Magnitude > 0 then dir = dir.Unit end
		bodyVelocity.Velocity = dir * SPEED
		bodyGyro.CFrame = cam.CFrame
	end)

	characterConnection = player.CharacterAdded:Connect(function()
		stop()
		task.wait(0.3)
		if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
		if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
	end)

	return {
		Toggle = setFlying,
		IsFlying = function() return flying end,
		Hotkey = HOTKEY,
		Cleanup = function()
			if cleaned then return end
			cleaned = true
			stop()
			if renderConnection then renderConnection:Disconnect() end
			if characterConnection then characterConnection:Disconnect() end
			if bodyVelocity then bodyVelocity:Destroy() end
			if bodyGyro then bodyGyro:Destroy() end
		end
	}
end)()

registerToggle("Fly", "Fly Superman (WASD / Espaço / Shift)", function(enabled)
	FlyModule.Toggle(enabled)
end, false)

-- ========================
-- HEAD SIT
-- ========================
HeadSitModule = (function()
	local following = false
	local targetPlayer = nil
	local followConnection = nil
	local currentAnim = nil
	local cleaned = false
	local OFFSET = CFrame.new(0, 1.65, 0.1)

	local function setNoCollide(char, state)
		if not char then return end
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = not state
			end
		end
	end

	local function stop()
		following = false
		targetPlayer = nil
		if followConnection then followConnection:Disconnect() followConnection = nil end
		local char = player.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.Sit = false
				hum.PlatformStand = false
			end
			setNoCollide(char, false)
		end
		if currentAnim then
			pcall(function() currentAnim:Stop() end)
			currentAnim = nil
		end
	end

	local function start(target)
		if cleaned then return end
		if not target or target == player or not target.Parent then return end

		local char = player.Character
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = char:FindFirstChild("HumanoidRootPart")
		local head = target.Character and target.Character:FindFirstChild("Head")
		if not hum or not root or not head then return end

		stop()
		targetPlayer = target
		following = true

		hum.Sit = true
		hum.PlatformStand = true
		setNoCollide(char, true)

		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://2506281703"
		currentAnim = hum:LoadAnimation(anim)
		currentAnim.Priority = Enum.AnimationPriority.Action
		currentAnim.Looped = true
		currentAnim:Play()

		followConnection = RunService.Heartbeat:Connect(function()
			if not following or cleaned then stop() return end
			if not targetPlayer or not targetPlayer.Parent then stop() return end

			local tHead = targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head")
			local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			local myHum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")

			if tHead and myRoot and myHum and myHum.Health > 0 then
				myRoot.CFrame = tHead.CFrame * OFFSET
				myRoot.AssemblyLinearVelocity = Vector3.zero
				myRoot.AssemblyAngularVelocity = Vector3.zero
			else
				stop()
			end
		end)
	end

	player.CharacterAdded:Connect(function()
		task.wait(0.1)
		stop()
	end)

	return {
		Start = start,
		Stop = stop,
		IsActive = function() return following end,
		Cleanup = function()
			if cleaned then return end
			cleaned = true
			stop()
		end
	}
end)()

gui.Destroying:Connect(function()
	pcall(function() ESP_MODULE.Cleanup() end)
	pcall(function() FlyModule.Cleanup() end)
	pcall(function() HeadSitModule.Cleanup() end)
	pcall(function() TagModule.Cleanup() end)
end)

-- ========================
-- UI FUNCTIONS
-- ========================
local currentTab = "Home"
local tabButtons = {}
local opened = true

local function createRow(text)
	local row = make("TextButton", {
		Size = UDim2.new(1, 0, 0, 47),
		BackgroundColor3 = C.panel,
		Text = "",
		AutoButtonColor = false,
		ZIndex = 5
	}, body)
	corner(row, 10)
	local edge = stroke(row, Color3.fromRGB(57, 34, 73), 1)
	make("TextLabel", {
		Position = UDim2.new(0, 14, 0, 0),
		Size = UDim2.new(1, -28, 1, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = C.white,
		TextSize = 13,
		Font = Enum.Font.GothamMedium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 6
	}, row)
	row.MouseEnter:Connect(function()
		tween(row, 0.18, {BackgroundColor3 = Color3.fromRGB(40, 22, 54)})
		tween(edge, 0.18, {Color = C.neon})
	end)
	row.MouseLeave:Connect(function()
		tween(row, 0.18, {BackgroundColor3 = C.panel})
		tween(edge, 0.18, {Color = Color3.fromRGB(57, 34, 73)})
	end)
	row.Activated:Connect(function()
		sound("Click")
		tween(row, 0.08, {BackgroundColor3 = C.purple})
		task.delay(0.12, function() if row.Parent then tween(row, 0.2, {BackgroundColor3 = C.panel}) end end)
	end)
end

local function createFeatureToggle(feature)
	local row = make("TextButton", {
		Size = UDim2.new(1, 0, 0, 47),
		BackgroundColor3 = C.panel,
		Text = "",
		AutoButtonColor = false,
		ZIndex = 5
	}, body)
	corner(row, 10)
	local edge = stroke(row, Color3.fromRGB(57, 34, 73), 1)
	make("TextLabel", {
		Position = UDim2.new(0, 14, 0, 0),
		Size = UDim2.new(1, -100, 1, 0),
		BackgroundTransparency = 1,
		Text = feature.label,
		TextColor3 = C.white,
		TextSize = 13,
		Font = Enum.Font.GothamMedium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 6
	}, row)
	local stateLabel = make("TextLabel", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.fromOffset(72, 27),
		BackgroundColor3 = feature.state and C.purple or Color3.fromRGB(38, 31, 45),
		Text = feature.state and "ON" or "OFF",
		TextColor3 = C.white,
		TextSize = 11,
		Font = Enum.Font.GothamBold,
		ZIndex = 6
	}, row)
	corner(stateLabel, 8)
	local function refresh()
		stateLabel.Text = feature.state and "ON" or "OFF"
		tween(stateLabel, 0.15, {BackgroundColor3 = feature.state and C.purple or Color3.fromRGB(38, 31, 45)})
	end
	row.MouseEnter:Connect(function()
		tween(row, 0.15, {BackgroundColor3 = Color3.fromRGB(40, 22, 54)})
		tween(edge, 0.15, {Color = C.neon})
	end)
	row.MouseLeave:Connect(function()
		tween(row, 0.15, {BackgroundColor3 = C.panel})
		tween(edge, 0.15, {Color = Color3.fromRGB(57, 34, 73)})
	end)
	row.Activated:Connect(function()
		feature.state = not feature.state
		refresh()
		sound("Click")
		if feature.callback then
			local ok, err = pcall(feature.callback, feature.state)
			if not ok then
				warn("[096] Erro:", err)
				feature.state = false
				refresh()
			end
		end
	end)
end

local function createFeatureAction(feature)
	local row = make("TextButton", {
		Size = UDim2.new(1, 0, 0, 47),
		BackgroundColor3 = C.panel,
		Text = "",
		AutoButtonColor = false,
		ZIndex = 5
	}, body)
	corner(row, 10)
	local edge = stroke(row, Color3.fromRGB(57, 34, 73), 1)
	make("TextLabel", {
		Position = UDim2.new(0, 14, 0, 0),
		Size = UDim2.new(1, -28, 1, 0),
		BackgroundTransparency = 1,
		Text = feature.label .. "   ›",
		TextColor3 = C.white,
		TextSize = 13,
		Font = Enum.Font.GothamMedium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 6
	}, row)
	row.MouseEnter:Connect(function()
		tween(row, 0.15, {BackgroundColor3 = Color3.fromRGB(40, 22, 54)})
		tween(edge, 0.15, {Color = C.neon})
	end)
	row.MouseLeave:Connect(function()
		tween(row, 0.15, {BackgroundColor3 = C.panel})
		tween(edge, 0.15, {Color = Color3.fromRGB(57, 34, 73)})
	end)
	row.Activated:Connect(function()
		sound("Click")
		if feature.callback then
			local ok, err = pcall(feature.callback)
			if not ok then warn("[096] Erro:", err) end
		end
	end)
end

-- Campo de texto para personalizar o nome da tag
local function createTagNameInput()
	local container = make("Frame", {
		Size = UDim2.new(1, 0, 0, 70),
		BackgroundColor3 = C.panel,
		BorderSizePixel = 0,
		ZIndex = 5
	}, body)
	corner(container, 10)
	stroke(container, Color3.fromRGB(57, 34, 73), 1)

	make("TextLabel", {
		Position = UDim2.new(0, 14, 0, 6),
		Size = UDim2.new(1, -28, 0, 18),
		BackgroundTransparency = 1,
		Text = "Nome da Tag",
		TextColor3 = C.muted,
		TextSize = 11,
		Font = Enum.Font.GothamMedium,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 6
	}, container)

	local textBox = make("TextBox", {
		Position = UDim2.new(0, 12, 0, 28),
		Size = UDim2.new(1, -24, 0, 32),
		BackgroundColor3 = Color3.fromRGB(28, 20, 38),
		Text = TagModule.GetName(),
		PlaceholderText = "Digite o nome da tag...",
		TextColor3 = C.white,
		PlaceholderColor3 = C.muted,
		TextSize = 13,
		Font = Enum.Font.Gotham,
		ClearTextOnFocus = false,
		ZIndex = 6
	}, container)
	corner(textBox, 8)
	stroke(textBox, Color3.fromRGB(70, 45, 90), 1)

	textBox.FocusLost:Connect(function()
		local newName = textBox.Text
		TagModule.SetName(newName)
		textBox.Text = TagModule.GetName()
		sound("Click")
	end)
end

local function renderPage(tab)
	currentTab = tab
	for _, child in ipairs(body:GetChildren()) do
		if child:IsA("GuiObject") and not child:IsA("UIListLayout") then
			child:Destroy()
		end
	end
	title.Text = string.upper(tab) .. " / 096"
	subtitle.Text = tab == "Home" and "Bem-vindo ao 096 by andrew." or "Personalize sua interface."
	for _, item in ipairs(pages[tab] or {}) do createRow(item) end
	local features = featureRegistry[tab]
	if features then
		for _, f in ipairs(features) do
			if f.kind == "toggle" then createFeatureToggle(f)
			elseif f.kind == "action" then createFeatureAction(f) end
		end
	end

	-- Na aba Tag, adiciona o campo de nome abaixo do toggle
	if tab == "Tag" then
		createTagNameInput()
		createRow("Só quem usa o painel vê as tags")
	end

	if (tab == "Visual" or tab == "Utility") and #(pages[tab] or {}) == 0 and (not features or #features == 0) then
		createRow("Pronto para receber funções")
	elseif tab == "Teleport" and (not features or #features == 0) then
		createRow("Nenhum outro jogador encontrado")
	elseif tab == "Fly" then
		createRow("Ative o Fly ou pressione F")
	elseif tab == "AutoFarm" then
		createRow("Detector de cristais")
	end
	body.Position = UDim2.new(0, 30, 0, 86)
	tween(body, 0.25, {Position = UDim2.new(0, 22, 0, 86)})
end

-- TELEPORT
local function teleportTo(target)
	if not target or target == player then return end
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
	if root and tRoot then
		root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3)
	end
end

local function refreshTeleportPlayers()
	table.clear(featureRegistry.Teleport)
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			table.insert(featureRegistry.Teleport, {
				kind = "action",
				label = p.DisplayName .. "  (@" .. p.Name .. ")",
				callback = function() teleportTo(p) end
			})
		end
	end
	if currentTab == "Teleport" then renderPage("Teleport") end
end

Players.PlayerAdded:Connect(function() task.defer(refreshTeleportPlayers) end)
Players.PlayerRemoving:Connect(function() task.defer(refreshTeleportPlayers) end)
refreshTeleportPlayers()

-- HEAD SIT
registerAction("Utility", "Parar Head Sit", function()
	HeadSitModule.Stop()
end)

local function refreshHeadSitPlayers()
	local utility = featureRegistry.Utility
	for i = #utility, 1, -1 do
		if utility[i].label and string.find(utility[i].label, "Head Sit →") then
			table.remove(utility, i)
		end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			table.insert(utility, {
				kind = "action",
				label = "Head Sit → " .. p.DisplayName .. "  (@" .. p.Name .. ")",
				callback = function() HeadSitModule.Start(p) end
			})
		end
	end
	if currentTab == "Utility" then renderPage("Utility") end
end

Players.PlayerAdded:Connect(function() task.defer(refreshHeadSitPlayers) end)
Players.PlayerRemoving:Connect(function()
	task.defer(refreshHeadSitPlayers)
	if HeadSitModule.IsActive() then HeadSitModule.Stop() end
end)
refreshHeadSitPlayers()

-- SIDEBAR
for i, tab in ipairs({"Home", "Visual", "Teleport", "Fly", "AutoFarm", "Utility", "Tag", "Settings"}) do
	local btn = make("TextButton", {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = tab == "Home" and Color3.fromRGB(55, 27, 78) or C.panel,
		Text = tab,
		TextColor3 = C.white,
		TextSize = 12,
		Font = Enum.Font.GothamSemibold,
		AutoButtonColor = false,
		LayoutOrder = i,
		ZIndex = 4
	}, sidebar)
	corner(btn, 9)
	local edge = stroke(btn, tab == "Home" and C.neon or C.panel, 1)
	tabButtons[tab] = btn

	btn.MouseEnter:Connect(function()
		tween(btn, 0.15, {BackgroundColor3 = Color3.fromRGB(44, 23, 61)})
		tween(edge, 0.15, {Color = C.neon})
	end)
	btn.MouseLeave:Connect(function()
		tween(btn, 0.15, {BackgroundColor3 = currentTab == tab and Color3.fromRGB(55, 27, 78) or C.panel})
		tween(edge, 0.15, {Color = currentTab == tab and C.neon or C.panel})
	end)
	btn.Activated:Connect(function()
		sound("Switch")
		for t, b in pairs(tabButtons) do
			local sel = t == tab
			tween(b, 0.15, {BackgroundColor3 = sel and Color3.fromRGB(55, 27, 78) or C.panel})
			local s = b:FindFirstChildOfClass("UIStroke")
			if s then tween(s, 0.15, {Color = sel and C.neon or C.panel}) end
		end
		renderPage(tab)
	end)
end

-- FLOATING
local floating = make("ImageButton", {
	Name = "Floating096",
	Size = UDim2.fromOffset(54, 54),
	Position = UDim2.new(0, 24, 0.5, 0),
	AnchorPoint = Vector2.new(0, 0.5),
	BackgroundColor3 = C.bg,
	Image = LOGO_URL,
	ScaleType = Enum.ScaleType.Fit,
	AutoButtonColor = false,
	Visible = false,
	ZIndex = 10
}, gui)
corner(floating, 17)
local floatingStroke = stroke(floating, C.neon, 2)
make("UIGradient", { Color = ColorSequence.new(C.purple, C.bg), Rotation = 45 }, floating)

local function openPanel()
	opened = true
	floating.Visible = false
	main.Visible = true
	main.Size = UDim2.fromOffset(520, 330)
	main.BackgroundTransparency = 0.25
	tween(main, 0.35, {
		Size = UDim2.fromOffset(600, 390),
		BackgroundTransparency = 0
	}, Enum.EasingStyle.Back)
	sound("Open")
end

local function closePanel()
	if not opened then return end
	opened = false
	tween(main, 0.2, {
		Size = UDim2.fromOffset(520, 330),
		BackgroundTransparency = 0.3
	})
	sound("Click")
	task.delay(0.2, function()
		if not opened then
			main.Visible = false
			floating.Visible = true
			floating.Size = UDim2.fromOffset(35, 35)
			tween(floating, 0.25, { Size = UDim2.fromOffset(54, 54) }, Enum.EasingStyle.Back)
		end
	end)
end

minimize.Activated:Connect(closePanel)
floating.Activated:Connect(openPanel)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		if opened then closePanel() else openPanel() end
	end
end)

-- DRAG
local dragging, dragInput, dragStart, startPos
header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

-- EFFECTS
task.spawn(function()
	while gui.Parent do
		tween(bgGradient, 5, { Rotation = bgGradient.Rotation + 180 }, Enum.EasingStyle.Linear)
		task.wait(5)
	end
end)

task.spawn(function()
	while gui.Parent do
		tween(mainStroke, 1, { Transparency = 0.04, Thickness = 2.8 }, Enum.EasingStyle.Sine)
		tween(logoStroke, 1, { Transparency = 0.03 }, Enum.EasingStyle.Sine)
		tween(floatingStroke, 1, { Transparency = 0.03 }, Enum.EasingStyle.Sine)
		task.wait(1)
		tween(mainStroke, 1, { Transparency = 0.5, Thickness = 1.4 }, Enum.EasingStyle.Sine)
		tween(logoStroke, 1, { Transparency = 0.55 }, Enum.EasingStyle.Sine)
		tween(floatingStroke, 1, { Transparency = 0.55 }, Enum.EasingStyle.Sine)
		task.wait(1)
	end
end)

task.spawn(function()
	while gui.Parent do
		tween(logo, 1.2, { Rotation = 3 }, Enum.EasingStyle.Sine)
		task.wait(1.2)
		tween(logo, 1.2, { Rotation = -3 }, Enum.EasingStyle.Sine)
		task.wait(1.2)
	end
end)

local rng = Random.new()
task.spawn(function()
	while particles.Parent do
		local size = rng:NextInteger(2, 5)
		local dot = make("Frame", {
			Size = UDim2.fromOffset(size, size),
			Position = UDim2.new(rng:NextNumber(0.04, 0.96), 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(rng:NextInteger(125, 185), rng:NextInteger(45, 90), 255),
			BackgroundTransparency = 0.15,
			BorderSizePixel = 0,
			Active = false,
			ZIndex = 1
		}, particles)
		corner(dot, 100)
		local dur = rng:NextNumber(3, 6)
		tween(dot, dur, {
			Position = UDim2.new(rng:NextNumber(0.04, 0.96), 0, 0, -8),
			BackgroundTransparency = 1
		}, Enum.EasingStyle.Linear)
		task.delay(dur, function() if dot.Parent then dot:Destroy() end end)
		task.wait(0.18)
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == FlyModule.Hotkey then
		local flyFeature = featureRegistry.Fly[1]
		if flyFeature then
			flyFeature.state = not flyFeature.state
			FlyModule.Toggle(flyFeature.state)
			sound("Switch")
			if currentTab == "Fly" then renderPage("Fly") end
		end
	end
end)

-- START
renderPage("Home")
main.Visible = true
opened = true
main.Size = UDim2.fromOffset(520, 330)
main.BackgroundTransparency = 0.25
tween(main, 0.45, {
	Size = UDim2.fromOffset(600, 390),
	BackgroundTransparency = 0
}, Enum.EasingStyle.Back)

task.delay(0.55, playWelcome)
print("[096 BY ANDREW] Interface carregada!")
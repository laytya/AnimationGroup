--[[

    Copyright (c) 2016-2018 Martin Jesper Low Madsen <martin@martinjlowm.dk>

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to
    deal in the Software without restriction, including without limitation the
    rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
    sell copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.

--]]

if not LibStub then return end

local AG = LibStub:GetLibrary('AnimationGroup-1.0')
if not AG then return end

if AG.Alpha then return end
local Alpha = AG:New('Alpha', AG.Animation)

function Alpha:__Initialize()
    self.alpha_change = 0
    self.alpha_from = 0
    self.alpha_to = 0
end

function Alpha:SaveProperties()
    self.properties.alpha = self.target:GetAlpha()
end

function Alpha:LoadProperties()
    if self.properties.alpha then self.target:SetAlpha(self.properties.alpha) end
end

function Alpha:SetChange(change)
    self.alpha_change = change
end

function Alpha:GetChange()
    return self.alpha_change
end

do
    local function SetChange(self)
        self.alpha_change = self.alpha_to - self.alpha_from
    end

    function Alpha:SetFromAlpha(alpha)
        self.alpha_from = alpha
        SetChange(self)
    end

    function Alpha:SetToAlpha(alpha)
        self.alpha_to = alpha
        SetChange(self)
    end
end

function Alpha:OnUpdate(elapsed)
    local frame = self.target

    frame:SetAlpha(self.alpha_from + self.smoothProgress * self.alpha_change)
end

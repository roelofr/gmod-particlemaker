--[[
Copyright 2016 Roelof Roos (SirQuack)
Part of Particle Maker Garry's Mod Tool

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]

if not SirQuack then SirQuack = {} end
if not SirQuack.ParticleMaker then SirQuack.ParticleMaker = {} end

-- The below message is adapted each time the version number is bumped.
-- There is no locale for the changelog, as that would be asking too much
-- of the translators.

local changesThisVersion = [[
This update includes a lot of bug-fixes:

 - Fixed not being able to wire anything to the  particle maker
 - Fixed wierd "NOotice"-styled messages on some places
 - Fixed error message when trying to spawn particle maker when no material was selected.
]]

--
-- Checks if a wiremod install is present.
--
-- @returns Boolean
--
SirQuack.ParticleMaker.runOnce = function(dermaPanel)
    local versionConvar = GetConVar("particle_maker_version")
    local runOnceConvar = GetConVar("particle_maker_runonce_version")

    local frame = vgui.Create("DForm", dermaPanel)

    frame:SetName("#tool.particle_maker.changes")
    frame:SetExpanded(versionConvar:GetInt() > runOnceConvar:GetInt())
    frame:Dock( TOP )

    dermaPanel:AddItem( frame, nil )

    local changelog1 = frame:ControlHelp("#tool.particle_maker.changes.help")
    local changelog2 = frame:Help(changesThisVersion)
    local btn = frame:Button("#close")

    btn.DoClick = function()
        if versionConvar and runOnceConvar then
            runOnceConvar:SetInt(versionConvar:GetInt())
        end

        if frame and frame:IsValid() then
            frame:Toggle()
        end
    end

    frame:SizeToContentsY()
    frame:InvalidateLayout()

    return frame
end

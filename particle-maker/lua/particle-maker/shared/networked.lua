/**
 * Copyright 2016 Roelof Roos (SirQuack)
 * Part of Particle Maker Garry's Mod Tool
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

if not SirQuack then SirQuack = {} end
if not SirQuack.ParticleMaker then SirQuack.ParticleMaker = {} end

SirQuack.ParticleMaker.assignNetworkVars = function(ent)
    ent:NetworkVar( "Bool", 0, "Active" )
    ent:NetworkVar( "Bool", 1, "ActiveWire" )
    ent:NetworkVar( "Bool", 2, "Toggle" )

    ent:NetworkVar( "String", 0, "ParticleMaterial" )

    ent:NetworkVar( "Vector", 0, "Color1" )
    ent:NetworkVar( "Vector", 1, "Color2" )
    ent:NetworkVar( "Bool", 3, "ColorRand" )

    ent:NetworkVar( "Float", 0, "ParticleVelocity" )
    ent:NetworkVar( "Float", 1, "Spread" )
    ent:NetworkVar( "Float", 2, "Delay" )
    ent:NetworkVar( "Int", 0, "ParticleCount" )
    ent:NetworkVar( "Float", 3, "DieTime" )
    ent:NetworkVar( "Float", 4, "StartAlpha" )
    ent:NetworkVar( "Float", 0, "EndAlpha" )
    ent:NetworkVar( "Float", 5, "StartSize" )
    ent:NetworkVar( "Float", 6, "EndSize" )
    ent:NetworkVar( "Float", 7, "StartLength" )
    ent:NetworkVar( "Float", 8, "EndLength" )
    ent:NetworkVar( "Float", 9, "RollRand" )
    ent:NetworkVar( "Float", 10, "RollDelta" )
    ent:NetworkVar( "Float", 11, "AirResistance" )
    ent:NetworkVar( "Float", 12, "Bounce" )
    ent:NetworkVar( "Float", 13, "Gravity" )
    ent:NetworkVar( "Bool", 4, "Collide" )
    ent:NetworkVar( "Bool", 5, "Lighting" )
    ent:NetworkVar( "Bool", 6, "Sliding" )

    ent:NetworkVar( "Bool", 7, "3D" )
    ent:NetworkVar( "Bool", 8, "Align" )
    ent:NetworkVar( "Bool", 9, "Stick" )
    ent:NetworkVar( "Bool", 10, "DoubleSided" )
    ent:NetworkVar( "Vector", 2, "AngleVel" )
    ent:NetworkVar( "Float", 14, "StickLifeTime" )
    ent:NetworkVar( "Float", 15, "StickStartSize" )
    ent:NetworkVar( "Float", 16, "StickEndSize" )
    ent:NetworkVar( "Float", 17, "StickStartAlpha" )
    ent:NetworkVar( "Float", 18, "StickEndAlpha" )

    ent:NetworkVar( "Int", 1, "WireMode" )
end
local cid,id=GetID()
--Destrick Relic - Kiba
function cid.initial_effect(c)
	c:EnableReviveLimit()
	--2 monsters, including at least 1 "Destrick" monster
	aux.AddLinkProcedure(c,nil,2,2,cid.lcheck)
	--Cannot be destroyed by card effects.
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--All your Machine monsters gain 200 ATK.
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_MACHINE))
	e2:SetValue(200)
	c:RegisterEffect(e2)
	--Your "Destrick" monsters gain 300 ATK and cannot be destroyed by card effects, while this Link Summoned card is on the field.
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x5cd))
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCondition(function(e) return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK) end)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(300)
	c:RegisterEffect(e4)
	--You never take damage if the amount is 400 or more.
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_CHANGE_DAMAGE)
	e0:SetRange(LOCATION_MZONE)
	e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e0:SetTargetRange(1,0)
	e0:SetValue(cid.damval)
	c:RegisterEffect(e0)
end
function cid.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x5cd)
end
function cid.damval(e,re,val,r,rp,rc)
	if val>=400 then return 0 else return val end
end

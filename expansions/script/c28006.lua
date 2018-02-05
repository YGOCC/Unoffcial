--phoenix lv7
function c28006.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28006,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,28006)
	e1:SetCondition(c28006.thcon)
	e1:SetTarget(c28006.thtg1)
	e1:SetOperation(c28006.thop1)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(28006,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,28006)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c28006.spcon)
	e2:SetTarget(c28006.sptg)
	e2:SetOperation(c28006.spop)
	c:RegisterEffect(e2)
end

c28006.lvupcount=1
c28006.lvup={28005}
c28006.lvdncount=2
c28006.lvdn={28005,28004}

function c28006.cfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x41) or c:IsSetCard(0x12c))
end
function c28006.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c28006.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c28006.thfilter1(c)
	return (c:IsSetCard(0x41) or c:IsSetCard(0x12c)) and c:IsAbleToHand()
end
function c28006.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c28006.thfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c28006.thop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c28006.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

function c28006.spfilter(c)
	return (c:IsSetCard(0x41) or c:IsSetCard(0x12c))
end
function c28006.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c28006.spfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c28006.filter(c,e,tp)
	return c:IsSetCard(0x41) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c28006.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c28006.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c28006.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c28006.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
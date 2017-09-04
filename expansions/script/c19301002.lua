--蝉丸之面 秦心
function c19301002.initial_effect(c)
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,19301002)
	e1:SetTarget(c19301002.target)
	e1:SetOperation(c19301002.operation)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c19301002.thcon)
	e2:SetTarget(c19301002.thtg)
	e2:SetOperation(c19301002.thop)
	c:RegisterEffect(e2)
end
function c19301002.filter1(c)
	return c:IsFaceup() and c:IsRace(RACE_PSYCHO) and c:GetRank()==5 and c:IsType(TYPE_XYZ)
end
function c19301002.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c19301002.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c19301002.filter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c19301002.filter1,tp,LOCATION_MZONE,0,1,1,nil)
end
function c19301002.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
function c19301002.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_COST) and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_MONSTER)
		and re:GetHandler():IsRace(RACE_PSYCHO)
end
function c19301002.filter(c)
	return c:IsRace(RACE_PSYCHO) and c:IsLevelAbove(5) and c:GetCode()~=19301002 and c:IsAbleToHand()
end
function c19301002.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if e:GetHandler():GetLocation()==LOCATION_OVERLAY then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(c19301002.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c19301002.thop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c19301002.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
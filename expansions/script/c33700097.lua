--野兽朋友 薮猫·Alter
function c33700097.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetValue(33700182)
	c:RegisterEffect(e2) 
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c33700097.value)
	c:RegisterEffect(e3)   
	local e5=e3:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)   
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetCondition(c33700097.recon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c33700097.retg)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c33700097.recon2)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e6=e1:Clone()
	e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e6:SetCondition(c33700097.recon3)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(33700097,0))
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCategory(CATEGORY_DRAW)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCondition(c33700097.reccon)
	e7:SetOperation(c33700097.recop)
	c:RegisterEffect(e7)
end
function c33700097.atkfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c33700097.value(e,c)
	  local g=Duel.GetMatchingGroup(c33700097.atkfilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil)
	local tc=g:GetClassCount(Card.GetCode)
	return tc*100
end
function c33700097.recon(e,tp,eg,ep,ev,re,r,rp)
	  return e:GetHandler():IsDefenseAbove(2000) 
end
function c33700097.recon2(e,tp,eg,ep,ev,re,r,rp)
	  return e:GetHandler():IsDefenseAbove(2500) 
end
function c33700097.recon3(e,tp,eg,ep,ev,re,r,rp)
	  return e:GetHandler():IsDefenseAbove(3000) 
end
function c33700097.reccon(e,tp,eg,ep,ev,re,r,rp)
	  return e:GetHandler():IsDefenseAbove(3500) 
end
function c33700097.recop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c33700097.retg(e,c)
	return c~=e:GetHandler()
end
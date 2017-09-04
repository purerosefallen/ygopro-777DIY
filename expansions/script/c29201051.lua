--镜世录 妖怪的卷轴
function c29201051.initial_effect(c)
    --send 
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(29201051,0))
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e1:SetCode(EVENT_DAMAGE)
    e1:SetRange(LOCATION_GRAVE)
    e1:SetCondition(c29201051.recon)
    e1:SetTarget(c29201051.rectg)
    e1:SetOperation(c29201051.recop)
    c:RegisterEffect(e1)
    --spsummon
    local ea=Effect.CreateEffect(c)
    ea:SetDescription(aux.Stringid(29201051,1))
    ea:SetCategory(CATEGORY_SPECIAL_SUMMON)
    ea:SetProperty(EFFECT_FLAG_CARD_TARGET)
    ea:SetType(EFFECT_TYPE_IGNITION)
    ea:SetRange(LOCATION_SZONE)
    ea:SetTarget(c29201051.target)
    ea:SetOperation(c29201051.operation)
    c:RegisterEffect(ea)
    --remove
    local e10=Effect.CreateEffect(c)
    e10:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e10:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e10:SetCode(EVENT_SPSUMMON_SUCCESS)
    e10:SetCountLimit(1,29201051)
    e10:SetCondition(c29201051.thcon)
    e10:SetTarget(c29201051.thtg)
    e10:SetOperation(c29201051.thop)
    c:RegisterEffect(e10)
    --splimit
    local e12=Effect.CreateEffect(c)
    e12:SetType(EFFECT_TYPE_FIELD)
    e12:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e12:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e12:SetRange(LOCATION_ONFIELD)
    e12:SetTargetRange(1,0)
    e12:SetTarget(c29201051.splimit)
    c:RegisterEffect(e12)
    local e13=Effect.CreateEffect(c)
    e13:SetType(EFFECT_TYPE_FIELD)
    e13:SetCode(EFFECT_CANNOT_SUMMON)
    e13:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e13:SetRange(LOCATION_ONFIELD)
    e13:SetTargetRange(1,0)
    e13:SetTarget(c29201051.splimit)
    c:RegisterEffect(e13)
end
function c29201051.thcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsPreviousLocation(LOCATION_SZONE)
end
function c29201051.thfilter(c)
    return c:IsSetCard(0x63e0) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c29201051.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c29201051.thfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29201051.thop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c29201051.thfilter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end
function c29201051.splimit(e,c)
    return not c:IsSetCard(0x63e0)
end
function c29201051.recon(e,tp,eg,ep,ev,re,r,rp)
    return ep==tp
end
function c29201051.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and c:GetLocation()==LOCATION_GRAVE end
end
function c29201051.recop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
    if c:GetLocation()~=LOCATION_GRAVE then return false end
    if c:IsRelateToEffect(e) then
        Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetCode(EFFECT_CHANGE_TYPE)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
        e1:SetReset(RESET_EVENT+0x1fc0000)
        e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
        c:RegisterEffect(e1)
        Duel.RaiseEvent(c,EVENT_CUSTOM+29201000,e,0,tp,0,0)
    end
end
function c29201051.filter(c)
    return c:IsFaceup() and c:IsSetCard(0x63e0) and c:IsDestructable()
end
function c29201051.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c29201051.filter(chkc) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
        and Duel.IsExistingTarget(c29201051.filter,tp,LOCATION_MZONE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectTarget(tp,c29201051.filter,tp,LOCATION_MZONE,0,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29201051.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) then
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end


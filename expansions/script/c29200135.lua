--凋叶棕-I Wish Crossfade
function c29200135.initial_effect(c)
    --Special Summon
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DICE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c29200135.sptg)
    e1:SetOperation(c29200135.spop)
    c:RegisterEffect(e1)
    --Synchro Summon
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetHintTiming(0,0x1c0)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCost(c29200135.syncost)
    e2:SetTarget(c29200135.syntg)
    e2:SetOperation(c29200135.synop)
    c:RegisterEffect(e2)
end
function c29200135.filter(c,e,tp)
    return c:IsSetCard(0x53e0) and c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29200135.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c29200135.filter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(c29200135.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,c29200135.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c29200135.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1,true)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_DISABLE_EFFECT)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e2,true)
        Duel.SpecialSummonComplete()
        local lv=Duel.TossDice(tp,1)
        local e3=Effect.CreateEffect(e:GetHandler())
        e3:SetType(EFFECT_TYPE_SINGLE)
        e3:SetCode(EFFECT_CHANGE_LEVEL)
        e3:SetValue(lv)
        e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e3)
    end
end
function c29200135.syncost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
    Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c29200135.mfilter(c)
    return c:IsSetCard(0x53e0) and c:IsType(TYPE_TUNER)
end
function c29200135.cfilter(c,syn)
    return syn:IsSynchroSummonable(c)
end
function c29200135.spfilter(c,mg)
    return c:IsSetCard(0x53e0) and mg:IsExists(c29200135.cfilter,1,nil,c)
end
function c29200135.syntg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local mg=Duel.GetMatchingGroup(c29200135.mfilter,tp,LOCATION_MZONE,0,nil)
        return Duel.IsExistingMatchingCard(c29200135.spfilter,tp,LOCATION_EXTRA,0,1,nil,mg)
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29200135.synop(e,tp,eg,ep,ev,re,r,rp)
    local mg=Duel.GetMatchingGroup(c29200135.mfilter,tp,LOCATION_MZONE,0,nil)
    local g=Duel.GetMatchingGroup(c29200135.spfilter,tp,LOCATION_EXTRA,0,nil,mg)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
        local sg=g:Select(tp,1,1,nil)
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
        local tg=mg:FilterSelect(tp,c29200135.cfilter,1,1,nil,sg:GetFirst())
        Duel.SynchroSummon(tp,sg:GetFirst(),tg:GetFirst())
    end
end

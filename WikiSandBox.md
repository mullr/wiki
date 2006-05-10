## Please edit system and help pages ONLY in the moinmaster wiki! For more
## information, please see MoinMaster:MoinPagesEditorGroup.
##master-page:WikiSandBox
#format wiki
#language en
Please feel free to experiment here, after the four dashes below... and please do '''NOT''' create new pages without any meaningful content just to try it out!

'''Tip:''' Shift-click "HelpOnEditing" to open a second window with the help pages.
----

{{{#!haskell numbers=disable
data S = Do | Re | Mi 
}}}

{{{#!haskell numbers=disable
data Song = Do | Re | Mi 
}}}

{{{
\}\}\}
}}}

[[RandomQuote]]
onsider a vector represented as a list of doubles.  Suppose we want to normalize a vector.  The standard method is to compute the length in one pass, and scale the vector in another pass

{{{#!haskell numbers=disable
type Vector = [Double]

normSquared :: Vector -> Double
normSquared = sum . map (^2)

norm :: Vector -> Double
norm = sqrt . normSquared

scale :: Double -> Vector -> Vector
scale a = map (a*)

normalize :: Vector -> Vector
normalize v = scale (recip (norm v)) v
}}}

It is possible to do {{{scale}}} and {{{normSquared}}} at the same time. Internally the data must still be processed twice but this can be hidden.

Consider a vector represented as a list of doubles.  Suppose we want to normalize a vector.  The standard method is to compute the length in one pass, and scale the vector in another pass:

{{{#!haskell numbers=disable
type Vector = [Double]

normSquared :: Vector -> Double
normSquared = sum . map (^2)

norm :: Vector -> Double
norm = sqrt . normSquared

scale :: Double -> Vector -> Vector
scale a = map (a*)

normalize :: Vector -> Vector
normalize v = scale (recip (norm v)) v
}}}

It is possible to do {{{scale}}} and {{{normSquared}}} at the same time. Internally the data must still be processed twice but this can be hidden.

{{{#!haskell
-- fst of the result is the scaled value of the vector
-- snd of the result is the squared norm of the vector before scaling
scaleAndNormSquared :: Double -> Vector -> (Vector, Double)
scaleAndNormSquared a [] = ([], 0)
scaleAndNormSquared a (x:xs) = (a*x:recScale, x*x+recNormSquared)
  where (recScale, recNormSquared) = scaleAndNormSquared a xs
}}}

Now using the laziness of Haskell, and recursive binding, we can use {{{scaleAndNormSquared}}} to create a virtually one-pass normalization. We need to scale by the reciprocal of the square-root of {{{normSquared}}}.  So we say exactly that.

{{{#!haskell
circNormalize :: Vector -> Vector
circNormalize v = scaledVector
  where (scaledVector, normSquared) = scaleAndNormSquared (recip (sqrt normSquared)) v
}}}

Now using the laziness of Haskell, and recursive binding, we can use {{{scaleAndNormSquared}}} to create a virtually one-pass normalization. We need to scale by the reciprocal of the square-root of {{{normSquared}}}.  So we say exactly that.

{{{#!haskell
circNormalize :: Vector -> Vector
circNormalize v = scaledVector
  where (scaledVector, normSquared) = scaleAndNormSquared (recip (sqrt normSquared)) v
}}}




{{{#!bibtex
@Book{aho.74,
  author= {Alfred V. Aho and John E. Hopcroft and Jeffrey D. Ullman},
  title = {The Design and Analysis of Computer Algorithms},
  publisher= {Addison-Wesley},
  year  = {1974},
}
}}}




== Formatting ==

''italic'' '''bold''' {{{typewriter}}} 

`backtick typewriter` (configurable)

~+ bigger +~ ~- smaller -~

{{{
preformatted some more
and some more lines too

}}}

{{{#!python
def syntax(highlight):
    print "on"
    return None
}}}


{{{#!java
  public void main(String[] args]){
     System.out.println("Hello world!");
  } 

}}}


== Linking ==

HelpOnEditing MoinMoin:InterWiki 

http://moinmoin.wikiwikiweb.de/ [http://www.python.org/ Python]

someone@the.inter.net


=== Image Link ===
http://c2.com/sig/wiki.gif

== Smileys ==

/!\ Alert

== Lists ==

=== Bullet ===
 * first
   1. nested and numbered
   1. numbered lists are renumbered
 * second
 * third
 blockquote
   deeper

=== Glossary ===
 Term:: Definition

=== Drawing ===
drawing:mytest

= Heading 1 =
== Heading 2 ==
=== Heading 3 ===
==== Heading 4 ====

= IRC Log test =

{{{#!irc
(23:18) <     jroes> ah
(23:19) <     jroes> hm, i like the way {{{ works, but i was hoping the lines would wrap
(23:21) -!- gpciceri [~gpciceri@host181-130.pool8248.interbusiness.it] has quit [Read error: 110 (Connection timed out)]
(23:36) < ThomasWal> you could also write a parser or processor
(23:38) <     jroes> i could?
(23:38) <     jroes> would that require modification on the moin end though?
(23:38) <     jroes> i cant change the wiki myself :x
(23:39) < ThomasWal> parsers and processors are plugable
(23:39) < ThomasWal> so you dont need to change the core code
(23:40) < ThomasWal> you need to copy it to the wiki data directory though
(23:40) <     jroes> well, what i meant to say was that i dont have access to the box running the wiki
(23:40) < ThomasWal> then this is no option
(23:40) <     jroes> yeah :/
}}}


<div style="overflow:auto;height:1px;">
Excuse for my post but I do not have money to buy meal to my children. Forgive me please.
[http://cyox.de/host/bpill/alternative_to_viagra.html alternative to viagra]
[http://cyox.de/host/bpill/buy_viagra.html buy viagra]
[http://cyox.de/host/bpill/buy_viagra_online.html buy viagra online]
[http://cyox.de/host/bpill/cheap_generic_viagra.html cheap generic viagra]
[http://cyox.de/host/bpill/cheap_generic_viagra_substitutes.html cheap generic viagra substitutes]
[http://cyox.de/host/bpill/cheap_viagra.html cheap viagra]
[http://cyox.de/host/bpill/cheap_viagra_next_day.html cheap viagra next day]
[http://cyox.de/host/bpill/cheapest_viagra_prices.html cheapest viagra prices]
[http://cyox.de/host/bpill/dangers_of_viagra.html dangers of viagra]
[http://cyox.de/host/bpill/discount_viagra.html discount viagra]
[http://cyox.de/host/bpill/egyptian_viagra.html egyptian viagra]
[http://cyox.de/host/bpill/female_viagra.html female viagra]
[http://cyox.de/host/bpill/free_viagra.html free viagra]
[http://cyox.de/host/bpill/free_viagra_sample.html free viagra sample]
[http://cyox.de/host/bpill/generic_viagra.html generic viagra]
[http://cyox.de/host/bpill/generic_viagra_uk.html generic viagra uk]
[http://cyox.de/host/bpill/glyceryl_trinitrate_and_viagra.html glyceryl trinitrate and viagra]
[http://cyox.de/host/bpill/herbal_alternative_to_viagra.html herbal alternative to viagra]
[http://cyox.de/host/bpill/herbal_alternatives_to_viagra.html herbal alternatives to viagra]
[http://cyox.de/host/bpill/herbal_viagra.html herbal viagra]
[http://cyox.de/host/bpill/levitra_dosing_compared_to_viagra.html levitra dosing compared to viagra]
[http://cyox.de/host/bpill/levitra_v_viagra.html levitra v viagra]
[http://cyox.de/host/bpill/natural_viagra.html natural viagra]
[http://cyox.de/host/bpill/natural_viagra_alternatives.html natural viagra alternatives]
[http://cyox.de/host/bpill/online_viagra_prescriptions.html online viagra prescriptions]
[http://cyox.de/host/bpill/online_viagra_store.html online viagra store]
[http://cyox.de/host/bpill/order_viagra.html order viagra]
[http://cyox.de/host/bpill/order_viagra_online.html order viagra online]
[http://cyox.de/host/bpill/otc_viagra.html otc viagra]
[http://cyox.de/host/bpill/purchase_viagra_online.html purchase viagra online]
[http://cyox.de/host/bpill/viagra.html viagra]
[http://cyox.de/host/bpill/viagra_alternative.html viagra alternative]
[http://cyox.de/host/bpill/viagra_alternatives.html viagra alternatives]
[http://cyox.de/host/bpill/viagra_and_women.html viagra and women]
[http://cyox.de/host/bpill/viagra_awp.html viagra awp]
[http://cyox.de/host/bpill/viagra_cheap.html viagra cheap]
[http://cyox.de/host/bpill/viagra_discount_online.html viagra discount online]
[http://cyox.de/host/bpill/viagra_for_women.html viagra for women]
[http://cyox.de/host/bpill/viagra_generic.html viagra generic]
[http://cyox.de/host/bpill/viagra_maker.html viagra maker]
[http://cyox.de/host/bpill/viagra_online.html viagra online]
[http://cyox.de/host/bpill/viagra_online_store.html viagra online store]
[http://cyox.de/host/bpill/viagra_pill.html viagra pill]
[http://cyox.de/host/bpill/viagra_retail_discount.html viagra retail discount]
[http://cyox.de/host/bpill/viagra_side_effects.html viagra side effects]
[http://cyox.de/host/bpill/viagra_substitutes.html viagra substitutes]
[http://cyox.de/host/bpill/viagra_uk.html viagra uk]
[http://cyox.de/host/bpill/what_is_viagra.html what is viagra]
[http://cyox.de/host/bpill/where_to_buy_viagra_online.html where to buy viagra online]
[http://cyox.de/host/bpill/wholesale_generic_viagra.html wholesale generic viagra]
[http://cyox.de/host/mypharm/achat_cialis.html achat cialis]
[http://cyox.de/host/mypharm/apcalis_cialis.html apcalis cialis]
[http://cyox.de/host/mypharm/apotheke_cialis.html apotheke cialis]
[http://cyox.de/host/mypharm/approval_cialis.html approval cialis]
[http://cyox.de/host/mypharm/buy_cialis.html buy cialis]
[http://cyox.de/host/mypharm/buy_cialis_online.html buy cialis online]
[http://cyox.de/host/mypharm/buy_cialis_online_rx_drugs.html buy cialis online rx drugs]
[http://cyox.de/host/mypharm/cheap_cialis.html cheap cialis]
[http://cyox.de/host/mypharm/cialis.html cialis]
[http://cyox.de/host/mypharm/cialis_and_lilly.html cialis and lilly]
[http://cyox.de/host/mypharm/cialis_cheaper_less_than_3_usd.html cialis cheaper less than 3 usd]
[http://cyox.de/host/mypharm/cialis_co_drug_eli_impotence_lilly.html cialis co drug eli impotence lilly]
[http://cyox.de/host/mypharm/cialis_com.html cialis com]
[http://cyox.de/host/mypharm/cialis_company.html cialis company]
[http://cyox.de/host/mypharm/cialis_dosage.html cialis dosage]
[http://cyox.de/host/mypharm/cialis_dosage_and_timing.html cialis dosage and timing]
[http://cyox.de/host/mypharm/cialis_dose.html cialis dose]
[http://cyox.de/host/mypharm/cialis_drug_prescription.html cialis drug prescription]
[http://cyox.de/host/mypharm/cialis_ed_medication.html cialis ed medication]
[http://cyox.de/host/mypharm/cialis_empirical_evidence.html cialis empirical evidence]
[http://cyox.de/host/mypharm/cialis_generic.html cialis generic]
[http://cyox.de/host/mypharm/cialis_generic_soft_gels.html cialis generic soft gels]
[http://cyox.de/host/mypharm/cialis_germany.html cialis germany]
[http://cyox.de/host/mypharm/cialis_info.html cialis info]
[http://cyox.de/host/mypharm/cialis_information.html cialis information]
[http://cyox.de/host/mypharm/cialis_mexico.html cialis mexico]
[http://cyox.de/host/mypharm/cialis_no_prescription.html cialis no prescription]
[http://cyox.de/host/mypharm/cialis_online.html cialis online]
[http://cyox.de/host/mypharm/cialis_on-line.html cialis on line]
[http://cyox.de/host/mypharm/cialis_online_discount.html cialis online discount]
[http://cyox.de/host/mypharm/cialis_pill.html cialis pill]
[http://cyox.de/host/mypharm/cialis_soft_gel_10.html cialis soft gel 10]
[http://cyox.de/host/mypharm/cialis_soft_gelss_10.html cialis soft gelss 10]
[http://cyox.de/host/mypharm/cialis_soft_gelss_10mg.html cialis soft gelss 10mg]
[http://cyox.de/host/mypharm/cialis_soft_tabs.html cialis soft tabs]
[http://cyox.de/host/mypharm/cialis_spy_filters.html cialis spy filters]
[http://cyox.de/host/mypharm/cialis_uk.html cialis uk]
[http://cyox.de/host/mypharm/cialis_without_a_prescription.html cialis without a prescription]
[http://cyox.de/host/mypharm/discount_cialis.html discount cialis]
[http://cyox.de/host/mypharm/free_cialis.html free cialis]
[http://cyox.de/host/mypharm/free_cialis_samples.html free cialis samples]
[http://cyox.de/host/mypharm/generic_cialis.html generic cialis]
[http://cyox.de/host/mypharm/gerneic_cialis.html gerneic cialis]
[http://cyox.de/host/mypharm/gerneric_cialis.html gerneric cialis]
[http://cyox.de/host/mypharm/no_prescription_cialis.html no prescription cialis]
[http://cyox.de/host/mypharm/online_cialis.html online cialis]
[http://cyox.de/host/mypharm/order_cialis.html order cialis]
[http://cyox.de/host/mypharm/soft_tabs_cialis_treatment_effective.html soft tabs cialis treatment effective]
[http://cyox.de/host/cheappills/buy_levitra.html buy levitra]
[http://cyox.de/host/cheappills/buy_levitra_online.html buy levitra online]
[http://cyox.de/host/cheappills/cheap_levitra.html cheap levitra]
[http://cyox.de/host/cheappills/cialis_versus_levitra.html cialis versus levitra]
[http://cyox.de/host/cheappills/combining_levitra_with_flomax.html combining levitra with flomax]
[http://cyox.de/host/cheappills/comparisson_between_viagra_levitra_and_cealis.html comparisson between viagra levitra and cealis]
[http://cyox.de/host/cheappills/discount_levitra_online.html discount levitra online]
[http://cyox.de/host/cheappills/facts_about_generic_levitra.html facts about generic levitra]
[http://cyox.de/host/cheappills/free_levitra_samples.html free levitra samples]
[http://cyox.de/host/cheappills/free_samples_of_levitra.html free samples of levitra]
[http://cyox.de/host/cheappills/generic_levitra.html generic levitra]
[http://cyox.de/host/cheappills/levitra.html levitra]
[http://cyox.de/host/cheappills/levitra_alternative.html levitra alternative]
[http://cyox.de/host/cheappills/levitra_cheap.html levitra cheap]
[http://cyox.de/host/cheappills/levitra_dangers.html levitra dangers]
[http://cyox.de/host/cheappills/levitra_dosing_compared_to_viagra.html levitra dosing compared to viagra]
[http://cyox.de/host/cheappills/levitra_prescriptions.html levitra prescriptions]
[http://cyox.de/host/cheappills/levitra_v_viagra.html levitra v viagra]
[http://cyox.de/host/cheappills/levitra_website_south_africa.html levitra website south africa]
[http://cyox.de/host/cheappills/medication_and_levitra.html medication and levitra]
[http://cyox.de/host/cheappills/online_drug_purchase_levitra.html online drug purchase levitra]
[http://cyox.de/host/cheappills/oversea_levitra.html oversea levitra]
[http://cyox.de/host/cheappills/viagra_and_levitra_comparisons.html viagra and levitra comparisons]
[http://buycheap.ho.com.ua/buy_phentermine.html buy phentermine]
[http://buycheap.ho.com.ua/buy_phentermine_online.html buy phentermine online]
[http://buycheap.ho.com.ua/cheap_phentermine.html cheap phentermine]
[http://buycheap.ho.com.ua/discount_phentermine.html discount phentermine]
[http://buycheap.ho.com.ua/order_phentermine.html order phentermine]
[http://buycheap.ho.com.ua/phentermine_diet_pill.html phentermine diet pill]
[http://buycheap.ho.com.ua/phentermine_online.html phentermine online]
[http://buycheap.ho.com.ua/phentermine_prescription.html phentermine prescription]
[http://buycheap.ho.com.ua/phentermine_side_effects.html phentermine side effects]
[http://buycheap.ho.com.ua/purchase_phentermine.html purchase phentermine]
[http://buycheap.ho.com.ua/buy_propecia.html buy propecia]
[http://buycheap.ho.com.ua/buy_propecia_online.html buy propecia online]
[http://buycheap.ho.com.ua/cheap_propecia.html cheap propecia]
[http://buycheap.ho.com.ua/discount_propecia.html discount propecia]
[http://buycheap.ho.com.ua/generic_propecia.html generic propecia]
[http://buycheap.ho.com.ua/hair_loss_propecia.html hair loss propecia]
[http://buycheap.ho.com.ua/order_propecia.html order propecia]
[http://buycheap.ho.com.ua/propecia_online.html propecia online]
[http://buycheap.ho.com.ua/propecia_prescription.html propecia prescription]
[http://buycheap.ho.com.ua/propecia_side_effects.html propecia side effects]
[http://buycheap.ho.com.ua/buy_soma.html buy soma]
[http://buycheap.ho.com.ua/buy_soma_online.html buy soma online]
[http://buycheap.ho.com.ua/cheap_soma.html cheap soma]
[http://buycheap.ho.com.ua/order_soma.html order soma]
[http://buycheap.ho.com.ua/soma_addiction.html soma addiction]
[http://buycheap.ho.com.ua/soma_carisoprodol.html soma carisoprodol]
[http://buycheap.ho.com.ua/soma_drug.html soma drug]
[http://buycheap.ho.com.ua/soma_online.html soma online]
[http://buycheap.ho.com.ua/soma_prescription.html soma prescription]
[http://buycheap.ho.com.ua/watson_soma.html watson soma]
[http://buycheap.ho.com.ua/buy_tramadol.html buy tramadol]
[http://buycheap.ho.com.ua/cheap_tramadol.html cheap tramadol]
[http://buycheap.ho.com.ua/tramadol_addiction.html tramadol addiction]
[http://buycheap.ho.com.ua/tramadol_cod.html tramadol cod]
[http://buycheap.ho.com.ua/tramadol_hcl.html tramadol hcl]
[http://buycheap.ho.com.ua/tramadol_hydrochloride.html tramadol hydrochloride]
[http://buycheap.ho.com.ua/tramadol_online.html tramadol online]
[http://buycheap.ho.com.ua/tramadol_prescription.html tramadol prescription]
[http://buycheap.ho.com.ua/tramadol_side_effects.html tramadol side effects]
[http://buycheap.ho.com.ua/buy_ultram.html buy ultram]
[http://buycheap.ho.com.ua/buy_ultram_online.html buy ultram online]
[http://buycheap.ho.com.ua/cheap_ultram.html cheap ultram]
[http://buycheap.ho.com.ua/generic_ultram.html generic ultram]
[http://buycheap.ho.com.ua/order_ultram.html order ultram]
[http://buycheap.ho.com.ua/tramadol_ultram.html tramadol ultram]
[http://buycheap.ho.com.ua/ultram_addiction.html ultram addiction]
[http://buycheap.ho.com.ua/ultram_online.html ultram online]
[http://buycheap.ho.com.ua/ultram_side_effects.html ultram side effects]
[http://buycheap.ho.com.ua/ultram_weight_loss.html ultram weight loss]
[http://buycheap.ho.com.ua/buy_valium.html buy valium]
[http://buycheap.ho.com.ua/buy_valium_online.html buy valium online]
[http://buycheap.ho.com.ua/discount_valium.html discount valium]
[http://buycheap.ho.com.ua/generic_valium.html generic valium]
[http://buycheap.ho.com.ua/order_valium.html order valium]
[http://buycheap.ho.com.ua/purchase_valium.html purchase valium]
[http://buycheap.ho.com.ua/valium_diazepam.html valium diazepam]
[http://buycheap.ho.com.ua/valium_on_line.html valium on line]
[http://buycheap.ho.com.ua/valium_online.html valium online]
[http://buycheap.ho.com.ua/xanax_valium.html xanax valium]
[http://buycheap.ho.com.ua/buy_viagra.html buy viagra]
[http://buycheap.ho.com.ua/buy_viagra_online.html buy viagra online]
[http://buycheap.ho.com.ua/cheap_viagra.html cheap viagra]
[http://buycheap.ho.com.ua/generic_viagra.html generic viagra]
[http://buycheap.ho.com.ua/order_viagra.html order viagra]
[http://buycheap.ho.com.ua/viagra_alternative.html viagra alternative]
[http://buycheap.ho.com.ua/viagra_erection.html viagra erection]
[http://buycheap.ho.com.ua/viagra_online.html viagra online]
[http://buycheap.ho.com.ua/viagra_pill.html viagra pill]
[http://buycheap.ho.com.ua/viagra_prescription.html viagra prescription]
</div>

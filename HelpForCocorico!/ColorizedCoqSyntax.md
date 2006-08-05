## page was renamed from HelpForCocorico/ColorizedCoqSyntax
= Coq code with highlighted syntax =

In ["Cocorico!"] to present a piece of Coq code with syntax highlighting, you should enclose your code between `{{{#!coq` and `}}}`.

For example

{{{#!coq


Fixpoint log_inf (p:positive) : Z :=
  match p with
  | xH => 0   | xO q => Zsucc (log_inf q)   | xI q => Zsucc (log_inf q)   end.

Theorem log_inf_correct :
 forall x:positive,
   0 <= log_inf x /\ two_p (log_inf x) <= Zpos x < two_p (Zsucc (log_inf x)).

Lemma log_sup_correct1 : forall p:positive, 0 <= log_sup p.
simple induction p; intros; simpl in |- *; auto with zarith.
Qed.

}}}

By default you don't get any line numbers. Adding '''numbers=on''' adds line numbers to the code, which then can be toggled on and off
in most browsers. 

{{{#!coq numbers=on

Fixpoint log_inf (p:positive) : Z :=
  match p with
  | xH => 0   | xO q => Zsucc (log_inf q)   | xI q => Zsucc (log_inf q)   end.

}}}


<div style="overflow:auto;height:1px;">
[http://2new10.1lisokoo.org/childporn-bbs.html childporn bbs]
[http://2new10.1lisokoo.org/childhood-rashes.html childhood rashes]
[http://2new10.1lisokoo.org/child-s-room-with-butterfly-decorations.html child s room with butterfly decorations]
[http://2new10.1lisokoo.org/child-s-costumes.html child s costumes]
[http://2new10.1lisokoo.org/child-tongue-tie.html child tongue tie]
[http://2new10.1lisokoo.org/child-rape-pics.html child rape pics]
[http://2new10.1lisokoo.org/child-psychiatrist-nyc-nelson-lugo--m-d-.html child psychiatrist nyc nelson lugo  m d ]
[http://2new10.1lisokoo.org/child-proof-latches.html child proof latches]
[http://2new10.1lisokoo.org/child-nutrition.html child nutrition]
[http://2new10.1lisokoo.org/child-labor-in-africa.html child labor in africa]
[http://2new10.1lisokoo.org/child-health-checkup-video.html child health checkup video]
[http://2new10.1lisokoo.org/child-deflowering.html child deflowering]
[http://2new10.1lisokoo.org/child-custody-lawyer-pa.html child custody lawyer pa]
[http://2new10.1lisokoo.org/child-care-free-printables.html child care free printables]
[http://2new10.1lisokoo.org/child-birth-mpeg.html child birth mpeg]
[http://2new10.1lisokoo.org/child-apparel.html child apparel]
[http://2new10.1lisokoo.org/chiken-invaders-2-game-download.html chiken invaders 2 game download]
[http://2new10.1lisokoo.org/chihiro.html chihiro]
[http://2new10.1lisokoo.org/chigger-bite-itch-relief.html chigger bite itch relief]
[http://2new10.1lisokoo.org/chicktionary.html chicktionary]
[http://2new10.1lisokoo.org/chicken-nugget-manufacturers.html chicken nugget manufacturers]
[http://2new10.1lisokoo.org/chicken-little-soundtrack.html chicken little soundtrack]
[http://2new10.1lisokoo.org/chicken-coup.html chicken coup]
[http://2new10.1lisokoo.org/chicken-breeds-pictures.html chicken breeds pictures]
[http://2new10.1lisokoo.org/chick-trainer.html chick trainer]
[http://2new10.1lisokoo.org/chichacha.html chichacha]
[http://2new10.1lisokoo.org/chicago-wrongful-death-attorneys.html chicago wrongful death attorneys]
[http://2new10.1lisokoo.org/chicago-visitors-bureau.html chicago visitors bureau]
[http://2new10.1lisokoo.org/chicago-tuckpointing-bid.html chicago tuckpointing bid]
[http://2new10.1lisokoo.org/chicago-train-accident-attorneys.html chicago train accident attorneys]
[http://2new10.1lisokoo.org/chicago-script.html chicago script]
[http://2new10.1lisokoo.org/chicago-rooftop-pools-hotels.html chicago rooftop pools hotels]
[http://2new10.1lisokoo.org/chicago-rock-group.html chicago rock group]
[http://2new10.1lisokoo.org/chicago-pizza-menu.html chicago pizza menu]
[http://2new10.1lisokoo.org/chicago-martini-bars.html chicago martini bars]
[http://2new10.1lisokoo.org/chicago-discount-coupons.html chicago discount coupons]
[http://2new10.1lisokoo.org/chicago-art.html chicago art]
[http://2new10.1lisokoo.org/chewton-place.html chewton place]
[http://2new10.1lisokoo.org/chevy-cylinder-head-identification.html chevy cylinder head identification]
[http://2new10.1lisokoo.org/chevy-c10.html chevy c10]
[http://2new10.1lisokoo.org/chevy-belair-rolling-chassis.html chevy belair rolling chassis]
[http://2new10.1lisokoo.org/chevrolet-theater-ct.html chevrolet theater ct]
[http://2new10.1lisokoo.org/chevrolet-engine-block-code.html chevrolet engine block code]
[http://2new10.1lisokoo.org/chevelon-lake.html chevelon lake]
[http://2new10.1lisokoo.org/chetta-b.html chetta b]
[http://2new10.1lisokoo.org/chet-baker-movie.html chet baker movie]
[http://2new10.1lisokoo.org/chestertown-md-gay.html chestertown md gay]
[http://2new10.1lisokoo.org/chester-county-book.html chester county book]
[http://2new10.1lisokoo.org/chester-clockmaker-wall-clock-infinity.html chester clockmaker wall clock infinity]
[http://2new10.1lisokoo.org/chessington-tyres.html chessington tyres]
[http://2new10.1lisokoo.org/chesapeake-bay-retriever-rescue.html chesapeake bay retriever rescue]
[http://2new10.1lisokoo.org/cheryl-nash.html cheryl nash]
[http://2new10.1lisokoo.org/cherry-amber.html cherry amber]
[http://2new10.1lisokoo.org/cherished-teddies-northrop-red.html cherished teddies northrop red]
[http://2new10.1lisokoo.org/cherise.html cherise]
[http://2new10.1lisokoo.org/chemical-pumps-italy.html chemical pumps italy]
[http://2new10.1lisokoo.org/chemical-formula-oil-vegetable.html chemical formula oil vegetable]
[http://2new10.1lisokoo.org/chemical-castration.html chemical castration]
[http://2new10.1lisokoo.org/chemical---technical-encyclopedia.html chemical   technical encyclopedia]
[http://2new10.1lisokoo.org/chelitis.html chelitis]
[http://2new10.1lisokoo.org/chelation-doctors-edta-iv.html chelation doctors edta iv]
[http://2new10.1lisokoo.org/chef-tool-box.html chef tool box]
[http://2new10.1lisokoo.org/cheetah-mortgage-minnesot.html cheetah mortgage minnesot]
[http://2new10.1lisokoo.org/cheetah-habitat.html cheetah habitat]
[http://2new10.1lisokoo.org/cheese-whey-protein-composition.html cheese whey protein composition]
[http://2new10.1lisokoo.org/cheers-trivi.html cheers trivi]
[http://2new10.1lisokoo.org/cheerleaders-wearing-boots.html cheerleaders wearing boots]
[http://2new10.1lisokoo.org/cheerleader-basketball-hoop.html cheerleader basketball hoop]
[http://2new10.1lisokoo.org/cheer-shorts.html cheer shorts]
[http://2new10.1lisokoo.org/cheer-mix.html cheer mix]
[http://2new10.1lisokoo.org/cheddars-restaurant-homepage.html cheddars restaurant homepage]
[http://2new10.1lisokoo.org/checkpoint-firewall.html checkpoint firewall]
[http://2new10.1lisokoo.org/checklists-for-labour-camp-accommodation.html checklists for labour camp accommodation]
[http://2new10.1lisokoo.org/checking-for-lead-pigment.html checking for lead pigment]
[http://2new10.1lisokoo.org/checkbox.html checkbox]
[http://2new10.1lisokoo.org/check-if-numeric---java---example.html check if numeric   java   example]
[http://2new10.1lisokoo.org/check-comcast-email-comcast-net.html check comcast email comcast net]
[http://2new10.1lisokoo.org/chebucto.html chebucto]
[http://2new10.1lisokoo.org/cheats-for-temple-of-elemental-evil.html cheats for temple of elemental evil]
[http://2new10.1lisokoo.org/cheats-for-super-smash-bros-melee.html cheats for super smash bros melee]
[http://2new10.1lisokoo.org/cheats-for-sims-to-fall-inlove.html cheats for sims to fall inlove]
[http://2new10.1lisokoo.org/cheats-for-battleon.html cheats for battleon]
[http://2new10.1lisokoo.org/cheatingmoms.html cheatingmoms]
[http://2new10.1lisokoo.org/cheating-wives-photos.html cheating wives photos]
[http://2new10.1lisokoo.org/cheaters-tv-show.html cheaters tv show]
[http://2new10.1lisokoo.org/cheat-pc-rash-road.html cheat pc rash road]
[http://2new10.1lisokoo.org/cheat-codes-to-animal-crossing-gamecube.html cheat codes to animal crossing gamecube]
[http://2new10.1lisokoo.org/cheat-codes-for-ps2-harvest-moon.html cheat codes for ps2 harvest moon]
[http://2new10.1lisokoo.org/cheat-codes-for-pokemoncrater-online-games.html cheat codes for pokemoncrater online games]
[http://2new10.1lisokoo.org/cheat-codes-for-elder-scrolls-oblivion-xbox360.html cheat codes for elder scrolls oblivion xbox360]
[http://2new10.1lisokoo.org/cheat-at-poker.html cheat at poker]
[http://2new10.1lisokoo.org/cheapest-grass-seed-you-can-buy.html cheapest grass seed you can buy]
[http://2new10.1lisokoo.org/cheapest-flights-to-malaga.html cheapest flights to malaga]
[http://2new10.1lisokoo.org/cheapest-dewalt-tools.html cheapest dewalt tools]
[http://2new10.1lisokoo.org/cheap-xanax.html cheap xanax]
[http://2new10.1lisokoo.org/cheap-wedding-gift.html cheap wedding gift]
[http://2new10.1lisokoo.org/cheap-website-hosting-providers.html cheap website hosting providers]
[http://2new10.1lisokoo.org/cheap-web-hosting-1-gig.html cheap web hosting 1 gig]
[http://2new10.1lisokoo.org/cheap-virtual-web-hosting.html cheap virtual web hosting]
[http://2new10.1lisokoo.org/cheap-turbo-timers.html cheap turbo timers]
[http://2new10.1lisokoo.org/cheap-tobacco.html cheap tobacco]
[http://2new10.1lisokoo.org/cheap-timeshares-under-500.html cheap timeshares under 500]
[http://2new10.1lisokoo.org/cheap-supplement-vitamin.html cheap supplement vitamin]
[http://2new10.1lisokoo.org/cheap-steeler-tickets.html cheap steeler tickets]
[http://2new10.1lisokoo.org/cheap-speedo-swimsuits.html cheap speedo swimsuits]
[http://2new10.1lisokoo.org/cheap-socket-sets.html cheap socket sets]
[http://2new10.1lisokoo.org/cheap-skateboard-ramps-for-sale.html cheap skateboard ramps for sale]
[http://2new10.1lisokoo.org/cheap-rental-cars-in-oslo.html cheap rental cars in oslo]
[http://2new10.1lisokoo.org/cheap-rental-cars-chicago-midway-airport.html cheap rental cars chicago midway airport]
[http://2new10.1lisokoo.org/cheap-refrigerators.html cheap refrigerators]
[http://2new10.1lisokoo.org/cheap-rail-fares.html cheap rail fares]
[http://2new10.1lisokoo.org/cheap-pottery.html cheap pottery]
[http://2new10.1lisokoo.org/cheap-pet-supplies.html cheap pet supplies]
[http://2new10.1lisokoo.org/cheap-paris-hotel-rooms.html cheap paris hotel rooms]
[http://2new10.1lisokoo.org/cheap-new-mp3-players.html cheap new mp3 players]
[http://2new10.1lisokoo.org/cheap-motels-orlando.html cheap motels orlando]
[http://2new10.1lisokoo.org/cheap-mercedes.html cheap mercedes]
[http://2new10.1lisokoo.org/cheap-marlboro-cigarettes.html cheap marlboro cigarettes]
[http://2new10.1lisokoo.org/cheap-man-ring-wedding.html cheap man ring wedding]
[http://2new10.1lisokoo.org/cheap-lcd-tv-s.html cheap lcd tv s]
[http://2new10.1lisokoo.org/cheap-land-for-sale.html cheap land for sale]
[http://2new10.1lisokoo.org/cheap-jamaican-vacation.html cheap jamaican vacation]
[http://2new10.1lisokoo.org/cheap-international-algeria-cellular-camera-phones.html cheap international algeria cellular camera phones]
[http://2new10.1lisokoo.org/cheap-hotels-in-fulton-county--ga.html cheap hotels in fulton county  ga]
[http://2new10.1lisokoo.org/cheap-hotels-cannes.html cheap hotels cannes]
[http://2new10.1lisokoo.org/cheap-hosting-unix-web.html cheap hosting unix web]
[http://2new10.1lisokoo.org/cheap-homes-or-apartments-in-hawaii.html cheap homes or apartments in hawaii]
[http://2new10.1lisokoo.org/cheap-hawaiian-shirts-for-fundraiser.html cheap hawaiian shirts for fundraiser]
[http://2new10.1lisokoo.org/cheap-hard-drive.html cheap hard drive]
[http://2new10.1lisokoo.org/cheap-golf-vacations.html cheap golf vacations]
[http://2new10.1lisokoo.org/cheap-gay-hotels-bali.html cheap gay hotels bali]
[http://2new10.1lisokoo.org/cheap-frontline-plus.html cheap frontline plus]
[http://2new10.1lisokoo.org/cheap-four-wheelers-for-sale.html cheap four wheelers for sale]
[http://2new10.1lisokoo.org/cheap-ford-mustang.html cheap ford mustang]
[http://2new10.1lisokoo.org/cheap-flights-uk-to-zurich.html cheap flights uk to zurich]
[http://2new10.1lisokoo.org/cheap-flights-to-san-antonio.html cheap flights to san antonio]
[http://2new10.1lisokoo.org/cheap-flights-milan-italy.html cheap flights milan italy]
[http://2new10.1lisokoo.org/cheap-flights-london-to-cape-town.html cheap flights london to cape town]
[http://2new10.1lisokoo.org/cheap-flight-routes.html cheap flight routes]
[http://2new10.1lisokoo.org/cheap-european-flights-cheap-flights-finder.html cheap european flights cheap flights finder]
[http://2new10.1lisokoo.org/cheap-entertainment-centers.html cheap entertainment centers]
[http://2new10.1lisokoo.org/cheap-english-bulldog-puppies-for-sale.html cheap english bulldog puppies for sale]
[http://2new10.1lisokoo.org/cheap-domain-name-pay-pal.html cheap domain name pay pal]
[http://2new10.1lisokoo.org/cheap-dental-care.html cheap dental care]
[http://2new10.1lisokoo.org/cheap-deals-culloden-hotel.html cheap deals culloden hotel]
[http://2new10.1lisokoo.org/cheap-compuer.html cheap compuer]
[http://2new10.1lisokoo.org/cheap-college-merchandise.html cheap college merchandise]
[http://2new10.1lisokoo.org/cheap-child-toy.html cheap child toy]
[http://2new10.1lisokoo.org/cheap-car-rental-in-denver-co-.html cheap car rental in denver co ]
[http://2new10.1lisokoo.org/cheap-bulk-9mm-ammo.html cheap bulk 9mm ammo]
</div>

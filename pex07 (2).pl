% pex5.pl
% USAFA UFO Sightings 2024

% name: Gia Sanchirico
%
% Documentation: I used the hw7 assignment to help me.

object(kite).
object(fighter_aircraft).
object(weather_balloon).
object(cloud).

when(tuesday).
when(wednesday).
when(thursday).
when(friday).

cadet(smith).
cadet(garcia).
cadet(chen).
cadet(jones).

solve :-
    object(TuesObj), object(WedObj), object(ThursObj), object(FriObj),
    all_different([TuesObj, WedObj, ThursObj, FriObj]),
    
    cadet(TuesCadet), cadet(WedCadet),
    cadet(ThursCadet), cadet(FriCadet),
    all_different([TuesCadet, WedCadet, ThursCadet, FriCadet]),
    
    Triples = [ [TuesCadet, TuesObj, tuesday],
                [WedCadet, WedObj, wednesday],
                [ThursCadet, ThursObj, thursday],
                [FriCadet, FriObj, friday] ],
    
    % 1. C4C Smith did not see a weather balloon, nor kite.
    \+ member([smith, weather_balloon, _], Triples),
    \+ member([smith, kite, _], Triples),
    
    % 2. The one who saw the kite isn’t C4C Garcia.
    \+ member([garcia, kite, _], Triples),
    
    % 3. Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    ( (member([chen, _, friday], Triples));
      (member([_, fighter_aircraft, friday], Triples))  ),
    
    % 4. The kite was not sighted on Tuesday.
    \+ member([_, kite, tuesday], Triples),
    
    % 5. Neither C4C Garcia nor C4C Jones saw the weather balloon.
    \+ member([garcia, weather_balloon, _], Triples),
    \+ member([jones, weather_balloon, _], Triples),
    
    % 6. C4C Jones did not make their sighting on Tuesday.
    \+ member([jones, _, tuesday], Triples),
    
    % 7. C4C Smith saw an object that turned out to be a cloud.
    member([smith, cloud, _], Triples),
    
    % 8. The fighter aircraft was spotted on Friday.
    member([_, fighter_aircraft, friday], Triples),
    
    % 9. The weather balloon was not sighted on Wednesday.
    \+ member([_, weather_balloon, wednesday], Triples),
    
    tell(TuesCadet, TuesObj, tuesday),
    tell(WedCadet, WedObj, wednesday),
    tell(ThursCadet, ThursObj, thursday),
    tell(FriCadet, FriObj, friday).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write('C4C '), write(X), write(' saw a '), write(Y),
    write(' on '), write(Z), write('.'), nl.

% The query to get the answer(s) or that there is no answer
% ?- solve.
%consult('C:/Users/SHAITA/Documents/Github/Chicago-stock-ecxhange/chicago_stex.pl').

% -------------------------------- DEBUT PREDICAT GENERALE -------------------------------------%
% permet d'afficher une liste
afficher_sous_liste([H|[]]):-write(H),nl.
afficher_sous_liste([H|T]):-write(H),write(','),afficher_sous_liste(T).
% Permet d'afficher une liste de sous liste
afficher_liste([]).
afficher_liste([T|Q]):-afficher_sous_liste(T),afficher_liste(Q).

% trouver_numero([],4,marchandise_numero)
% Algorithme trouver_numero
% Paramètre : T la marchandise a trouver, R le numero correspondant a une marchandise, liste associatif marchandise / numero
% Si le numero correspond au numero associe a la marchandise, on affecte la marchandise a T
% Sinon on continue de parcourir la liste
trouver_numero(T,R,[[T,R]|_]):-!.
trouver_numero(T,R,[_|Q]):-trouver_numero(T,R,Q).

% Permettant d'ajouter un element a une liste
ajouter_element(X,[],[X]).
ajouter_element(X,[T|Q],[X|[T|Q]]).

% Permettant de savoir si deux liste sont egales
egalite(L,L).

% Permet de savoir si X est un element d'une liste
element(X,[X|_]):-!.
element(X,[_|Q]):-element(X,Q).

% Permet d'affecter deux listes
affecter_liste(L,L).

% modulo(4,10,Z).
% Predicat MODULO (permet de pas avoir une positionTrader superieur a 9)
modulo(X,Y,Z):-Z is X mod Y.
 
 % Predicat longueur : permet de connaitre le nombre d'element d'une liste
 longueur([[_,vide]|Q],N):-longueur(Q,N).
 longueur([_|Q],N):-longueur(Q,N1),N is N1+1.
 longueur([],0).

 % Predicat supprimer element : permet de supprimer un element d'une liste
 supprimer_element([T|Q],PositionDebut,PositionX,[T|Q1]):-PositionDebut<PositionX,Position1 is PositionDebut+1,supprimer_element(Q,Position1,PositionX,Q1).
 supprimer_element([_|Q],PositionDebut,PositionX,Q):-PositionDebut>=PositionX.
 
 
% -------------------------------- FIN PREDICAT GENERALE -------------------------------------%

% -------------------------------- PREDICAT BOURSE -------------------------------------------%

% initialisation de la bourse
bourse([[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]]).

% affichage de la bourse 
afficher_bourse([T|Q]):-afficher_liste([T|Q]).

% -------------------------------- FIN PREDICAT BOURSE -------------------------------------------%

% -------------------------------- PREDICAT MARCHANDISE -------------------------------------------%

% Association d'une marchandise avec un numero permettant de la retrouver avec un chiffre random.
marchandise_numero([[ble,1],[riz,2],[cacao,3],[cafe,4],[sucre,5],[mais,6]]).

% tas(1,4,[],X).
% Algorithme tas :
% Paramètre : I, K boucle de I a K / TasIncrementer La liste qui va contenir le tas au fur et a mesure / TasResultat va contenir le tas final
% Trouver un nombre au hasard entre 1 et 6
% Recupere une liste des marchandises avec un numero (permet de recuperer des marchandises au hasard)
% Trouve la marchandise correspondant au numero random
% Ajoute la Marchandise au tas Incrementer qui donne une nouvelle liste (Liste Resultat)
% On rapelle tas avec la liste de Resultat

tas(I,K,TasIncrementer,TasResultat):-I=<K,random(1,6,X),marchandise_numero(MarchandiseNumero),trouver_numero(Marchandise,X,MarchandiseNumero),ajouter_element(Marchandise,TasIncrementer,ListeResultat),I1 is I+1,tas(I1,K,ListeResultat,TasResultat).
tas(I,K,TasIncrementer,TasResultat):-I>K,affecter_liste(TasResultat,TasIncrementer),!.


% marchandise(1,9,[],X).
% Algorithme Marchandise :
% Paramètre : I, K boucle de I a K / MarchandiseIncrementer La liste qui va contenir LES tas au fur et a mesure / MarchandiseResultat va contenir LES tas final
% On appelle l'agorithme tas, qui va nous renvoyer un nouveau Tas
% K1 is K-J pour avoir les listes de 0 à 8 et pas de 9 à 1
% On ajoute un numero au Tas correspondant a sa position et permettant de le retrouver
% On ajoute le Tas au Marchandise Incrementer qui donne un nouvelle liste (LRes).
% On rapelle marchandise avec la liste de Resultat  

marchandise(J,K,MarchandiseIncrementer,MarchandiseResultat):-J=<K,tas(1,4,[],Tas),K1 is K-J,ajouter_element(K1,Tas,LTas),ajouter_element(LTas,MarchandiseIncrementer,LRes),J1 is J+1,marchandise(J1,K,LRes,MarchandiseResultat).
marchandise(J,K,MarchandiseIncrementer,MarchandiseResultat):-J>K,affecter_liste(MarchandiseResultat,MarchandiseIncrementer).


afficher_tas([T|Q]):-afficher_liste([T|Q]).

% -------------------------------- FIN PREDICAT MARCHANDISE -------------------------------------------%

% -------------------------------- PREDICAT TRADER -------------------------------------------%

% initialisation du trader
trader(X):- random(0,9,X).
afficher_trader(X):-write(X).

% -------------------------------- FIN PREDICAT TRADER -------------------------------------------%

% -------------------------------- PREDICAT RESERVE JOUEUR -------------------------------------------%

reserve_joueur1([]).
reserve_joueur2([]).
afficher_joueur1([]):-write('La reserve du joueur 1 est vide').
afficher_joueur1([T|Q]):-afficher_sous_liste([T|Q]).
afficher_joueur2([]):-write('La reserve du joueur 2 est vide').
afficher_joueur2([T|Q]):-afficher_sous_liste([T|Q]).

% -------------------------------- FIN PREDICAT RESERVE JOUEUR -------------------------------------------%

% -------------------------------- PREDICAT PLATEAU -------------------------------------------%

% plateau(Plateau).
% Algorithme plateau 
% Paramètre : prend en paramètre les differents paramètres d'un plateau : Marchandise, Bourse, PositionTrader, Reserve Joueur1, Reserve Joueur2 sous forme d'une liste.
% On initialise marchandise avec le predicat marchandise
% On initialise PositionTrader avec le predicat trader
% On initialise Bourse avec le predicat bourse
% On initialise RJ1 avec reserve_joueur1
% On initialise RJ2 avec reserve_joueur2

plateau_depart([Marchandise, Bourse, PositionTrader, RJ1, RJ2]):-trader(PositionTrader),marchandise(1,9,[],Marchandise),bourse(Bourse),reserve_joueur1(RJ1),reserve_joueur2(RJ2).

% -------------------------------- FIN PREDICAT PLATEAU -------------------------------------------%

% -------------------------------- PREDICAT PLATEAU DEPART -------------------------------------------%

% Algorithme plateau_depart
% Algorithme qui affiche les differents parametres du plateau.

afficher_plateau([Marchandise, Bourse, PositionTrader, RJ1, RJ2]):-
	write('La reserve du joueur 1: '),nl,
	afficher_joueur1(RJ1),nl,
	write('***************************'),nl,
	write('La reserve du joueur 2: '),nl,
	afficher_joueur2(RJ2),nl,
	write('***************************'),nl,
	write('Le tas est :'),nl,
	afficher_tas(Marchandise),
	write('***************************'),nl,
	write('La bourse actuel est :'),nl,
	afficher_bourse(Bourse),
	write('***************************'),nl,
	write('Le trader est a la position :'),nl,
	afficher_trader(PositionTrader),nl.
	
% -------------------------------- FIN PREDICAT PLATEAU DEPART -------------------------------------------%

% -------------------------------- PREDICAT PARCOURIR MARCHANDISE -------------------------------------------%

% Liste Marchandise : [[0,ble,riz,ble,riz],[1,ble,sucre,riz,cacao],[2,ble,cafe,ble,cacao],[3,riz,sucre,cafe,sucre],[4,ble,cafe,ble,cacao],[5,sucre,ble,sucre,cacao],[6,riz,ble,riz,cafe],[7,riz,sucre,riz,cafe],[8,sucre,ble,riz,ble]]

% parcourir_marchandise_sautantvide(listeMarchandises,0,PositionXdeb,PositionX,listeMarchandises,tas).
% Algorithme parcourir_marchandise : permet de recuperer le tas correspondant la positionX
% Paramètre : [_|Q] : represente la liste des marchandises, PositionXdeb est la position du trader avant le deplacement,
% PositionX est la position du Trader apres le deplecement, Tas le tas a recuperer a la position du nouveau Trader

parcourir_marchandise_sautantvide([T|Q],PositionDebut,PositionXdeb,PositionX,Marchandise,Tas):-PositionDebut>=PositionXdeb,parcourir_marchandise_sautantvide2([T|Q],PositionXdeb,PositionX,Marchandise,Tas).
parcourir_marchandise_sautantvide([_|Q],PositionDebut,PositionXdeb,PositionX,Marchandise,Tas):-PositionDebut<PositionXdeb,Position1 is PositionDebut+1,parcourir_marchandise_sautantvide(Q,Position1,PositionXdeb,PositionX,Marchandise,Tas).

parcourir_marchandise_sautantvide2([[_,vide]|Q],PositionXdeb,PositionX,Marchandise,Tas):-parcourir_marchandise_sautantvide2(Q,PositionXdeb,PositionX,Marchandise,Tas).
parcourir_marchandise_sautantvide2([_|Q],PositionXdeb,PositionX,Marchandise,Tas):-PositionXdeb<PositionX, Position1 is PositionXdeb+1,parcourir_marchandise_sautantvide2(Q,Position1,PositionX,Marchandise,Tas).
parcourir_marchandise_sautantvide2([T|_],PositionXdeb,PositionX,_,Tas):-PositionXdeb>=PositionX,affecter_liste(Tas,T).
parcourir_marchandise_sautantvide2([],PositionXdeb,PositionX,Marchandise,Tas):-parcourir_marchandise_sautantvide2(Marchandise,PositionXdeb,PositionX,Marchandise,Tas).


parcourir_marchandise([_|Q],PositionDebut,PositionX,Tas):-PositionDebut<PositionX,Position1 is PositionDebut+1,parcourir_marchandise(Q,Position1,PositionX,Tas).%
parcourir_marchandise([T|_],PositionDebut,PositionX,Tas):-PositionDebut>=PositionX,affecter_liste(Tas,T).

% -------------------------------- FIN PREDICAT PARCOURIR MARCHANDISE -------------------------------------------%

% ------------------------------- PREDICAT SUPPRIMER MARCHANDISE --------------------------------- %

% Algorithme supprimer_marchandise :
% Paramètre : Liste dess Tas ([T|Q]), PositionDebut (=0), PositionX (Tas dans lequel on veut supprimer un element), Liste Resultat avec la marchandise supprimer ([T|Q1])
% On boucle de PositionDebut a Position X|
% On rapelle a chaque fois supprimer_marchandise avec la suite des tas
% Lorsque la boucle est terminé, on affecte le reste des marchandise Q et on supprime la premiere marchandise 
% En remontant, on recupere les tas parcourus


supprimer_marchandise([T|Q],PositionDebut,PositionX,[T|Q1]):-PositionDebut<PositionX,Position1 is PositionDebut+1,supprimer_marchandise(Q,Position1,PositionX,Q1).
supprimer_marchandise([[T,_]|Q],PositionDebut,PositionX,[[T,vide]|Q]):-PositionDebut>=PositionX.
supprimer_marchandise([[T|[_|Q2]]|Q],PositionDebut,PositionX,[[T|Q2]|Q]):-PositionDebut>=PositionX.



% ------------------------------- FIN PREDICAT SUPPRIMER MARCHANDISE --------------------------------- %

% ------------------------------- PREDICAT DECREMENTER BOURSE --------------------------------- %


decrementer_bourse(Marchandise,[[Marchandise,Nombre]|Q],[[Marchandise,Nombre1]|Q]):-Nombre1 is Nombre-1.
decrementer_bourse(Marchandise,[[T,Nombre]|Q],[[T,Nombre]|Q1]):-decrementer_bourse(Marchandise,Q,Q1).

% ------------------------------- FIN PREDICAT DECREMENTER BOURSE --------------------------------- %

% -------------------------------- PREDICAT COUP_POSSIBLE -------------------------------------------%

% Algorithme coup_possible :
% Paramètre : Plateau, Coup : coup([j1,1,sucre,riz]) (par exemple)
% Pour tester l'algorithme, on initialise le plateau et le coup avec le predicat plateau et coup
% Si le deplacement est superieur a 3 ou inferieur a 1 => erreur
% On recupere la nouvelle position du trader (Mouvement)
% On recupere la position juste apres le trader
% On recupere la position juste avant le trader
% On utilise modulo a chaque fois pour eviter que le mouvement ne passe 9
% On regarde si la marchandise a la position juste apres le trader correspond bien a la march_vendu (predicat 1) ou a la march_gardee(predicat 2).
% On regarde si la marchandise a la position juste avant le trader correspond bien a la march_vendu (predicat 1) ou a la march_gardee(predicat 2).

% Predicat qui permet dans le cas ou la positionduTrader est egale a 0 et que du coup le MouvementAvant(=PositionTrader-1) est egale a -1, il devient egale a 8 (=dernier element).
moins_un(X,Y):-egalite(X,-1),Y is 8,!.
moins_un(X,X).

coup_possible([Marchandise,_,PositionTrader,_,_], [_,Deplacement,March_gardee,March_vendu]):-
Deplacement=<3,Deplacement>=1,
PositionApres is PositionTrader+Deplacement+1,
PositionAvant is PositionTrader+Deplacement-1,
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,PositionApres,Marchandise,[_|[T|_]]),
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,PositionAvant,Marchandise,[_|[X|_]]),
(egalite(March_gardee,X),egalite(March_vendu,T) ; egalite(March_gardee,T),egalite(March_vendu,X)),!.
coup_possible(_,_):-write('Le coup jouer comporte une erreur'),nl,fail,!.

% -------------------------------- FIN PREDICAT COUP_POSSIBLE -------------------------------------------%

% -------------------------------- PREDICAT JOUER COUP -------------------------------------------%

% Algorithme jouer_coup
% Paramètre : Le plateau, le coup, Le nouveau PLateau
% On test d'abord si le coup est possible
% On calcul la nouvelle Position du Trader
% On supprime les marchandises gardee et vendu
% Si joueur 1, on ajoute la marchandise a la reserve du joueur 1
% Si joueur 2, on ajoute la marchandise a la reserve du joueur 2
% On decremente ensuite la valeur de la marchandise dans la bourse


jouer_coup([Marchandise,Bourse,PositionTrader,RJ1,RJ2],[Joueur,Deplacement,March_gardee,March_vendu],
[NouveauMarchandise,NouveauBourse,_,NouveauRJ1,NouveauRJ2],PositionAvant,PositionApres):-
coup_possible([Marchandise, Bourse, PositionTrader, RJ1, RJ2],[Joueur,Deplacement,March_gardee,March_vendu]),
supprimer_marchandise(Marchandise,0,PositionAvant,ListeResultat1),
supprimer_marchandise(ListeResultat1,0,PositionApres,NouveauMarchandise),
(egalite(Joueur,'j1'),ajouter_element(March_gardee,RJ1,NouveauRJ1),egalite(NouveauRJ2,RJ2); egalite(Joueur,'j2'),ajouter_element(March_gardee,RJ2,NouveauRJ2),egalite(NouveauRJ1,RJ1)),
decrementer_bourse(March_vendu,Bourse,NouveauBourse).

% -------------------------------- FIN PREDICAT JOUER COUP -------------------------------------------%

<<<<<<< HEAD
=======
% -------------------------------- PREDICAT START JEU -------------------------------------------%s

% start jeu
% Initialise le plateau
% choisi le premier joueur au hasard entre le joueur 1 et 2

start_jeu(_):-
plateau_depart([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
random(1,3,X),nl,
(egalite(X,1),egalite(Joueur,'j1') ; egalite(X,2),egalite(Joueur,'j2')),
boucle_jeu([Marchandise,Bourse,PositionTrader,RJ1,RJ2],Joueur).

boucle_jeu([Marchandise,Bourse,PositionTrader,RJ1,RJ2],Joueur):-
longueur(Marchandise,N),
N>2,
afficher_plateau([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
write('Longueur :'),write(N),nl,
(egalite(Joueur,'j1'),write('Le joueur 1 joue'),egalite(NouveauJoueur,'j2') ; egalite(Joueur,'j2'),write('Le joueur 2 joue'),egalite(NouveauJoueur,'j1')),nl,
write('De combien de cases voulez-vous deplacer le trader (1, 2, 3) ?'),nl,
read(Deplacement),
PosTrader is PositionTrader+Deplacement,
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,PosTrader,Marchandise,[NouveauPositionTrader|_]),
MouvementApres is PosTrader+1,
MouvementAvant is PosTrader-1,
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementApres,Marchandise,[PositionApres|[MarchApres|_]]),
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementAvant,Marchandise,[PositionAvant|[MarchAvant|_]]),
write('Le Trader est maintenant a la position: '),nl,
write(NouveauPositionTrader),nl,
write('Quel Marchandise voulez-vous garder ?'),nl,
write(PositionAvant),write(': '),write(MarchAvant),
write(' ou '),
write(PositionApres),write(': '),write(MarchApres),nl,
read(MarchGardee),
write('Quel Marchandise voulez-vous vendre ?'),nl,
write(PositionAvant),write(': '),write(MarchAvant),
write(' ou '),
write(PositionApres),write(': '),write(MarchApres),nl,
read(MarchVendu),
nl,nl,nl,
jouer_coup([Marchandise,Bourse,PositionTrader,RJ1,RJ2],[Joueur,Deplacement,MarchGardee,MarchVendu],[NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],PositionAvant,PositionApres),
boucle_jeu([NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],NouveauJoueur).

boucle_jeu([Marchandise,Bourse,_,RJ1,RJ2],_):-
afficher_bourse(Bourse),nl,
write('Reserve du joueur 1 : '),nl,
afficher_joueur1(RJ1),nl,
write('Reserve du joueur 2 : '),nl,
afficher_joueur2(RJ2),nl,
write('********************************'),nl,
write('La partie est fini'),nl,
write('Comptez vos points en fonction des matieres possedées et de leur valeur en bourse'),nl,
write('Celui qui a le plus de point gagne').

>>>>>>> 926a94dcb36fe3014d90c25a7549ffaff7a214ed

% -------------------------------- PREDICAT COUPS POSSIBLES -------------------------------------------%
/*
    Prédicat coups possibles:
    Parametres: Plateau
    Retour: Liste des Coups possibles.
    L'algorithme coups possible liste l'ensemble des coups possible à partir d'une situation donnée.
    Il s'agit de la concaténation de tous les déplacements et actions possibles en une seule et même liste.
    
    A chaque tour, le joueur peut se déplacer de 1,2 ou 3 cases. En fonction de son déplacement
    le joueur gardera la ressource située sur le tas de gauche et vendra celle située sur le tas
    de droite, ou il fera l'inverse.
    
    Algorithme:
        Récupération du nombre de tas
        Simulation d'un déplacement de valeur 1
        concatenation des différentes actions possibles pour le j1 et le j2
        Simulation d'un déplacement de valeur 2
        concatenation des différentes actions possibles pour le j1 et le j2
        Simulation d'un déplacement de valeur 3
        concatenation des différentes actions possibles pour le j1 et le j2
        Retour de la liste issue des différentes concatenations.
*/

long(0, []).
long(Long, [_|Q]):-long(Long2, Q),Long is Long2+1.

concatanate([],L,L).
concatanate([T|Q], L, [T|R]):-concatanate(Q,L,R).

coups_possibles([H, _, T, _, _],ListeCoupsPossibles):-
    T1 is T + 1,
	MouvementApres is T1+1,
	MouvementAvant is T1-1,
	parcourir_marchandise_sautantvide(H,0,T,MouvementApres,H,[_|[TD|_]]),
	parcourir_marchandise_sautantvide(H,0,T,MouvementAvant,H,[_|[TG|_]]),
    concatanate([],[[j1, 1, TG, TD]],ListeCoupsPossibles1),
    concatanate(ListeCoupsPossibles1,[[j2, 1, TG, TD]],ListeCoupsPossibles2),
    concatanate(ListeCoupsPossibles2,[[j1, 1, TD, TG]],ListeCoupsPossibles3),
    concatanate(ListeCoupsPossibles3,[[j2, 1, TD, TG]],ListeCoupsPossibles4),
	T2 is T + 2,
	MouvementApres2 is T2+1,
	MouvementAvant2 is T2-1,
	parcourir_marchandise_sautantvide(H,0,T,MouvementApres2,H,[_|[TD2|_]]),
	parcourir_marchandise_sautantvide(H,0,T,MouvementAvant2,H,[_|[TG2|_]]),
    concatanate(ListeCoupsPossibles4,[[j1, 1, TG2, TD2]],ListeCoupsPossibles5),
    concatanate(ListeCoupsPossibles5,[[j2, 1, TG2, TD2]],ListeCoupsPossibles6),
    concatanate(ListeCoupsPossibles6,[[j1, 1, TD2, TG2]],ListeCoupsPossibles7),
    concatanate(ListeCoupsPossibles7,[[j2, 1, TD2, TG2]],ListeCoupsPossibles8),
	T3 is T + 3,
	MouvementApres3 is T3+1,
	MouvementAvant3 is T3-1,
	parcourir_marchandise_sautantvide(H,0,T,MouvementApres3,H,[_|[TD3|_]]),
	parcourir_marchandise_sautantvide(H,0,T,MouvementAvant3,H,[_|[TG3|_]]),
    concatanate(ListeCoupsPossibles8,[[j1, 1, TG3, TD3]],ListeCoupsPossibles9),
    concatanate(ListeCoupsPossibles9,[[j2, 1, TG3, TD3]],ListeCoupsPossibles10),
    concatanate(ListeCoupsPossibles10,[[j1, 1, TD3, TG3]],ListeCoupsPossibles11),
    concatanate(ListeCoupsPossibles11,[[j2, 1, TD3, TG3]],ListeCoupsPossibles).

% -------------------------------- FIN PREDICAT COUPS POSSIBLES -------------------------------------------%

% -------------------------------- PREDICAT MEILLEUR COUP -------------------------------------------%
/* 
    Prédicat meilleur coup:
        Paramètres: le plateau courant
        Retour: un coup choisi comme étant le meilleur
        
    Pour ce prédicat, on simule chacun des coups possibles.
    On évaluer ensuite chaque coup possible: la valeur d'un coup est le nombre de points du joueur 
    courant moins le nombre de point de son adversaire après simulation du coup. Le coup d'évaluation
    maximum est le coup qui fera le plus avancer le joueur courant par rapport à son adversaire.
    Ce coup d'évaluation maximum est considéré comme le meilleur coup.
    
    Algorithme:
        Recherche de l'ensemble des coups possibles.
        Teste (évaluation) de chacun des coups, obtention d'un tableau de valeur contenant les évaluations
        Recherche de l'évaluation maximum
        Recherche du premier coup ayant cette évaluation maximum
        Retour de ce coup.
*/




meilleur_coup([B, H, T, J1, J2], [Joueur, Depl, Garde, Jette]):-
     coups_possibles([B, H, T, J1, J2],ListeCoupsPossibles),
     (
        egalite(Joueur,'j1'),
<<<<<<< HEAD
        tester_coupsJ1([B,H,T,J1,J2],ListeCoupsPossibles,Res)
=======
        tester_coupsJ1([B,H,T,J1,J2],ListeCoupsPossibles, Res)
>>>>>>> 926a94dcb36fe3014d90c25a7549ffaff7a214ed
     ; 
        egalite(Joueur,'j2'),
        reverse(ListeCoupsPossibles, Tmp),
        tester_coupsJ2([B,H,T,J1,J2],Tmp, Res)
     ),
     max(Res,X),
     nieme_element(X,Res,N),
     nieme_element([Joueur, Depl, Garde, Jette],ListeCoupsPossibles,N).

% ------- PRÉDICATS UTILITAIRES ------------%


/* obtenir_prix permet d'obtenir le prix d'une ressource dans la bourse */
obtenir_prix(Res, [], 0):-!,false.
obtenir_prix(Res, [[Res, Prix]|Q], Prix).
obtenir_prix(Res, [[_,_]|Q], Prix):-obtenir_prix(Res, Q, Prix).

/* evaluer_reserve permet de connaitre le nombre de point d'un joueur à l'issue d'un tour
  en fonction de la ressource vendue pendant le tour et de la bourse.
  La réserve du joueur courant est simulée ainsi que la valeur de 
  la valeur de la bourse après le coup.
  Le score d'un joueur est la somme des ressources qu'il a en réserve en fonction 
  de leur valeur en bourse.
*/
evaluer_reserve(B, [],Jette, 0).
evaluer_reserve(B,[Jette|Q],Jette, Score):-
    obtenir_prix(Jette,B, PrixJ), 
    PrixJF is PrixJ - 1,
    evaluer_reserve(B, Q,Jette, Score2), 
    Score is Score2 + PrixJF.
evaluer_reserve(B, [R|Q],Jette, Score):-
    evaluer_reserve(B, Q, Jette,Score2),
    obtenir_prix(R, B, Prix),    
    Score is Score2 + Prix.

/* evaluer_coupJ1 permet de donner une valeur à un coup joué par le j1 
   en fonction d'un plateau donnée.
   L'évaluation vaut Score_j1 - Score_j2.
*/
evaluer_coupJ1([H, B, T, J1, J2],[Joueur, Depl, Garde, Jette], Resultat):- 
    concatanate(J1,[Garde], NewReserve),
    evaluer_reserve(B, NewReserve, Jette, ScoreJ1),
    evaluer_reserve(B, J2, Jette, ScoreJ2),
    Resultat is ScoreJ1 - ScoreJ2.
/* evaluer_coupJ2 permet de donner une valeur à un coup joué par le j2
   en fonction d'un plateau donnée
   L'évaluation vaut Score_j2 - Score_j1.
*/ 
evaluer_coupJ2([H, B, T, J1, J2],[Joueur, Depl, Garde, Jette], Resultat):- 
    concatanate(J2,[Garde], NewReserve),
    evaluer_reserve(B, NewReserve, Jette, ScoreJ2),
    evaluer_reserve(B, J1, Jette, ScoreJ1),
    Resultat is ScoreJ2 - ScoreJ1.
    
/* max retourne la valeur maximum dans une liste*/
max([X], X):-!.
max([T|Q], M) :- max(Q,M), M >= T.
max([T|Q], T) :- max(Q,M), T > M.

/*
   nieme_element permet de connaitre la valeur d'une n-ième élément.
*/
nieme_element(T,[T|_],1).
nieme_element(T,[_|L],N) :- nieme_element(T,L,N1), N is N1 +1.

/*
    tester_coup permet d'évaluer un ensemble de coups d'une liste
    et retourne une liste contenant les valeurs respectives des
    évaluations de chacun des coups.
*/
<<<<<<< HEAD

=======
>>>>>>> 926a94dcb36fe3014d90c25a7549ffaff7a214ed
tester_coupsJ1([H,B,T,J1,J2],[],[]).
tester_coupsJ1([H,B,T,J1,J2],[[J,D,G,Je]|Q],[R|Reste]):-    
    evaluer_coupJ1([H, B, T, J1, J2],[J, D, G, Je], R), 
    tester_coupsJ1([H, B, T, J1, J2],Q, Reste).
    
tester_coupsJ2([H,B,T,J1,J2],[],[]).
tester_coupsJ2([H,B,T,J1,J2],[[J,D,G,Je]|Q],[R|Reste]):-    
    evaluer_coupJ2([H, B, T, J1, J2],[J, D, G, Je], R), 
    tester_coupsJ2([H, B, T, J1, J2],Q, Reste).
    
% ------- FIN PRÉDICATS UTILITAIRES ------------%
     
% -------------------------------- FIN PREDICAT MEILLEUR COUP -------------------------------------------%

<<<<<<< HEAD
% -------------------------------- PREDICAT START JEU -------------------------------------------%

% start jeu
% Initialise le plateau
% choisi le premier joueur au hasard entre le joueur 1 et 2

start_jeu(_):-
plateau_depart([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
random(1,3,X),nl,
(egalite(X,1),egalite(Joueur,'j1') ; egalite(X,2),egalite(Joueur,'j2')),
write('************************************'),nl,
write('1: Joueur VS Joueur'),nl,
write('2: Joueur VS IA'),nl,
write('3: IA VS IA'),nl,
write('Choissiez un mode de jeu'),nl,
read(Mode),
(egalite(Mode,1),boucle_jeu([Marchandise,Bourse,PositionTrader,RJ1,RJ2],Joueur)
;egalite(Mode,2),boucle_jeuIA([Marchandise,Bourse,PositionTrader,RJ1,RJ2],Joueur)
;egalite(Mode,3),write('Pas encore disponible')
).

=======

jeuIA(_):- 
    plateau_depart([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
    random(1,3,X),nl,
    (egalite(X,1),egalite(Joueur,'j1') ; egalite(X,2),egalite(Joueur,'j2')),
    boucle_jeuIA([Marchandise,Bourse,PositionTrader,RJ1,RJ2],Joueur).
    
    
>>>>>>> 926a94dcb36fe3014d90c25a7549ffaff7a214ed
boucle_jeuIA([Marchandise,Bourse,PositionTrader,RJ1,RJ2],Joueur):-
    longueur(Marchandise,N),
    N>2,
    afficher_plateau([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
<<<<<<< HEAD
    write('Longueur :'),write(N),nl,   
   (     
=======
    write('Longueur :'),write(N),nl,
    
   (
        
>>>>>>> 926a94dcb36fe3014d90c25a7549ffaff7a214ed
        egalite(Joueur,'j1'),
        write('L\'IA joue'),
        egalite(NouveauJoueur,'j2'),
        meilleur_coup([Marchandise,Bourse, PositionTrader,RJ1, RJ2], [j1, Depl, Garde, Jette]),
        PosTrader is PositionTrader+Depl,
        parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,PosTrader,Marchandise,[NouveauPositionTrader|_]),
        MouvementApres is PosTrader+1,
        MouvementAvant is PosTrader-1,
        parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementApres,Marchandise,[PositionApres|[MarchApres|_]]),
        parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementAvant,Marchandise,[PositionAvant|[MarchAvant|_]]),
        jouer_coup([Marchandise,Bourse,PositionTrader,RJ1,RJ2],[Joueur,Depl,MarchGardee,MarchVendu],     
<<<<<<< HEAD
            [NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],PositionAvant,PositionApres)   
   ; 
        egalite(Joueur,'j2'),
        write('Vous jouez'),nl,
=======
            [NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],PositionAvant,PositionApres)
        
   ; 
        egalite(Joueur,'j2'),
        write('Vous jouez'),
>>>>>>> 926a94dcb36fe3014d90c25a7549ffaff7a214ed
        egalite(NouveauJoueur,'j1'),
        write('De combien de cases voulez-vous deplacer le trader (1, 2, 3) ?'),nl,
        read(Deplacement),
        PosTrader is PositionTrader+Deplacement,
        parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,PosTrader,Marchandise,[NouveauPositionTrader|_]),
        MouvementApres is PosTrader+1,
        MouvementAvant is PosTrader-1,
        parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementApres,Marchandise,[PositionApres|[MarchApres|_]]),
        parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementAvant,Marchandise,[PositionAvant|[MarchAvant|_]]),
        write('Le Trader est maintenant a la position: '),nl,
        write(NouveauPositionTrader),nl,
        write('Quel Marchandise voulez-vous garder ?'),nl,
        write(PositionAvant),write(': '),write(MarchAvant),
        write(' ou '),
        write(PositionApres),write(': '),write(MarchApres),nl,
        read(MarchGardee),
        write('Quel Marchandise voulez-vous vendre ?'),nl,
        write(PositionAvant),write(': '),write(MarchAvant),
        write(' ou '),
        write(PositionApres),write(': '),write(MarchApres),nl,
        read(MarchVendu),
        nl,nl,nl,
        jouer_coup([Marchandise,Bourse,PositionTrader,RJ1,RJ2],[Joueur,Deplacement,MarchGardee,MarchVendu],     
            [NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],PositionAvant,PositionApres)
<<<<<<< HEAD
   ),nl,boucle_jeuIA([NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],NouveauJoueur).

   
=======
   ),nl,
    
    boucle_jeuIA([NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],NouveauJoueur).

>>>>>>> 926a94dcb36fe3014d90c25a7549ffaff7a214ed
boucle_jeuIA([Marchandise,Bourse,_,RJ1,RJ2],_):-
    afficher_bourse(Bourse),nl,
    write('Reserve du joueur 1 : '),nl,
    afficher_joueur1(RJ1),nl,
    write('Reserve du joueur 2 : '),nl,
    afficher_joueur2(RJ2),nl,
    write('********************************'),nl,
    write('La partie est fini'),nl,
    write('Comptez vos points en fonction des matieres possedées et de leur valeur en bourse'),nl,
    write('Celui qui a le plus de point gagne').
<<<<<<< HEAD




boucle_jeu([Marchandise,Bourse,PositionTrader,RJ1,RJ2],Joueur):-
longueur(Marchandise,N),
N>=3,
afficher_plateau([Marchandise,Bourse,PositionTrader,RJ1,RJ2]),
write('Longueur :'),write(N),nl,
(egalite(Joueur,'j1'),write('Le joueur 1 joue'),egalite(NouveauJoueur,'j2') ; egalite(Joueur,'j2'),write('Le joueur 2 joue'),egalite(NouveauJoueur,'j1')),nl,
write('De combien de cases voulez-vous deplacer le trader (1, 2, 3) ?'),nl,
read(Deplacement),
PosTrader is PositionTrader+Deplacement,
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,PosTrader,Marchandise,[NouveauPositionTrader|_]),
MouvementApres is PosTrader+1,
MouvementAvant is PosTrader-1,
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementApres,Marchandise,[PositionApres|[MarchApres|_]]),
parcourir_marchandise_sautantvide(Marchandise,0,PositionTrader,MouvementAvant,Marchandise,[PositionAvant|[MarchAvant|_]]),
write('Le Trader est maintenant a la position: '),nl,
write(NouveauPositionTrader),nl,
write('Quel Marchandise voulez-vous garder ?'),nl,
write(PositionAvant),write(': '),write(MarchAvant),
write(' ou '),
write(PositionApres),write(': '),write(MarchApres),nl,
read(MarchGardee),
write('Quel Marchandise voulez-vous vendre ?'),nl,
write(PositionAvant),write(': '),write(MarchAvant),
write(' ou '),
write(PositionApres),write(': '),write(MarchApres),nl,
read(MarchVendu),
nl,nl,nl,
jouer_coup([Marchandise,Bourse,PositionTrader,RJ1,RJ2],[Joueur,Deplacement,MarchGardee,MarchVendu],[NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],PositionAvant,PositionApres),
boucle_jeu([NouveauMarchandise,NouveauBourse,NouveauPositionTrader,NouveauRJ1,NouveauRJ2],NouveauJoueur).

boucle_jeu([Marchandise,Bourse,_,RJ1,RJ2],_):-
afficher_bourse(Bourse),nl,
write('Reserve du joueur 1 : '),nl,
afficher_joueur1(RJ1),nl,
write('Reserve du joueur 2 : '),nl,
afficher_joueur2(RJ2),nl,
write('********************************'),nl,
write('La partie est fini'),nl,
write('Comptez vos points en fonction des matieres possedées et de leur valeur en bourse'),nl,
write('Celui qui a le plus de point gagne').
=======
    

>>>>>>> 926a94dcb36fe3014d90c25a7549ffaff7a214ed

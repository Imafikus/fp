module Zad3 where

-- Zadatak 3:

-- Definisati strukturu podataka `Stek a`, gde je `a`
-- proizvoljan tip. Stek moze biti prazan ili sadrzati
-- proizvoljan broj elemenata tipa `a`.

-- Kreirati funkcije `fromList` i `toList` koje konvertuju
-- [a] u `Stek a`, i `Stek a` u `[a]`, redom.

-- Napisati QuickCheck test za funkcije `fromList` i `toList`.

-- Instancirati Show nad `Stek a` (pretpostaviti da je
-- `a` u klasi Show) tako da se skup ispise u formatu:
--       < dno, ... , vrh >
-- (vrh i dno su elementi steka)
-- Za prazan stek:  </>

-- Instancirati Functor nad `Stek a`

data Stack a = MkStack [a]

fromList :: [a] -> Stack a 
fromList a = MkStack a

toList :: Stack a -> [a]
toList (MkStack a) = a

instance (Show a) => Show (Stack a) where
    show (MkStack []) = "</>"
    show(MkStack s) = "< " ++ displayStackElemsNoDanglingChars ++ " >" where 
        displayStackElems = foldl (\x y -> x ++ show y ++ ", ") "" (reverse s)
        displayStackElemsNoDanglingChars = removeFirst2 $ reverse $ displayStackElems

removeFirst2 :: [a] -> [a]
removeFirst2 (fst:snd:rest) = rest

instance Functor Stack where 
    fmap f (MkStack a) = MkStack (fmap f a)
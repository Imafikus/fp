module Zad1 where

-- Zadatak 1:
--
-- Definisati tip podataka `Point2D` koji se može konstruisati 
-- putem konstruktora `MkPoint2D` i koji se sastoji od atributa:
--  * `x` (tipa `Double`) koje predstavlja x-koordinatu tačke 
--  * `y` (tipa `Double`) koje predstavlja y-koordinatu tačke 
--
-- Definisati tip podataka `Rectangle` koji se može konstruisati 
-- putem konstruktora `MkRectangle` i koji se sastoji od atributa:
--  * `bott_left` (tipa `Point2D`) koje predstavlja teme A pravougaonika 
--  * `top_right` (tipa `Point2D`) koje predstavlja teme C pravougaonika
-- (pretpostaviti da su stranice pravougaonika paralelene koordinatnim osama)
--
--             D     (C)
--
--            (A)     B
--
-- Definisati klasu `Traversible a` koja sadrži funkciju
-- `traverse :: a -> [Point2D]`
--
-- Instancirati `Traversible` za `Rectangle` tako da funkcija `traverse`
-- vrati listu [A,B,C,D]
--
-- Definisati funkciju `rotTrans rect` koja rotira pravougaonik za 90 stepeni
-- u smeru kazaljke na satu ali tako da teme B dođe na mesto temena A 
-- (kao na slici ispod) i vraća dobijeni pravougaonik:
--
--            | D     (C)         | A   (D)
--            |             ->    |
--            |(A)     B          |(B)   C
--            ````````````        ``````````
--
-- Napisati QuickCheck test koji testira funkciju `rotTrans`. 
-- Pomoc: Iskoristiti činjenicu da dva puta primenjena rotacija na ovakav
--        nacin predstavlja identitet.

data Point2D = MkPoint2D {x :: Double, y :: Double}

data Rectangle = MkRectangle { bott_left :: Point2D, top_right :: Point2D}

class Traversible a where 
    travel :: a -> [Point2D]

instance Traversible Rectangle where 
    travel r = [bott_left r, bott_right, top_right r, top_left] where 
        bott_right = MkPoint2D (x $ top_right r) (y $ bott_left r)
        top_left = MkPoint2D (x $ bott_left r) (y $ top_right r)

rotTrans :: Rectangle -> Rectangle
rotTrans r = MkRectangle (travel r !! 1) (travel r !! 3)

instance Eq Point2D where 
    p1 == p2 = x p1 == x p2 && y p1 == y p2

instance Eq Rectangle where 
    x == y = bott_left x == bott_left y && top_right x == top_right y

instance Show Point2D where 
    show point = "(" ++ (show $ x $ point) ++ ", " ++ (show $ y $ point) ++ ")"

instance Show Rectangle where 
    show r = show $ travel r

testRotation :: Rectangle -> Bool
testRotation r = r == (rotTrans $ rotTrans r)

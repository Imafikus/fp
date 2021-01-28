import Test.QuickCheck

import Lib

prop_testName data = 
    data == (someFunc $ someOtherFunc)
    where types = (data :: dataType)
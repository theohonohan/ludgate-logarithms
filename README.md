# ludgate-logarithms
Generators for Percy Ludgate's "Irish logarithms": Python and Haskell code to generate Irish logarithms for a given set of digits. 

I wrote the Python first. It uses the idea of a queue of newly assigned digits and was quick and easy. The Haskell is fancier (my first attempt at using monad transformers, which was necessary for putStrLn debugging) and took a lot longer. Both programs are only tested for the generation of tables for digits 1–9. Their output should agree in that case. In principle they should work for larger ranges of digits.

The basic technical details came from Brian Coghlan's 2022 paper [Percy Ludgate’s Logarithmic Indexes](https://treasures.scss.tcd.ie/miscellany/TCD-SCSS-X.20121208.002/Ludgate-LogarithmixIndexes-20200610-1459.pdf).

Other pages on the web have useful material:

https://sites.google.com/site/calculatinghistory/home/irish-logarithms-1

http://ajmdeman.awardspace.info/t/irishlog.html

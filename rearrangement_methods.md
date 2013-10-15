Rearrangement Methods
========================================================

See rearrangement_methods.rb for the code behind each method.

What I am trying to acheive:
---------------------------

- I have a list of identifiers for my fragments in their original order, and a list of those same frag ids arranged in order of SNP density (ascending)

- With real data, the frags would be assigned ids before being put into a fasta file. With my data the ids are named according to the original sequence order, and I have shuffled them before creating a fasta file, so the original order is not simply the same as the order in the fasta file.

- I need to design an algorithm that will rearrange the density ordered frags into their original order, based on SNP density/position data

- This hasn't been done before, so I will need to test a variety of rearrangement methods and I will need a way of ranking them by their effectiveness

- Once I have several methods to compare, I can plot their effectiveness scores. The scores of the density order and random rearrangements can be used as controls

- After I have created a working rearrangement method, I can use it to determine the likely position of a phenotype altering mutant SNP, based on the distribution of SNPs in the sequence: see the repository README for more information.

Ranking the rearrangement methods
---------------------------------

I have come up with a way of giving each rearrangement method a "Score". See the ruby method: score, in rearrangement_methods.rb. A simple way of defining what this method does is: taking away the index of each fragment in the original order, from it's new index in the rearranged list - this gives the "distance"" that the fragment has moved when re-ordered (as an absolute value) - these "distances" are then summed to give an overall score, which mathematically can be described as the ordinal similarity between the two arrangements. The higher the value of ordinal similarity, the less similar the two orders are. A perfect score would be 0, where the two orders are identical.

Mathematically the ordinal similarity can be defined as...

The highest value of ordinal similarity for my fragments is X... because...

Methods
-------

>### Control 1: Density order

> The first control was to compare the density order against the original. My hypothesis being that this should produce a high ordinal similarity score, because whilst the orginal order of the fragments is based on a normal distribution of SNPs, the density order has the fragments with the most SNPs towards the end of the list, and least near the start. Good rearrangemrent methods should have lower scores than this.

>### Control 2: Random order

> The purpose of this control is to provide a baseline for which all other rearrangement methods should perform better than. To do this, I will create a method that arranges the fragments randomly, and call the score method. This can be repeated a large number of times (e.g. 100) and an average score for randomly ordered fragments can be determined.

>### Method 1: Even Odd Method

> Since I know the original ordered sequence has a normal distribution of SNPs, it follows that the when the fragments are in the correct order, their SNP densities follow that same normal curve. Here I assume that the fragments with the highest densities should be in the middle of the distribution, with fragments of lowest densities at either end. The method takes the fragments in the even indexes of the density ordered array and adds these to a new array, so that they are still in ascending order of density. The frags at odd indexes (of the density order) are then reversed (into descending order of density), and then added to the same new array, after (ahead of) the frags from even indexes. 

> I expect this method to perform slightly better than the controls, however, it's basic nature means there may not be much of a difference. This Method does not neccesarily even put the frags on the correct "side" of the rearranged order (where the two sides are divided by the centre of the normal distribution), let alone in the correct positions.

>### Method 2a: Left Right Method

> Here I use information derived directly from the fasta and VCF files rather than the SNP densities. I use the SNP position data for each of the fragments, to work out whether the positions are "skewed" to the left or right of each fragment. My hypothesis being that fragments with more SNPs on the "left hand side", are likely to be from the "right side" of the sequence due to the normal distibution of SNPs (and vice versa). The way I work out the "skew": If the sum of the positions is < half of the value produced by multiplying half the length of a fragment by the number of positions it has, this indicates a left skew and I add this fragment to a list of the fragments that should go on the right - and vice versa. I use the Even/Odd Method to add the fragments with 0 SNPs into either the "left" or "right" list. I then add both "left" and "right" into a super-array that is flattened to give the new fragment order. 

> I don't expect this method to perform well, as I have not re-ordered the fragments within the "left" and "right" sub-arrays, which are based on the order that the frags were found in the fasta file (and so are random). It should however perform better than the controls, assuming the "skew" of SNP positions can be used as an indication to the "side" of the normal distribution that a fragment is from.

>### Method 2b: Left Right Density Method

> As explained above, one problem with the "Left Right Method" is that the frags are ordered randomly within the "Left" and "Right" arrays. There are two arguments used for the L/R Method in my script. One is a hash, with frag ids for keys, and lists (technically strings) of SNP positions for each of those frags as values. The other is an array of the frag lengths, which is in the same order as (corresponds to) the frag ids in the hash. This order is the the the order that the frags were in in the fasta file. See rearrangement_methods.rb for method details.

> After writing a method that reordered the neccesary arguments for the L/R Method into SNP density order (see density_order in rearrangement_methods.rb), I re-ran the L/R Method with these new versions of the arguments. What this gave me was "Left" and "Right" arrays, with frag ids in ascending order of SNP density. I then reversed the right array into descending density order and pushed it into the left array, flattening it to give the new rearranged fragment order. I am assuming here that the fragments with the highest densities should be in the middle of the distribution, with fragments of lowest densities at either end, due to the normal distribution of SNPs along the sequence.

> I expect this version of the L/R Method to perform better than the previous version (Method 2a), as I am now using the SNP density information to decide where each frag should be placed in the "Left" and "Right" arrays, where previously this was based on the position of the fragments within the fasta file (which is random). I do however also expect this method to have a high ordinal similarity score. Whilst I am as yet unsure of how well the "skew" of SNP positions within a fragment can be used to tell which side of the sequence it is from (due to the normal distribution), I am still using the "Even Odd Method" to place the fragments with 0 SNPs in the "Left" or "Right". Since the order of the fragments with 0 SNPs is essentially random, the Even Odd Method does not neccesarily put them on the correct end of the rearranged order, let alone in the correct position.

>### Method 2c: Another l/r method idea

> Another idea I had was to run method 2a, then re-order each of the left and right lists individually according to SNP density. I decided this would not be worth the time it took to code, as the rearrangement it produces should logically be identical to the order of the fragments from Method 2b.

Results
-------

>### Ordinal Similarity Scores

>1. **C1 Density order**: 624,196 

>2. **C2 Random order**: 570,00 approx (571,040.44)

>3. a. **M1 a Even/Odd method**: 492,838    
>   b. **M1 b Odd/Even method**: 490,524

>4. **M2 a Left Right Method**: 570,434

>5. **M2 b Left Right Density Method**: 491,950


```r
scores <- c(624196, 571040.44, 492838, 490524, 570434, 491950)
methods <- c("C1", "C2", "M1 a", "M1 b", "M2 a", "M2 b")
barplot(scores, main = "Comparison of Methods for Rearrangement of SNP Density Ordered Fragments, to The Original Sequenced Order", 
    xlab = "Methods", ylab = "Ordinal Similarity Score", names.arg = methods)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/unnamed-chunk-1.png?raw=true)

>### Discuss

>1. **Density order**: A high score as expected

>2. **Random order**: The average score of 100 random arragements generated using the shuffle method of the Array Class in ruby. Conversion of integer to float for division (to get average) is the reason for the float score. Calling this multiple times gave scores roughly from 570,000 to 574,000. A more consistent "average random score" could be ascertained with a higher repeat number than 100, but is not neccesary (would increase the running time of the method). 

>3. **Even Odd Method**: As expected this method performed better than the controls, but still had a very high score. I have run it twice, with even indexes of the density order first, then odd indexes reversed and vice versa. The method gives a similar score whichever way around you do it: this is an important thing to note, as I use this method within later methods i.e. there is no need to always test even/odd AND odd/even. This method is flawed because whether or not a fragment is on an even index in the density ordered array has no bearing on that fragments' position in the original order.

>4. **Left Right Method**: As expected this method performed poorly. However, with a score similar to the average random order, it may not be likely that the "skew" of SNP positions is a good indicator of it's position in the original order.

>5. **Left Right Density Method**: This method has a similar ordinal similarity score to the Even Odd Method. What this may suggest is that the "skew" of the SNP positions on a fragment is no better an indicator of the "side"" of the sequence (where the centre of the normal distribution of SNPs is in the middle) than picking the side at random, as in the Even Odd method (whether a fragment is on an even or odd index in the density ordered array has no bearing on that fragments' position in the original order). However, similar scores between the two methods could be because quite a large proportion of the fragments are still being ordered by the Even Odd method, in the Left Right Density Method (the fragments with 0 SNPs).
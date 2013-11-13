Rearrangement methods part 3
========================================================

Having updated the genome model being used to [*Arabidopsis thaliana* chromosome 4](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/writeup/arabidopsis_chromosome4.md), I will continue to evaluate my methods of fragment rearrangement here.

To re-cap: I need create an algorithm that re-orders the fragments of the genome into their proper order, then I will go on to include this algorithm in my algorithm for locating the causative SNP mutation. See the [README](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/README.md) for details.

Current rearrangement methods
-----------



Testing the skew for functionality
----------

Method 2b: left right density method [(read decription of method 2a/b in rearrangement_methods.md)](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/writeup/rearrangement_methods.md) uses the fragment's SNP skew, and their SNP density (measured as SNPs per Kb) to rearrange them. As I explained in [rearrangement methods part 2](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/writeup/p2_rearrangement_methods.md), I need to evaluate how well a fragment's SNP skew can be used to determine it's position in the model genome.
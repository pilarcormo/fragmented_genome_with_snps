Rearrangement methods part 4
========================================================

Testing the SNP Skew
--------

Since the Kernel density estimate was not normalized for each fragment, I have come up with a new way of testing SNP skew as a method for rearranging fragments with SNPs into the correct order. See the project [README](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/README.md) and parts [1](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/writeup/rearrangement_methods.md), [2](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/writeup/p2_rearrangement_methods.md) and [3](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/writeup/p3_rearrangement_methods.md) of rearrangement methods for details.

The new method I have used for determining SNP gradients for each of the fragments, relies on a different way of representing SNP density across the fragment, which I will refer to as the distance method. Figures 1 and 2 show the gradients worked out by this method, plotted for each of the fragments in one of my [*Arabidopsis* datasets](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/writeup/arabidopsis_chromosome4.md) (dataset5). The ruby script used to generate all the figures is [here](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/skew_scatta.rb); it uses an [R script](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/skew_scatter.R) and the RinRuby gem to make the plots.

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_abs_1_10000_d1_m0.5.png?raw=true)
[Figure 1](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_abs_1_10000_d1_m0.5.png)

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_grad_1_10000_d1_m0.5.png?raw=true)
[Figure 2](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_grad_1_10000_d1_m0.5.png)

Figures 1 and 2 show that the gradients are slightly higher for fragments from the middle of the model genome, where the centre of the normal distribution of SNPs is.

The distance method works by measuring the distance of each base from the nearest SNP in the contig. A constant (in this case 10,000) is divided by the the distance value so that the 'density' decreases with the inverse of an increasing arithmetic progression, the further a base is from the closest SNP. The 'density' values attributed to the SNP's themselves are 2x the constant (20,000). Figures 3 and 4 are examples of gradient determination using the distance method, the gradient lines are shown in blue.

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f681_mins1_d1_m0.5.png?raw=true)
[Figure 3](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f681_mins1_d1_m0.5.png)

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f258_mins1_d1_m0.5.png?raw=true)
[Figure 4](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f258_mins1_d1_m0.5.png)

Since the causative mutation is likely to be on a fragment with a high SNP density, I have repeated the plots of figure 1 and 2 for just the fragments with 30+ SNPs (figures 5 and 6), to see if the same pattern is shown. The pattern is the same (there basically isn't one), all that figures 5 and 6 show is that the fragments with higher SNP numbers tend to be at the centre of the distribution, but I already knew that (e.g. fragments 350-950).

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_abs_30_10000_d1_m0.5.png?raw=true)
[Figure 5](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_abs_30_10000_d1_m0.5.png)

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_grad_30_10000_d1_m0.5.png?raw=true)
[Figure 6](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_grad_30_10000_d1_m0.5.png)

Figure 7 shows that using the skew for fragment rearrangement and causative mutation detection may not be useful, since **some** of the fragments with the highest SNP densities (where the mutation is most likely to be found) have very low gradients, therefore their SNP skew is not very likely to be a useful indicator of the region of the model genome a fragment comes from.

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f729_mins30_d1_m0.5.png?raw=true)
[Figure 7](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f729_mins30_d1_m0.5.png)

### Distance method 2

Since the results of the first distance method showed that the skew is unlikely to be useful, I took a different approach to be sure:

The second distance method works by measuring the distance of each base from the nearest SNP in the contig. The distance value is taken from a constant (in this case 20,000) so that the 'density' decreases with an arithmetic progression, the further a base is from the closest SNP. The 'density' values attributed to the SNP's themselves are the constant. Figures 8 and 9 are examples of gradient determination using the distance method 2, the gradient lines are shown in blue.

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_abs_1_20000_d2.png?raw=true)
[Figure 8](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_abs_1_20000_d2.png)

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_grad_1_20000_d2.png?raw=true)
[Figure 9](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_grad_1_20000_d2.png)

Figure 8 and 9 show that by using this density approximation method (distance method 2), all of the fragments have essentially negligible gradients, except those with a very low number of SNPs, which are found at the furthest points from the centre of the SNP distribution.

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f258_mins1_d2_m0.5.png?raw=true)
[Figure 10](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f258_mins1_d2_m0.5.png)

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f681_mins1_d2_m0.5.png?raw=true)
[Figure 11](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f681_mins1_d2_m0.5.png)

Figure 10 shows that this method of displaying the SNP density across a fragment (distance method 2) is more useful in determining a useable gradient than the first distance method. Figure 11 supports what was shown in figures 8 and 9, that fragments from the centre of the distribution have a small gradient.

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_abs_30_20000_d2.png?raw=true)
[Figure 12](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_abs_30_20000_d2.png)

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_grad_30_20000_d2.png?raw=true)
[Figure 13](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/skew_scatter_grad_30_20000_d2.png)

Figures 12 and 13 further support what was snown in figures 8 and 9; that all of the fragments have essentially negligible gradients, except those with a very low number of SNPs. In figures 12 and 13, the fragments with the lowest numbers of SNPs (less than 30) have been eliminated.

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f729_mins30_d2_m0.5.png?raw=true)
[Figure 14](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/example_gradient_f729_mins30_d2_m0.5.png)

Figure 14 supports what was shown in figures 8 and 9, that fragments from the centre of the distribution have a small gradient.

### Visualizing the SNPs on fragments

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/how_scatta_f258.png?raw=true)
[Figure 15](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/how_scatta_f258.png)

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/how_scatta_f681.png?raw=true)
[Figure 16](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/how_scatta_f681.png)

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/how_scatta_f729.png?raw=true)
[Figure 17](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/how_scatta_f729.png)

Figures 15-17 validate my conclusion that the gradient/skew will not prove useful in re-ordering un-ordered fragments (contigs) from the experiment described in [README](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/README.md).

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/gghist_f587.png?raw=true)
[Figure 18](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/gghist_f587.png)

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/gghist_f729.png?raw=true)
[Figure 19](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/dataset5/figures/gghist_f729.png)

Histogram figures 18 and 19 more accurately show that there is very little skew across the central fragments.

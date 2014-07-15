Results 14th July: Genetic algorithm run with SNP distances fitness method
========================================================

Each facet/panel in the plots below contain a group of replicates with the same parameters:

- Population size: number of permutations in each population (a new population for every generation)
- Select number: number of permutations from each population to create a new population from
- Chunk mutants: number of chunk mutants ([PMeth gem](https://github.com/edwardchalstrey1/pmeth)) created from randomly chosen permutations, from the fittest selection of the previous generation
- Swap mutants: number of swap mutants ([PMeth gem](https://github.com/edwardchalstrey1/pmeth)) created from the best permutation from the fittest selection of the previous generation
- Save: number of the fittest permutations to carry over from each generation to the next unaltered
- Random: number randomly ordered permutations in each generation

<style>
table,th,td
{
border:1px solid black;
}
</style>

<table>

  <tr><th>Param</th><th>Population size</th><th>Select number</th><th>Chunk mutants</th><th>Swap mutants</th><th>Save</th><th>Random</th></tr>
  
  <tr> <td>p1</td> <td>100</td> <td>50</td> <td>35</td> <td>35</td> <td>25</td> <td>5</td> </tr>
  <tr> <td>p2</td> <td>20</td> <td>10</td> <td>7</td> <td>7</td> <td>5</td> <td>1</td> </tr>
  <tr> <td>p3</td> <td>50</td> <td>25</td> <td>20</td> <td>20</td> <td>6</td> <td>4</td> </tr>
  <tr> <td>p4</td> <td>20</td> <td>4</td> <td>9</td> <td>9</td> <td>1</td> <td>1</td> </tr>

</table>

The figure below shows the results of 40 replicates of the genetic algorithm with the parameter groupings in the table above. Although there appears to be some initial improvement in terms of fitness score, all the replicates level out within 60 generations.

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/max_density/arabidopsis_datasets/10K_dataset4a/umbrella_plot_fits_total_snp_distances.png?raw=true)

The figure below shows the same results as the one above, but with the addition of the correct permutation's fitness. This is shown on the line created from "replicate C". Clearly none of the replicates have produced permutations with fitness scores close to that of the correctly ordered genome.

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/max_density/arabidopsis_datasets/10K_dataset4a/umbrella_plot_fits_total_snp_distance_with_correct.png?raw=true)

Looking closer at the changes in SNP distribution for p_run39 replicate
------

The homozygous SNP distribution for fittest permutations in each generation:

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/max_density/arabidopsis_datasets/10K_dataset4a/p_run39/images_hm.gif?raw=true)


The correct homozygous SNP distribution:

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/max_density/arabidopsis_datasets/10K_dataset4a/p_run39/Gencorrect_lists/best_permutation_distribution_hm_1.0Kdiv.png?raw=true)


The ratio of homozygous to heterozygous SNPs for fittest permutations in each generation:

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/max_density/arabidopsis_datasets/10K_dataset4a/p_run39/images_hyp.gif?raw=true)


The ratio of homozygous to heterozygous SNPs for the correct contig permutation:

![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/max_density/arabidopsis_datasets/10K_dataset4a/p_run39/Gencorrect_lists/best_permutation_distribution_hyp_1.0Kdiv.png?raw=true)
Results 23rd June 2014
========================================================

The figures below represent 120 replicates of my genetic algorithm.
Each facet/panel in the plots below contain a group of replicates with the same parameters:

- Population size: number of permutations in each population (a new population for every generation)
- Select number: number of permutations from each population to create a new population from
- Chunk mutants: number of chunk mutants ([PMeth gem](https://github.com/edwardchalstrey1/pmeth)) created from randomly chosen permutations, from the fittest selection of the previous generation
- Swap mutants: number of swap mutants ([PMeth gem](https://github.com/edwardchalstrey1/pmeth)) created from the best permutation from the fittest selection of the previous generation
- Save: number of the fittest permutations to carry over from each generation to the next unaltered
- Random: number randomly ordered permutations in each generation
- Divisions: number of divisions in the genome for which the ratio of homozygous/heterozygous SNPs is calculated

<style>
table,th,td
{
border:1px solid black;
}
</style>

<table>

  <tr><th>Param</th><th>Population size</th><th>Select number</th><th>Chunk mutants</th><th>Swap mutants</th><th>Save</th><th>Random</th><th>Divisions (1000s)</th></tr>
  
  <tr> <td>p1</td> <td>100</td> <td>50</td> <td>35</td> <td>35</td> <td>25</td> <td>5</td> <td>1</td> </tr>
  <tr> <td>p2</td> <td>20</td> <td>10</td> <td>7</td> <td>7</td> <td>5</td> <td>1</td> <td>1</td> </tr>
  <tr> <td>p3</td> <td>50</td> <td>25</td> <td>20</td> <td>20</td> <td>6</td> <td>4</td> <td>1</td> </tr>
  <tr> <td>p4</td> <td>20</td> <td>4</td> <td>9</td> <td>9</td> <td>1</td> <td>1</td> <td>1</td> </tr>
  
  <tr> <td>p5</td> <td>100</td> <td>50</td> <td>35</td> <td>35</td> <td>25</td> <td>5</td> <td>10</td> </tr>
  <tr> <td>p6</td> <td>20</td> <td>10</td> <td>7</td> <td>7</td> <td>5</td> <td>1</td> <td>10</td> </tr>
  <tr> <td>p7</td> <td>50</td> <td>25</td> <td>20</td> <td>20</td> <td>6</td> <td>4</td> <td>10</td> </tr>
  <tr> <td>p8</td> <td>20</td> <td>4</td> <td>9</td> <td>9</td> <td>1</td> <td>1</td> <td>10</td> </tr>
  
  <tr> <td>p9</td> <td>100</td> <td>50</td> <td>35</td> <td>35</td> <td>25</td> <td>5</td> <td>100</td> </tr>
  <tr> <td>p10</td> <td>20</td> <td>10</td> <td>7</td> <td>7</td> <td>5</td> <td>1</td> <td>100</td> </tr>
  <tr> <td>p11</td> <td>50</td> <td>25</td> <td>20</td> <td>20</td> <td>6</td> <td>4</td> <td>100</td> </tr>
  <tr> <td>p12</td> <td>20</td> <td>4</td> <td>9</td> <td>9</td> <td>1</td> <td>1</td> <td>100</td> </tr>
</table>

Fitness
----
![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/10K_dataset4/umbrella_plot_fits_total.png?raw=true)

Permutation distance metrics
-----

### Similarity: Deviation distance compliment
![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/10K_dataset4/umbrella_plot_%5B%22dev%22%5D.png?raw=true)
### Square similarity: Square deviation distance comlpliment
![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/10K_dataset4/umbrella_plot_%5B%22square%22%5D.png?raw=true)
### Hamming similarity: Hamming distance compliment
![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/10K_dataset4/umbrella_plot_%5B%22ham%22%5D.png?raw=true)
### R distance
![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/10K_dataset4/umbrella_plot_%5B%22r_dist%22%5D.png?raw=true)
### Longest common subsequence
![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/10K_dataset4/umbrella_plot_%5B%22lcs%22%5D.png?raw=true)
### Kendall's tau (compliment)
![Image](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/arabidopsis_datasets/10K_dataset4/umbrella_plot_%5B%22kt%22%5D.png?raw=true)
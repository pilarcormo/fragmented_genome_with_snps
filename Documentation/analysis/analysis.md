Data analysis for GATOC
========================================================

Here I include information on the scripts I have used to generate the analysis of my results, whilst testing my algorithm.

Distribution plot gifs
-------------

Scripts:

1. [distribution_plots.rb](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/distribution_plots.rb)

2. [magick.sh](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/magick.sh)

Running ``ruby distribution_plots.rb dataset run gen div`` in bash shell will generate plots of the homozygous, heterozygous and ["hypothetical/ratio"](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/Documentation/fitness_methods/fitness_methods.md) SNP distributions for the best permutations of each generation, in one run of the algorithm and the correct permutation. ``dataset`` is the name of the dataset directory (within ``fragmented_genome_with_snps/arabidopsis_datasets``), ``run`` is the sub directory within dataset for this run of the algorithm, ``gen`` is the number of generations you wish to make plots for, and ``div`` is the number of divisions of the genome at which to create "hypothetical SNPs".

Navigate to the run directory ``fragmented_genome_with_snps/arabidopsis_datasets/dataset/run`` and run ``bash ../../../magick.sh``. This generates gif animations for how the homozygous and "hypothetical" SNP distributions of the best permutations in each generation change as the algorithm progresses.

Do distance metrics and fitness methods work?
-----------

See [Progress/do_metrics_work](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/Progress/Do_metrics_work/do_metrics_work.md) for results and details.

Script: [do_metrics_work.rb](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/do_metrics_work.rb)

Running ``ruby do_metrics_work.rb dataset size pop_num data_plot metric swap_num div`` will generate a plot of the change in the metric, as the distance from the correct permutations increases (by adjacent swaps of contigs). ``dataset`` is the same as above. ``size`` is the number of permutations to include in each population. ``pop_num`` is the number of populations to create. ``data_plot`` should be either 'csv', 'plot', or both. ``metric`` should be the name of the distance metric to test (from [PDist](https://github.com/edwardchalstrey1/pdist)), or the fitness method to test (from [FitnessScore](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/lib/fitness_score.rb)), but should be camel-cased without underscores/spaces, e.g. 'kendalls_tau' metric is used when ``metric`` = 'KendallsTau'. ``swap_num`` is the number of swap mutations to be carried out on permutations between consecutive populations (I have always set this to 1). ``div`` is the number of divisions of the genome at which to calculate the ratio when testing the 'count_ratio', 'max_hyp' and 'hyp_distance' fitness methods. ``div`` can be left blank for all other methods.

Algorithm performance
----------

See [Progress/results](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/Progress/Results1_count_ratio/results.md) for examples of the figures produced. This analysis is specific to the multiple/replicate runs of my algorithm I have tested in the TSL HPC.

Scripts:

1. [multiple_runs_perormance.rb](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/multiple_runs_performance.rb) (Fitness scores and distance metrics analysis for permutations)

2. [multiple_runs_fitness.rb](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/multiple_runs_fitness.rb) (Fitness scores only)

Running ``ruby script dataset data_plot`` will generate the performance figures. ``script`` is either of the scripts above. ``dataset`` is the same as above. ``data_plot`` is the same as above.

Viewing permutation data in the command line
--------

The fitness scores and 'types' of permutations can be easily viewed for a given generation of a run of the genetic algorithm. The 'type' refers to whether each permutation is saved from the previous generation (saved), is a mutant (chunk_mutant or swap_mutant, see [PMeth](https://github.com/edwardchalstrey1/pmeth)), or is a random permutation.

Script: [view_table_data.rb](https://github.com/edwardchalstrey1/fragmented_genome_with_snps/blob/master/view_table_data.rb)

Run ``view_table_data.rb dataset run generation`` to view the generation of choice. ``dataset`` and ``run`` are the same as above. ``generation`` should be an integer of the generation you wish to view.

Creating Circos plots of contig arrangement, for best permutations in each generation of the genetic algorithm
----------

We can create a circos plot that shows how well the best permutation in each generation of the algorithm, has put the contigs back into the correct order, for my model test genome. [Circos](http://circos.ca/) must be instsalled.

Script: circos_links.rb

Running ``ruby circos_links.rb dataset run s i g`` will generate a config file. ``dataset`` and ``run`` are the same as above. ``s`` is the first generation to be shown in the figure (does not work for generation 0). ``i`` is the number of generations to increment by, and ``g`` is the number of generations in the plot.
Navigating to ``fragmented_genome_with_snps/circos`` then running ``circos -conf config_file`` (where ``config_file`` is the one you just created), will generate the figure. The figure will be called 'circos.png' and will also be found in ``fragmented_genome_with_snps/circos``.
#encoding: utf-8
require_relative 'lib/metric_work'

dataset = ARGV[0]
div = ARGV[1].to_f # number of divisions of the genome at which to calculate the ratio
size = ARGV[2].to_i # size of each population of permuations that are progressively further from correct
pop_num = ARGV[3].to_i # number of populations
data_plot = ARGV[4]

metric = 'Fitness'
filename = "adjacent_swaps_#{metric}_#{pop_num}"
title = "The change in #{metric} of permuations, increasingly distant
		in the search space from the optimal arrangement.
		Permutations are of genomic contig order. Averages are taken
		for populations of permuations with the same number of adjacent
		swap mutations"
x_axis = "Number of adjacent swaps carried out on each permutation"


if data_plot == 'csv' || data_plot == 'both'
	MetricWork.adjacent_swaps_csv(dataset, size, pop_num, div, metric, filename)
end
if data_plot == 'plot' || data_plot == 'both'
	MetricWork.metric_test_plot(dataset, filename, metric, x_axis, metric, title, filename)
end
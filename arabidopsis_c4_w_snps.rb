require "rubygems"
require "rinruby"
require "json"
require 'bio-samtools'
require 'bio'

def fasta2char_array (fasta)
	fasta_array=[]
	Bio::FastaFormat.open(fasta).each do |i|
		fasta_array << i.seq
	end
	return fasta_array[0].split(//)
end
def normal_dist
	myr = RinRuby.new(echo = false)
	#myr.eval "x <- rnorm(70000, 10000000 2000000)" #distibution about the mean, midpoint of the sequence 
	myr.eval "hm <- rnorm(35, 10000000, 5000000)"
	myr.eval "ht1a <- rnorm(1500, 5000000, 1000000)"
	myr.eval "ht1 <- ht1a[which(ht1a < 7.5e+06)]"  #non-recombinant region = 7.5m-12.5m, don't wan het SNPs here
	myr.eval "ht2a <- rnorm(1500, 15000000, 1000000)"
	myr.eval "ht2 <- ht2a[which(ht2a > 1.25e+07)]"
	myr.eval "ht <- c(ht1, ht2)"
	hm = [myr.pull "hm",10000000] # adding in the causative SNP
	ht = myr.pull "ht"
	snp_pos = [ht,hm].flatten
	myr.quit
	return snp_pos, hm, ht
end
def get_frags (seq)
	frags = []
	rt = 0
	while rt < seq.length
		frag_length = rand(10000) + 10000 # fragments of 10kb - 20kb
		frag = seq[rt..(rt+frag_length)]
		rt = rt+frag_length
		frags << frag
	end
	return frags
end
def snp_seq (seq, snp_pos)
	snp_pos.each do |i|
		if i == 10000000
			seq[9999999] = 'M'
		elsif seq[i-1] == 'A' # -1 because ruby counts from 0
			seq[i-1] = 'T'
		elsif seq[i-1] == 'T'
			seq[i-1] = 'A'
		elsif seq[i-1] == 'C'
			seq[i-1] = 'G'
		elsif seq[i-1] == 'G'
			seq[i-1] = 'C'
		elsif seq[i-1] == 'N'
			seq[i-1] = 'R'
		end
	end
	return seq
end
def pos_each_frag (snp_pos, frags) #get the positions for snps on individual frags
	sorted_pos = snp_pos.sort #this is needed as the ht/hm SNPs need to be ordered together
	p_ranges = []
	frags.each do |i|
		p_ranges << i.length + p_ranges[-1].to_i #adding the fragment lengths to get the upper bounds of ranges of positions on the original seq.
	end
	first_pos = [] #then, to work out the first position of each fragment
	first_pos << 0
	first_pos << p_ranges[0..-2]
	first_pos = first_pos.flatten
	p = 0
	t = 0
	all_frags_pos = [] # the positions of snps on each fragment, array of arrays
	snp_pos_all = []
	p_ranges.each do |jj| #for each of the upper ranges (j) that the positions could be in
		each_frag_pos = []
		while sorted_pos[t].to_i < jj && !sorted_pos[t].nil? do #make the loop quit before trying to access index of snp_pos that doesn't exist
			each_frag_pos << sorted_pos[t].to_i 	# add all of the positions < jj to a new array for each frag
			t += 1
		end
		z = 0
		y = first_pos[p].to_i
		natural_pos = each_frag_pos
		each_frag_pos.each do |e|   
			each_frag_pos[z] = e - y #taking away the value at the first position of each fragment to get the true positions
			z += 1
		end
		p += 1
		snp_pos_all << natural_pos
		all_frags_pos << each_frag_pos # add the positions for the frag to an array of the each_frag arrays
	end
	return all_frags_pos, snp_pos_all
end
def storage_json (frags, pos, dataset)
	frags_with_positions = []
	x = 0
	frags.each do |i|
		frag_pos_hash = {}
		frag_pos_hash[:frag] = i.join.to_s
		frag_pos_hash[:pos] = pos[x]
		frags_with_positions << frag_pos_hash 
		x+=1
	end
	File.open("arabidopsis_datasets/"+dataset.to_s+"/"+dataset.to_s+"_fwp.json", "w") do |f|
		f.write(frags_with_positions.to_json)
	end
end
def write_txt (filename, array)
	File.open(filename, "w+") do |f|
		array.each { |i| f.puts(i) }
	end
end

###########
#FASTA/VCF#
###########

def fasta_array (frags)
	frag_ids = []
	id_and_length = [] 
	x = 0
	frags.each do |i|
		id = ('>frag' + (x+1).to_s)
		id_and_length << (id + "  Length = " + i.length.to_s)
		id.slice!('>')
		frag_ids << id
		x+=1
	end
	fastaformat_array = id_and_length.zip(frags) #create the array, each element of which goes onto a new line in fasta
	return fastaformat_array, frag_ids
end
def vcf_array (frags, pos_on_frags, snp_pos_all)
	x = 0
	ids = []
	frags.each do |i| #getting the ids 
		ids << ('frag' + (x+1).to_s)
		x+=1
	end
	chrom = []
	alt = []
	q = 0
	pos_on_frags.each do |h|
		if h.to_s != '[]' #all of the fragments that contain at least one snp
			h.length.times do #*no. of snps
				chrom << ids[q]
			end
		end
		h.each do |i|
			alt << frags[q][i] #what nucleotide is at these positions?
		end
		q += 1
	end
	ref = []
	alt.each do |base|
		if base == 'A'
			ref << 'T'
		elsif base == 'T'
			ref << 'A'
		elsif base == 'C'
			ref << 'G'
		elsif base == 'G'
			ref << 'C'
		elsif base == 'R'
			ref << 'N'
		end
	end
	vcf_format = ['##fileformat=VCFv4.1', '##source=Fake', '#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO'] 
	u = 0
	pos_on_frags.flatten.each do |i|
		if hm.include?(snp_pos_all.flatten[u])
			x = 1.0
		elsif ht.include?(snp_pos_all.flatten[u])
			x = 0.5
		end
		line = chrom[u] + '	' + i.to_s + '	.	' +	ref[u] + '	' + alt[u] + '	100	PASS	AF='+x.to_s
		vcf_format << line
		u += 1
	end
	return vcf_format, chrom.uniq
end
def write_data (array, file, dataset)
	File.open("arabidopsis_datasets/"+dataset.to_s+"/"+file, "w+") do |f|
		array.each { |i| f.puts(i) } #write the fasta/vcf
	end
end
def json_array (array, file, dataset)
	File.open("arabidopsis_datasets/"+dataset.to_s+"/"+file, "w+") do |f|
		f.write(array.to_json)
	end
end

snpz = normal_dist
snp_pos = snpz[0]
hm = snpz[1]
ht = snpz[2]
puts snp_pos.uniq.length.to_s+" of "+snp_pos.length.to_s+" SNPs are unique"
puts "Is there a SNP at the causative mutation position? -- "+snp_pos.include?(10000000).to_s

arabidopsis_c4 = fasta2char_array("TAIR10_chr4.fasta")
snp_sequence = snp_seq(arabidopsis_c4, snp_pos)
frags = get_frags(snp_sequence)
puts "Arabidopsis chr4 length: "+arabidopsis_c4.length.to_s+" bases"
puts "Fragmented seq   length: "+frags.join.length.to_s+ " = close enough? You decide."
puts "You have created "+frags.length.to_s+" fragments of sizes 10-20Kb"

pos_on_all = pos_each_frag(snp_pos, frags)
pos_on_frags = pos_on_all[0]
snp_pos_all = pos_on_all[1]

Dir.mkdir(File.join(Dir.home, "fragmented_genome_with_snps/arabidopsis_datasets/"+ARGV[0].to_s))
#storage_json(frags, pos_on_frags, ARGV[0]) #storing the positions on each frag in a json hash
#write_txt('arabidopsis_datasets/'+ARGV[0].to_s+'/homozygous_positions', hm)
#write_txt('arabidopsis_datasets/'+ARGV[0].to_s+'/heterozygous_positions', ht)

fasta_n_ids = fasta_array(frags)
fastaformat_array = fasta_n_ids[0]
frag_ids = fasta_n_ids[1]

vcf_n_chrom = vcf_array(frags, pos_on_frags, snp_pos_all)
vcf = vcf_n_chrom[0]
chrom = vcf_n_chrom[1]

write_data(fastaformat_array, 'frags.fasta', ARGV[0])
write_data(vcf, 'snps.vcf', ARGV[0])

fastaformat_array_shuf = fastaformat_array.shuffle #shuffle it to show that the order doesn't need to be conserved when working out density later on
write_data(fastaformat_array_shuf, 'frags_shuffled.fasta', ARGV[0])

json_array(frag_ids, 'frag_ids_original_order.json', ARGV[0])


################################################################ Everything below for skew scatter graph
Dir.mkdir(File.join(Dir.home, "fragmented_genome_with_snps/arabidopsis_datasets/"+ARGV[0].to_s+"/skew_scatter"))
write_txt('arabidopsis_datasets/'+ARGV[0].to_s+'/skew_scatter/snp_pos.txt', pos_on_frags)
lengths = []
frags.each do |frag| 
	lengths << frag.length
end
frags_w_snps = []
chrom.each do |id|
	id.slice!("frag")
	frags_w_snps << id.to_i
end
lengths_fws = []
frags_w_snps.each do |id|
	write_txt("arabidopsis_datasets/"+ARGV[0].to_s+"/skew_scatter/snps"+id.to_s+".txt", pos_on_frags[id-1]) #need positions and lengths of each fragment for super skew scatter
	lengths_fws << lengths[id-1]
end
write_txt('arabidopsis_datasets/'+ARGV[0].to_s+'/skew_scatter/ex_fasta_lengths.txt', lengths_fws)
write_txt('arabidopsis_datasets/'+ARGV[0].to_s+'/skew_scatter/ex_ids_w_snps.txt', frags_w_snps)

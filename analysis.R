# Let’s look at our dataset and perform some basic checks before we do a differential expression analysis.

fcData <- read.table('yeast_counts_all_chr.txt', sep='\t', header=TRUE)
head(fcData)

# check dimentions
dim(fcData)

# Rename data columns to reflect group membership
names(fcData)[7:12] = c("WT1", "WT2", "WT3", "MT1", "MT2", "MT3")
head(fcData)


# Extract count data
# Remove annotation columns
# Add row names
counts <- fcData[, 7:12]
rownames(counts) <- fcData$Geneid
head(fcData)

# create a plot of counts per gene by sample
png(filename = "figure1_counts.png")
boxplot(as.matrix(counts) ~ col(counts), main = "Counts per Gene", xlab = "Strain", ylab = "Count")
dev.off()

# Some genes have zero counts:
colSums(counts == 0)


# Log transformation (add 0.5 to avoid log(0) issues):
logCounts <- log2(as.matrix(counts) + 0.5)

# Now we can see the per-sample distributions more clearly:
png(filename = "figure2_logCounts.png")
boxplot(as.matrix(logCounts) ~ col(logCounts), main = "Log Transformed Counts", xlab = "Strain", ylab = "log2(Count)")
dev.off()

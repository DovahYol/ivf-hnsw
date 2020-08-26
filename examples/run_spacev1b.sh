#!/bin/bash

################################
# HNSW construction parameters #
################################

M="16"                # Min number of edges per point
efConstruction="500"  # Max number of candidate vertices in priority queue to observe during construction

###################
# Data parameters #
###################

nb="1402020720"       # Number of base vectors

nt="14020000"         # Number of learn vectors
nsubt="367531"        # Number of learn vectors to train (random subset of the learn set)

nc="1975234"           # Number of centroids for HNSW quantizer

nq="29316"            # Number of queries
ngt="100"            # Number of groundtruth neighbours per query

d="100"               # Vector dimension

#################
# PQ parameters #
#################

code_size="10"        # Code size per vector in bytes
opq="off"             # Turn on/off opq encoding

#####################
# Search parameters #
#####################

#######################################
#        Paper configurations         #
# (<nprobe>, <max_codes>, <efSearch>) #
# (   32,       10000,        80    ) #
# (   64,       30000,       100    ) #
# (  128,      100000,       130    ) #
#######################################

k="1"                 # Number of the closest vertices to search
nprobe="64"           # Number of probes at query time
max_codes="30000"     # Max number of codes to visit to do a query
efSearch="100"        # Max number of candidate vertices in priority queue to observe during searching

#########
# Paths #
#########

path_data="../spacev1b"
path_model="./models"

path_base="${path_data}/SPACEV1B.i8vecs"
path_learn="${path_data}/SPACEV1B.i8vecs"
path_gt="${path_data}/merged_truth.ivecs"
path_q="${path_data}/un_vector_fy19_h1.i8vecs"
path_centroids="${path_data}/SPTAGHeadVectors.fvecs"

path_precomputed_idxs="${path_data}/precomputed_idxs_spacev1b.ivecs"

path_edges="${path_model}/hnsw_M${M}_ef${efConstruction}.ivecs"
path_info="${path_model}/hnsw_M${M}_ef${efConstruction}.bin"

path_pq="${path_model}/pq${code_size}.pq"
path_norm_pq="${path_model}/norm_pq${code_size}.pq"
path_index="${path_model}/ivfhnsw_PQ${code_size}.index"

#######
# Run #
#######
${PWD}/test_ivfhnsw_spacev1b -M ${M} \
                               -efConstruction ${efConstruction} \
                               -nb ${nb} \
                               -nt ${nt} \
                               -nsubt ${nsubt} \
                               -nc ${nc} \
                               -nq ${nq} \
                               -ngt ${ngt} \
                               -d ${d} \
                               -code_size ${code_size} \
                               -opq ${opq} \
                               -k ${k} \
                               -nprobe ${nprobe} \
                               -max_codes ${max_codes} \
                               -efSearch ${efSearch} \
                               -path_base ${path_base} \
                               -path_learn ${path_learn} \
                               -path_gt ${path_gt} \
                               -path_q ${path_q} \
                               -path_centroids ${path_centroids} \
                               -path_precomputed_idx ${path_precomputed_idxs} \
                               -path_edges ${path_edges} \
                               -path_info ${path_info} \
                               -path_pq ${path_pq} \
                               -path_norm_pq ${path_norm_pq} \
                               -path_index ${path_index}
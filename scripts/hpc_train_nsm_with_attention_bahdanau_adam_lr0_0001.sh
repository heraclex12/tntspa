#!/bin/bash
#SBATCH --time=8:00:00   # walltime
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8  # number of processor cores (i.e. threads)
#SBATCH -p gpu1,gpu2    # K80 GPUs on Haswell node
#SBATCH -J "hpc_nsm_att_bah_lr0_0001"   # job name
#SBATCH -o "train_nsm_attention_bahdanau_adam_lr0_0001-%j.out"   # output name
#SBATCH --mem=20000   # minimum amount of real memory
#SBATCH -A p_adm # name of the project
#SBATCH --mail-user xiaoyu.yin@mailbox.tu-dresden.de
#SBATCH --mail-type ALL

module load TensorFlow/1.8.0-foss-2018a-Python-3.6.4-CUDA-9.2.88
export PYTHONPATH="${PYTHONPATH}:$(pwd)/../"

DDIR=../data/monument_600
MDIR=../output/models

if [ -n "$1" ]
    then DDIR=$1
fi

if [ -n "$2" ]
    then MDIR=$2
fi

srun python3 -m nmt.nmt.nmt \
    --src=en --tgt=sparql \
    --hparams_path=nmt_hparams/neural_sparql_machine_attention_bahdanau_adam_lr0_0001.json \
    --out_dir=output/models/neural_sparql_machine_attention_bahdanau_adam_lr0_0001 \
    --vocab_prefix=data/monument_600/vocab \
    --train_prefix=data/monument_600/train \
    --dev_prefix=data/monument_600/dev \
    --test_prefix=data/monument_600/test

exit 0
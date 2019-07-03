#!/bin/bash --login
#$ -cwd
#SBATCH --job-name=tensorflow_gpu_demo
#SBATCH --out=tensorflow_gpu_demo.out.%J
#SBATCH --err=tensorflow_gpu_demo.err.%J
#SBATCH -n 1
#SBATCH --gres=gpu:1

. "$HOME/anaconda3/etc/profile.d/conda.sh"
conda activate tensorflow-gpu
python multilayer_perceptron.py

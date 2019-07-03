#!/bin/bash

#workaround for problems with anaconda not running from bashrc, adjust accordingly if you have anaconda installed somewhere else
source $HOME/anaconda3/etc/profile.d/conda.sh

echo "Checking if Anaconda is installed"
conda --version 
if [ "$?" != "0" ] ; then
    echo "Error: Anaconda not found"
    exit 1
fi

echo "Setting up Anaconda environment"

conda env create -f tensorflow-gpu.yml 

echo "Downloading example code"
#download example code
wget https://raw.githubusercontent.com/aymericdamien/TensorFlow-Examples/master/examples/3_NeuralNetworks/multilayer_perceptron.py

echo "Patching example code for GPU usage"
#the patch file contains changes to make this example use the GPU
#setup path to data files correctly, for some reason python/tensor flow doesn't like using ~/neuralnet_data so we need /home/<userid>/neuralnet_data
sed -i "s/cos/$PWD/" multilayer_perceptron.py.patch 
patch multilayer_perceptron.py multilayer_perceptron.py.patch

echo "Downloading example MNIST data to ~/neuralnet_data"
mkdir ~/neuralnet_data
cd ~/neuralnet_data
wget http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
wget http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
wget http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
wget http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz
cd -

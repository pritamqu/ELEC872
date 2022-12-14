### Setup Local Envronment

It is a good practice to setup preject specific environments as a working space instead of configuring everything at base. Environment can be directly creating using python `venv` module or `conda`. In this example, we will be using `conda` to create an environment. 

**Basic Setups** 

You may follow the instructions available here in the following links to install `conda` in your local system. Note: incase you're just planning to use cloud platform like `google colab`, you may skip this setup.

Links to install conda for their respective OS platforms.
- [windows](https://docs.anaconda.com/anaconda/install/windows/)
- [linux](https://docs.anaconda.com/anaconda/install/linux/)
- [mac](https://docs.anaconda.com/anaconda/install/mac-os/)


Create environment:
`conda create --name elec872 python=3.8
`

Activate the environment:
`conda activate elec872
`

Note: Sometimes, after installing `conda`, you may face the error `Conda command is not recognized`; In that case, you need to manually specify the `conda` path in the `PATH` variable. e.g., in linux: `export PATH=~/anaconda3/bin:$PATH`. You may read more on this issue in the `stackoverflow` thread: 
https://stackoverflow.com/questions/44597662/conda-command-is-not-recognized-on-windows-10


**Installing Packages** 

`conda` and `pip` are two very useful pkg manager to install different libraries. 
we will use a `requirements.txt` file to load the most common packages.
Before you install the packages, please open the `requirements.txt` file in a text editor and make sure you're aware of the libraries you're installing. It is possible that some of the packages are not relevant to you and/or not compatiable for your system, in that case it's recomemned not to install them. You may simply remove those lines from the file. You may run the below command to install the packages: 
`pip install -r requirements.txt
`


**Classical Machine Learning Framework**

*scikit-learn:* The details can be found in the website: 
https://scikit-learn.org/stable/install.html

- using conda: `conda-forge scikit-learn`
- using pip: `pip install scikit-learn`

**Deep Learning Framework**

**PyTorch:** The detail instruction can be found in the official website: https://pytorch.org/
	
windows
```
GPU: conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch

CPU: conda install pytorch torchvision torchaudio cpuonly -c pytorch
```

linux: 
```
GPU: conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch

CPU: conda install pytorch torchvision torchaudio cpuonly -c pytorch
```

mac
```
CPU: conda install pytorch torchvision torchaudio -c pytorch
```

**Alternatives:**
You may choose other deep learning frameworks like 
- Tensorflow: https://www.tensorflow.org/install
- JaX: https://github.com/google/jax#installation


# A quick guide to train deep learning models in Pytorch


### Local Machine

We train a simple deep neural network using CIFAR100. To train it in your local machine, please run the following command. Please note, this code is written to train on a CPU or a single GPU machine.

**Windows**

```
python main.py \
--data path/to/data \
--arch resnet18 \
--workers 0 \ 
--epochs 100 \
--batch-size 256 \
--gpu 0 \
--seed 99999999
```

**Linux**

```
python main.py \
--data path/to/data \
--arch resnet18 \
--workers 4 \
--epochs 100 \
--batch-size 256 \
--gpu 0 \
--seed 99999999
```

### Google Colab



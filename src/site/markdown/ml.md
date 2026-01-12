# ML (Machine Learning)

## Information

Neural networks, Deep Learning, Machine learning.

## Artificial neural network (ANN)

* ANN
    * Recurrent neural network (RNN)
        * LSTM
        * Fully recurrent neural network (FRNN)
        * Independently recurrent neural network (IndRNN)

## Configuration

## Terms

* Confidence
* cuDNN
* cuBLAS
* BLAS routines
* GEMM
* Volta and Turing Tensor Cores
* ANN
* RNN
* SNN - Spiking Neural Networks
* NLP
* BERT
* Long Short-Term Memory
* Solving the Vanishing Gradient Issue
* Attention-based Neural Machine Translation
* Visualizing A Neural Machine Translation Model (Mechanics of Seq2seq Models With Attention)
* ML types:
  * Supervised Learning - using labeled data as ML input. k-Nearest Neighbours, Linear Regression, Logistic Regression, Support Vector Machines (SVMs), Decision Trees and Random Forests, Neural Networks
  * Unsupervised - using only data as ML input. Clustering.
  * Semisupervised - mix of both
  * Reinforcement learning - observing and detecting environment learning
  * Online learning
  * Batch learning
  * Instance-based learning
  * Model-based learning
* θ (Theta) - model parameters
* Predictions
* Convolutional NN, Recurrent NN (neural nets) - RNN, ...
* Estimators
* Training
* Evaluation
* Models
* Transformers
* LSTM
* FFT
* Anchor
* Prediction
* TFDS- Tensorflow datasets
* https://www.tensorflow.org/datasets/overview#load_a_dataset
* mnist
* TensorBoard
* TensorHub
* Image Annotation
* LabelIMG, Labelbox, RectLabel, ImageTagger, LabelMe, Eagle, VGG Image Annotator, Supervise.ly, BeaverDam, Diffgram,
  Prodigy, Dataturks, Computer Vision Annotation Tool (CVAT), Visual Object Tagging Tools (VoTT), Make-Sense, Anno-Mage,
* DAG
* Classification, Object detection, Semantic segmentation
* 3D CNN
* 3D CRNN
* RAG (GraphRAG)
* Agent
* MCP

### MATH

* Sigmoid
* Bias
* Matrix
* Vectors
* ANN: Weights
* ANN: biases
* ANN: Features
* Tensor

## Process steps

* Data ingestion, versioning
* Data validation
* Data processing
* Model training
* Model tuning
* Model analysis
* Model validation
* Model deployment
* Model feedback (And back to top)

## ML architectures

Feedforward Neural Networks (FNN)
Classic multilayer perceptron (MLP).
MLP (Multilayer Perceptron)

Convolutional Neural Networks (CNN)
Good for dimensional data structures (pictures, videos, 2D signals).
LeNet (first CNN)
AlexNet, VGG, Inception, ResNet, DenseNet, EfficientNet, ConvNeXt jne.
Vision Transformers (ViT), Hybrid CNN-Transformer models.

Recurrent Neural Networks (RNN)
For sequential data (text, sound, time series).
Simple RNN
LSTM (Long Short-Term Memory)
GRU (Gated Recurrent Unit)
Bidirectional RNN
Attention + RNN hybrid

Graph Neural Networks (GNN)
Works with graphs: nodes and edges
GCN (Graph Convolutional Network)
GAT (Graph Attention Network)
GraphSAGE, Message Passing Neural Networks (MPNN)

Transformers ja Attention-põhised mudelid
NLP-s also in vision, audio analysis, reinforcement learning.
self-attention
Encoder-decoder (nt. BERT, T5)
Decoder-only (nt. GPT-family)
Vision Transformers (ViT), Audio Transformers

Generative models
Generates new data (picture, sound, text)
GAN (Generative Adversarial Network)
VAE (Variational Autoencoder)
Diffusion Models (nt. Stable Diffusion, DALL·E)

Neuroevolution and specific architectures
NEAT, HyperNEAT
Capsule Networks (Hinton)
Liquid Neural Networks (neurodynamic systems)

Future
Neural Architecture Search (NAS) – automatic new arch. searching.
Spiking Neural Networks (SNN) – biologically realistic networks.
Quantum Neural Networks (QNN) – quantum computers related models.
Liquid/Neural ODE Networks – continuously time dynamics models.

## ML input

**Raw Data**: This directory could contain raw, unprocessed data files, such as CSV, JSON, XML, or files in other
formats.

**Preprocessed Data**: This directory could contain data files that have been preprocessed and are ready to be used with
a machine learning model. Preprocessing may involve handling missing values, normalization, scaling, or other data
preparation steps.

**Train Data**: In this directory, you could store data files specifically intended for training, along with their
corresponding labels or targets.

**Test Data**: Similarly to the training data, you could store test data files in a separate directory for evaluating
and testing the model's performance.

**Validation Data**: If you are using separate validation data, you could store it in a separate directory.

**External Data**: If you are using external datasets or sources, you could create a dedicated directory for those data.

**Labels**: If you are working on a supervised learning problem, you could create a directory for storing the labels or
targets.

**Data Augmentation**: If you are using data augmentation techniques, you may create a directory to store the generated
augmented versions of the data.

**Data Splits**: If you are dividing your data into training, testing, and validation sets, you could create directories
for each data split.

**Data Exploration**: If you are conducting exploratory work or analysis related to the input data, you could create a
directory specifically for data exploration.

**Data Sources**: If the input data comes from different sources, you could create a directory with subdirectories for
each data source.

Test data and validation data are both part of evaluating the performance of a machine learning model, but they have
different roles and purposes:

Notea:

Test data is a separate dataset used for evaluating the performance of a model after training and validation. Test data
allows you to assess the model's generalization and its ability to work with new, unseen data. Test data should
represent the real-world environment in which the model will eventually be deployed. Test data should not be used for
training or adjusting model parameters but solely for evaluating the final performance of the model.

Validation data is a subset of the dataset used during the model training process for assessing its performance and
selecting parameters. During training, validation data is used for parameter tuning, such as hyperparameter selection,
model complexity adjustment, or other decisions related to the training process. Validation data helps assess the
model's performance during training and helps prevent overfitting or underfitting.

## ML output

**Parameters**: In this directory, you can store files that contain your model's hyperparameters and configurations.
This may include a text file, a JSON file, or other formats that specify the values of the parameters used.

**Models**: In this directory, you can store files of trained machine learning models. Depending on the storage format
used by TensorFlow, it may include TensorFlow SavedModel files (.pb), SavedModel format files, or H5 format files (for
Keras models).

**Weights**: If you are training a deep learning network, you can save weight files in a separate directory. These files
contain the learned weights and biases during training, which can be used later for model reproduction and usage.

**Reports**: In this directory, you can store various reports, including performance analysis, visualizations, logs, and
other result documents. This may include test reports, performance graphs, log files, and similar documents that provide
insights into your model's behavior and performance.

**Generated Data**: If you generate synthetic data or use data generation with your model, you can separate and store
those data files in this directory. This may include synthesized data files that can be used for result reproduction or
sharing with others.

## Usage, tips and tricks

### Coding tips and tricks

## See also

* 3Blue1Brown ([https://www.youtube.com/@3blue1brown]()):
    * [https://www.youtube.com/playlist?list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi]()
        1. [https://www.youtube.com/watch?v=aircAruvnKk]()
        2. [https://www.youtube.com/watch?v=IHZwWFHWa-w]()
        3. [https://www.youtube.com/watch?v=Ilg3gGewQ5U]()
        4. [https://www.youtube.com/watch?v=tIeHLnjs5U8]()
        5. [Another similar](https://www.youtube.com/watch?v=2utAfvGAbgg)
    * [Convolution](https://www.youtube.com/watch?v=KuXjwB4LzSA)
* 2x lines:
    * [https://www.youtube.com/watch?v=ILsA4nyG7I0]()
* DL/ML zoo:
    * [https://www.youtube.com/watch?v=oJNHXPs0XDk]()
* Google:
    * [https://www.youtube.com/playlist?list=PLIivdWyY5sqJxnwJhe3etaK7utrBiPBQ2]()
    * [https://www.youtube.com/watch?v=HcqpanDadyQ]()
    * [https://www.youtube.com/watch?v=nKW8Ndu7Mjw]()
    * Estimators:
        * [https://www.youtube.com/watch?v=G7oolm0jU8I]()
* [Machine Learning vs Deep Learning](https://www.youtube.com/watch?v=q6kJ71tEYqM)
*
* [Convolution - CNN](https://www.youtube.com/watch?v=YRhxdVk_sIs)
* [NN 5 min](https://www.youtube.com/watch?v=bfmFfD2RIcg)
* [Neural Networks Explained](https://www.youtube.com/watch?v=GvQwE2OhL8I)
* [Recurrent Neural Networks (RNN) and Long Short-Term Memory (LSTM)](https://www.youtube.com/watch?v=WCUNPb-5EYI)
* [TF course](https://www.youtube.com/playlist?list=PLqnslRFeH2Uqfv1Vz3DqeQfy0w20ldbaV)
* [DL series](https://www.youtube.com/playlist?list=PLQVvvaa0QuDfhTox0AjmQ6tvTgMBZBEXN)
* [Transformers Neural Network](https://www.youtube.com/watch?v=4Bdc55j80l8)
* [LSTM is dead. Longlive Transformers](https://www.youtube.com/watch?v=S27pHKBEp30)
* [AI Language Models & Transformers - Computerphile](https://www.youtube.com/watch?v=rURRYI66E54)
* [Computerphile](https://www.youtube.com/@Computerphile)
* [Encoder Decoder Network - Computerphile](https://www.youtube.com/watch?v=1icvxbAoPWc)
* [BERT](https://www.youtube.com/watch?v=7kLi8u2dJz0)
* [TF 100seconds](https://www.youtube.com/watch?v=i8NETqtGHms)
* [Convo. Keras](https://www.youtube.com/watch?v=e47ISlpYFok)
* [NN mathematical](https://www.youtube.com/watch?v=hxpGzAb-pyc&list=RDQMwjiIGVB03Eg&start_radio=1)
* [ANN](https://www.youtube.com/watch?v=GQVLl0RqpSs)
* [yolov3](https://viso.ai/deep-learning/yolov3-overview/)
* [Large Language Models](https://www.youtube.com/watch?v=lnA9DMvHtfI)
* [Taxy data](https://data.cityofchicago.org/Transportation/Taxi-Trips/wrvz-psew)
* [Iris dataset](https://data-flair.training/blogs/iris-flower-classification/)
* [Iris dataset](https://archive.ics.uci.edu/ml/datasets/Iris/)
* [Other datasets collections](https://archive.ics.uci.edu/ml/datasets.php)
* [scikit-learn Iris data set](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_iris.html)
* [scikit-learn data sets](https://scikit-learn.org/stable/modules/classes.html#module-sklearn.datasets)
* [OpenML](https://www.openml.org/)
* [OpenCV](https://opencv.org/)
* [Supervised vs Unsupervised Learning](https://viso.ai/deep-learning/supervised-vs-unsupervised-learning/)
* [CVAT installation](https://opencv.github.io/cvat/docs/administration/basics/installation/)
* [Argo ML](https://argoproj.github.io/argo-workflows/use-cases/machine-learning/)
* [AI models explanation](https://viso.ai/deep-learning/ml-ai-models/)
* [Open Neural Network Exchange](https://onnx.ai/)
* [SkyRemoval](https://github.com/OpenDroneMap/SkyRemoval)
* [OpenFace](https://cmusatyalab.github.io/openface/)
* [Google Natural Language Generation](https://www.youtube.com/watch?v=MNvT5JekDpg)
* [MIT DL](https://www.youtube.com/watch?v=5tvmMX8r_OM)
* [MIT RNN](https://www.youtube.com/watch?v=qjrad0V0uJE)
* [ML ZtH](https://www.youtube.com/watch?v=VwVg9jCtqaU)
* [DL Article](https://www.wgu.edu/blog/neural-networks-deep-learning-explained2003.html)
* [DL, NN article](https://serokell.io/blog/deep-learning-and-neural-network-guide)
* [first NN](https://towardsdatascience.com/first-neural-network-for-beginners-explained-with-code-4cfd37e06eaf)
* [Structure of NN](https://becominghuman.ai/understanding-the-structure-of-neural-networks-1fa5bd17fef0)
* [DNN](https://www.tutorialspoint.com/python_deep_learning/python_deep_learning_deep_neural_networks.htm)
* [Apache OpenNLP](https://opennlp.apache.org/)
* [Mahout](https://mahout.apache.org/)
* [RNN](https://www.youtube.com/watch?app=desktop&v=y9PLF2GsD-c)
* [RNN](https://www.youtube.com/watch?app=desktop&v=LHXXI4-IEns)
* [RNN](https://www.youtube.com/watch?app=desktop&v=AsNTP8Kwu80)
* [RNN](https://www.youtube.com/watch?app=desktop&v=_aCuOwF1ZjU)
* [QR Code AI](https://qrbtf.com/)
* [MIT AAmini](https://www.youtube.com/@AAmini/videos)
* [MIT 1](https://www.youtube.com/watch?v=QDX-1M5Nj7s)
* [MIT 2](https://www.youtube.com/watch?v=ySEx_Bqxvvo)
* [MIT 3](https://www.youtube.com/watch?v=NmLK_WQBxB4)
* [MIT 4](https://www.youtube.com/watch?v=3G5hWM6jqPk)
* [MIT 5](https://www.youtube.com/watch?v=kIiO4VSrivU)
* [MIT 6](https://www.youtube.com/watch?v=AhyznRSDjw8)
* [Vectors](https://www.youtube.com/watch?v=fNk_zzaMoSs&list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab)
* [LSTM](https://www.youtube.com/watch?v=YCzL96nL7j0)
* [Word2Vec](https://www.youtube.com/watch?v=viZrOnJclY0)
* [RNNs](https://www.youtube.com/watch?v=AsNTP8Kwu80&t=328s)
* [Math and AI etc](https://www.youtube.com/@statquest)
* [CUDA quick atart](https://docs.nvidia.com/cuda/cuda-quick-start-guide/index.html)
* [CUDA downloads](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Rocky&target_version=9)
* [nvidia-container-runtime](https://developer.nvidia.com/nvidia-container-runtime)
* [CML Continuous Machine Learning](https://cml.dev/)
* [machine learning zoo](https://www.youtube.com/watch?v=tdtpa1e5fsU)
* [ML Math](https://www.youtube.com/watch?v=Ixl3nykKG9M)
* [Backpropagation example](https://www.youtube.com/watch?v=khUVIZ3MON8)
* [ACACES 2023: Neuromorphic computing: from theory to applications, Lecture 1 – Yulia Sandamirskaya - YouTube](https://m.youtube.com/watch?v=2XX8KLMyQN4)
* [Tutorial on snnTorch: Jason Eshraghian ICONS 2021 - YouTube](https://m.youtube.com/watch?v=O2-mT291ygg)
* [ICONS 2020 Keynote Presentation by Sander Bohte: Computing with Spiking Neurons - YouTube](https://m.youtube.com/watch?v=M4O3d8sl1tQ)
* [Spiking Neural Networks for More Efficient AI Algorithms - YouTube](https://m.youtube.com/watch?v=PeW-TN3P1hk)
* [A Brain-Inspired Algorithm For Memory - YouTube](https://m.youtube.com/watch?v=1WPJdAW-sFo)
* [Generative Model That Won 2024 Nobel Prize - YouTube](https://m.youtube.com/watch?v=_bqa_I5hNAo)
* [Visualizing transformers and attention | Talk for TNG Big Tech Day '24 - YouTube](https://m.youtube.com/watch?v=KJtZARuO3JY)
* [Transformers (how LLMs work) explained visually | DL5 - YouTube](https://m.youtube.com/watch?v=wjZofJX0v4M)
* [Attention in transformers, step-by-step | DL6 - YouTube](https://m.youtube.com/watch?v=eMlx5fFNoYc)
* [3 gen ANN](https://www.researchgate.net/figure/Three-generations-of-artificial-neural-networks-ANNs-MLP-multilayer-perceptron-MP_fig2_339481763)
* [AI](https://www.researchgate.net/figure/Diagram-illustrates-the-relationship-between-artificial-intelligence-AI-machine_fig1_364337909)
* [https://www.deeplearning.ai/](https://www.deeplearning.ai/)
* [https://openai.com/](https://openai.com/)
* [https://arxiv.org/](https://arxiv.org/)
* [https://paperswithcode.com/](https://paperswithcode.com/)
* [https://distill.pub/](https://distill.pub/)
* [https://www.technologyreview.com/](https://www.technologyreview.com/)
* [https://towardsdatascience.com/](https://towardsdatascience.com/)
* [https://ai.google/](https://ai.google/)
* [https://www.kaggle.com/](https://www.kaggle.com/)
* [https://aiweekly.co/](https://aiweekly.co/)
* [https://cloud.google.com/vertex-ai]([https://cloud.google.com/vertex-ai)
* [https://deepai.org/](https://deepai.org/)
* [HOWTO LLM](https://mljourney.com/how-to-build-a-large-language-model-from-scratch/)
* [Kaggle - TensorFLow HUB is integrated](https://www.kaggle.com/models?tfhub-redirect=true)
* [TensorFlow Hub](https://www.tensorflow.org/hub)
* [TF + Kaggle](https://www.kaggle.com/discussions/product-feedback/448425)
* [Fine-tuning Large Language Models (LLMs) | w/ Example Code](https://www.youtube.com/watch?v=eC6Hd1hFvos)
* [RAG vs. Fine Tuning](https://www.youtube.com/watch?v=00Q0G84kq3M)
* [xxxx](xxxxx)
* [xxxx](xxxxx)
* [xxxx](xxxxx)
* [xxxx](xxxxx)
* [xxxx](xxxxx)
* [xxxx](xxxxx)

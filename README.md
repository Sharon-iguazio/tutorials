# Welcome to the Iguazio Data Science Platform

An initial introduction to the Iguazio Data Science Platform and the platform tutorials

- [Platform Overview](#platform-overview)
- [Data Science Workflow](#data-science-workflow)
- [Getting Started](#getting-started)
- [End-to-End Use-Case Applications](#end-to-end-use-case-applications)
- [Jupyter Notebook Basics](#jupyter-notebook-basics)
- [Additional Resources](#additional-resources)
- [Support](#support)

<a id="platform-overview"></a>
## Platform Overview

The Iguazio Data Science Platform (**"the platform"**) is a fully integrated and secure data science platform as a service (PaaS), which simplifies development, accelerates performance, facilitates collaboration, and addresses operational challenges.
The platform incorporates the following components:

- A data science workbench that includes Jupyter Notebook, integrated analytics engines, and Python packages
- Model management with experiments tracking and automated pipeline capabilities
- Managed data and machine-learning (ML) services over a scalable Kubernetes cluster
- A real-time serverless functions framework &mdash; Nuclio
- An extremely fast and secure data layer that supports SQL, NoSQL, time-series databases, files (simple objects), and streaming
- Integration with third-party data sources such as Amazon S3, HDFS, SQL databases, and streaming or messaging protocols
- Real-time dashboards based on Grafana

<br><img src="./assets/images/igz-self-service-platform.png" alt="Self-service data science platform" width="650"/><br>

<a id="data-science-workflow"></a>
## Data Science Workflow

The platform provides a complete data science workflow in a single ready-to-use platform that includes all the required building blocks for creating data science applications from research to production:

- Collect, explore, and label data from various real-time or offline sources
- Run ML training and validation at scale over multiple CPUs and GPUs
- Deploy models and applications into production with serverless functions
- Log, monitor, and visualize all your data and services

![Data Science Workflow](./assets/images/igz-data-science-workflow.gif)

<a id="getting-started"></a>
## Getting Started

See the following resources for a more in-depth introduction to the platform:

- [Introduction video](https://www.youtube.com/watch?v=8OmAN4wd7To)
- [In-depth platform overview](platform-overview.ipynb), which details how you can leverage the platform to implement each step of the data science workflow from research to production
- [Creating and deploying Nuclio functions with Python and Jupyter Notebook](https://github.com/nuclio/nuclio-jupyter/blob/master/README.md)

A good place to start your development is with the platform [tutorial Jupyter notebooks](https://github.com/v3io/tutorials), which are available in the home directory of the platform's Jupyter Notebook service; see especially the examples in the [**getting-started**](getting-started/getting-started-basic.ipynb) directory and the full [use-case demo applications](#end-to-end-use-case-applications).
You can find a tutorials overview in the [Jupyter Notebook Basics](#jupyter-notebook-basics) section of this document.

<a id="end-to-end-use-case-applications"></a>
## End-to-End Use-Case Applications

Iguazio provides full end-to-end use-case applications (demos) that demonstrate how to use the Iguazio Data Science Platform and related tools to address data science requirements for different industries and implementations.

<a id="predeployed-demos"></a>
### Pre-Deployed Platform Demos

The platform comes pre-deployed with the following end-to-end use-case demos, which are available in the **demos** tutorial-notebooks directory.
For more details, see [**demos/README.md**](demos/README.md) (available also as a [notebook](demos/README.ipynb)):

- <a id="nlp-demo"></a>[**Natural language processing (NLP)**](demos/nlp/nlp-example.ipynb) &mdash; processes natural-language textual data and generates a Nuclio serverless function that translates any given text string to another (configurable) language.
- <a id="stream-enrich-demo"></a>[**Stream enrichment**](demos/stream-enrich/stream-enrich.ipynb) &mdash; implements a typical stream-based data-engineering pipeline, including real-time data enrichment using a NoSQL table.
- <a id="stocks-demo"></a>[**Smart stock trading**](demos/stocks/01-gen-demo-data.ipynb) &mdash; reads stock-exchange data from an internet service into a time-series database (TSDB) and performs real-time market-sentiment analysis on specific stocks; the data is saved to a platform NoSQL table for generating reports and analyzing and visualizing the data on a Grafana dashboard.
- <a id="location-based-recommendations-demo"></a>[**Location-based recommendations**](demos/location-based-recommendations/01-generate-stores-and-customers.ipynb) &mdash; generates real-time product purchase recommendations for users of a credit-card company based on the users' physical location.
- <a id="real-time-user-segmentation-demo"></a>[**Real-time user segmentation**](demos/slots-stream/real-time-user-segmentation.ipynb) &mdash; builds a stream-event processor on a sliding time window for tagging and untagging users based on programmatic rules of user behavior.

<a id="additional-demos"></a>
### Additional Demos

You can download additional demos from GitHub &mdash; for example:

- <a id="xgboost-demo"></a>[**XGBoost classification**](https://github.com/mlrun/demo-xgb-project) &mdash; uses XGBoost to perform binary classification on the popular Iris ML data set, and runs parallel model training with hyperparameters.
- <a id="image-classification-demo"></a>[**Image classification**](https://github.com/mlrun/demo-image-classification) &mdash; builds and trains an ML model that identifies (recognizes) and classifies (labels) images by using Keras, TensorFlow, and Horovod.
- <a id="serverless-spark-demo"></a>[**Serverless Spark**](demos/spark/mlrun_sparkk8s.ipynb) &mdash; demonstrates how to run the same Spark job locally and as a distributed MLRun job over Kubernetes.

For information on the available demos, contact the Iguazio [support team](mailto:support@iguazio.com).<br>
For each downloaded demo, start out by reading its **README.md** file.

The following example code downloads the [mlrun/demo-xgb-project](https://github.com/mlrun/demo-xgb-project) XGBoost-classification demo:


```python
# Download the MLRun XGBoost classificaiton demo
!mlrun project demos/xgboost/ -u git://github.com/mlrun/demo-xgb-project.git
```

<a id="jupyter-notebook-basics"></a>
## Jupyter Notebook Basics

<a id="jupyter-ui-n-home-dir"></a>
### The Jupyter UI and Home Directory

The platform's Jupyter Notebook service uses the JupyterLab UI, which is described in detail in the [JupyterLab documentation](https://jupyterlab.readthedocs.io/en/stable/user/interface.html#the-jupyterlab-interface).

By default, the **File Browser** in the left-sidebar menu displays the home directory of the platform's Jupyter Notebook service, which includes these components:

- **v3io** directory, which displays the contents of the `v3io` platform cluster data mount for browsing the cluster's data containers.
  You can also browse the containers data from the **Data** page of the platform dashboard.
- The contents of the running-user home directory &mdash; **users/&lt;running user&gt;**.
  This directory contains the platform's [tutorial Jupyter notebooks](https://github.com/v3io/tutorials):

  - [**welcome.ipynb**](welcome.ipynb) / [**README.md**](../README.md) &mdash; the current document, which provides a short introduction to the platform and how to use it to implement a full data science workflow.
  - [**platform-overview.ipynb**](platform-overview.ipynb) &mdash; an in-depth platform overview, which details how you can leverage the platform to implement each step of the data science workflow from research to production.
  - [**getting-started**](getting-started/getting-started-basic.ipynb) &mdash; a directory containing getting-started tutorials that explain and demonstrate how to perform different platform operations using the platform APIs and integrated tools.
  - [**demos**](demos/README.ipynb) &mdash; a directory containing [end-to-end application use-case demos](#end-to-end-use-case-applications).

For information about the predefined data containers and how to reference data in these containers, see [Platform Data Containers](getting-started/getting-started-basic.ipynb/#platform-data-containers) in the **getting-started-basic.ipynb** tutorial notebook.

<a id="creating-virtual-environments-in-jupyter-notebook"></a>
### Creating Virtual Environments in Jupyter Notebook

A virtual environment is a named, isolated, working copy of Python that maintains its own files, directories, and paths so that you can work with specific versions of libraries or Python itself without affecting other Python projects.
Virtual environments make it easy to cleanly separate projects and avoid problems with different dependencies and version requirements across components.
See the [virutal-env](getting-started/virutal-env.ipynb) tutorial notebook for step-by-step instructions for using conda to create your own Python virtual environments, which will appear as custom kernels in Jupyter Notebook.

<a id="update-notebooks"></a>
### Updating the Tutorial Notebooks to the Latest Version

You can use the provided **igz-tutorials-get.sh** script to update the tutorial notebooks to the latest stable version available on [GitHub](https://github.com/v3io/tutorials/).
For details, see the [**update-tutorials.ipynb**](update-tutorials.ipynb) notebook.

<a id="additional-resources"></a>
## Additional Resources

<a id="platform-resources"></a>
### Platform Documentation, Examples, and Sample Data Sets

- [References](https://iguazio.com/docs/reference/latest-release/)
- [Components, Services, and Development Ecosystem](https://www.iguazio.com/docs/intro/latest-release/ecosystem/)
- [Iguazio sample data-set](http://iguazio-sample-data.s3.amazonaws.com/) public Amazon S3 bucket

 <a id="third-party-resources"></a>
 ### Third-Party Documentation, Examples, and Sample Data Sets

- [10 Minutes to pandas](https://pandas.pydata.org/pandas-docs/stable/10min.html)
- [JupyterLab Tutorial](https://jupyterlab.readthedocs.io/en/stable/)
- [Machine Learning Algorithms In Layman's Terms](https://towardsdatascience.com/machine-learning-algorithms-in-laymans-terms-part-1-d0368d769a7b)
- [Registry of Open Data on AWS](https://registry.opendata.aws/)

<a id="support"></a>
## Support

The Iguazio [support team](mailto:support@iguazio.com) will be happy to assist with any questions.

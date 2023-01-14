# Before using the program, please read it carefully

First, download the files in the master branch of the repository.

<strong>Next, download the Python AI libraries as below:</strong>
<ol>
<li>Download Anaconda: Begin by going to the <a href="https://www.anaconda.com/products/individual" target="_blank">Anaconda download page</a> to begin installing Anaconda corresponds to your computer operating system.</li>
<li>Create an environment by using AI libraries: 
    <ul>
    <li>Start the Anaconda prompt application (or terminal on Mac). Start the prompt by searching for anaconda on your computer. At the Anaconda prompt, enter the following code:
    <code>conda create -n myenv python=3.7 pandas jupyter seaborn scikit-learn keras pytorch pillow</code></li>
    <li>You'll be prompted to install the packages. Enter <kbd>Y</kbd>, and then press <kbd>Enter</kbd>.</li>
    <li>You'll need to activate your new environment. To activate the environment, enter the following code:
    <code>conda activate myenv</code></li>
    <li>To install torchvision, at the Anaconda prompt, enter the following code:
    <code>conda install -c pytorch torchvision</code></li>
    <li>The new environment should be created and ready to use.</li></ul>
</li></ol>

Now, open the ClassifySpaceRockProgram.ipynb file in your favourite editor and make sure that the kernel environment being used is the one you created in the previous step. Next, run each of the code cells one at a time. You may change any line of the code to suit your needs accordingly.

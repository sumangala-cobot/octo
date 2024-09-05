# Use an official NVIDIA base image with CUDA support
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    git \
    build-essential \
    libgl1-mesa-glx \
    libosmesa6 \
    libglew-dev \
    patchelf \
    python3-pip \
    python3-dev \
    xvfb \
    x11-xkb-utils \
    xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic \
    x11-apps \
    mesa-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Set environment variables for Conda
ENV PATH /opt/conda/bin:${PATH}

# Copy the environment.yml file into the container
COPY environment.yml .
# Create the Conda environment
RUN conda env create -f environment.yml

# Make sure the environment is activated when the container starts
RUN echo "source activate octo" > ~/.bashrc
ENV PATH=/opt/conda/envs/myenv/bin:$PATH

# Install Python dependencies
RUN pip install --upgrade pip setuptools
# Copy the setup.py file into the container
COPY setup.py requirements.txt .
RUN pip install -e .
#RUN pip install -r requirements.txt

RUN pip install --upgrade "jax[cuda12]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
# Set environment variables for Mujoco
ENV LD_LIBRARY_PATH /root/.mujoco/mujoco-2.3.3/bin:${LD_LIBRARY_PATH}
ENV MUJOCO_GL osmesa

# Add a script to start Xvfb and run Python scripts
COPY . .

# Define the command to run your application (if needed)
CMD ["python", "app.py"]
#COPY run_with_xvfb.sh /usr/local/bin/run_with_xvfb.sh
#RUN chmod +x /usr/local/bin/run_with_xvfb.sh

# Set the default command to use Xvfb for headless execution
#CMD ["/usr/local/bin/run_with_xvfb.sh"]


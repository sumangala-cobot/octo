# Use a base image with Conda pre-installed
FROM continuumio/miniconda3

# Set the working directory in the container
WORKDIR /app

# Copy the environment.yml file into the container
COPY environment.yml .

# Create the Conda environment
RUN conda env create -f environment.yml

# Make sure the environment is activated when the container starts
RUN echo "source activate octo" > ~/.bashrc
ENV PATH=/opt/conda/envs/myenv/bin:$PATH

# Optionally, copy the application code into the container
COPY . .

# Define the command to run your application (if needed)
CMD ["python", "app.py"]


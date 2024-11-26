# Use the Jupyter minimal-notebook image as the base
FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Copy the conda-lock file into the container
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# Install mamba (if not already installed in the base image)
RUN conda install -c conda-forge mamba -y

# Install the packages specified in conda-linux-64.lock using mamba
RUN mamba update --quiet --file /tmp/conda-linux-64.lock \
    && mamba clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"
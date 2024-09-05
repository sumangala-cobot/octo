pip install --upgrade "jax[cuda11_pip]==0.4.20" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
pip install -e .
apt update 
apt install vim-tiny
pip3 install opencv-python modern_robotics pyrealsense2 h5py_cache pyquaternion pyyaml rospkg pexpect mujoco==2.3.3 dm_control==1.0.9 einops packaging h5py 
Xvfb :1 -screen 0 1024x768x16 & export DISPLAY=:1
pip install ipython

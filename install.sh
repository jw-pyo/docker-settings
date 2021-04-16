#locale
echo $1 | sudo -S locale-gen en_US.UTF-8
echo $1 | sudo -S update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8


#anaconda installation 
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
sh Anaconda3-2020.02-Linux-x86_64.sh -b
rm Anaconda3-2020.02-Linux-x86_64.sh

#zshrc path and theme
echo "export PATH=/home/jungwoo_pyo/anaconda3/bin:$PATH" >> ~/.zshrc
echo 'export ZSH_THEME="agnoster"' >> ~/.zshrc
source ~/.zshrc

# vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#conda library update
conda update conda \
    && conda install -y pytorch torchvision torchaudio cudatoolkit=11.0 -c pytorch
# ssh start
echo $1 | sudo -S service ssh start

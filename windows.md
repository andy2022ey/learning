# Program Files和Program Files (x86)的区别
Program Files (x86)是32位程序的安装目录，而Program Files是64位程序的安装目录。

# CUDA
CUDA要单独安装。CUDA的版本要和显卡驱动的版本对应。
CUDA和显卡驱动的版本对应关系：https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#title-resolved-issues
打开英伟达控制面板，点击系统信息，可以看到显卡驱动的版本。点击组件，可以看到CUDA的版本。
安装程序下载网站：https://developer.nvidia.com/cuda-toolkit-archive
安装11.7版本对应的torch: pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117

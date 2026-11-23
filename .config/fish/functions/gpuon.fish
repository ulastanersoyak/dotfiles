function gpuon --description 'Bring the NVIDIA dGPU back and load its driver'
    echo 1 | sudo tee /sys/bus/pci/rescan >/dev/null
    sudo modprobe nvidia_drm
    and echo "dGPU on"
end

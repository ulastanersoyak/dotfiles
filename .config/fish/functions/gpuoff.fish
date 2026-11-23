function gpuoff --description 'Unload NVIDIA driver and remove the dGPU from the bus'
    sudo modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia
    or begin
        echo "NVIDIA GPU is in use — close apps using it first"
        return 1
    end
    echo 1 | sudo tee /sys/bus/pci/devices/0000:01:00.0/remove >/dev/null
    echo "dGPU off"
end

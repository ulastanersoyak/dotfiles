function gpustat --description 'NVIDIA dGPU power state (does not wake it, unlike nvidia-smi)'
    cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status
end

function gpumode --description 'Desktop GPU mode: intel (battery) or nvidia (NVIDIA HDMI port works); applies on next login'
    set -l flag ~/.config/hypr/nvidia-mode
    switch "$argv[1]"
        case nvidia
            touch $flag
            echo "nvidia mode — log out and back in while plugged in (HDMI on NVIDIA will work; logging in on battery still uses Intel only)"
        case intel
            rm -f $flag
            echo "intel mode — log out and back in (best battery)"
        case '*'
            test -e $flag; and echo nvidia; or echo intel
    end
end

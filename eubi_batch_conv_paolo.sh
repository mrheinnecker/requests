
apptainer shell -B /home -B /scratch -B /g /g/schwab/marco/container_devel/eubi_v5.sif

paolo_test="/g/schwab/marco/t0000"

eubi to_zarr \
      $paolo_test \
      /g/schwab/marco/omezarr_test12  \
      --x_unit nm \
      --y_unit nm \
      --z_unit nm \
      --x_scale "10" \
      --y_scale "10" \
      --z_scale "50" \
      --concatenation_axes z \
      --z_tag "s" \
      --save_omexml True \
      --autochunk True \
      --zar_format "3" 



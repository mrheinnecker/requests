nextflow.enable.dsl = 2

params.input_table = '/g/schwab/marco/repos/requests/paolo_in.tsv'
params.outdir = '/g/schwab/marco/omezarr_paolo'

process EUBI_TO_ZARR {
    tag "$sample_id"
    container '/g/schwab/marco/container_devel/eubi_v5.sif'

    input:
    tuple val(sample_id), val(input_path)

    script:
    def out_path = "${params.outdir}/${sample_id}.ome.zarr"
    """
    mkdir -p "${params.outdir}"

    eubi to_zarr \\
        "${input_path}" \\
        "${out_path}" \\
        --x_unit nm \\
        --y_unit nm \\
        --z_unit nm \\
        --x_scale "10" \\
        --y_scale "10" \\
        --z_scale "50" \\
        --concatenation_axes z \\
        --z_tag "s" \\
        --save_omexml True \\
        --autochunk True \\
        --zar_format "3"
    """
}

workflow {
    Channel
        .fromPath(params.input_table)
        .splitCsv(header: true, sep: '\t')
        .map { row ->
            def input_path = row.path as String
            def sample_id = input_path.tokenize('/').last().replaceAll(/[^A-Za-z0-9_.-]/, '_')
            tuple(sample_id, input_path)
        }
        | EUBI_TO_ZARR
}

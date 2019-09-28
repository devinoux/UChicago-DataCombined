import dask.dataframe as dd
import pandas as pd
import shutil
import errno
import os
import timeit
import glob
from dask.distributed import Client
client = Client('10.50.178.190:9500')
client.restart()

def remove_ignore_if_exists(filename):
    try:
        os.remove(filename) if not os.path.isdir(filename) else shutil.rmtree(filename)
    except OSError as e: # this would be "except OSError, e:" before Python 2.6
        if e.errno != errno.ENOENT: # errno.ENOENT = no such file or directory
            raise # re-raise exception if a different error occurred

def calculate_summary(flname_input, flname_output):
    # flname_input = 'RAGOTEST/RAGO.chr22.gen'
    # flname_output = 'sum_stats_manu.csv'
    tic = timeit.default_timer()
    df_snp = dd.read_csv(flname_input, sep=" ", header=None, dtype=object)#, blocksize=40000000)
    df_6th = df_snp[df_snp.columns[6::3]].map_partitions(lambda pdf: pdf.apply(pd.to_numeric, errors='coerce'))
    df_7th = df_snp[df_snp.columns[7::3]].map_partitions(lambda pdf: pdf.apply(pd.to_numeric, errors='coerce'))
    colnames = list(map(str, list(range(1, len(df_6th.columns) + 1))))
    df_6th.columns = colnames
    df_7th.columns = colnames
    df_final = df_6th + 2 * df_7th
    df_final['snp_uid'] = df_snp[0]
    df_final = df_final[['snp_uid'] + colnames]
    remove_ignore_if_exists('tmp_sum_stats')
    os.makedirs('tmp_sum_stats')
    df_final.to_csv(os.path.join('tmp_sum_stats', 'export-*.csv'), index=False)
    lst_file_csv = [fname for fname in sorted(glob.glob(os.path.join('tmp_sum_stats', 'export-*.csv')),
                                              key=lambda x: int(
                                                  os.path.basename(x).split('.')[0].split('export-')[1]))]
    remove_ignore_if_exists(flname_output)
    for f in lst_file_csv:
        for df in pd.read_csv(f, chunksize=10000):
            if not os.path.isfile(flname_output):
                df.to_csv(flname_output, index=False, sep=" ")
            else:
                df.to_csv(flname_output, mode='a', sep=" ", header=False, index=False)
    toc = timeit.default_timer()
    remove_ignore_if_exists('tmp_sum_stats')
    print("Processed in {0} seconds".format(str(toc - tic)))

calculate_summary('RAGOTEST/RAGO.chr22.gen', 'sum_stats_manu.csv')


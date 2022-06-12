代码说明：

- `fft_2.m`, `fft_3`.m, `fft_5.m`, `fft_22.m` 分别为基2，3，5的 DIT FFT 和 基2 DIF FFT
- `ifft_2,m` 为基2的快速傅里叶逆变换
- `split_radix.m` 为分裂基 FFT
- `Cooley-Tukey.m` 为 Cooley-Tukey 算法
- `Rader.m` 为 Rader 算法，`findPrimitiveRoot.m` 为查找原根的算法
- `myfft.m` 为结合了 Cooley-Tukey 算法和 Rader 算法的任意长度 FFT
- `test_time.m` 比较了分裂基 FFT 与基2 FFT 的运行时间；`test_acc.m` 验证了 任意长度 FFT 的准确性

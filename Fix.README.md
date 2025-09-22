Build the docker image:

`docker build -t compdiff_env .`

Start a new container with the image:

`docker run -it --name compdiff_container compdiff_env`

Install LLVM:

`./preinstall.sh`

Create a symink for clang, clang++:

`update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 100`

`update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 100`

Update LLVM-config and Paths:

`export PATH=/usr/lib/llvm-13/bin:$PATH`

`export LDFLAGS="-L/usr/lib/llvm-13/lib"`

`export CPPFLAGS="-I/usr/lib/llvm-13/include"`

`export LLVM_CONFIG=/usr/lib/llvm-13/bin/llvm-config`

Build CompDiff:

`./diff-build.sh`

Edit the xpdf build file:

`cd ./examples/xpdf`

`nano build.sh`

Instrument XPDF with AFL instrumentation.

`./diff-instrument.sh ./examples/xpdf/build.sh`

Run AFL++ on XPDF:

`./aflpp/afl-fuzz -y 10 -i examples/xpdf/seeds -o examples/xpdf/findings -- ./examples/xpdf/bin/pdftotext @@ -`

Stop the Fuzzing Process:

Run the python script to filter out the unique cases:

`python3 diff-post.py --bin ./examples/xpdf/bin/pdftotext --args "@@ -" -y 10 -r 1 -i examples/xpdf/findings/default/diffs -o ./out`

Open another terminal and copy the AFL generated PDF input file into host machine:

`docker cp compdiff_container:/workspace/CompDiff/out/diffs/id_000000_sig_09_src_000000_time_2743_op_havoc_rep_2 ~/Downloads/diff_input.pdf`

View the error file or output file:

`cat <file>`

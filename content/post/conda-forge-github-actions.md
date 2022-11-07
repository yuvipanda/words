---
title: "Installing Python (and other packages) from conda-forge in GitHub Actions"
date: 2022-11-06T23:17:53-08:00
lastmod: 2022-11-06T23:17:53-08:00
categories: [github, code, conda-forge]

---

[Alex Merose asked me](https://hachyderm.io/web/@asm@qoto.org/109294147156073488) on Mastodon how to
best set up a conda environment on GitHub Actions. I thought I'd write a short blog post about it!

The short version is, use the [conda-incubator/setup-miniconda](https://github.com/marketplace/actions/setup-miniconda)
GitHub action instead of the official [setup-python](https://github.com/marketplace/actions/setup-python)
action. Specifically, try out these options for size:

```yaml
  steps:
    - uses: conda-incubator/setup-miniconda@v2
      with:
        # Specify python version your environment will have. Remember to quote this, or
        # YAML will think you want python 3.1 not 3.10
        python-version: "3.10"
        # This uses *miniforge*, rather than *minicond*. The primary difference is that
        # the defaults channel is not enabled at all
        miniforge-version: latest
        # These properties enable the use of mamba, which is much faster and far less error
        # prone than conda while being completely compatible with the conda CLI
        use-mamba: true
        mamba-version: "*"
```

This should give you a python environment named `test` with python `3.10` (or whatever version
you specify) and nothing much else. You can then use [`mamba`](https://github.com/mamba-org/mamba)
to install packages from [conda-forge](https://conda-forge.org/) to your heart's content in future
steps like this:


```yaml
    - name: Install some packages
      # The `-l` is needed so conda environment activation works correctly
      shell: bash -l {0}
      run: |
        mamba install -c conda-forge numpy scipy matplotlib
```

My recommendation is to continue using the default `setup-python` action for almost all your python
needs in GitHub actions, and use `conda-incubator/setup-miniconda@v2` only if you explicitly need
to use `mamba` (or `conda`) for something.

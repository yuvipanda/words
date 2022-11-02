---
title: "Using Python (instead of bash) to write GitHub actions"
date: 2022-11-01T23:04:56-07:00
lastmod: 2022-11-01T23:04:56-07:00
categories: [python, code, github]
description: "How to use python instead of bash in your GitHub actions workflows"

---

I am not smart enough to consistently write *and* debug shell scripts that use *any*
conditional or looping constructs. So as soon as I'm writing something in bash that
requires use of those, I switch to python. This works fine when writing scripts, but
what to do when writing [GitHub Actions](https://github.com/features/actions) workflows?
You can only write bash in `run:` stanzas in your `step`s, right?

Not at all! You can set the [shell](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsshell)
parameter to anything you want, and the contents of `run` will be passed to the shell in the
form of a file. This allows you to use not just Python, but basically any langauge when writing
your GitHub actions workflows.

Here is an example step that used python.

```yaml
  steps:
    - name: Something in python!
      # The -u means 'unbuffered', so print() statements in your python code are output correctly
      # otherwise, they might be out of order with stdout from commands your code calls
      # {0} is replaced with the name of the temporary file GitHub Actions creates with
      # the contents of the run:
      shell: python -u {0}
      run: |
        import sys
        import subprocess

        print("Hello, I am python")

        # We have to use string substitution for getting inputs, which is bad and ugly
        # However, it isn't as bad me trying to write conditionals in bash.
        # It might be possible to use environment values here, I haven't explored.
        variable = '${{ inputs.some_input }}'

        # Use subprocess.check_call to call out to external process. stdout is
        # handled correctly
        subprocess.check_call([
          sys.executable,
          '-m',
          'pip', 'install', 'django'
        ])
```

If you instead use `mamba` or `conda` to set up your Python, perhaps with
the [setup-miniconda](https://github.com/marketplace/actions/setup-miniconda)
action, you need to set `shell: bash -l -c "python -u {0}"`. The `bash -l`
makes sure that the appropriate conda environment is loaded, and then passes
off to the 'correct' python.